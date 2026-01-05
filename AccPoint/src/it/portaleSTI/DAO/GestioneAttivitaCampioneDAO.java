package it.portaleSTI.DAO;

import java.io.File;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;


import it.portaleSTI.DTO.AcAttivitaCampioneDTO;
import it.portaleSTI.DTO.AcTipoAttivitaCampioniDTO;
import it.portaleSTI.DTO.AttivitaManutenzioneDTO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.RegistroEventiDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.TaraturaEsternaCampioneDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneCertificatoBO;


public class GestioneAttivitaCampioneDAO {

	public static ArrayList<AcAttivitaCampioneDTO> getListaAttivita(int idC, Session session) {
		
		ArrayList<AcAttivitaCampioneDTO> lista=null;

		Query query = session.createQuery("from AcAttivitaCampioneDTO where campione.id = :_id_campione and disabilitata = 0");
		query.setParameter("_id_campione", idC);
		
		lista= (ArrayList<AcAttivitaCampioneDTO>)query.list();
		
		return lista;
	}


	public static ArrayList<AcTipoAttivitaCampioniDTO> getListaTipoAttivitaCampione(Session session) {

		ArrayList<AcTipoAttivitaCampioniDTO> lista=null;

		Query query = session.createQuery("from AcTipoAttivitaCampioniDTO");		
		lista= (ArrayList<AcTipoAttivitaCampioniDTO>)query.list();
		
		return lista;
	}


	public static AcAttivitaCampioneDTO getAttivitaFromId(int id_attivita, Session session) {
		
		ArrayList<AcAttivitaCampioneDTO> lista=null;
		AcAttivitaCampioneDTO result = null;
		Query query = session.createQuery("from AcAttivitaCampioneDTO where id = :_id_attivita");		
		query.setParameter("_id_attivita", id_attivita);
		
		lista= (ArrayList<AcAttivitaCampioneDTO>)query.list();
		
		if(lista.size()>0) {
			result = lista.get(0); 
		}
		
		return result;
	}


