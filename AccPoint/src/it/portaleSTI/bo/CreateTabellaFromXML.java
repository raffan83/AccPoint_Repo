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

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.RilMisuraRilievoDTO;
import it.portaleSTI.DTO.RilParticolareDTO;
import it.portaleSTI.DTO.RilPuntoQuotaDTO;
import it.portaleSTI.DTO.RilQuotaDTO;
import it.portaleSTI.DTO.RilSimboloDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.action.ContextListener;

public class CreateTabellaFromXML {
	
public CreateTabellaFromXML(InputStream fileContent,  int id_particolare, int pezzo, int n_pezzi,  Session session) throws Exception {
		
		build(fileContent,  id_particolare, pezzo, n_pezzi, session);
		
		
}

public void build(InputStream fileContent, int id_particolare, int pezzo, int n_pezzi, Session session) throws Exception, IOException {

	DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
	DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
	ArrayList<ArrayList<String>> lista_valori = null;
	
	Document doc = dBuilder.parse(fileContent);
	NodeList nList = doc.getElementsByTagName("Cell");
	
	lista_valori = new ArrayList<ArrayList<String>>();
	
	RilParticolareDTO particolare = GestioneRilieviBO.getImprontaById(id_particolare, session);
	
	int start = 1;
		
	for (int temp = 0; temp < nList.getLength(); temp++) {
		ArrayList<String> lista_valori_quota = null;
		if(temp>=(10*start)+1 && temp <=(10*start)+6) {
			lista_valori_quota = new ArrayList<String>();
		for(int j = temp; j<=(10*start)+6;j++) {			
			Node nNode = nList.item(j);					
			if (nNode.getNodeType() == Node.ELEMENT_NODE) {				
				Element eElement = (Element) nNode;				
				if(eElement.getElementsByTagName("Text").item(0)!=null) {
					lista_valori_quota.add(eElement.getElementsByTagName("Text").item(0).getTextContent());			
				}
			}			
		}
		if(!lista_valori_quota.get(0).equals("ELEMENTO")) {
			lista_valori.add(lista_valori_quota);
		}
		start++;
		}		
	}
	
	
	ArrayList<RilQuotaDTO> lista_quote = GestioneRilieviBO.getQuoteImportate(particolare.getId(), session);
	ArrayList<RilParticolareDTO> lista_impronte = new ArrayList<RilParticolareDTO>();
	
	if(particolare.getNome_impronta()!=null && !particolare.getNome_impronta().equals("")) {
		lista_impronte = GestioneRilieviBO.getListaImprontePerMisura(particolare.getMisura().getId(), session);
		
	}else {
		lista_impronte.add(particolare);
	}
	
	int k = 1;
	
	
	if(lista_quote.size()==0) {
		for (RilParticolareDTO part : lista_impronte) {
			for(int i = 0; i<lista_valori.size();i++) {
			RilQuotaDTO quota = new RilQuotaDTO();
		
				quota.setCoordinata(lista_valori.get(i).get(0));
				RilSimboloDTO simbolo = GestioneRilieviBO.getSimboloFromDescrizione(lista_valori.get(i).get(1).replace(" ", "_").toUpperCase(), session);
				if(simbolo!=null) {
					if(simbolo.getId()!=2) {
						quota.setUm("mm");
					}else {
						quota.setUm("°");
					}
				}
				quota.setSimbolo(simbolo);
				quota.setVal_nominale(new BigDecimal(lista_valori.get(i).get(2)));
				quota.setTolleranza_negativa(new BigDecimal(lista_valori.get(i).get(3)));
				quota.setTolleranza_positiva(new BigDecimal(lista_valori.get(i).get(4)));
							
	//			if(particolare.getNome_impronta().equals("")) {
	//				quota.setId_ripetizione(0);
	//			}else {
	//				quota.setId_ripetizione((GestioneRilieviBO.getMaxIdRipetizione(particolare, session))+1);
	//			}
				if(part.getNome_impronta().equals("")) {
					quota.setId_ripetizione(0);
				}else {
					quota.setId_ripetizione(k);
				}
				
				quota.setImpronta(part);
				quota.setImportata(1);
				session.save(quota);
				List lista_punti = new ArrayList<RilPuntoQuotaDTO>();
				for(int j = 0; j<n_pezzi;j++) {
					RilPuntoQuotaDTO punto = new RilPuntoQuotaDTO();
					punto.setId_quota(quota.getId());
					if((j+1)==pezzo) {	
						punto.setValore_punto(new BigDecimal(lista_valori.get(i).get(5)));
					}
					lista_punti.add(punto);
					session.save(punto);
				}
				
				
				Set<RilPuntoQuotaDTO> foo = new HashSet<RilPuntoQuotaDTO>(lista_punti);
				
				TreeSet myTreeSet = new TreeSet();
				myTreeSet.addAll(foo);
				quota.setListaPuntiQuota(myTreeSet);
				session.update(quota);
			}
			k++;
		}
	}else {
	
		int i = 0;
		RilPuntoQuotaDTO punto = null;
		for (RilQuotaDTO quota : lista_quote) {
			List list = new ArrayList(quota.getListaPuntiQuota());
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
			punto.setId_quota(quota.getId());
			if(i<lista_valori.size() && lista_valori.get(i)!=null) {
				punto.setValore_punto(new BigDecimal(lista_valori.get(i).get(5)));	
			}else {
				punto.setValore_punto(null);
			}
			i++;
			session.saveOrUpdate(punto);
			
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
