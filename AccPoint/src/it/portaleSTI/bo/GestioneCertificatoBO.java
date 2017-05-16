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
				
/*				
				List<ReportSVT_DTO> datasource = new ArrayList<ReportSVT_DTO>();
				List<ReportSVT_DTO> datasource2 = new ArrayList<ReportSVT_DTO>();

				Map<String, Object> values = new HashMap<String, Object>();



							ReportSVT_DTO data = new ReportSVT_DTO();
						  	
							List<Map<String, Object>> comments = new ArrayList<Map<String, Object>>();
						  	values.put("tv", "comment1comment1comment1");
						  	comments.add(values);
						  	values = new HashMap<String, Object>();
						  	values.put("tv", "comment2");
						  	comments.add(values);
						  	values = new HashMap<String, Object>();
						  	values.put("tv", "comment3");
						  	comments.add(values);

						  	
						  	
						  	List<Map<String, Object>> ums = new ArrayList<Map<String, Object>>();
						  	values = new HashMap<String, Object>();
						  	
						  	values.put("um", "um1");
						  	ums.add(values);
						  	values = new HashMap<String, Object>();
						  	values.put("um", "um2");
						  	ums.add(values);
						  	values = new HashMap<String, Object>();
						  	values.put("um", "um3");
						  	ums.add(values);
						  	
						  	
						  	List<Map<String, Object>> vcs = new ArrayList<Map<String, Object>>();
						  	values = new HashMap<String, Object>();
						  	
						  	values.put("vc", "0,5");
						  	vcs.add(values);
						  	values = new HashMap<String, Object>();
						  	values.put("vc", "0,5");
						  	vcs.add(values);
						  	values = new HashMap<String, Object>();
						  	values.put("vc", "0,5");
						  	vcs.add(values);
						  	
						  	
						  	List<Map<String, Object>> vss = new ArrayList<Map<String, Object>>();
						  	values = new HashMap<String, Object>();
						  	
						  	values.put("vs", "0,5");
						  	vss.add(values);
						  	values = new HashMap<String, Object>();
						  	values.put("vs", "0,5");
						  	vss.add(values);
						  	values = new HashMap<String, Object>();
						  	values.put("vs", "0,5");
						  	vss.add(values);
						  	
						  	
						  	data.setTipoVerifica(comments);
						  	data.setUnitaDiMisura(ums);
						  	data.setValoreCampione(vcs);
						  	data.setValoreMedioCampione("0,5");
						  	data.setValoreStrumento(vss);
						  	data.setValoreMedioStrumento("0,498");
						  	data.setScostamento_correzione("0,002");
						  	data.setAccettabilita("0,004");
						  	data.setIncertezza("0,001");
						  	data.setEsito("IDONEO");
						  	
						  	
						  	
						  	ReportSVT_DTO data2 = new ReportSVT_DTO();
						  	
							List<Map<String, Object>> comments2 = new ArrayList<Map<String, Object>>();
						  	values.put("tv", "comment1comment1comment1comment1comment1");
						  	comments2.add(values);


						  	
						  	
						  	List<Map<String, Object>> ums2 = new ArrayList<Map<String, Object>>();
						  	values = new HashMap<String, Object>();
						  	
						  	values.put("um", "um1");
						  	ums2.add(values);

						  	
						  	List<Map<String, Object>> vcs2 = new ArrayList<Map<String, Object>>();
						  	values = new HashMap<String, Object>();
						  	
						  	values.put("vc", "0,5");
						  	vcs2.add(values);

						  	
						  	
						  	List<Map<String, Object>> vss2 = new ArrayList<Map<String, Object>>();
						  	values = new HashMap<String, Object>();
						  	
						  	values.put("vs", "0,5");
						  	vss2.add(values);

						  	
						  	
						  	data2.setTipoVerifica(comments2);
						  	data2.setUnitaDiMisura(ums2);
						  	data2.setValoreCampione(vcs2);
						  	data2.setValoreMedioCampione("0,5");
						  	data2.setValoreStrumento(vss2);
						  	data2.setValoreMedioStrumento("0,498");
						  	data2.setScostamento_correzione("0,002");
						  	data2.setAccettabilita("0,004");
						  	data2.setIncertezza("0,001");
						  	data2.setEsito("IDONEO");
						  	
						  	datasource.add(data);
						  	datasource.add(data);
						  	
						  	
						  	datasource2.add(data2);
						  	datasource2.add(data2);
						  	datasource2.add(data2);

						  	
						  	datasource2.add(data2);
						  	datasource2.add(data2);
						  	datasource2.add(data2);

						  	
						  	listaTabelle.put("R_S",datasource);	
						  	
						  	//listaTabelle.put("L_R",datasource2);

						  	//listaTabelle.put("R_R",datasource);	
							
						  	listaTabelle.put("L_S",datasource2);
						  	
							List<CampioneDTO> listaCampioni = new ArrayList<CampioneDTO>();

							CampioneDTO campione = new CampioneDTO();
							campione.setCodice("Campione 1");
							campione.setDataScadenza(new Date());
							listaCampioni.add(campione);
							campione = new CampioneDTO();
							campione.setCodice("Campione 2");
							campione.setDataScadenza(new Date());
							listaCampioni.add(campione);
							

							
							  DRDataSource listaProcedure = new DRDataSource("listaProcedure");
								 
							  listaProcedure.add("Procedura1");
							  listaProcedure.add("Procedura2");
							  listaProcedure.add("Procedura3");
							
						new CreateCertificato(listaTabelle, listaCampioni, listaProcedure, strumento);*/
					
				
				
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
				  	
				  	values.put("vc", punto.getValoreCampione());
				  	vcs2.add(values);
				  	
				  	List<Map<String, Object>> vss2 = new ArrayList<Map<String, Object>>();
				  	values = new HashMap<String, Object>();
				  	
				  	values.put("vs", punto.getValoreStrumento());
				  	vss2.add(values);

				  	
				  	
				  	data.setTipoVerifica(tipoVerifica);
				  	data.setUnitaDiMisura(ums);
				  	data.setValoreCampione(vcs2);
				  	data.setValoreMedioCampione(""+punto.getValoreCampione());
				  	data.setValoreStrumento(vss2);
				  	data.setValoreMedioStrumento(""+punto.getValoreStrumento());
				  	data.setScostamento_correzione(""+punto.getScostamento());
				  	data.setAccettabilita(data.getAccettabilita());
				  	data.setIncertezza(data.getIncertezza());
				  	data.setEsito(data.getEsito());
				  	
				  	dataSource.get(i).add(data);
					
				}
			 }
			 else
			 {
				 /*Gestione Ripetibilità*/ 
				String[] strutturaProva=listaPuntiPerTabella.get(0).getTipoProva().split("_");
				
				int ripetizioni =Integer.parseInt(strutturaProva[2]);
				int punti =Integer.parseInt(strutturaProva[1]);
				 
					
					for (int a = 0; a < ripetizioni; a++) 
					{
						
						ReportSVT_DTO data = new ReportSVT_DTO();
						
						Map<String, Object> values = new HashMap<String, Object>();
						
						List<Map<String, Object>> tipoVerifica = new ArrayList<Map<String, Object>>();
					  	
					  	List<Map<String, Object>> ums = new ArrayList<Map<String, Object>>();
					  	
					  	
					  	
					  	List<Map<String, Object>> vcs = new ArrayList<Map<String, Object>>();
					  
					  	
					  	
					  	List<Map<String, Object>> vss = new ArrayList<Map<String, Object>>();
					  
					  	
					  	
					  	
						
						for (int b = 0; b < punti; b++) 
						{
							values.put("tv", "comment1comment1comment1");
							tipoVerifica.add(values);
						  
						  	
						  	values = new HashMap<String, Object>();
						  	values.put("um", "um1");
						  	ums.add(values);
						  	values = new HashMap<String, Object>();
						  	values.put("um", "um2");
						  	ums.add(values);
						  	values = new HashMap<String, Object>();
						  	values.put("um", "um3");
						  	ums.add(values);
						  	
							values = new HashMap<String, Object>();
						  	
						  	values.put("vc", "0,5");
						  	vcs.add(values);
						  	values = new HashMap<String, Object>();
						  	values.put("vc", "0,5");
						  	vcs.add(values);
						  	values = new HashMap<String, Object>();
						  	values.put("vc", "0,5");
						  	vcs.add(values);
						  	
							values = new HashMap<String, Object>();
						  	
						  	values.put("vs", "0,5");
						  	vss.add(values);
						  	values = new HashMap<String, Object>();
						  	values.put("vs", "0,5");
						  	vss.add(values);
						  	values = new HashMap<String, Object>();
						  	values.put("vs", "0,5");
						  	vss.add(values);
						  			
						}
						
						data.setTipoVerifica(tipoVerifica);
					  	data.setUnitaDiMisura(ums);
					  	data.setValoreCampione(vcs);
					  	data.setValoreMedioCampione("0,5");
					  	data.setValoreStrumento(vss);
					  	data.setValoreMedioStrumento("0,498");
					  	data.setScostamento_correzione("0,002");
					  	data.setAccettabilita("0,004");
					  	data.setIncertezza("0,001");
					  	data.setEsito("IDONEO");
						
					}
				 
				 
			 }
			
			
			}	
			
			
			return listaTabelle;
		}


	

		
	
}
