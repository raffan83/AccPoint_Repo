package it.portaleSTI.bo;


import it.portaleSTI.DAO.GestioneCertificatoDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.InterventoDatiDTO;
import it.portaleSTI.DTO.MagItemDTO;
import it.portaleSTI.DTO.MagItemPaccoDTO;
import it.portaleSTI.DTO.MagPaccoDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.PuntoMisuraDTO;
import it.portaleSTI.DTO.ReportSVT_DTO;

import it.portaleSTI.DTO.StatoCertificatoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;

import java.io.File;
import java.math.BigDecimal;
import java.math.MathContext;
import java.math.RoundingMode;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.apache.commons.fileupload.FileItem;
import org.hibernate.Session;

import net.sf.dynamicreports.report.datasource.DRDataSource;

public class GestioneCertificatoBO {
	
	
		public static ArrayList<CertificatoDTO> getListaCertificato(StatoCertificatoDTO stato,InterventoDatiDTO intervento, CompanyDTO cmp, UtenteDTO utente, String obsoleto, String idCliente, String idSede) throws Exception
		{
				
				return GestioneCertificatoDAO.getListaCertificati(stato,intervento,cmp,utente, obsoleto, idCliente, idSede);
			
		}
		
		public static CertificatoDTO getCertificatoById(String id)
		{
			return GestioneCertificatoDAO.getCertificatoById(id);
		}

		
		public static String createCertificato(String idCertificato,Session session, ServletContext context, UtenteDTO utente) throws Exception {
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

				new CreateCertificato(misura,certificato,listaTabelle, listaCampioni, listaProcedure, strumento,idoneo,session,context,true, utente);
					
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
		    		
					
			} catch (Exception e) {
				e.printStackTrace();
				throw e;
			}
			return null;
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
					  		
					  		data.setAccettabilita(Utility.changeDotComma(punto.getAccettabilita().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).toPlainString()));
					  	}
						if(punto.getSelTolleranza()==1)
					  	{
							String perc = " (" + punto.getPer_util()+"%)";	
						  	data.setAccettabilita(Utility.changeDotComma(punto.getAccettabilita().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).toPlainString())+perc);
					  	}
						if(punto.getSelTolleranza()==2)
					  	{
							String perc = " (" +Utility.changeDotComma(punto.getPer_util()+"% FS["+punto.getFondoScala().stripTrailingZeros().toPlainString())+"])";	
						  	data.setAccettabilita(Utility.changeDotComma(punto.getAccettabilita().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).toPlainString())+perc);
					  	}
						if(punto.getSelTolleranza()==3)
					  	{
					   
							BigDecimal valoreMisura = punto.getMisura();
							Double percentualeUtil = punto.getPer_util();
							
							BigDecimal percentuale = valoreMisura.multiply(new BigDecimal(percentualeUtil)).divide(BigDecimal.valueOf(100),RoundingMode.HALF_UP);
							
						//	BigDecimal dgt = punto.getAccettabilita().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).subtract(percentuale).stripTrailingZeros();
							
							String perc ="("+ punto.getDgt().stripTrailingZeros() +" + "+punto.getPer_util()+"%)";	
							data.setAccettabilita(Utility.changeDotComma(punto.getAccettabilita().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).toPlainString())+perc);
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
							  		
							  		data.setAccettabilita(Utility.changeDotComma(punto.getAccettabilita().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).toPlainString()));
							  	}
								if(punto.getSelTolleranza()==1)
							  	{
									String perc = " (" + punto.getPer_util()+"%)";	
								  	data.setAccettabilita(Utility.changeDotComma(punto.getAccettabilita().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).toPlainString())+perc);
							  	}
								if(punto.getSelTolleranza()==2)
							  	{
									String perc = " (" +Utility.changeDotComma(punto.getPer_util()+"% FS["+punto.getFondoScala().stripTrailingZeros().toPlainString())+"])";	
								  	data.setAccettabilita(Utility.changeDotComma(punto.getAccettabilita().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).toPlainString())+perc);
							  	}
								if(punto.getSelTolleranza()==3)
							  	{
							   
									BigDecimal valoreMisura = punto.getMisura();
									Double percentualeUtil = punto.getPer_util();
									
									BigDecimal percentuale = valoreMisura.multiply(new BigDecimal(percentualeUtil)).divide(BigDecimal.valueOf(100),RoundingMode.HALF_UP);
									
									BigDecimal dgt = punto.getAccettabilita().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).subtract(percentuale).stripTrailingZeros();
									
									String perc ="("+ dgt +" + "+punto.getPer_util()+"%)";	
									data.setAccettabilita(Utility.changeDotComma(punto.getAccettabilita().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).toPlainString())+perc);
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

	public static File createCertificatoMulti(String id, Session session, ServletContext context, UtenteDTO utente) throws Exception {
		 

			CertificatoDTO certificato = getCertificatoById(id);
			
			MisuraDTO misura = certificato.getMisura();
		    
			StrumentoDTO strumento = misura.getStrumento();
					
					
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

 		  CreateCertificato cert = new CreateCertificato(misura,certificato,listaTabelle, listaCampioni, listaProcedure, strumento,idoneo,session,context,false, utente);
				
 		  return cert.file;
		 

	}

	public static ArrayList<CertificatoDTO> getListaCertificatoByIntervento(StatoCertificatoDTO stato,InterventoDTO intervento, CompanyDTO cmp, UtenteDTO utente, String obsoleto, String idCliente, String idSede) throws Exception {
		
		return GestioneCertificatoDAO.getListaCertificatiByIntervento(stato, intervento, cmp, utente, obsoleto, idCliente, idSede);
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
}
