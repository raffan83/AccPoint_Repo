package it.portaleSTI.bo;

import it.portaleSTI.DAO.GestioneCertificatoDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.InterventoDatiDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.PuntoMisuraDTO;
import it.portaleSTI.DTO.ReportSVT_DTO;
import it.portaleSTI.DTO.ScadenzaDTO;
import it.portaleSTI.DTO.StatoCertificatoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.Util.Utility;

import java.math.RoundingMode;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.hibernate.Session;

import net.sf.dynamicreports.report.datasource.DRDataSource;

public class GestioneCertificatoBO {
	
	
		public static ArrayList<CertificatoDTO> getListaCertificato(StatoCertificatoDTO stato,InterventoDatiDTO intervento) throws Exception
		{
				
				return GestioneCertificatoDAO.getListaCertificati(stato,intervento);
			
		}
		
		public static CertificatoDTO getCertificatoById(String id)
		{
			return GestioneCertificatoDAO.getCertificatoById(id);
		}

		
		public static String createCertificato(String idCertificato,Session session, ServletContext context) throws Exception {
			try {
				
				
				CertificatoDTO certificato = getCertificatoById(idCertificato);
				
				MisuraDTO misura = certificato.getMisura();
			    
				StrumentoDTO strumento = misura.getStrumento();
						
						
				LinkedHashMap<String,List<ReportSVT_DTO>> listaTabelle = new LinkedHashMap<String, List<ReportSVT_DTO>>();
				
				
				listaTabelle= getListaTabelle(misura);
				
  	
				List<CampioneDTO> listaCampioni = GestioneMisuraBO.getListaCampioni(misura.getListaPunti());
				
				String idoneo = getIsIdoneo(misura);

	            DRDataSource listaProcedure = new DRDataSource("listaProcedure");
				
	         //   String procedure=strumento.get
				//			  listaProcedure.add("Procedura1");
				//			  listaProcedure.add("Procedura2");
				//			  listaProcedure.add("Procedura3");
							
						new CreateCertificato(misura,certificato,listaTabelle, listaCampioni, listaProcedure, strumento,idoneo,session,context);
					
					/*
					 * Aggiornata data Emissione su scadenzaDTO
					 */
				
						ScadenzaDTO scadenza =strumento.getScadenzaDTO();
						
						scadenza.setDataEmissione(new Date(System.currentTimeMillis()));
						
						GestioneStrumentoBO.updateScadenza(scadenza,session);
					
						
						/*
					 * cambio stato certificato 
					 */
						
					certificato.setStato(new StatoCertificatoDTO(2));
					
					updateCertificato(certificato,session);
				
			} catch (Exception e) {
				e.printStackTrace();
				throw e;
			}
			return null;
		}


		private static void updateCertificato(CertificatoDTO certificato,Session session)throws Exception {
			
			session.update(certificato);
			
		}

