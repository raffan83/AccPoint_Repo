package it.portaleSTI.bo;


import it.portaleSTI.DAO.GestioneCertificatoDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.InterventoDatiDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.PuntoMisuraDTO;
import it.portaleSTI.DTO.ReportSVT_DTO;

import it.portaleSTI.DTO.StatoCertificatoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.certificatiLAT.CreaCertificatoLivellaBolla;
import it.portaleSTI.certificatiLAT.CreaCertificatoLivellaElettronica;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.MathContext;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.io.FileUtils;
import org.hibernate.Session;

import com.google.gson.JsonObject;
import com.itextpdf.text.Annotation;
import com.itextpdf.text.Image;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.PdfAnnotation;
import com.itextpdf.text.pdf.PdfBorderArray;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfDestination;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfStamper;
import com.itextpdf.text.pdf.parser.ImageRenderInfo;
import com.itextpdf.text.pdf.parser.PdfReaderContentParser;
import com.itextpdf.text.pdf.parser.RenderListener;
import com.itextpdf.text.pdf.parser.TextRenderInfo;
import net.sf.dynamicreports.report.datasource.DRDataSource;

public class GestioneCertificatoBO {
	
	
		public static ArrayList<CertificatoDTO> getListaCertificato(StatoCertificatoDTO stato,InterventoDatiDTO intervento, CompanyDTO cmp, UtenteDTO utente, String obsoleto, String idCliente, String idSede, int anno) throws Exception
		{
				
				return GestioneCertificatoDAO.getListaCertificati(stato,intervento,cmp,utente, obsoleto, idCliente, idSede, anno);
			
		}
		
		public static CertificatoDTO getCertificatoById(String id)
		{
			return GestioneCertificatoDAO.getCertificatoById(id);
		}

		
		public static String createCertificato(String idCertificato,String data_emissione, Session session, ServletContext context, UtenteDTO utente) throws Exception {
			try {
				
				
				CertificatoDTO certificato = getCertificatoById(idCertificato);
				
				MisuraDTO misura = certificato.getMisura();
			    
				StrumentoDTO strumento = misura.getStrumento();
						
				LinkedHashMap<String,List<ReportSVT_DTO>> listaTabelle = new LinkedHashMap<String, List<ReportSVT_DTO>>();
				
				
				listaTabelle= getListaTabelle(misura,strumento.getTipoRapporto().getNoneRapporto());
				
  	
				List<CampioneDTO> listaCampioni = GestioneMisuraBO.getListaCampioni(misura.getListaPunti(),strumento.getTipoRapporto());
				String idoneo;
				if(!strumento.getTipoRapporto().getNoneRapporto().equals("RDP")) {
					idoneo = getIsIdoneo(misura);
				}else {
					idoneo = null;
				}
	            DRDataSource listaProcedure = new DRDataSource("listaProcedure");
				
	            listaProcedure.add(strumento.getProcedura());

				CreateCertificato cert = new CreateCertificato(misura, data_emissione, certificato,listaTabelle, listaCampioni, listaProcedure, strumento,idoneo,session,context,true,false, utente);
					
					/*
					 * Aggiornata data Emissione su scadenzaDTO
					 */
				
//						ScadenzaDTO scadenza =strumento.getScadenzaDTO();
//						
//						scadenza.setDataEmissione(new Date(System.currentTimeMillis()));
//						
//						GestioneStrumentoBO.update(strumento,session);
					
						
					/*
					 * cambio stato certificato 
					 */
						
					certificato.setStato(new StatoCertificatoDTO(2));
					
					updateCertificato(certificato,session);
					
					/*
		    		 *  Controllo presenza strumento a magazzino
		    		 */
					
		    		int idItem=GestioneMagazzinoBO.checkStrumentoInMagazzino(misura.getStrumento().get__id(),misura.getIntervento().getIdCommessa());
		    		
		    		if(idItem!=0) 
		    		{
		    		 GestioneMagazzinoBO.cambiaStatoStrumento(idItem, 2, session);
		    		}
		    		
					
			
			return cert.firmato.get("messaggio").getAsString();
			
			} catch (Exception e) {
				e.printStackTrace();
				throw e;
			}
		}
		
		


