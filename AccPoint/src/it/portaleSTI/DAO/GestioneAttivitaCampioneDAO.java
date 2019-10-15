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

		Query query = session.createQuery("from AcAttivitaCampioneDTO where campione.id = :_id_campione");
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

		Query query = session.createQuery("from AcAttivitaCampioneDTO where campione.id = :_id_campione and tipo_attivita.id = 1");		
		query.setParameter("_id_campione", id_campione);
		
		
		lista= (ArrayList<AcAttivitaCampioneDTO>)query.list();	
		
		return lista;
	
	}

	
public static ArrayList<AcAttivitaCampioneDTO> getListaTaratureVerificheIntermedie(int id_campione, Session session) {
		
		ArrayList<AcAttivitaCampioneDTO> lista=null;

		Query query = session.createQuery("from AcAttivitaCampioneDTO where campione.id = :_id_campione and (tipo_attivita.id = 2 or tipo_attivita.id = 3)");		
		query.setParameter("_id_campione", id_campione);		
		
		lista= (ArrayList<AcAttivitaCampioneDTO>)query.list();	
		
		return lista;
	
	}


public static ArrayList<TaraturaEsternaCampioneDTO> getListaTaratureEsterneCampione(int id_campione, Session session) {

	ArrayList<TaraturaEsternaCampioneDTO> lista=null;

	Query query = session.createQuery("from TaraturaEsternaCampioneDTO where campione.id = :_id_campione)");
	query.setParameter("_id_campione", id_campione);		
	
	lista= (ArrayList<TaraturaEsternaCampioneDTO>)query.list();	
	
	return lista;
}

public static ArrayList<AcAttivitaCampioneDTO> getListaVerificheIntermedie(int id_campione, Session session) {
	
	ArrayList<AcAttivitaCampioneDTO> lista=null;

	Query query = session.createQuery("from AcAttivitaCampioneDTO where campione.id = :_id_campione and tipo_attivita.id = 2 ");		
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
	
	query  = session.createQuery( "from AcAttivitaCampioneDTO where campione.id = :_id_campione");	
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
	
	query  = session.createQuery( "from AcAttivitaCampioneDTO ");	
	
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


public static ArrayList<CampioneDTO> getListaCampioniPerData(String data, boolean manutenzione, boolean lat) throws Exception, ParseException {
	DateFormat df = new SimpleDateFormat("yyyy-MM-dd");		
Session session = SessionFacotryDAO.get().openSession();
    
	session.beginTransaction();
	ArrayList<AcAttivitaCampioneDTO> attivita = null;
	ArrayList<RegistroEventiDTO> registro = null;
	ArrayList<CampioneDTO> lista = new ArrayList<CampioneDTO>();
	Query query = null;
	
	if(!lat) {
		if(!manutenzione) {
			query = session.createQuery("from AcAttivitaCampioneDTO where data_scadenza = :_date");	
			query.setParameter("_date", df.parse(data));
		}
		else {
			query= session.createQuery("from AcAttivitaCampioneDTO where tipo_attivita.id = 1");
		}
		
		attivita = (ArrayList<AcAttivitaCampioneDTO>) query.list();
		
		if(attivita!=null) {
			for (AcAttivitaCampioneDTO a : attivita) {
				if(!manutenzione) {
					lista.add(a.getCampione());	
				}else {
					
					Calendar calendar = Calendar.getInstance();
					calendar.setTime(a.getData());
					calendar.add(Calendar.MONTH, a.getCampione().getFrequenza_manutenzione());
					
					Date date = calendar.getTime();
					if(df.format(date).equals(data)) {
						lista.add(a.getCampione());	
					}
					
				}
				
			}
		}
	
	}else {
		query= session.createQuery("from RegistroEventiDTO where tipo_evento.id = 1");
		
		registro = (ArrayList<RegistroEventiDTO>) query.list();
		
		if(registro!=null) {
			for (RegistroEventiDTO r : registro) {
									
					Calendar calendar = Calendar.getInstance();
					calendar.setTime(r.getData_evento());
					calendar.add(Calendar.MONTH, r.getCampione().getFrequenza_manutenzione());
					
					Date date = calendar.getTime();
					if(df.format(date).equals(data)) {
						lista.add(r.getCampione());	
					}

			}
		}
	}	
	session.close();
	return lista;
}


}
