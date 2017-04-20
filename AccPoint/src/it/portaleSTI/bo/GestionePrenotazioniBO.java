package it.portaleSTI.bo;

import it.portaleSTI.DAO.GestionePrenotazioneDAO;
import it.portaleSTI.DTO.PrenotazioneDTO;

import java.util.List;

public class GestionePrenotazioniBO {

	public static List<PrenotazioneDTO> getListaPrenotazioniRichieste(int myId) throws Exception {
	
		
		return GestionePrenotazioneDAO.getListaPrenotazioniRichieste(myId);
	}

	public static void updatePrenotazione(PrenotazioneDTO prenotazione) throws Exception {
		
		GestionePrenotazioneDAO.updatePrenotazione(prenotazione);	
	}

	public static PrenotazioneDTO getPrenotazione(int idPrenotazione) {
		
		return GestionePrenotazioneDAO.getPrenotazione(idPrenotazione);
	}

	public static List<PrenotazioneDTO> getListaPrenotazione(String idC) {
		
		return GestionePrenotazioneDAO.getListaPrenotazione(idC);
	}
	public static List<PrenotazioneDTO> getListaPrenotazioneNG(int idC) {
		
		return GestionePrenotazioneDAO.getListaPrenotazioneNG(idC);
	}
}