		private static void updateCertificato(CertificatoDTO certificato,Session session)throws Exception {
			
			session.update(certificato);
			
		}

		private static LinkedHashMap<String, List<ReportSVT_DTO>> getListaTabelle(MisuraDTO misura,String tipoRapporto) {
			
			LinkedHashMap<String,List<ReportSVT_DTO>> listaTabelle = new LinkedHashMap<String, List<ReportSVT_DTO>>();
			
			/*Otteniamo il numero di tabella per Misura*/
			
			int nTabelle=GestioneMisuraBO.getMaxTabellePerMisura(misura.getListaPunti());
			
			/*istanzio le tabelle*/
			
			ArrayList<List<ReportSVT_DTO>> dataSource =new ArrayList<List<ReportSVT_DTO>>();
			
			for (int i = 0; i < nTabelle; i++) {
				
				dataSource.add(new ArrayList<ReportSVT_DTO>());
			}
			
			for(int i=0;i<nTabelle;i++)
			{
				
				ArrayList<PuntoMisuraDTO> listaPuntiPerTabella=GestioneMisuraBO.getListaPuntiByIdTabella(misura.getListaPunti(),i+1);
			
			if(listaPuntiPerTabella.size()>0)	
			{	
			 if(listaPuntiPerTabella.get(0).getTipoProva().startsWith("L")||listaPuntiPerTabella.get(0).getTipoProva().equals("RDP") ||listaPuntiPerTabella.get(0).getTipoProva().startsWith("D"))
			 {
				/*Gestione Linearità*/ 
				for (int j = 0; j < listaPuntiPerTabella.size(); j++) 
				{
					PuntoMisuraDTO punto =listaPuntiPerTabella.get(j);
					
					if(listaPuntiPerTabella.get(0).getTipoProva().equals("RDP") && punto.getValoreStrumento()!=null)
					{
						punto.setValoreStrumento(punto.getValoreStrumento().stripTrailingZeros());
					}
					
					ReportSVT_DTO data = new ReportSVT_DTO();
					if(punto.getApplicabile() != null && punto.getApplicabile().equals("N")) {
		
						data.setTipoProva(punto.getTipoProva());		
						
						Map<String, Object> values = new HashMap<String, Object>();
						
						List<Map<String, Object>> tipoVerifica = new ArrayList<Map<String, Object>>();
					  	values.put("tv",punto.getTipoVerifica());
					  	tipoVerifica.add(values);
					  	
					  	/*ASLEFT - ASFOUND*/
					    data.setAsLeftAsFound(punto.getCalibrazione());
					  	
					  	List<Map<String, Object>> ums = new ArrayList<Map<String, Object>>();
					  	values = new HashMap<String, Object>();
					  	
					  	values.put("um", "N/A");
					  	ums.add(values);
	
					  	
					  	List<Map<String, Object>> vcs2 = new ArrayList<Map<String, Object>>();
					  	values = new HashMap<String, Object>();
					  	
					  	values.put("vc", "N/A");
					  	vcs2.add(values);
					  	
					  	List<Map<String, Object>> vss2 = new ArrayList<Map<String, Object>>();
					  	values = new HashMap<String, Object>();
					  	
					  	values.put("vs", "N/A");
					  	vss2.add(values);
	
					  	
					  	
					  	data.setTipoVerifica(tipoVerifica);
					  	data.setUnitaDiMisura(ums);
					  	data.setValoreCampione(vcs2);
					  	
					  	data.setValoreMedioCampione("N/A");
					  	
					  	data.setValoreStrumento(vss2);
					  	data.setValoreMedioStrumento("N/A");
					  	data.setScostamento_correzione("N/A");
					  			
					  	data.setAccettabilita("N/A");
 					  	data.setIncertezza("N/A");
					  	data.setEsito("N/A");
				  	
					}
					else 
					{
		
						data.setTipoProva(punto.getTipoProva());		
						
						Map<String, Object> values = new HashMap<String, Object>();
						
						List<Map<String, Object>> tipoVerifica = new ArrayList<Map<String, Object>>();
					  	values.put("tv",punto.getTipoVerifica());
					  	tipoVerifica.add(values);
					  	
					  	/*ASLEFT - ASFOUND*/
					    data.setAsLeftAsFound(punto.getCalibrazione());
					  	
					  	List<Map<String, Object>> ums = new ArrayList<Map<String, Object>>();
					  	values = new HashMap<String, Object>();
					  	
					  	values.put("um", punto.getUm());
					  	ums.add(values);
					  	data.setTipoVerifica(tipoVerifica);
					  	data.setUnitaDiMisura(ums);
					  	
					  	List<Map<String, Object>> vcs2 = new ArrayList<Map<String, Object>>();
					  	values = new HashMap<String, Object>();
					  	if(punto.getValoreCampione()!=null) {
					  	values.put("vc", Utility.changeDotComma(punto.getValoreCampione().setScale(Utility.getScale(punto.getRisoluzione_campione()), RoundingMode.HALF_UP).toPlainString()));
					  	vcs2.add(values);
					  	
					  	
					  	
					  	data.setValoreCampione(vcs2);
					  	
					  	data.setValoreMedioCampione(Utility.changeDotComma(punto.getValoreCampione().setScale(Utility.getScale(punto.getRisoluzione_campione()), RoundingMode.HALF_UP).toPlainString()));
					  	}
					  	if(!punto.getTipoProva().equals("RDP") ) {
					  	List<Map<String, Object>> vss2 = new ArrayList<Map<String, Object>>();
					  	values = new HashMap<String, Object>();
					  	
						values.put("vs", Utility.changeDotComma(punto.getValoreStrumento().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).toPlainString()));
					  	vss2.add(values);
					  	data.setValoreStrumento(vss2);
					  	
					  	data.setValoreMedioStrumento(Utility.changeDotComma(punto.getValoreStrumento().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).toPlainString()));
					  	}else {
					  		List<Map<String, Object>> vss2 = new ArrayList<Map<String, Object>>();
						  	values = new HashMap<String, Object>();		
						  	if(punto.getValoreStrumento()!=null) {
							values.put("vs", Utility.changeDotComma(punto.getValoreStrumento().toPlainString()));
						  	}else {
						  	values.put("vs", "");
						  	}
						  	vss2.add(values);
						  	data.setValoreStrumento(vss2);
						  	
						  	//data.setValoreMedioStrumento(Utility.changeDotComma(punto.getValoreStrumento().toPlainString()));
					  	}
					  	
					  	
					 	if(tipoRapporto.equals("SVT"))
					  	{
					  		data.setScostamento_correzione(Utility.changeDotComma(punto.getScostamento().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).toPlainString()));
					  	}
					  	else if(!tipoRapporto.equals("SVT")&&!tipoRapporto.equals("RDP"))
					  	{
					  		data.setScostamento_correzione(Utility.changeDotComma(punto.getScostamento().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).toPlainString()));
					  	}
					  
					  	
					  	List<Map<String, Object>> esito = new ArrayList<Map<String, Object>>();
					  	values = new HashMap<String, Object>();
					  	
					  	values.put("esito", punto.getEsito());
					  	esito.add(values);
					  //	data.setEsito(esito);
					  	/*
					  	 * Accetabilità 
					  	 */
					  	if(!tipoRapporto.equals("RDP")) {
					  	if(punto.getSelTolleranza()==0)
					  	{
					  		String um = "";
					  		if(punto.getUm_calc()!=null && !punto.getUm_calc().equals("")){
					  			um = punto.getUm_calc();
					  		}else{
					  			um = punto.getUm();
					  		}
					  		
					  		data.setAccettabilita(Utility.changeDotComma(punto.getAccettabilita().setScale(Utility.getScale(punto.getRisoluzione_misura())+2, RoundingMode.HALF_UP).stripTrailingZeros().toPlainString()));
					  	}
						if(punto.getSelTolleranza()==1)
					  	{
							String perc = " (" + punto.getPer_util()+"%)";	
						  	data.setAccettabilita(Utility.changeDotComma(punto.getAccettabilita().setScale(Utility.getScale(punto.getRisoluzione_misura())+2, RoundingMode.HALF_UP).stripTrailingZeros().toPlainString())+perc);
					  	}
						if(punto.getSelTolleranza()==2)
					  	{
							String perc = " (" +Utility.changeDotComma(punto.getPer_util()+"% FS["+punto.getFondoScala().stripTrailingZeros().toPlainString())+"])";	
						  	data.setAccettabilita(Utility.changeDotComma(punto.getAccettabilita().setScale(Utility.getScale(punto.getRisoluzione_misura())+2, RoundingMode.HALF_UP).stripTrailingZeros().toPlainString())+perc);
					  	}
						if(punto.getSelTolleranza()==3)
					  	{
					   
							BigDecimal valoreMisura = punto.getMisura();
							Double percentualeUtil = punto.getPer_util();
							
							BigDecimal percentuale = valoreMisura.multiply(new BigDecimal(percentualeUtil)).divide(BigDecimal.valueOf(100),RoundingMode.HALF_UP);
							
						//	BigDecimal dgt = punto.getAccettabilita().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).subtract(percentuale).stripTrailingZeros();
							
							String perc ="("+ punto.getDgt().stripTrailingZeros() +" + "+punto.getPer_util()+"%)";	
							data.setAccettabilita(Utility.changeDotComma(punto.getAccettabilita().setScale(Utility.getScale(punto.getRisoluzione_misura())+2, RoundingMode.HALF_UP).stripTrailingZeros().toPlainString())+perc);
					  	}
					  	//data.setAccettabilita(punto.getAccettabilita().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).toPlainString());
					  	
					  	
						BigDecimal bd = punto.getIncertezza();
						bd = bd.round(new MathContext(2, RoundingMode.HALF_UP));
						data.setIncertezza(Utility.changeDotComma(bd.toPlainString()));
					  	}
					  	data.setEsito(punto.getEsito());
					  	data.setDescrizioneCampione(punto.getDesc_Campione());
					  	
					  
					  	
					}
				  	dataSource.get(i).add(data);
					
				}
			 }
			 else
			 {
				 /*Gestione Ripetibilità*/ 
				String[] strutturaProva=listaPuntiPerTabella.get(0).getTipoProva().split("_");
				
				int ripetizioni =Integer.parseInt(strutturaProva[2]);
				int punti =Integer.parseInt(strutturaProva[1]);
				 
					
					int indicePunto=0;
					for (int a = 0; a < ripetizioni; a++) 
					{
						
						ReportSVT_DTO data = new ReportSVT_DTO();
						
						
						
						Map<String, Object> values = new HashMap<String, Object>();
						
						List<Map<String, Object>> tipoVerifica = new ArrayList<Map<String, Object>>();
					  	
					  	
						List<Map<String, Object>> ums = new ArrayList<Map<String, Object>>();
					  	
					  	
					  	
					  	List<Map<String, Object>> vcs = new ArrayList<Map<String, Object>>();
					  
					  	
					  	
					  	List<Map<String, Object>> vss = new ArrayList<Map<String, Object>>();
					  

					  	PuntoMisuraDTO punto=null;
						
					  	for (int b = 0; b < punti; b++) 
						{
							 punto =listaPuntiPerTabella.get(indicePunto);
							 
							 if(punto.getApplicabile() != null && punto.getApplicabile().equals("N")) {
							 
								 data.setTipoProva(punto.getTipoProva());
								 
								values = new HashMap<String, Object>(); 
								values.put("tv", punto.getTipoVerifica());
								tipoVerifica.add(values);
								
								/*ASLEFT - ASFOUND*/
							    data.setAsLeftAsFound(punto.getCalibrazione());
							  	
							  	values = new HashMap<String, Object>();
							  	values.put("um", "N/A");
							  	ums.add(values);
							  
							  	
								values = new HashMap<String, Object>();
							  	values.put("vc", "N/A");
							  	vcs.add(values);
							  
							  	
								values = new HashMap<String, Object>();
							  	values.put("vs", "N/A");
						  	
							 }else {
								 data.setTipoProva(punto.getTipoProva());
								 
									values = new HashMap<String, Object>(); 
									values.put("tv", punto.getTipoVerifica());
									tipoVerifica.add(values);
								  
									/*ASLEFT - ASFOUND*/
								    data.setAsLeftAsFound(punto.getCalibrazione());
								  	
								  	
								  	values = new HashMap<String, Object>();
								  	values.put("um", punto.getUm());
								  	ums.add(values);
								  
								  	
									values = new HashMap<String, Object>();
								  	values.put("vc", Utility.changeDotComma(punto.getValoreCampione().setScale(Utility.getScale(punto.getRisoluzione_campione()), RoundingMode.HALF_UP).toPlainString()));
								  	vcs.add(values);
								  
								  	
									values = new HashMap<String, Object>();
								  	values.put("vs", Utility.changeDotComma(punto.getValoreStrumento().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).toPlainString()));
							 }
							 vss.add(values);
						  	indicePunto++;
						  	
						}
						
					  	 if(punto.getApplicabile() != null && punto.getApplicabile().equals("N")) {
							  	data.setValoreMedioCampione("N/A");
								data.setValoreMedioStrumento("N/A");
							  	data.setScostamento_correzione("N/A");
							  	data.setAccettabilita("N/A");
							  	data.setIncertezza("N/A");
							  	data.setEsito("N/A");
					  	 
					  	 }else {
							  	data.setValoreMedioCampione(Utility.changeDotComma(punto.getValoreMedioCampione().setScale(Utility.getScale(punto.getRisoluzione_campione()), RoundingMode.HALF_UP).toPlainString()));
								data.setValoreMedioStrumento(Utility.changeDotComma(punto.getValoreMedioStrumento().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).toPlainString()));
							
								if(tipoRapporto.equals("SVT")) 
								{
									data.setScostamento_correzione(Utility.changeDotComma(punto.getScostamento().setScale(Utility.getScale(punto.getRisoluzione_misura())+1, RoundingMode.HALF_UP).toPlainString()));
								}
								else 
								{
									data.setScostamento_correzione(Utility.changeDotComma(punto.getScostamento().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).toPlainString()));	
								}
							  //	data.setAccettabilita(Utility.changeDotComma(punto.getAccettabilita().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).toPlainString()));

								/*
							  	 * Accetabilità 
							  	 */
							  	if(punto.getSelTolleranza()==0)
							  	{
							  		String um = "";
							  		if(punto.getUm_calc()!=null && !punto.getUm_calc().equals("")){
							  			um = punto.getUm_calc();
							  		}else{
							  			um = punto.getUm();
							  		}
							  		
							  		data.setAccettabilita(Utility.changeDotComma(punto.getAccettabilita().setScale(Utility.getScale(punto.getRisoluzione_misura())+2, RoundingMode.HALF_UP).stripTrailingZeros().toPlainString()));
							  	}
								if(punto.getSelTolleranza()==1)
							  	{
									String perc = " (" + punto.getPer_util()+"%)";	
								  	data.setAccettabilita(Utility.changeDotComma(punto.getAccettabilita().setScale(Utility.getScale(punto.getRisoluzione_misura())+2, RoundingMode.HALF_UP).stripTrailingZeros().toPlainString())+perc);
							  	}
								if(punto.getSelTolleranza()==2)
							  	{
									String perc = " (" +Utility.changeDotComma(punto.getPer_util()+"% FS["+punto.getFondoScala().stripTrailingZeros().toPlainString())+"])";	
								  	data.setAccettabilita(Utility.changeDotComma(punto.getAccettabilita().setScale(Utility.getScale(punto.getRisoluzione_misura())+2, RoundingMode.HALF_UP).stripTrailingZeros().toPlainString())+perc);
							  	}
								if(punto.getSelTolleranza()==3)
							  	{
							   
									BigDecimal valoreMisura = punto.getMisura();
									Double percentualeUtil = punto.getPer_util();
									
									BigDecimal percentuale = valoreMisura.multiply(new BigDecimal(percentualeUtil)).divide(BigDecimal.valueOf(100),RoundingMode.HALF_UP);
									
									BigDecimal dgt = punto.getAccettabilita().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).subtract(percentuale).stripTrailingZeros();
									
									String perc ="("+ dgt +" + "+punto.getPer_util()+"%)";	
									data.setAccettabilita(Utility.changeDotComma(punto.getAccettabilita().setScale(Utility.getScale(punto.getRisoluzione_misura())+2, RoundingMode.HALF_UP).stripTrailingZeros().toPlainString())+perc);
							  	}
								
							  	BigDecimal bd = punto.getIncertezza();
								bd = bd.round(new MathContext(2, RoundingMode.HALF_UP));
								data.setIncertezza(Utility.changeDotComma(bd.toPlainString()));
							  	
							  	data.setEsito(punto.getEsito());
					  	 }
						data.setTipoVerifica(tipoVerifica);
					  	data.setUnitaDiMisura(ums);
					  	data.setValoreCampione(vcs);
					  	data.setValoreStrumento(vss);
					  	 
						
					  	dataSource.get(i).add(data);
					}
				 
				 
			 }
			
			
			}	
			
		}
			
			for (int j = 0; j < dataSource.size(); j++) 
			{
				
				if(dataSource.get(j).size()>0)
				{
			  	
				if(misura.getStrumento().getTipoRapporto().getNoneRapporto().equals("RDT"))
				{
					if(dataSource.get(j).get(0).getTipoProva().startsWith("L"))
					{
					listaTabelle.put("L_R_"+j,dataSource.get(j));
					}
					if(dataSource.get(j).get(0).getTipoProva().startsWith("R"))
					{
				  	listaTabelle.put("R_R_"+j,dataSource.get(j));
					}	
					if(dataSource.get(j).get(0).getTipoProva().startsWith("D"))
					{
				  	listaTabelle.put("D_R_"+j,dataSource.get(j));
					}	
				}
			
			if(misura.getStrumento().getTipoRapporto().getNoneRapporto().equals("SVT"))
				{
					if(dataSource.get(j).get(0).getTipoProva().startsWith("L"))
					{
					listaTabelle.put("L_S_"+j,dataSource.get(j));
					}
					if(dataSource.get(j).get(0).getTipoProva().startsWith("R"))
					{
				  	listaTabelle.put("R_S_"+j,dataSource.get(j));
					}	
					if(dataSource.get(j).get(0).getTipoProva().startsWith("D"))
					{
				  	listaTabelle.put("D_S_"+j,dataSource.get(j));
					}	
				
				}
				if(misura.getStrumento().getTipoRapporto().getNoneRapporto().equals("RDP")) 
				{
					listaTabelle.put("RDP",dataSource.get(j));
				}
				

				
				  }
			}			
			return listaTabelle;
		}


		public static String getIsIdoneo(MisuraDTO misura) {
			
			
 			int nTabelle=GestioneMisuraBO.getMaxTabellePerMisura(misura.getListaPunti());
			
			/*istanzio le tabelle*/
			
			ArrayList<List<ReportSVT_DTO>> dataSource =new ArrayList<List<ReportSVT_DTO>>();
			
			for (int i = 0; i < nTabelle; i++) {
				
				dataSource.add(new ArrayList<ReportSVT_DTO>());
			}
			
			for(int i=0;i<nTabelle;i++)
			{
				
				ArrayList<PuntoMisuraDTO> listaPuntiPerTabella=GestioneMisuraBO.getListaPuntiByIdTabella(misura.getListaPunti(),i+1);
				
				if(listaPuntiPerTabella.size()>0)
				{	
				 if(listaPuntiPerTabella.get(0).getTipoProva().startsWith("L") || listaPuntiPerTabella.get(0).getTipoProva().startsWith("D"))				
				 {
					/*Gestione Linearità*/ 
					for (int j = 0; j < listaPuntiPerTabella.size(); j++) 
					{
						PuntoMisuraDTO punto =listaPuntiPerTabella.get(j);
						
						 if(punto.getCalibrazione()!=null ) 
						 {
							if( punto.getEsito().equals("NON IDONEO") && !punto.getCalibrazione().equals("ASF"))
							{
								return "NON IDONEO - <i>UNSUITABLE</i>";
							}
						 }
						 else 
						 {
							 if( punto.getEsito().equals("NON IDONEO"))
							 {
									return "NON IDONEO - <i>UNSUITABLE</i>";
							 }
						 }
	
					}
				 }
				 else
				 {
					 /*Gestione Ripetibilità*/ 
					String[] strutturaProva=listaPuntiPerTabella.get(0).getTipoProva().split("_");
					
					int ripetizioni =Integer.parseInt(strutturaProva[2]);
					int punti =Integer.parseInt(strutturaProva[1]);
					 
						
						int indicePunto=0;
						for (int a = 0; a < ripetizioni; a++) 
						{
	
							PuntoMisuraDTO punto=null;
							
						  	for (int b = 0; b < punti; b++) 
							{
								 punto =listaPuntiPerTabella.get(indicePunto);
	
								 if(punto.getCalibrazione()!=null ) 
								 {
									if( punto.getEsito().equals("NON IDONEO") && !punto.getCalibrazione().equals("ASF"))
									{
										return "NON IDONEO - <i>UNSUITABLE</i>";
									}
								 }else 
								 {
									 if( punto.getEsito().equals("NON IDONEO"))
									 {
											return "NON IDONEO - <i>UNSUITABLE</i>";
									 }
								 }
							  	indicePunto++;
							}
						  
							
	
						}
					 
					 
				 }
				}
			}	
			
			return "IDONEO - <i>SUITABLE</i>";
		}

		
