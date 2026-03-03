package it.portaleSTI.bo;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestionePrenotazioneCampioneDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CampionePrenotazioneDTO;


public class GestionePrenotazioneCampioneBO {
	
	public static ArrayList<CampionePrenotazioneDTO> getListaPrenotazioniDate(LocalDate startDate, LocalDate endDate,
			Session session) {
		// TODO Auto-generated method stub
		return GestionePrenotazioneCampioneDAO.getListaPrenotazioniDate(startDate, endDate, session);
	}

	public static ArrayList<CampioneDTO> getListaCampioniDisponibiliDate(LocalDateTime startDateTime, LocalDateTime endDateTime,
			Session session) {
		// TODO Auto-generated method stub
		return GestionePrenotazioneCampioneDAO.getListaCampioniDisponibiliDate(startDateTime, endDateTime, session);
	}

	public static CampionePrenotazioneDTO getPrenotazioneFromId(int parseInt, Session session) {
		// TODO Auto-generated method stub
		return GestionePrenotazioneCampioneDAO.getPrenotazioneFromId(parseInt, session);
	}

}