	public static ArrayList<AcAttivitaCampioneDTO> getListaManutenzioni(int id_campione, Session session) {
		
		ArrayList<AcAttivitaCampioneDTO> lista=null;

		Query query = session.createQuery("from AcAttivitaCampioneDTO where campione.id = :_id_campione and tipo_attivita.id = 1 and disabilitata = 0");		
		query.setParameter("_id_campione", id_campione);
		
		
		lista= (ArrayList<AcAttivitaCampioneDTO>)query.list();	
		
		return lista;
	
	}

	
public static ArrayList<AcAttivitaCampioneDTO> getListaTaratureVerificheIntermedie(int id_campione, Session session) {
		
		ArrayList<AcAttivitaCampioneDTO> lista=null;

		Query query = session.createQuery("from AcAttivitaCampioneDTO where campione.id = :_id_campione and (tipo_attivita.id = 2 or tipo_attivita.id = 3) and disabilitata = 0");		
		query.setParameter("_id_campione", id_campione);		
		
		lista= (ArrayList<AcAttivitaCampioneDTO>)query.list();	
		
		return lista;
	
	}


public static ArrayList<TaraturaEsternaCampioneDTO> getListaTaratureEsterneCampione(int id_campione, Session session) {

	ArrayList<TaraturaEsternaCampioneDTO> lista=null;

	Query query = session.createQuery("from TaraturaEsternaCampioneDTO where campione.id = :_id_campione) and disabilitata = 0");
	query.setParameter("_id_campione", id_campione);		
	
	lista= (ArrayList<TaraturaEsternaCampioneDTO>)query.list();	
	
	return lista;
}

public static ArrayList<AcAttivitaCampioneDTO> getListaVerificheIntermedie(int id_campione, Session session) {
	
	ArrayList<AcAttivitaCampioneDTO> lista=null;

	Query query = session.createQuery("from AcAttivitaCampioneDTO where campione.id = :_id_campione and tipo_attivita.id = 2  and disabilitata = 0");		
	query.setParameter("_id_campione", id_campione);		
	
	lista= (ArrayList<AcAttivitaCampioneDTO>)query.list();	
	
	return lista;

}


public static TaraturaEsternaCampioneDTO getTaraturaEsternaById(int id_taratura, Session session) {
	
	ArrayList<TaraturaEsternaCampioneDTO> lista=null;

	Query query = session.createQuery("from TaraturaEsternaCampioneDTO where id = :_id_taratura");		
	query.setParameter("_id_taratura", id_taratura);		
	
	lista= (ArrayList<TaraturaEsternaCampioneDTO>)query.list();	
	
	if(lista.size()>0) {
		return lista.get(0);
	}
	
	return null;

}


public static ArrayList<HashMap<String, Integer>> getListaAttivitaScadenziarioCampione(CampioneDTO campione, Session session) {

	Query query=null;
	ArrayList<HashMap<String, Integer>> listMap= new ArrayList<HashMap<String, Integer>>();
	HashMap<String, Integer> mapTarature = new HashMap<String, Integer>();
	HashMap<String, Integer> mapVerifiche = new HashMap<String, Integer>();
	HashMap<String, Integer> mapManutenzioni = new HashMap<String, Integer>();
	
	List<AcAttivitaCampioneDTO> lista =null;
	
	query  = session.createQuery( "from AcAttivitaCampioneDTO where campione.id = :_id_campione and (obsoleta = null or obsoleta = 'N') and disabilitata = 0");	
	query.setParameter("_id_campione", campione.getId());
	
	lista=query.list();
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	for (AcAttivitaCampioneDTO att: lista) {
		
		
		if(att.getTipo_attivita().getId()==1) {
		
			if(campione.getFrequenza_manutenzione()!=0) {
				int i=1;
				
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(att.getData());
				calendar.add(Calendar.MONTH, campione.getFrequenza_manutenzione());
				
				Date date = calendar.getTime();
				
				if(mapManutenzioni.get(sdf.format(date))!=null) {					
					
					i= mapManutenzioni.get(sdf.format(date))+1;
				}
				
				mapManutenzioni.put(sdf.format(date), i);
			}			
		}
		
		if(att.getTipo_attivita().getId()==2 && att.getData_scadenza()!=null) {
			
			int i=1;
			if(mapVerifiche.get(sdf.format(att.getData_scadenza()))!=null) {
				i= mapVerifiche.get(sdf.format(att.getData_scadenza()))+1;
			}
			
			mapVerifiche.put(sdf.format(att.getData_scadenza()), i);
			
		}
		
		if(att.getTipo_attivita().getId()==3 && att.getData_scadenza()!=null) {
			
			int i=1;
			if(mapTarature.get(sdf.format(att.getData_scadenza()))!=null) {
				i= mapTarature.get(sdf.format(att.getData_scadenza()))+1;
			}
			
			mapTarature.put(sdf.format(att.getData_scadenza()), i);
			
		}
		

    }
	
	listMap.add(mapManutenzioni);
	listMap.add(mapVerifiche);
	listMap.add(mapTarature);

	return listMap;
}

//
//public static ArrayList<HashMap<String, Integer>> getListaAttivitaScadenziario(Session session) {
//	
//	Query query=null;
//	ArrayList<HashMap<String, Integer>> listMap= new ArrayList<HashMap<String, Integer>>();
//	HashMap<String, Integer> mapTarature = new HashMap<String, Integer>();
//	HashMap<String, Integer> mapVerifiche = new HashMap<String, Integer>();
//	HashMap<String, Integer> mapManutenzioni = new HashMap<String, Integer>();
//	
//	List<AcAttivitaCampioneDTO> lista =null;
//	List<CampioneDTO> lista_campioni = null;
//	
//	query  = session.createQuery( "from AcAttivitaCampioneDTO where campione.statoCampione != 'F' and (obsoleta = null or obsoleta = 'N') and disabilitata = 0");	
//	
//	lista=query.list();
//	
//	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//	
//	for (AcAttivitaCampioneDTO att: lista) {
//		
//		
//		if(att.getTipo_attivita().getId()==1) {
//		
//			if(att.getCampione().getFrequenza_manutenzione()!=0) {
//				int i=1;
//				
//				Calendar calendar = Calendar.getInstance();
//				calendar.setTime(att.getData());
//				calendar.add(Calendar.MONTH, att.getCampione().getFrequenza_manutenzione());
//				
//				Date date = calendar.getTime();
//				
//				if(mapManutenzioni.get(sdf.format(date))!=null) {					
//					
//					i= mapManutenzioni.get(sdf.format(date))+1;
//				}
//				
//				mapManutenzioni.put(sdf.format(date), i);
//			}			
//		}
//		
//		if(att.getTipo_attivita().getId()==2 && att.getData_scadenza()!=null) {
//			
//			int i=1;
//			if(mapVerifiche.get(sdf.format(att.getData_scadenza()))!=null) {
//				i= mapVerifiche.get(sdf.format(att.getData_scadenza()))+1;
//			}
//			
//			mapVerifiche.put(sdf.format(att.getData_scadenza()), i);
//			
//		}
//		
////		if(att.getTipo_attivita().getId()==3 && att.getData_scadenza()!=null) {
////			
////			int i=1;
////			if(mapTarature.get(sdf.format(att.getData_scadenza()))!=null) {
////				i= mapTarature.get(sdf.format(att.getData_scadenza()))+1;
////			}
////			
////			mapTarature.put(sdf.format(att.getData_scadenza()), i);
////			
////		}
//		
//
//    }
//	
//	query  = session.createQuery( "from CampioneDTO where statoCampione != 'F' and codice like '%CDT%'");	
//	
//	lista_campioni=query.list();
//	
//	for (CampioneDTO c : lista_campioni) {
//		
//		if(c.getDataScadenza()!=null) {
//		
//		int i=1;
//		if(mapTarature.get(sdf.format(c.getDataScadenza()))!=null) {
//			i= mapTarature.get(sdf.format(c.getDataScadenza()))+1;
//		}
//		
//		mapTarature.put(sdf.format(c.getDataScadenza()), i);
//		
//	}
//		
//	}
//	
//	listMap.add(mapManutenzioni);
//	listMap.add(mapVerifiche);
//	listMap.add(mapTarature);
//
//	return listMap;
//}



public static ArrayList<HashMap<String, Integer>> getListaAttivitaScadenziario(Session session) {

Query query=null;
ArrayList<HashMap<String, Integer>> listMap= new ArrayList<HashMap<String, Integer>>();
HashMap<String, Integer> mapTarature = new HashMap<String, Integer>();
HashMap<String, Integer> mapVerifiche = new HashMap<String, Integer>();
HashMap<String, Integer> mapManutenzioni = new HashMap<String, Integer>();

List<AcAttivitaCampioneDTO> lista =null;
List<CampioneDTO> lista_campioni = null;

query  = session.createQuery( "from CampioneDTO where campione.statoCampione != 'F' and (obsoleta = null or obsoleta = 'N') and disabilitata = 0");	

lista=query.list();

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

for (AcAttivitaCampioneDTO att: lista) {
	
	
	if(att.getTipo_attivita().getId()==1) {
	
		if(att.getCampione().getFrequenza_manutenzione()!=0) {
			int i=1;
			
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(att.getData());
			calendar.add(Calendar.MONTH, att.getCampione().getFrequenza_manutenzione());
			
			Date date = calendar.getTime();
			
			if(mapManutenzioni.get(sdf.format(date))!=null) {					
				
				i= mapManutenzioni.get(sdf.format(date))+1;
			}
			
			mapManutenzioni.put(sdf.format(date), i);
		}			
	}
	
	if(att.getTipo_attivita().getId()==2 && att.getData_scadenza()!=null) {
		
		int i=1;
		if(mapVerifiche.get(sdf.format(att.getData_scadenza()))!=null) {
			i= mapVerifiche.get(sdf.format(att.getData_scadenza()))+1;
		}
		
		mapVerifiche.put(sdf.format(att.getData_scadenza()), i);
		
	}
	
//	if(att.getTipo_attivita().getId()==3 && att.getData_scadenza()!=null) {
//		
//		int i=1;
//		if(mapTarature.get(sdf.format(att.getData_scadenza()))!=null) {
//			i= mapTarature.get(sdf.format(att.getData_scadenza()))+1;
//		}
//		
//		mapTarature.put(sdf.format(att.getData_scadenza()), i);
//		
//	}
	

}

query  = session.createQuery( "from CampioneDTO where statoCampione != 'F' and codice like '%CDT%'");	

lista_campioni=query.list();

for (CampioneDTO c : lista_campioni) {
	
	if(c.getDataScadenza()!=null) {
	
	int i=1;
	if(mapTarature.get(sdf.format(c.getDataScadenza()))!=null) {
		i= mapTarature.get(sdf.format(c.getDataScadenza()))+1;
	}
	
	mapTarature.put(sdf.format(c.getDataScadenza()), i);
	
}
	
}

listMap.add(mapManutenzioni);
listMap.add(mapVerifiche);
listMap.add(mapTarature);

return listMap;
}



public static ArrayList<HashMap<String, Integer>> getListaRegistroEventiScadenziario(String verificazione, Session session) {
	
	Query query=null;
	ArrayList<HashMap<String, Integer>> listMap= new ArrayList<HashMap<String, Integer>>();
	HashMap<String, Integer> mapTarature = new HashMap<String, Integer>();
	HashMap<String, Integer> mapVerifiche = new HashMap<String, Integer>();
	HashMap<String, Integer> mapManutenzioni = new HashMap<String, Integer>();
	
	List<RegistroEventiDTO> lista =null;
	List<CampioneDTO> lista_campioni = null;
	
	if(verificazione!=null) {
		query  = session.createQuery( "from RegistroEventiDTO where campione.statoCampione != 'F' and campione.campione_verificazione = 1 and (obsoleta = null or obsoleta = 'N')");
	}else {
		query  = session.createQuery( "from RegistroEventiDTO where campione.statoCampione != 'F' and (obsoleta = null or obsoleta = 'N')");	
	}
		
	
	lista=query.list();
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	for (RegistroEventiDTO att: lista) {
		
		
		if(att.getTipo_evento().getId()==1) {
			
			int i=1;
		
			if(att.getCampione().getFrequenza_manutenzione()!=0) {
				
				
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(att.getData_evento());
				calendar.add(Calendar.MONTH, att.getCampione().getFrequenza_manutenzione());
				
				Date date = calendar.getTime();
				
				if(mapManutenzioni.get(sdf.format(date))!=null) {					
					
					i= mapManutenzioni.get(sdf.format(date))+1;
				}
				
				mapManutenzioni.put(sdf.format(date), i);
			}else {
				if(att.getPianificato()==1) {
					
					
					if(mapManutenzioni.get(sdf.format(att.getData_scadenza()))!=null) {					
						
						i= mapManutenzioni.get(sdf.format(att.getData_scadenza()))+1;
					}
					
					mapManutenzioni.put(sdf.format(att.getData_scadenza()), i);
				}
			}
		}
		
		
		if(att.getTipo_evento().getId()==2 && att.getData_scadenza()!=null ) {
			
			int i=1;
			if(mapTarature.get(sdf.format(att.getData_scadenza()))!=null) {
				i= mapTarature.get(sdf.format(att.getData_scadenza()))+1;
			}
			
			mapTarature.put(sdf.format(att.getData_scadenza()), i);
			
		}
		
		
		if(att.getTipo_evento().getId()==5 && att.getData_scadenza()!=null) {
			
			int i=1;
			if(mapVerifiche.get(sdf.format(att.getData_scadenza()))!=null) {
				i= mapVerifiche.get(sdf.format(att.getData_scadenza()))+1;
			}
			
			mapVerifiche.put(sdf.format(att.getData_scadenza()), i);
			
		}
		


    }
	
	if(verificazione==null) {
		query  = session.createQuery( "from CampioneDTO where statoCampione != 'F' and tipo_campione.id = 4");
		lista_campioni = query.list();
		
		for (CampioneDTO campioneDTO : lista_campioni) {
			if(campioneDTO.getDataScadenza()!=null ) {
				
				int i=1;
				if(mapTarature.get(sdf.format(campioneDTO.getDataScadenza()))!=null) {
					i= mapTarature.get(sdf.format(campioneDTO.getDataScadenza()))+1;
				}
				
				mapTarature.put(sdf.format(campioneDTO.getDataScadenza()), i);
				
			}
		}
	}
	
//	if(verificazione!=null) {
//		query  = session.createQuery( "from CampioneDTO where statoCampione != 'F' and campione_verificazione = 1 and  codice not like '%CDT%'");	
//	}else {
//		query  = session.createQuery( "from CampioneDTO where statoCampione != 'F' and codice not like '%CDT%'");		
//	}
//	
//	
//	lista_campioni=query.list();
//	
//	for (CampioneDTO c : lista_campioni) {
//		
//		if(c.getDataScadenza()!=null) {
//		
//		int i=1;
//		if(mapTarature.get(sdf.format(c.getDataScadenza()))!=null) {
//			i= mapTarature.get(sdf.format(c.getDataScadenza()))+1;
//		}
//		
//		mapTarature.put(sdf.format(c.getDataScadenza()), i);
//		
//	}
//		
//	}
//	
	listMap.add(mapManutenzioni);
	listMap.add(mapVerifiche);
	listMap.add(mapTarature);

	return listMap;
}


public static void mergeTabelleAttivita(Session session) throws Exception{
	
ArrayList<RegistroEventiDTO> lista = new ArrayList<RegistroEventiDTO>();
	
	

	String query = "from RegistroEventiDTO";
	
Query q = session.createQuery(query);

lista = (ArrayList<RegistroEventiDTO>) q.list();
	

	AcAttivitaCampioneDTO attivita = null;
	
for (RegistroEventiDTO r : lista) {
	attivita = new AcAttivitaCampioneDTO();
	
	//attivita.setId(r.getId());
	attivita.setObsoleta(r.getObsoleta());
	attivita.setDescrizione_attivita(r.getDescrizione());
	attivita.setData(r.getData_evento());
	if(r.getTipo_evento().getId()==2) {
		attivita.setTipo_attivita(new AcTipoAttivitaCampioniDTO(3,""));
	}
	else if(r.getTipo_evento().getId()==5) {
		attivita.setTipo_attivita(new AcTipoAttivitaCampioniDTO(2,""));
	}else {
		attivita.setTipo_attivita(new AcTipoAttivitaCampioniDTO(r.getTipo_evento().getId(),""));
	}
	
	
	attivita.setCampione(r.getCampione());
	if(r.getTipo_manutenzione()!=null) {
		attivita.setTipo_manutenzione(r.getTipo_manutenzione().getId());
	}else {
		attivita.setTipo_manutenzione(0);
	}
	if(r.getData_scadenza()!=null) {
		attivita.setData_scadenza(r.getData_scadenza());	
	}else {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(r.getData_evento());
		calendar.add(Calendar.MONTH, r.getCampione().getFrequenza_manutenzione());
		
		java.util.Date date = calendar.getTime();
		attivita.setData_scadenza(date);
	}
	
	attivita.setEnte(r.getLaboratorio());

	attivita.setCampo_sospesi(r.getCampo_sospesi());
	attivita.setStato(r.getStato()) ;
	if(r.getOperatore()!=null && !r.getOperatore().equals("0")) {
		attivita.setOperatore(r.getOperatore());	
	}else {
		attivita.setOperatore(null);
	}
	
	if(r.getNumero_certificato()!=null && !r.getNumero_certificato().equals("0")) {
		attivita.setNumero_certificato(r.getNumero_certificato());	
	}else {
		attivita.setCertificato(null);
	}
	
	attivita.setAllegato(r.getAllegato());

	attivita.setPianificata(r.getPianificato());;
	

	session.save(attivita);

}
		
	
		
	
	


	
}



public static void mergeRenameAllegati(Session session) throws Exception{
	
ArrayList<AcAttivitaCampioneDTO> lista = new ArrayList<AcAttivitaCampioneDTO>();
	
	

	String query = "from AcTipoAttivitaCampioniDTO";
	
Query q = session.createQuery(query);

lista = (ArrayList<AcAttivitaCampioneDTO>) q.list();
	

	
	
for (AcAttivitaCampioneDTO attivita : lista) {
	
	String path = Costanti.PATH_FOLDER+"//Campioni//"+attivita.getCampione().getId()+"//Allegati//AttivitaManutenzione//";
	String path1 = Costanti.PATH_FOLDER+"//Campioni//"+attivita.getCampione().getId()+"//Allegati//";
	File f = new File(path);
	File f1 = new File(path1);
	
	f.renameTo(f1);
	
}

}


//public static ArrayList<CampioneDTO> getListaCampioniPerData(String data, String tipo_data_lat, String tipo_evento, int verificazione) throws Exception, ParseException {
//	DateFormat df = new SimpleDateFormat("yyyy-MM-dd");		
//	Session session = SessionFacotryDAO.get().openSession();
//    
//	session.beginTransaction();
//	ArrayList<AcAttivitaCampioneDTO> attivita = null;
//	ArrayList<RegistroEventiDTO> registro = null;
//	ArrayList<CampioneDTO> lista = new ArrayList<CampioneDTO>();
//	Query query = null;
//	
//	if(tipo_data_lat!=null) {
//		
//		if(tipo_data_lat.equals("1")) {
//			query = session.createQuery("from AcAttivitaCampioneDTO where tipo_attivita.id = 1 and (obsoleta = null or obsoleta = 'N') and disabilitata = 0");	
//						
//			attivita = (ArrayList<AcAttivitaCampioneDTO>) query.list();
//			
//			for (AcAttivitaCampioneDTO a : attivita) {
//				
//
//				Calendar calendar = Calendar.getInstance();
//				calendar.setTime(a.getData());
//				calendar.add(Calendar.MONTH, a.getCampione().getFrequenza_manutenzione());
//				
//				Date date = calendar.getTime();
//				if(df.format(date).equals(data) && !lista.contains(a.getCampione())) {
//					lista.add(a.getCampione());	
//				}
//				
//			}
//		}
//		else if(tipo_data_lat.equals("2")) {
//			query = session.createQuery("from AcAttivitaCampioneDTO where data_scadenza = :_date and tipo_attivita.id = 2 and (obsoleta = null or obsoleta = 'N') and disabilitata = 0");	
//			query.setParameter("_date", df.parse(data));
//			
//			attivita = (ArrayList<AcAttivitaCampioneDTO>) query.list();
//			
//			for (AcAttivitaCampioneDTO a : attivita) {
//				
//					lista.add(a.getCampione());	
//				
//			}
//			
//		}
//		else if(tipo_data_lat.equals("3")) {
//			query = session.createQuery("from CampioneDTO where data_scadenza = :_date and stato_campione != 'F' and codice like '%CDT%'");	
//			query.setParameter("_date", df.parse(data));
//			
//			lista = (ArrayList<CampioneDTO>) query.list();
//		}
//	
//	
//
//	
//	}else {
//		
//		if(verificazione!=0) {
//			if(tipo_evento.equals("1")) {
//				
//				query= session.createQuery("from RegistroEventiDTO where tipo_evento.id = :_tipo_evento and campione.campione_verificazione = :_campione_verificazione and campione.statoCampione!='F' and (obsoleta = null or obsoleta = 'N')");
//				query.setParameter("_tipo_evento", Integer.parseInt(tipo_evento));
//				query.setParameter("_campione_verificazione",verificazione);
//				
//				
//			}else {
//				query= session.createQuery("from RegistroEventiDTO where tipo_evento.id = :_tipo_evento and data_scadenza = :_data_scadenza and campione.campione_verificazione = :_campione_verificazione and campione.statoCampione!='F' and (obsoleta is null or obsoleta = 'N')");
//				query.setParameter("_tipo_evento", Integer.parseInt(tipo_evento));
//				query.setParameter("_campione_verificazione",verificazione);
//				query.setParameter("_data_scadenza",df.parse(data));
//			
//				
//				
//			}
//			
//		}else {
//			if(tipo_evento.equals("1")) {
//				
//				query= session.createQuery("from RegistroEventiDTO where tipo_evento.id = :_tipo_evento and campione.statoCampione!='F' and (obsoleta = null or obsoleta = 'N')");
//				query.setParameter("_tipo_evento", Integer.parseInt(tipo_evento));
//			
//				
//				
//			}else {
//				query= session.createQuery("from RegistroEventiDTO where tipo_evento.id = :_tipo_evento and data_scadenza = :_data_scadenza and campione.statoCampione!='F' and (obsoleta is null or obsoleta = 'N')");
//				query.setParameter("_tipo_evento", Integer.parseInt(tipo_evento));
//				query.setParameter("_data_scadenza",df.parse(data));
//			
//				
//				
//			}
//			
//		}
//		
//		registro = (ArrayList<RegistroEventiDTO>) query.list();
//		
//		if(registro!=null) {
//			for (RegistroEventiDTO r : registro) {
//				if(tipo_evento.equals("1")){
//						
//					if(r.getCampione().getFrequenza_manutenzione()!=0) {
//									
//						Calendar calendar = Calendar.getInstance();
//						calendar.setTime(r.getData_evento());
//						calendar.add(Calendar.MONTH, r.getCampione().getFrequenza_manutenzione());
//						
//						Date date = calendar.getTime();
//						if(df.format(date).equals(data) && !lista.contains(r.getCampione())) {
//							lista.add(r.getCampione());	
//						}
//					}
//				}else  {
//					lista.add(r.getCampione());	
//				}
//			}
//		}
//		
//		if(verificazione==0) {
//			query  = session.createQuery( "from CampioneDTO where statoCampione != 'F' and tipo_campione.id = 4 and data_scadenza = :_data_scadenza ");
//			query.setParameter("_data_scadenza",df.parse(data));
//			ArrayList<CampioneDTO> lista_campioni = (ArrayList<CampioneDTO>) query.list();
//			
//			for (CampioneDTO campioneDTO : lista_campioni) {
//	
//				lista.add(campioneDTO);
//			}
//		}
//		
//	}	
//	session.close();
//	return lista;
//}



public static ArrayList<CampioneDTO> getListaCampioniPerData(String data, String tipo_data,  String verificazione, String lat, Session session) throws Exception, ParseException {
	
	DateFormat df = new SimpleDateFormat("yyyy-MM-dd");			

	ArrayList<CampioneDTO> lista = new ArrayList<CampioneDTO>();

	String not = "not";
	if(!lat.equals("")) {
		not = "";
	}
	Query query = null;
	
	if(verificazione.equals("1")) {
		query = session.createQuery("from CampioneDTO where "+tipo_data+"= :_date and statoCampione!='F' and codice "+ not+" like '%CDT%' and campione_verificazione = :_verificazione");
		query.setParameter("_verificazione", Integer.parseInt(verificazione));
	}else {
		query = session.createQuery("from CampioneDTO where "+tipo_data+"= :_date and statoCampione!='F' and codice "+ not+" like '%CDT%'");
	}
	
	query.setParameter("_date", df.parse(data));

		
	lista = (ArrayList<CampioneDTO>) query.list();
		

	return lista;
}


public static void updateObsolete(String idC, int tipo_attivita, Date data, Session session) {
	
	Query query = null;
	String str_query = "";
			
	if(tipo_attivita==1) {
		str_query = "update AcAttivitaCampioneDTO set obsoleta='S' where id_campione =:_id_campione and id_tipo_attivita = 1 and tipo_manutenzione=1 ";
		
		
	}else {
		str_query = "update AcAttivitaCampioneDTO set obsoleta='S' where id_campione =:_id_campione and id_tipo_attivita = 2";
	}
	
	if(data!=null) {
		str_query += " and data < :_data";
	}
	
	query = session.createQuery(str_query);
	
	query.setParameter("_id_campione", idC);
	if(data!=null) {
		query.setParameter("_data", data);
	}
	
	query.executeUpdate();
}


public static ArrayList<AcAttivitaCampioneDTO> getListaFuoriServizio(int id_campione, Session session) {
	ArrayList<AcAttivitaCampioneDTO> lista=null;

	Query query = session.createQuery("from AcAttivitaCampioneDTO where campione.id = :_id_campione and tipo_attivita.id = 4 and disabilitata = 0");		
	query.setParameter("_id_campione", id_campione);
	
	
	lista= (ArrayList<AcAttivitaCampioneDTO>)query.list();	
	
	return lista;
}


public static ArrayList<CampioneDTO> getListaCampioniAffini(String codice, Session session) {


	ArrayList<CampioneDTO> lista=null;

	Query query = session.createQuery("from CampioneDTO where codice like '%"+codice+"%'");		
	
	
	
	lista= (ArrayList<CampioneDTO>)query.list();	
	
	return lista;
}


public static ArrayList<HashMap<String, Integer>> getListaScadenzeCampione(String verificazione, int id_company, String lat, UtenteDTO utente, Session session) {
	
	ArrayList<CampioneDTO> lista=null;

	ArrayList<HashMap<String, Integer>> listMap= new ArrayList<HashMap<String, Integer>>();
	HashMap<String, Integer> mapTarature = new HashMap<String, Integer>();
	HashMap<String, Integer> mapVerifiche = new HashMap<String, Integer>();
	HashMap<String, Integer> mapManutenzioni = new HashMap<String, Integer>();
	
	String not = "not";
	if(!lat.equals("")) {
		not = "";
	}
	
	Query query = null;
	
	if(verificazione.equals("1")) {
		query = session.createQuery("from CampioneDTO where codice "+ not+" like '%CDT%' and campione_verificazione = :_verificazione and statoCampione != 'F'");
		query.setParameter("_verificazione", Integer.parseInt(verificazione));
	}else {
		//query = session.createQuery("from CampioneDTO where codice "+ not+" like '%CDT%' and id_company = :_idCmp and statoCampione != 'F'");
		if(!utente.isTras()&& (utente.checkRuolo("FR")||utente.checkRuolo("VC"))) {
			query = session.createQuery("from CampioneDTO where codice "+ not+" like '%CDT%' and statoCampione != 'F' and id_company = :_idCmp");
			query.setParameter("_idCmp", id_company);
		}else {
			query = session.createQuery("from CampioneDTO where codice "+ not+" like '%CDT%' and statoCampione != 'F'");
		}
		
		
	}
	
	
	//Query query = session.createQuery("from CampioneDTO where codice "+ not+" like '%CDT%' and id_company = :_idCmp and campione_verificazione = :_verificazione and statoCampione != 'F'");
	
	//query.setParameter("_idCmp", id_company);
		
	
	lista= (ArrayList<CampioneDTO>)query.list();	
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	
	

	
	for (CampioneDTO campione : lista) {
		
		if(campione.getDataScadenza()!=null){
			int count_tar = 1;
			if(mapTarature.get(sdf.format(campione.getDataScadenza()))!=null) {
				count_tar= mapTarature.get(sdf.format(campione.getDataScadenza()))+1;
			}
			
			mapTarature.put(sdf.format(campione.getDataScadenza()), count_tar);
		}
		
		if(campione.getDataScadenzaVerificaIntermedia()!=null){
			int count_ver = 1;
			if(mapVerifiche.get(sdf.format(campione.getDataScadenzaVerificaIntermedia()))!=null) {
				count_ver= mapVerifiche.get(sdf.format(campione.getDataScadenzaVerificaIntermedia()))+1;
			}
			
			mapVerifiche.put(sdf.format(campione.getDataScadenzaVerificaIntermedia()), count_ver);
		}
		
		if(campione.getDataScadenzaManutenzione()!=null){
			int count_man = 1;
			if(mapManutenzioni.get(sdf.format(campione.getDataScadenzaManutenzione()))!=null) {
				count_man= mapManutenzioni.get(sdf.format(campione.getDataScadenzaManutenzione()))+1;
			}
			
			mapManutenzioni.put(sdf.format(campione.getDataScadenzaManutenzione()), count_man);
		}
		
	}
	
	
	listMap.add(mapManutenzioni);
	listMap.add(mapVerifiche);
	listMap.add(mapTarature);
	
	
	return listMap;
}


public static void aggiornaCampioni(Session session) {
	
	ArrayList<AcAttivitaCampioneDTO> lista=null;

	Query query = session.createQuery("from AcAttivitaCampioneDTO where disabilitata = 0 and obsoleta = 'N'");		
	
	
	lista= (ArrayList<AcAttivitaCampioneDTO>)query.list();	
	
	
	for (AcAttivitaCampioneDTO a : lista) {
		if(a.getTipo_attivita().getId()==1) {
			a.getCampione().setDataManutenzione(a.getData());
			
			if(a.getData_scadenza()!=null) {
				a.getCampione().setDataScadenzaManutenzione(a.getData_scadenza());	
			}else {
				
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(a.getData());
				calendar.add(Calendar.MONTH, a.getCampione().getFrequenza_manutenzione());
				
				java.util.Date date = calendar.getTime();
				a.getCampione().setDataScadenzaManutenzione(date);
			}
			
			System.out.println("CAMPIONE "+a.getCampione().getId()+" manutenzione: "+a.getData()+" scadenza: "+a.getData_scadenza());
		}else if(a.getTipo_attivita().getId()==2){
			a.getCampione().setDataVerificaIntermedia(a.getData());
			a.getCampione().setDataScadenzaVerificaIntermedia(a.getData_scadenza());
			System.out.println("CAMPIONE "+a.getCampione().getId()+" verifica: "+a.getData()+" scadenza: "+a.getData_scadenza());
		}else if(a.getTipo_attivita().getId()==3) {
			a.getCampione().setDataVerifica(a.getData());
			a.getCampione().setDataScadenza(a.getData_scadenza());
			System.out.println("CAMPIONE "+a.getCampione().getId()+" taratura: "+a.getData()+" scadenza: "+a.getData_scadenza());
		}
		
		session.update(a.getCampione());
	}


}



public static void aggiornaObsolete(Session session) {
	
	ArrayList<AcAttivitaCampioneDTO> lista=null;
	ArrayList<AcAttivitaCampioneDTO> listaObsolete=null;

	Query query = session.createQuery("from AcAttivitaCampioneDTO");		
	
	
	listaObsolete= (ArrayList<AcAttivitaCampioneDTO>)query.list();	
	
	
	for (AcAttivitaCampioneDTO a : listaObsolete) {
		
		query = session.createQuery("from AcAttivitaCampioneDTO where campione.id = :_campione and tipo_attivita.id =:_tipo and data_attivita > :_data");
		query.setParameter("_campione", a.getCampione().getId());
		query.setParameter("_tipo", a.getTipo_attivita().getId());
		query.setParameter("_data", a.getData());
		
		lista= (ArrayList<AcAttivitaCampioneDTO>)query.list();	
		
		if(lista.size()>0) {
			a.setObsoleta("S");
		}else {
			a.setObsoleta("N");
		}
		
		
				
		session.update(a);
	}


}


public static void aggiornaTar(Session session) {
	ArrayList<AcAttivitaCampioneDTO> lista=null;
	ArrayList<AcAttivitaCampioneDTO> listaObsolete=null;

	Query query = session.createQuery("from AcAttivitaCampioneDTO where campione.codice like '%CDT%' and data_attivita = '2022-12-23 00:00:00' and tipo_attivita.id = 2");		
	
	
	listaObsolete= (ArrayList<AcAttivitaCampioneDTO>)query.list();	
	
	
	for (AcAttivitaCampioneDTO a : listaObsolete) {
		
		System.out.println("CAMPIONE: "+a.getCampione().getCodice()+" data scadenza old: "+a.getCampione().getDataScadenza()+" data scadenza new: "+a.getData_scadenza());
		
		a.setTipo_attivita(new AcTipoAttivitaCampioniDTO(3, ""));
		a.getCampione().setDataVerifica(a.getData());
		
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(a.getData());
		calendar.add(Calendar.MONTH, a.getCampione().getFreqTaraturaMesi());
		
		Date date = calendar.getTime();
		
		a.getCampione().setDataScadenza(date);
		a.setData_scadenza(date);
	
		
		if(a.getCampione().getDataScadenza().after(new Date())) {
			a.getCampione().setStatoCampione("S");
		}
		
		
				
		//session.update(a);
		//session.update(a.getCampione());
	}
	
	//session.getTransaction().commit();
	//session.close();
	
}

public static void aggiornaTarCampioni(Session session) {
	ArrayList<CampioneDTO> lista=null;
	ArrayList<AcAttivitaCampioneDTO> listaObsolete=null;

	Query query = session.createQuery("from CampioneDTO where data_scadenza > '2023-02-14 00:00:00' and statoCampione = 'N'");		
	
	
	lista= (ArrayList<CampioneDTO>)query.list();	
	
	
	for (CampioneDTO a : lista) {
		
		
		
		if(a.getDataScadenza().after(new Date())) {
			a.setStatoCampione("S");
		}
		
		
				
		session.update(a);
		//session.update(a.getCampione());
	}
	
	//session.getTransaction().commit();
	//session.close();
	
}


public static void aggiornaLaboratorio(Session session) {

	
	ArrayList<AcAttivitaCampioneDTO> lista=null;

	Query query = session.createQuery("from AcAttivitaCampioneDTO where ente is not null and ente !='Interno' AND ente NOT LIKE '%STI%'  AND ente NOT LIKE '%S.T.I.%' ");		
	
	
	lista= (ArrayList<AcAttivitaCampioneDTO>)query.list();	
	
	
	for (AcAttivitaCampioneDTO a : lista) {
		
		
	a.setEtichettatura("Esterna");
		
		
				
		session.update(a);
		//session.update(a.getCampione());
	}
}


}
