package it.portaleSTI.bo;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.TreeSet;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.hibernate.Session;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import it.portaleSTI.DTO.RilParticolareDTO;
import it.portaleSTI.DTO.RilPuntoQuotaDTO;
import it.portaleSTI.DTO.RilQuotaDTO;
import it.portaleSTI.DTO.RilQuotaFunzionaleDTO;
import it.portaleSTI.DTO.RilSimboloDTO;
import it.portaleSTI.Util.Utility;

public class CreateTabellaFromXML {
	
public CreateTabellaFromXML(InputStream fileContent,  RilParticolareDTO particolare, int pezzo, int n_pezzi, String applica_tutti, Session session) throws Exception {
		
		build(fileContent,  particolare, pezzo, n_pezzi, applica_tutti, session);
		
		
}

public void build(InputStream fileContent, RilParticolareDTO particolare, int pezzo, int n_pezzi, String applica_tutti, Session session) throws Exception, IOException {

	DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
	DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
	ArrayList<ArrayList<String>> lista_valori = null;
	
	Document doc = dBuilder.parse(fileContent);
	NodeList nList = doc.getElementsByTagName("Cell");
	
	lista_valori = new ArrayList<ArrayList<String>>();
	
	int start = 1;
		
	
	for(int i = 0; i < nList.getLength();i++) {
		ArrayList<String> lista_valori_quota = null;
		if(i>=(12*start) && i<=(12*(start)+11)) {
			lista_valori_quota = new ArrayList<String>();
			for(int j = i; j<=(12*(start)+11);j++) {	
				Node nNode = nList.item(j);	
				if (nNode.getNodeType() == Node.ELEMENT_NODE) {				
					Element eElement = (Element) nNode;				
					if(eElement.getElementsByTagName("Text").item(0)!=null ) {
						lista_valori_quota.add(eElement.getElementsByTagName("Text").item(0).getTextContent());			
					}else {
						lista_valori_quota.add("");		
					}
				}
			}

			if(!lista_valori_quota.get(3).toUpperCase().equals("NOMINALE")){
				lista_valori.add(lista_valori_quota);
				}
				start++;
		}
	}
	
	
	
	ArrayList<RilQuotaDTO> lista_quote = GestioneRilieviBO.getQuoteImportate(particolare.getId(), session);
	ArrayList<RilParticolareDTO> lista_impronte = new ArrayList<RilParticolareDTO>();
	
	if(applica_tutti!=null && applica_tutti.equals("1") && particolare.getNome_impronta()!=null && !particolare.getNome_impronta().equals("")) {
		lista_impronte = GestioneRilieviBO.getListaImprontePerMisura(particolare.getMisura().getId(), session);
		
	}else {
		lista_impronte.add(particolare);
	}
	
	if(lista_quote.size()==0) {
		for (RilParticolareDTO part : lista_impronte) {
			int id_ripetizione = GestioneRilieviBO.getMaxIdRipetizione(part, session) + 1;
			
			for(int i = 0; i<lista_valori.size();i++) {
				RilQuotaDTO quota = new RilQuotaDTO();
				RilSimboloDTO simbolo = null;
				
				if(!lista_valori.get(i).get(3).equals("")) {
					quota.setCoordinata(lista_valori.get(i).get(0));
					if(lista_valori.get(i).get(2).toUpperCase().contains("DISTANZA") || lista_valori.get(i).get(2).toUpperCase().contains("POSIZIONE")) {
						if(lista_valori.get(i).get(2).endsWith("X")||lista_valori.get(i).get(2).endsWith("Y")||
								lista_valori.get(i).get(2).endsWith("Z")||lista_valori.get(i).get(2).toUpperCase().equals("DISTANZA")) {
							simbolo = null;
						}						
						else if(lista_valori.get(i).get(2).toUpperCase().contains("ASSI")) {
							simbolo = GestioneRilieviBO.getSimboloFromDescrizione("POSIZIONE_ASSI", session);
						}
						else if(lista_valori.get(i).get(2).toUpperCase().contains("PIANO")) {
							simbolo = GestioneRilieviBO.getSimboloFromDescrizione("POSIZIONE_PIANO", session);
						}
						else {							
							simbolo = GestioneRilieviBO.getSimboloFromDescrizione(lista_valori.get(i).get(2).replace(" ", "_").toUpperCase(), session);
						}
					}
					else if(lista_valori.get(i).get(2).toUpperCase().contains("ANGOLO")) {
						simbolo = GestioneRilieviBO.getSimboloFromDescrizione("ANGOLO", session);
					}
					else if(lista_valori.get(i).get(2).toUpperCase().contains("INCLINAZIONE")) {
						simbolo = GestioneRilieviBO.getSimboloFromDescrizione("ANGOLARITA", session);
					}
					else if(lista_valori.get(i).get(2).toUpperCase().contains("SIMMETRIA")) {						
						if(lista_valori.get(i).get(2).toUpperCase().contains("ASSE")) {
							simbolo = GestioneRilieviBO.getSimboloFromDescrizione("SIMMETRIA_ASSE", session);
						}
						else if(lista_valori.get(i).get(2).toUpperCase().contains("PIANO")) {
							simbolo = GestioneRilieviBO.getSimboloFromDescrizione("SIMMETRIA_PIANO", session);
						}
						else {
							simbolo = GestioneRilieviBO.getSimboloFromDescrizione("SIMMETRIA", session);
						}	
					}
					else if(lista_valori.get(i).get(2).toUpperCase().contains("OSCILLAZIONE")) {
						if(lista_valori.get(i).get(2).toUpperCase().contains("ASSIALE")) {
							simbolo = GestioneRilieviBO.getSimboloFromDescrizione("OSCILLAZIONE_ASSIALE", session);
						}else {
							simbolo = GestioneRilieviBO.getSimboloFromDescrizione("OSCILLAZIONE_CIRCOLARE", session);	
						}
					}
					else if(lista_valori.get(i).get(2).toUpperCase().contains("SUPERFICIE")) {
						simbolo = GestioneRilieviBO.getSimboloFromDescrizione("PROFILO_SUPERFICIE", session);
					}
					else if(lista_valori.get(i).get(2).toUpperCase().contains("CONTOUR")||lista_valori.get(i).get(2).toUpperCase().contains("LINEA")) {
						simbolo = GestioneRilieviBO.getSimboloFromDescrizione("PROFILO_LINEA", session);
					}
					else {
						simbolo = GestioneRilieviBO.getSimboloFromDescrizione(lista_valori.get(i).get(2).replace("Ã", "A").replace("À","A").replace("¶"," ").replace(" ", "_").replace(" ","").toUpperCase(), session);
					}
					 
					quota.setSimbolo(simbolo);
					if(simbolo!=null) {
						if(simbolo.getId()!=2) {
							quota.setUm("mm");
						}else {
							quota.setUm("°");
						}
					}else {
						quota.setUm("mm");
					}
					
					quota.setVal_nominale(lista_valori.get(i).get(3).replace("-", ""));
					if(lista_valori.get(i).get(4).equals("F")) {
						quota.setQuota_funzionale(new RilQuotaFunzionaleDTO(1, ""));
					}
					else if(lista_valori.get(i).get(4).equals("F0")) {
						quota.setQuota_funzionale(new RilQuotaFunzionaleDTO(2, ""));
					}
					else if(lista_valori.get(i).get(4).equals("Fi")) {
						quota.setQuota_funzionale(new RilQuotaFunzionaleDTO(3, ""));
					}
					else if(lista_valori.get(i).get(4).equals("Fc")) {
						quota.setQuota_funzionale(new RilQuotaFunzionaleDTO(4, ""));
					}
					else {					
						quota.setQuota_funzionale(null);
					}
					if(lista_valori.get(i).get(5).equals("/")||lista_valori.get(i).get(6).equals("/")) {
						quota.setTolleranza_negativa(lista_valori.get(i).get(5));
						quota.setTolleranza_positiva(lista_valori.get(i).get(6));
					}
					else if(Double.parseDouble(lista_valori.get(i).get(5))==0 && Double.parseDouble(lista_valori.get(i).get(6))==0) {
						Double[] tolleranza = Utility.calcolaTolleranze(Double.valueOf(lista_valori.get(i).get(3).replace("-", "")), simbolo, particolare.getMisura().getClasse_tolleranza());
						quota.setTolleranza_positiva(String.valueOf(tolleranza[0]));
						quota.setTolleranza_negativa(String.valueOf(tolleranza[1]));				
					}else {
						quota.setTolleranza_negativa(lista_valori.get(i).get(5));
						quota.setTolleranza_positiva(lista_valori.get(i).get(6));
					}			
					
					if(part.getNome_impronta().equals("")) {
						quota.setId_ripetizione(0);
					}else {
						quota.setId_ripetizione(id_ripetizione);
					}
					
					quota.setImpronta(part);
					quota.setImportata(1);
					session.save(quota);
					List lista_punti = new ArrayList<RilPuntoQuotaDTO>();
					for(int j = 0; j<n_pezzi;j++) {
						RilPuntoQuotaDTO punto = new RilPuntoQuotaDTO();
						punto.setId_quota(quota.getId());
						if(part==particolare) {
							if((j+1)==pezzo) {	
								punto.setValore_punto(lista_valori.get(i).get(7).replace("-", ""));								
								
								String delta = Utility.setDecimalDigits(quota.getImpronta().getMisura().getCifre_decimali(), Utility.calcolaDelta(quota.getTolleranza_negativa(), quota.getTolleranza_positiva(), quota.getVal_nominale(), punto.getValore_punto()));
								punto.setDelta(delta);
								punto.setDelta_perc(Utility.setDecimalDigits(quota.getImpronta().getMisura().getCifre_decimali(), Utility.calcolaDeltaPerc(quota.getTolleranza_negativa(), quota.getTolleranza_positiva(), delta)));								
							}
						}else {
							punto.setValore_punto(null);
						}
						lista_punti.add(punto);
						session.save(punto);
					}
					if(i+1<lista_valori.size() && lista_valori.get(i+1).get(10)=="") {
						quota.setNote(lista_valori.get(i+1).get(11));
					}				
					id_ripetizione++;
					
					Set<RilPuntoQuotaDTO> foo = new HashSet<RilPuntoQuotaDTO>(lista_punti);
					
					TreeSet myTreeSet = new TreeSet();
					myTreeSet.addAll(foo);
					quota.setListaPuntiQuota(myTreeSet);
					session.update(quota);
				}
			}			
		}
	}else {

		RilPuntoQuotaDTO punto = null;
		int j=0;
		for(int i = 0; i< lista_valori.size();i++) {			
			if(!lista_valori.get(i).get(3).equals("")) {
				List list = new ArrayList(lista_quote.get(j).getListaPuntiQuota());
				Collections.sort(list, new Comparator<RilPuntoQuotaDTO>() {
				    public int compare(RilPuntoQuotaDTO o1, RilPuntoQuotaDTO o2) {
				    	Integer obj1 = o1.getId();
				    	Integer obj2 = o2.getId();
				        return obj1.compareTo(obj2);
				    }
				});
				if(list.size()>=pezzo) {
					punto = (RilPuntoQuotaDTO) list.get(pezzo-1);
				}else {
					punto = new RilPuntoQuotaDTO();
				}			
				punto.setId_quota(lista_quote.get(j).getId());
				if(i<lista_valori.size() && lista_valori.get(j)!=null) {
					
					punto.setValore_punto(lista_valori.get(i).get(7).replace("-", ""));	
					
					String delta = Utility.setDecimalDigits(lista_quote.get(j).getImpronta().getMisura().getCifre_decimali(), Utility.calcolaDelta(lista_quote.get(j).getTolleranza_negativa(), lista_quote.get(j).getTolleranza_positiva(), lista_quote.get(j).getVal_nominale(), punto.getValore_punto()));
					punto.setDelta(delta);
					punto.setDelta_perc(Utility.setDecimalDigits(lista_quote.get(j).getImpronta().getMisura().getCifre_decimali(), Utility.calcolaDeltaPerc(lista_quote.get(j).getTolleranza_negativa(), lista_quote.get(j).getTolleranza_positiva(),  delta)));					
				}else {
					punto.setValore_punto(null);
				}			
				session.saveOrUpdate(punto);
				j++;
			}
		}		
	}	
}


//public static void main(String[] args) throws Exception {
//	new ContextListener().configCostantApplication();
//	Session session=SessionFacotryDAO.get().openSession();
//	session.beginTransaction();
//	
//		
//	new CreateTabellaFromXML(session);
//	System.out.println("FINITO");
//}

}
