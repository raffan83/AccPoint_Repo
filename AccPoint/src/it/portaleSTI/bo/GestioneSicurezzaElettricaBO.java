package it.portaleSTI.bo;

import org.hibernate.Session;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.GestioneSicurezzaElettricaDAO;
import it.portaleSTI.DTO.SicurezzaElettricaDTO;
import it.portaleSTI.DTO.UtenteDTO;

public class GestioneSicurezzaElettricaBO {

	public static SicurezzaElettricaDTO getMisuraSeFormIdMisura(int id_misura, Session session) {
		
		return GestioneSicurezzaElettricaDAO.getMisuraSeFormIdMisura(id_misura, session);
	}

	public static void updateContatoreUtente(UtenteDTO utente) throws Exception {
		
		DirectMySqlDAO.updateConatoreUtente(utente);
		
	}
	


}
