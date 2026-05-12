package it.portaleSTI.DAO;


import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;


import it.portaleSTI.DTO.SessioneDTO;



public class GestioneSessioneDAO {
	
	public static SessioneDTO getSessioneById(int id,Session session) throws Exception {
		
		Query query  = session.createQuery( "from SessioneDTO WHERE id= :_id" );
		query.setParameter("_id", id);
		
	    
		List<SessioneDTO> result =query.list();
		if(result.size()>0)
		{			
			return result.get(0);
		}
		
		return null;
	}
	
	public static ArrayList<SessioneDTO> getListaSessioni( Boolean permesso, Session session){
		if(permesso==true) {
		Query query = session.createQuery("from SessioneDTO" );
		
		List<SessioneDTO> result =query.list();
		if(result.size()>0)
		{			
			return (ArrayList) result;
		}
		}
		
		return null;
	}
	
	
	
	public static ArrayList<SessioneDTO> getListaSessioniFromDate( Boolean permesso, Session session,String dateFrom, String dateTo) throws ParseException{
		
		 if (!Boolean.TRUE.equals(permesso)) {
		        return new ArrayList<>();
		    }

		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");	
		java.sql.Date sql1 = new java.sql.Date(df.parse(dateFrom).getTime());
		java.sql.Date sql2 = new java.sql.Date(df.parse(dateTo).getTime());
		
		System.out.println("start: " + sql1 + "   end: " + sql2);
		
	    Query query = session.createQuery( "from SessioneDTO s where s.dataCreazione between :from and :to");

	    query.setParameter("from", sql1);
	    query.setParameter("to", sql2);

	    List<SessioneDTO> result =query.list();
		if(result.size()>0)
		{			
			return (ArrayList) result;
		}
		
		return null;
	}
		

public static void saveSession(SessioneDTO sessione,  Session session) {
	    

	        SessioneDTO s = new SessioneDTO();
	       s.setUsername(sessione.getUsername());
	       s.setPassword(sessione.getPassword());
	       s.setDataCreazione(sessione.getDataCreazione());
	       s.setDataScadenza(sessione.getDataScadenza());
	       s.setId_cliente(sessione.getId_cliente());
	       s.setNome_cliente(sessione.getNome_cliente());
	       s.setId_sede(sessione.getId_sede());
	       s.setNome_sede(sessione.getNome_sede());
	       s.setSession_id(sessione.getSession_id());
	       s.setId_intervento(sessione.getId_intervento());
	       s.setLista_misure_inviate(sessione.getLista_misure_inviate());
	       s.setUser(sessione.getUser());
	       s.setEmail_cliente(sessione.getEmail_cliente());
	       
	        session.save(s);

	      
	   
	}
		

}