		private static LinkedHashMap<String, List<ReportSVT_DTO>> getListaTabelle(MisuraDTO misura) {
			
			LinkedHashMap<String,List<ReportSVT_DTO>> listaTabelle = new LinkedHashMap<String, List<ReportSVT_DTO>>();
			
			/*Otteniamo il numero di tabella per Misura*/
			
			int nTabelle=GestioneMisuraBO.getTabellePerMisura(misura.getListaPunti());
			
			/*istanzio le tabelle*/
			
			ArrayList<List<ReportSVT_DTO>> dataSource =new ArrayList<List<ReportSVT_DTO>>();
			
			for (int i = 0; i < nTabelle; i++) {
				
				dataSource.add(new ArrayList<ReportSVT_DTO>());
			}
			
			for(int i=0;i<nTabelle;i++)
			{
				
				ArrayList<PuntoMisuraDTO> listaPuntiPerTabella=GestioneMisuraBO.getListaPuntiByIdTabella(misura.getListaPunti(),i+1);
				
				
			 if(listaPuntiPerTabella.get(0).getTipoProva().startsWith("L"))
			 {
				/*Gestione Linearità*/ 
				for (int j = 0; j < listaPuntiPerTabella.size(); j++) 
				{
					PuntoMisuraDTO punto =listaPuntiPerTabella.get(j);
					
					ReportSVT_DTO data = new ReportSVT_DTO();
					data.setTipoProva(punto.getTipoProva());
					
					
					Map<String, Object> values = new HashMap<String, Object>();
					
					List<Map<String, Object>> tipoVerifica = new ArrayList<Map<String, Object>>();
				  	values.put("tv",punto.getTipoVerifica());
				  	tipoVerifica.add(values);
				  	
				  	List<Map<String, Object>> ums = new ArrayList<Map<String, Object>>();
				  	values = new HashMap<String, Object>();
				  	
				  	values.put("um", punto.getUm());
				  	ums.add(values);

				  	
				  	List<Map<String, Object>> vcs2 = new ArrayList<Map<String, Object>>();
				  	values = new HashMap<String, Object>();
				  	
				  	values.put("vc", punto.getValoreCampione().setScale(Utility.getScale(punto.getRisoluzione_campione()), RoundingMode.HALF_UP).toPlainString());
				  	vcs2.add(values);
				  	
				  	List<Map<String, Object>> vss2 = new ArrayList<Map<String, Object>>();
				  	values = new HashMap<String, Object>();
				  	
				  	values.put("vs", punto.getValoreStrumento().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).toPlainString());
				  	vss2.add(values);

				  	
				  	
				  	data.setTipoVerifica(tipoVerifica);
				  	data.setUnitaDiMisura(ums);
				  	data.setValoreCampione(vcs2);
				  	data.setValoreMedioCampione(punto.getValoreCampione().setScale(Utility.getScale(punto.getRisoluzione_campione()), RoundingMode.HALF_UP).toPlainString());
				  	data.setValoreStrumento(vss2);
				  	data.setValoreMedioStrumento(punto.getValoreStrumento().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).toPlainString());
				  	data.setScostamento_correzione(punto.getScostamento().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).toPlainString());
				  	
				  	/*
				  	 * Accetabilità 
				  	 */
				  	if(punto.getSelTolleranza()==0)
				  	{
				  	data.setAccettabilita(punto.getAccettabilita().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).toPlainString()+"(dgt/div)");
				  	}
					if(punto.getSelTolleranza()==1)
				  	{
					String perc ="("+punto.getPer_util()+" %)";	
				  	data.setAccettabilita(punto.getAccettabilita().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).toPlainString()+perc);
				  	}
					if(punto.getSelTolleranza()==2)
				  	{
					String perc ="("+punto.getPer_util()+" % FS["+punto.getFondoScala().stripTrailingZeros().toPlainString()+"])";	
				  	data.setAccettabilita(punto.getAccettabilita().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).toPlainString()+perc);
				  	}
					if(punto.getSelTolleranza()==3)
				  	{
				   
						String perc ="("+punto.getValoreStrumento().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).toPlainString()+" + "+punto.getPer_util()+" %)";	
				  	data.setAccettabilita(punto.getAccettabilita().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).toPlainString()+perc);
				  	}
				  	//data.setAccettabilita(punto.getAccettabilita().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).toPlainString());
				  	data.setIncertezza(punto.getIncertezza().setScale(Utility.getScaleIncertezza(punto.getIncertezza()), RoundingMode.HALF_UP).toPlainString());
				  	data.setEsito(punto.getEsito());
				  	
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
							System.out.println(punto.getValoreCampione());
							 data.setTipoProva(punto.getTipoProva());
							 
							values = new HashMap<String, Object>(); 
							values.put("tv", punto.getTipoVerifica());
							tipoVerifica.add(values);
						  
						  	
						  	values = new HashMap<String, Object>();
						  	values.put("um", punto.getUm());
						  	ums.add(values);
						  
						  	
							values = new HashMap<String, Object>();
						  	values.put("vc", punto.getValoreCampione().setScale(Utility.getScale(punto.getRisoluzione_campione()), RoundingMode.HALF_UP).toPlainString());
						  	vcs.add(values);
						  
						  	
							values = new HashMap<String, Object>();
						  	values.put("vs", punto.getValoreStrumento().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).toPlainString());
						  	vss.add(values);
						  	
						  	indicePunto++;
						}
						
						data.setTipoVerifica(tipoVerifica);
					  	data.setUnitaDiMisura(ums);
					  	data.setValoreCampione(vcs);
					  	data.setValoreMedioCampione(punto.getValoreMedioCampione().setScale(Utility.getScale(punto.getRisoluzione_campione()), RoundingMode.HALF_UP).toPlainString());
					  	data.setValoreStrumento(vss);
					  	data.setValoreMedioStrumento(punto.getValoreMedioStrumento().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).toPlainString());
					  	data.setScostamento_correzione(punto.getScostamento().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).toPlainString());
					  	data.setAccettabilita(punto.getAccettabilita().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).toPlainString());
					  	data.setIncertezza(punto.getIncertezza().setScale(Utility.getScale(punto.getRisoluzione_misura()), RoundingMode.HALF_UP).toPlainString());
					  	data.setEsito(punto.getEsito());
						
					  	dataSource.get(i).add(data);
					}
				 
				 
			 }
			
			
			}	
			
			for (int j = 0; j < dataSource.size(); j++) 
			{
			  	
				if(misura.getStrumento().getScadenzaDTO().getTipo_rapporto().getNoneRapporto().equals("RDT"))
				{
					if(dataSource.get(j).get(0).getTipoProva().startsWith("L"))
					{
					listaTabelle.put("L_R",dataSource.get(j));
					}
					if(dataSource.get(j).get(0).getTipoProva().startsWith("R"))
					{
				  	listaTabelle.put("R_R",dataSource.get(j));
					}	
				}
				else
				{
					if(dataSource.get(j).get(0).getTipoProva().startsWith("L"))
					{
					listaTabelle.put("L_S",dataSource.get(j));
					}
					if(dataSource.get(j).get(0).getTipoProva().startsWith("R"))
					{
				  	listaTabelle.put("R_S",dataSource.get(j));
					}	
				
				}
				
			}
						
			return listaTabelle;
		}


		private static String getIsIdoneo(MisuraDTO misura) {
			
			
			int nTabelle=GestioneMisuraBO.getTabellePerMisura(misura.getListaPunti());
			
			/*istanzio le tabelle*/
			
			ArrayList<List<ReportSVT_DTO>> dataSource =new ArrayList<List<ReportSVT_DTO>>();
			
			for (int i = 0; i < nTabelle; i++) {
				
				dataSource.add(new ArrayList<ReportSVT_DTO>());
			}
			
			for(int i=0;i<nTabelle;i++)
			{
				
				ArrayList<PuntoMisuraDTO> listaPuntiPerTabella=GestioneMisuraBO.getListaPuntiByIdTabella(misura.getListaPunti(),i+1);
				
					
				 if(listaPuntiPerTabella.get(0).getTipoProva().startsWith("L"))
				 {
					/*Gestione Linearità*/ 
					for (int j = 0; j < listaPuntiPerTabella.size(); j++) 
					{
						PuntoMisuraDTO punto =listaPuntiPerTabella.get(j);
						
						if( punto.getEsito().equals("NON IDONEO")){
							return "NON IDONEO";
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
	
									if( punto.getEsito().equals("NON IDONEO")){
										return "NON IDONEO";
									}
							  	
							  	indicePunto++;
							}
						  
							
	
						}
					 
					 
				 }
			
			
			}	
			
			return "IDONEO";
		}

		
	
}
