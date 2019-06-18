package it.portaleSTI.bo;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneCartaDiControlloDAO;
import it.portaleSTI.DTO.CartaDiControlloDTO;

public class GestioneCartaDiControlloBO {

	public static CartaDiControlloDTO getCartaDiControlloFromCampione(String id_campione, Session session) {
		
		return GestioneCartaDiControlloDAO.getCartaDiControlloFromCampione(id_campione, session);
	}

	public static CartaDiControlloDTO getCartaDiControlloFromId(int id_carta, Session session) {
	
		return GestioneCartaDiControlloDAO.getCartaDiControlloFromId(id_carta, session);
	}

}
