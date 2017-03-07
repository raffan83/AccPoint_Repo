package it.portaleSTI.bo;

import it.portaleSTI.DAO.GestionePrenotazioneDAO;
import it.portaleSTI.DTO.PrenotazioneDTO;

import java.util.ArrayList;

public class GestionePrenotazioni {

	public static ArrayList<PrenotazioneDTO> getListaPrenotazioniRichieste(int myId) throws Exception {
	
		
		return GestionePrenotazioneDAO.getListaPrenotazioniRichieste(myId);
	}

}
