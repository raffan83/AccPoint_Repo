package it.portaleSTI.bo;

import it.portaleSTI.DAO.GestioneCertificatoDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.InterventoDatiDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.PuntoMisuraDTO;
import it.portaleSTI.DTO.ReportSVT_DTO;
import it.portaleSTI.DTO.StatoCertificatoDTO;
import it.portaleSTI.DTO.StrumentoDTO;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import net.sf.dynamicreports.report.datasource.DRDataSource;

public class GestioneCertificatoBO {
	
	
		public static ArrayList<CertificatoDTO> getListaCertificato(StatoCertificatoDTO stato,InterventoDatiDTO intervento) throws Exception
		{
				
				return GestioneCertificatoDAO.getListaCertificati(stato,intervento);
			
		}

		
		public static void main(String[] args) {
			try {
				ArrayList<CertificatoDTO> listaCert=getListaCertificato(null, null);
				
				for (CertificatoDTO certificatoDTO : listaCert) {
					
					System.out.println("ID intervento: " +certificatoDTO.getMisura().getIntervento().getId() + 
							           " ID interventoDati: "+certificatoDTO.getMisura().getInterventoDati().getId()+
										" Misura: "+certificatoDTO.getMisura().getId());
					
				}
				System.out.println(listaCert.size());
				
					
				MisuraDTO misura = listaCert.get(0).getMisura();
			    
				StrumentoDTO strumento = misura.getStrumento();
						
						
				LinkedHashMap<String,List<ReportSVT_DTO>> listaTabelle = new LinkedHashMap<String, List<ReportSVT_DTO>>();
				
				
				listaTabelle= getListaTabelle(misura);
				
  	
				List<CampioneDTO> listaCampioni = GestioneMisuraBO.getListaCampioni(misura.getListaPunti());

							  DRDataSource listaProcedure = new DRDataSource("listaProcedure");
								 
							  listaProcedure.add("Procedura1");
							  listaProcedure.add("Procedura2");
							  listaProcedure.add("Procedura3");
							
						new CreateCertificato(listaTabelle, listaCampioni, listaProcedure, strumento);
					
				
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
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
				  	
				  	values.put("vc", punto.getValoreCampione().toPlainString());
				  	vcs2.add(values);
				  	
				  	List<Map<String, Object>> vss2 = new ArrayList<Map<String, Object>>();
				  	values = new HashMap<String, Object>();
				  	
				  	values.put("vs", punto.getValoreStrumento().toPlainString());
				  	vss2.add(values);

				  	
				  	
				  	data.setTipoVerifica(tipoVerifica);
				  	data.setUnitaDiMisura(ums);
				  	data.setValoreCampione(vcs2);
				  	data.setValoreMedioCampione(punto.getValoreCampione().toPlainString());
				  	data.setValoreStrumento(vss2);
				  	data.setValoreMedioStrumento(punto.getValoreStrumento().toPlainString());
				  	data.setScostamento_correzione(punto.getScostamento().toPlainString());
				  	data.setAccettabilita(punto.getAccettabilita().toPlainString());
				  	data.setIncertezza(punto.getIncertezza().toPlainString());
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
						  	values.put("vc", punto.getValoreCampione().toPlainString());
						  	vcs.add(values);
						  
						  	
							values = new HashMap<String, Object>();
						  	values.put("vs", punto.getValoreStrumento().toPlainString());
						  	vss.add(values);
						  	
						  	indicePunto++;
						}
						
						data.setTipoVerifica(tipoVerifica);
					  	data.setUnitaDiMisura(ums);
					  	data.setValoreCampione(vcs);
					  	data.setValoreMedioCampione(punto.getValoreMedioCampione().toPlainString());
					  	data.setValoreStrumento(vss);
					  	data.setValoreMedioStrumento(punto.getValoreMedioStrumento().toPlainString());
					  	data.setScostamento_correzione(punto.getScostamento().toPlainString());
					  	data.setAccettabilita(punto.getAccettabilita().toPlainString());
					  	data.setIncertezza(punto.getIncertezza().toPlainString());
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


	

		
	
}