//	public static LinkedHashMap<String, String> getListaClientiCertificato() throws Exception 
//	{
//		return GestioneCertificatoDAO.getClientiPerCertificato();
//	}
		public static LinkedHashMap<String, String> getListaClientiCertificato(int id_company, UtenteDTO utente) throws Exception 
		{
			return GestioneCertificatoDAO.getClientiPerCertificato(id_company,utente);
		}

	public static File createCertificatoMulti(String id, String data_emissione, Session session, ServletContext context, UtenteDTO utente) throws Exception {
		 

			CertificatoDTO certificato = getCertificatoById(id);
			
			MisuraDTO misura = certificato.getMisura();
		    
			StrumentoDTO strumento = misura.getStrumento();
			

			 if(certificato.getMisura().getLat().equals("E") || certificato.getMisura().getLat().equals("S")) {
				
			
				return new File(Costanti.PATH_FOLDER+certificato.getMisura().getIntervento().getNomePack()+"\\"+certificato.getMisura().getIntervento().getNomePack()+"_" + certificato.getMisura().getInterventoDati().getId()+""+certificato.getMisura().getStrumento().get__id()+".pdf");
				
				 
			}
			else {
					
					
				LinkedHashMap<String,List<ReportSVT_DTO>> listaTabelle = new LinkedHashMap<String, List<ReportSVT_DTO>>();
				
				
				listaTabelle= getListaTabelle(misura,strumento.getTipoRapporto().getNoneRapporto());
				
		
				List<CampioneDTO> listaCampioni = GestioneMisuraBO.getListaCampioni(misura.getListaPunti(),strumento.getTipoRapporto());
				
			//	String idoneo = getIsIdoneo(misura);
				String idoneo;
				if(!strumento.getTipoRapporto().getNoneRapporto().equals("RDP")) {
					idoneo = getIsIdoneo(misura);
				}else {
					idoneo = null;
				}
	            DRDataSource listaProcedure = new DRDataSource("listaProcedure");
	 			listaProcedure.add(strumento.getProcedura());
	
	 		  CreateCertificato cert = new CreateCertificato(misura,data_emissione, certificato,listaTabelle, listaCampioni, listaProcedure, strumento,idoneo,session,context,false, true, utente);
					
	 		  return cert.file;
			}
			

	}

	public static ArrayList<CertificatoDTO> getListaCertificatoByIntervento(StatoCertificatoDTO stato,InterventoDTO intervento, CompanyDTO cmp, UtenteDTO utente, String obsoleto, String idCliente, String idSede) throws Exception {
		
		return GestioneCertificatoDAO.getListaCertificatiByIntervento(stato, intervento, cmp, utente, obsoleto, idCliente, idSede);
	}

	public static ArrayList<CertificatoDTO> getListaCertificatiChiusiStrumento(Integer id_strumento, Session session) {
		
		return GestioneCertificatoDAO.getListaCertificatiChiusiStrumento(id_strumento, session);
	}
	
	public static ArrayList<CertificatoDTO> getListaCertificatiCampioneStrumento(Integer id_strumento, Session session) {
		
		return GestioneCertificatoDAO.getListaCertificatiCampioneStrumento(id_strumento, session);
	}

	public static void uploadCertificato(FileItem item, String pack, int idInt, int id_strumento) {
		
		
		String filename=pack+"_"+idInt+""+id_strumento+".pdf";
		File file = new File(Costanti.PATH_FOLDER+pack+"\\"+filename);

		//File file = new File(folder.getPath() +"\\"+ filename);
		
			while(true) {		
				
				try {
					item.write(file);
					
					break;
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					break;
				}
				
		
			}
		
	}

	public static JsonObject addSign(UtenteDTO utente, String keyWord, boolean multi, CertificatoDTO certificato) throws Exception {
		
		
		String path = Costanti.PATH_FOLDER+certificato.getMisura().getIntervento().getNomePack()+"\\"+certificato.getNomeCertificato();
		
		if(multi) {
			path = Costanti.PATH_FOLDER+"\\temp\\"+certificato.getNomeCertificato();
			
		}
		String path_stamper = Costanti.PATH_FOLDER+"\\temp\\"+certificato.getNomeCertificato();
	    PdfReader reader = new PdfReader(path);
	        
	    if(multi) {
	    	path_stamper = Costanti.PATH_FOLDER+"\\temp\\"+certificato.getNomeCertificato().substring(0, certificato.getNomeCertificato().length()-4)+"new.pdf";
	    }
	    
	    PdfStamper stamper = new PdfStamper(reader,new FileOutputStream(path_stamper)); 
	    
	    Image image = Image.getInstance(Costanti.PATH_FOLDER + "FileFirme\\"+utente.getFile_firma());

	    image.setAnnotation(new Annotation(0, 0, 0, 0, 3));	    
	    
	    Integer[] fontPosition = null;
		for(int i = 1;i<=reader.getNumberOfPages();i++) {
			fontPosition = getFontPosition(reader, keyWord, i);
			
			if(fontPosition[0] != null && fontPosition[1] != null) {
				
				int x = fontPosition[0] - 15;
				int y = fontPosition[1] +10;
				int w = x + 85;
				int h = y + 31;
				
				 Rectangle rect = new Rectangle(x, y, w, h);
			    
				 image.scaleAbsolute(rect);
				
				image.setAbsolutePosition(fontPosition[0] - 15 , fontPosition[1] -25);
				PdfContentByte content = stamper.getOverContent(i);
				content.addImage(image);
				
				break;
			}
		}
		
		stamper.close();
		reader.close();
	    System.out.println(Arrays.toString(fontPosition));
	    if(!multi) {
	    File targetFile=  new File(path);
		File source = new File(Costanti.PATH_FOLDER+"\\temp\\"+certificato.getNomeCertificato());
     	FileUtils.copyFile(source, targetFile);
     	
     	
     		source.delete();
     	}else {
     		File targetFile=  new File(path);
     		File source = new File(Costanti.PATH_FOLDER+"\\temp\\"+certificato.getNomeCertificato().substring(0, certificato.getNomeCertificato().length()-4)+"new.pdf");
          	FileUtils.copyFile(source, targetFile);
     	}
	    JsonObject myObj = new JsonObject();
	    
     	myObj.addProperty("success", true);
		return myObj;
	}
	
	
	
	private static Integer[] getFontPosition(  PdfReader pdfReader, final String keyWord, Integer pageNum) throws IOException {
	    final Integer[] result = new Integer[2];
	    if (pageNum == null) {
	        pageNum = pdfReader.getNumberOfPages();
	    }
	    new PdfReaderContentParser(pdfReader).processContent(pageNum, new RenderListener() {
	        public void beginTextBlock() {

	        }

	        public void renderText(TextRenderInfo textRenderInfo) {
	        	
	            String text = textRenderInfo.getText();
	          //  System.out.println("text is ：" + text);
	            if (text != null && text.contains(keyWord)) {
	                                     // The abscissa and ordinate of the text in the page
	                com.itextpdf.awt.geom.Rectangle2D.Float textFloat = textRenderInfo.getBaseline().getBoundingRectange();
	                float x = textFloat.x;
	                float y = textFloat.y;
	                result[0] = (int) x;
	                result[1] = (int) y;
	                 //                    System.out.println(String.format("The signature text field absolute position is x:%s, y:%s", x, y));
	            }
	        }

	        public void endTextBlock() {

	        }

	        public void renderImage(ImageRenderInfo renderInfo) {

	        }
	    });
	    return result;
	}

	public static ArrayList<Integer> getListaAnni(String idCliente, String idSede, Session session) {
		
		return GestioneCertificatoDAO.getListaAnni(idCliente, idSede, session);
	}

}
