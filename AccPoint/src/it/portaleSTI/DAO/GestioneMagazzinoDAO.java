package it.portaleSTI.DAO;

import org.hibernate.Session;

import it.portaleSTI.DTO.LogMagazzinoDTO;

public class GestioneMagazzinoDAO {

	public static void save(LogMagazzinoDTO logMagazzino, Session session) throws Exception{
		
		session.save(logMagazzino);
		
	}

}
