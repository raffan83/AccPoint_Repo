package it.portaleSTI.bo;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.GestionePrenotazioneDAO;
import it.portaleSTI.DTO.PrenotazioneDTO;

import java.util.ArrayList;

public class GestionePrenotazioniBO {

	public static ArrayList<PrenotazioneDTO> getListaPrenotazioniRichieste(int myId) throws Exception {
	
		
		return GestionePrenotazioneDAO.getListaPrenotazioniRichieste(myId);
	}

	public static void updatePrenotazione(PrenotazioneDTO prenotazione, String nota, int stato) throws Exception {
		
		GestionePrenotazioneDAO.updatePrenotazione(prenotazione.getId(), nota,stato);
		
		GestioneCampioneDAO.updateStatoCampione(prenotazione);
		
	}

	public static PrenotazioneDTO getPrenotazione(int idPrenotazione) {
		
		return GestionePrenotazioneDAO.getPrenotazione(idPrenotazione);
	}

}
