package it.portaleSTI.DAO;

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
import it.portaleSTI.DTO.TaraturaEsternaCampioneDTO;


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


public static ArrayList<HashMap<String, Integer>> getListaAttivitaScadenziario(Session session) {
	
	Query query=null;
	ArrayList<HashMap<String, Integer>> listMap= new ArrayList<HashMap<String, Integer>>();
	HashMap<String, Integer> mapTarature = new HashMap<String, Integer>();
	HashMap<String, Integer> mapVerifiche = new HashMap<String, Integer>();
	HashMap<String, Integer> mapManutenzioni = new HashMap<String, Integer>();
	
	List<AcAttivitaCampioneDTO> lista =null;
	List<CampioneDTO> lista_campioni = null;
	
	query  = session.createQuery( "from AcAttivitaCampioneDTO where campione.statoCampione != 'F' and (obsoleta = null or obsoleta = 'N') and disabilitata = 0");	
	
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
		
//		if(att.getTipo_attivita().getId()==3 && att.getData_scadenza()!=null) {
//			
//			int i=1;
//			if(mapTarature.get(sdf.format(att.getData_scadenza()))!=null) {
//				i= mapTarature.get(sdf.format(att.getData_scadenza()))+1;
//			}
//			
//			mapTarature.put(sdf.format(att.getData_scadenza()), i);
//			
//		}
		

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
		
		if(att.getTipo_evento().getId()==5 && att.getData_scadenza()!=null) {
			
			int i=1;
			if(mapVerifiche.get(sdf.format(att.getData_scadenza()))!=null) {
				i= mapVerifiche.get(sdf.format(att.getData_scadenza()))+1;
			}
			
			mapVerifiche.put(sdf.format(att.getData_scadenza()), i);
			
		}
		


    }
	
	if(verificazione!=null) {
		query  = session.createQuery( "from CampioneDTO where statoCampione != 'F' and campione_verificazione = 1 and  codice not like '%CDT%'");	
	}else {
		query  = session.createQuery( "from CampioneDTO where statoCampione != 'F' and codice not like '%CDT%'");		
	}
	
	
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





public static ArrayList<CampioneDTO> getListaCampioniPerData(String data, String tipo_data_lat, String tipo_evento, int verificazione) throws Exception, ParseException {
	DateFormat df = new SimpleDateFormat("yyyy-MM-dd");		
	Session session = SessionFacotryDAO.get().openSession();
    
	session.beginTransaction();
	ArrayList<AcAttivitaCampioneDTO> attivita = null;
	ArrayList<RegistroEventiDTO> registro = null;
	ArrayList<CampioneDTO> lista = new ArrayList<CampioneDTO>();
	Query query = null;
	
	if(tipo_data_lat!=null) {
		
		if(tipo_data_lat.equals("1")) {
			query = session.createQuery("from AcAttivitaCampioneDTO where tipo_attivita.id = 1 and (obsoleta = null or obsoleta = 'N') and disabilitata = 0");	
						
			attivita = (ArrayList<AcAttivitaCampioneDTO>) query.list();
			
			for (AcAttivitaCampioneDTO a : attivita) {
				

				Calendar calendar = Calendar.getInstance();
				calendar.setTime(a.getData());
				calendar.add(Calendar.MONTH, a.getCampione().getFrequenza_manutenzione());
				
				Date date = calendar.getTime();
				if(df.format(date).equals(data) && !lista.contains(a.getCampione())) {
					lista.add(a.getCampione());	
				}
				
			}
		}
		else if(tipo_data_lat.equals("2")) {
			query = session.createQuery("from AcAttivitaCampioneDTO where data_scadenza = :_date and tipo_attivita.id = 2 and (obsoleta = null or obsoleta = 'N') and disabilitata = 0");	
			query.setParameter("_date", df.parse(data));
			
			attivita = (ArrayList<AcAttivitaCampioneDTO>) query.list();
			
			for (AcAttivitaCampioneDTO a : attivita) {
				
					lista.add(a.getCampione());	
				
			}
			
		}
		else if(tipo_data_lat.equals("3")) {
			query = session.createQuery("from CampioneDTO where data_scadenza = :_date and stato_campione != 'F'");	
			query.setParameter("_date", df.parse(data));
			
			lista = (ArrayList<CampioneDTO>) query.list();
		}
	
	

	
	}else {
		query= session.createQuery("from RegistroEventiDTO where tipo_evento.id = :_tipo_evento and campione.campione_verificazione = :_campione_verificazione and campione.statoCampione!='F' and (obsoleta = null or obsoleta = 'N')");
		query.setParameter("_tipo_evento", Integer.parseInt(tipo_evento));
		query.setParameter("_campione_verificazione",verificazione);
		registro = (ArrayList<RegistroEventiDTO>) query.list();
		
		if(registro!=null) {
			for (RegistroEventiDTO r : registro) {
				if(r.getCampione().getFrequenza_manutenzione()!=0) {
									
					Calendar calendar = Calendar.getInstance();
					calendar.setTime(r.getData_evento());
					calendar.add(Calendar.MONTH, r.getCampione().getFrequenza_manutenzione());
					
					Date date = calendar.getTime();
					if(df.format(date).equals(data) && !lista.contains(r.getCampione())) {
						lista.add(r.getCampione());	
					}
				}
			}
		}
	}	
	session.close();
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


}
