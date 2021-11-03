package it.portaleSTI.DAO;

import org.hibernate.Session;

import it.portaleSTI.DTO.GPDTO;

public class GestioneValidazioneGPDAO {

	public static void save(GPDTO greenPass, Session session) {
		
		session.save(greenPass);
		session.getTransaction().commit();
		session.close();
	}

}
