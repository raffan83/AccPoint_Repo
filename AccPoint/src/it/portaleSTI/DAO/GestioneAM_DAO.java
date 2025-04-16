package it.portaleSTI.DAO;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.AMInterventoDTO;
import it.portaleSTI.DTO.AMOggettoProvaDTO;
import it.portaleSTI.DTO.AMOperatoreDTO;
import it.portaleSTI.DTO.AMCampioneDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerInterventoDTO;
import it.portaleSTI.DTO.VerInterventoStrumentiDTO;
import it.portaleSTI.DTO.VerMisuraDTO;
import it.portaleSTI.DTO.VerStrumentoDTO;

public class GestioneAM_DAO {

	public static ArrayList<AMInterventoDTO> getListaInterventi(UtenteDTO utente, String dateFrom, String dateTo, Session session) throws HibernateException, ParseException {
		
		ArrayList<AMInterventoDTO> lista = null;
		Query query = null;
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		query = session.createQuery("from AMInterventoDTO where data_intervento between :_dateFrom and :_dateTo");
			
		
		query.setParameter("_dateFrom", sdf.parse(dateFrom));
		query.setParameter("_dateTo", sdf.parse(dateTo));
		
		lista = (ArrayList<AMInterventoDTO>) query.list();
		
		return lista;
	}

	public static ArrayList<AMOperatoreDTO> getListaOperatoriAll(Session session) throws HibernateException, ParseException {
		
		
		ArrayList<AMOperatoreDTO> lista = null;
		

		Query query = session.createQuery("from AMOperatoreDTO");
	  
	    		
	    lista = (ArrayList<AMOperatoreDTO>)query.list();
	    
	    
		return lista;
	}

	public static ArrayList<AMCampioneDTO> getListaCampioni(Session session) {
		
		ArrayList<AMCampioneDTO> lista = null;
		

		Query query = session.createQuery("from AMCampioneDTO");
	  
	    		
	    return lista = (ArrayList<AMCampioneDTO>)query.list();
	    
	}
	
	
public static AMInterventoDTO getInterventoFromID(int id_intervento, Session session) {
		
		ArrayList<AMInterventoDTO> lista = null;
		AMInterventoDTO res = new AMInterventoDTO();
		Query query = null;
		
		
		query = session.createQuery("from AMInterventoDTO where id = :_id");			
		
		query.setParameter("_id", id_intervento);
		
		lista = (ArrayList<AMInterventoDTO>) query.list();
		
		if(lista.size()>0) {
			res = lista.get(0);
		}
		
		return res;


	}

public static ArrayList<AMOggettoProvaDTO> getListaStrumenti(Session session) {


	ArrayList<AMOggettoProvaDTO> lista = null;
	

	Query query = session.createQuery("from AMOggettoProvaDTO");
  
    		
    return lista = (ArrayList<AMOggettoProvaDTO>)query.list();
}

public static AMOggettoProvaDTO getOggettoProvaFromID(int id_strumento, Session session) {

	ArrayList<AMOggettoProvaDTO> lista = null;
	AMOggettoProvaDTO res = new AMOggettoProvaDTO();
	Query query = null;
	
	
	query = session.createQuery("from AMOggettoProvaDTO where id = :_id");			
	
	query.setParameter("_id", id_strumento);
	
	lista = (ArrayList<AMOggettoProvaDTO>) query.list();
	
	if(lista.size()>0) {
		res = lista.get(0);
	}
	
	return res;
}


}
