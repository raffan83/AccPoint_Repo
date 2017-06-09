package it.portaleSTI.bo;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneUtenteDAO;
import it.portaleSTI.DTO.UtenteDTO;


public class GestioneUtenteBO {

	
	public static UtenteDTO getUtenteById(String id_str, Session session) throws Exception {


		return GestioneUtenteDAO.getUtenteById(id_str, session);
	}

	public static void save(UtenteDTO utente) {
		
		GestioneUtenteDAO.save(utente);
		
	}


}
