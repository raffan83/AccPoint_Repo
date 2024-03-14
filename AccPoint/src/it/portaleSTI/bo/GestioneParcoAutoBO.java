package it.portaleSTI.bo;

import java.util.ArrayList;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneParcoAutoDAO;
import it.portaleSTI.DTO.PaaPrenotazioneDTO;
import it.portaleSTI.DTO.PaaVeicoloDTO;

public class GestioneParcoAutoBO {

	public static ArrayList<PaaVeicoloDTO> getListaVeicoli(Session session) {
		// TODO Auto-generated method stub
		return GestioneParcoAutoDAO.getListaVeicoli(session);
	}

	public static PaaVeicoloDTO getVeicoloFromId(int id, Session session) {
		
		return GestioneParcoAutoDAO.getVeicoloFromId(id, session);
	}
	
	public static ArrayList<PaaPrenotazioneDTO> getListaPrenotazioni(Session session) {
		// TODO Auto-generated method stub
		return GestioneParcoAutoDAO.getListaPrenotazioni(session);
	}

	public static PaaPrenotazioneDTO getPrenotazioneFromId(int id, Session session) {

		return GestioneParcoAutoDAO.getPrenotazioneFromId(id, session);
	}

}
