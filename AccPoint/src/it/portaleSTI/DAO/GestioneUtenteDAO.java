package it.portaleSTI.DAO;


import it.portaleSTI.DTO.UtenteDTO;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

public class GestioneUtenteDAO {


public static UtenteDTO getUtenteById(String id, Session session)throws HibernateException, Exception {


	Query query  = session.createQuery( "from UtenteDTO WHERE id= :_id");
	
	query.setParameter("_id", Integer.parseInt(id));
	List<UtenteDTO> result =query.list();
	
	if(result.size()>0)
	{			
		return result.get(0);
	}
	return null;
	
}

public static void save(Session session, UtenteDTO utente)throws Exception {
	
	session.save(utente);
	
}


}