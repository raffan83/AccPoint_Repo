package it.portaleSTI.bo;

import java.text.ParseException;
import java.util.ArrayList;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneAssegnazioneAttivitaDAO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.MilestoneOperatoreDTO;

public class GestioneAssegnazioneAttivitaBO {

	public static ArrayList<MilestoneOperatoreDTO> getListaMilestoneOperatore(Session session) {
		
		return GestioneAssegnazioneAttivitaDAO.getListaMilestoneOperatore(session);
	}

	public static ArrayList<String> getListaCommesse(Session session) {
		
		return GestioneAssegnazioneAttivitaDAO.getListaCommesse(session);
	}

	public static ArrayList<MilestoneOperatoreDTO> getListaMilestoneFiltrata(String id_utente, String commessa, String dateFrom, String dateTo, Session session) throws Exception, Exception {
		
		return GestioneAssegnazioneAttivitaDAO.getListaMilestoneFiltrata(id_utente, commessa, dateFrom, dateTo, session);
	}
	
	

}
