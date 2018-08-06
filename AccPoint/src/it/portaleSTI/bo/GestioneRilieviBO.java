package it.portaleSTI.bo;

import java.util.ArrayList;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneRilieviDAO;
import it.portaleSTI.DTO.RilMisuraRilievoDTO;
import it.portaleSTI.DTO.RilPezzoDTO;
import it.portaleSTI.DTO.RilTipoRilievoDTO;

public class GestioneRilieviBO {

	public static ArrayList<RilMisuraRilievoDTO> getListaRilievi() {
		
		return GestioneRilieviDAO.getListaRilievi();
	}

	public static ArrayList<RilPezzoDTO> getListaPezzi() {
		
		return GestioneRilieviDAO.getListaPezzi();
	}

	public static ArrayList<RilTipoRilievoDTO> getListaTipoRilievo() {
		
		return GestioneRilieviDAO.getListaTipoRilievo();
	}

	public static void saveRilievo(RilMisuraRilievoDTO misura_rilievo, Session session) {
		
		GestioneRilieviDAO.saveRilievo(misura_rilievo, session);
		
	}

	public static void update(RilMisuraRilievoDTO misura_rilievo, Session session) {

		GestioneRilieviDAO.updateRilievo(misura_rilievo, session);
	}

	public static RilMisuraRilievoDTO getMisuraRilieviFromId(int id_misura, Session session) {

		return GestioneRilieviDAO.getMisuraRilievoFromId(id_misura, session);
	}
	
	

}
