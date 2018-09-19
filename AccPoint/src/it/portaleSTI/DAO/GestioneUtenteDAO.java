package it.portaleSTI.DAO;


import it.portaleSTI.DTO.UtenteDTO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
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
		return  result.get(0);
	}
	return null;
	
}

public static void save(Session session, UtenteDTO utente)throws Exception {
	
	session.save(utente);
	
}

public static UtenteDTO getUtenteByUsername(String username, Session session) {
	Query query  = session.createQuery( "from UtenteDTO WHERE user= :_user");
	
	UtenteDTO utente = null;
	
	query.setParameter("_user", username);
	List<UtenteDTO> result =query.list();
	
	if(result.size()>0)
	{			
	
		return result.get(0);
	}
	return null;
}

public static ArrayList<UtenteDTO> getAllUtenti(Session session) {

ArrayList<UtenteDTO> lista = null;
	
	Query query  = session.createQuery( "from UtenteDTO");
	

	lista =(ArrayList<UtenteDTO>) query.list();
	return lista;
}

public static ArrayList<UtenteDTO> getUtentiFromCompany(int id_company, Session session){
	
	ArrayList<UtenteDTO> lista = null;
	
	Query query  = session.createQuery( "from UtenteDTO WHERE id_company= :_id_company");
	
	query.setParameter("_id_company", id_company);
	lista =(ArrayList<UtenteDTO>) query.list();
	
	return lista;
}

public static boolean checkPINFIrma(int id, String pin, Session session) {

	boolean esito = false;
	
	Query query= session.createQuery("select pin_firma from UtenteDTO WHERE id= :_id");

	query.setParameter("_id", id);
	String res_pin = (String)query.list().get(0);
	
	if(res_pin.equals(pin)) {
		esito= true;
	}
	
	return esito;
}




}
