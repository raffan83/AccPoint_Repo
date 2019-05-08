package it.portaleSTI.bo;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneSicurezzaElettricaDAO;
import it.portaleSTI.DTO.SicurezzaElettricaDTO;

public class GestioneSicurezzaElettricaBO {

	public static SicurezzaElettricaDTO getMisuraSeFormIdMisura(int id_misura, Session session) {
		
		return GestioneSicurezzaElettricaDAO.getMisuraSeFormIdMisura(id_misura, session);
	}
	


}
