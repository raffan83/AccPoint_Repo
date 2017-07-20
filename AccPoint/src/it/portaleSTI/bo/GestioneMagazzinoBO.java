package it.portaleSTI.bo;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneMagazzinoDAO;
import it.portaleSTI.DTO.LogMagazzinoDTO;

public class GestioneMagazzinoBO {

	public static void save(LogMagazzinoDTO logMagazzino, Session session) throws Exception {
		GestioneMagazzinoDAO.save(logMagazzino,session);
		
	}

}
