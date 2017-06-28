package it.portaleSTI.bo;

import it.portaleSTI.DAO.GestionePrenotazioneDAO;
import it.portaleSTI.DTO.PrenotazioneDTO;

import java.util.List;

import org.hibernate.Session;

public class GestionePrenotazioniBO {

	public static List<PrenotazioneDTO> getListaPrenotazioniRichieste(int myId) throws Exception {
	
		
		return GestionePrenotazioneDAO.getListaPrenotazioniRichieste(myId);
	}

	public static int updatePrenotazione(PrenotazioneDTO prenotazione, Session session) throws Exception {
		
		int toRet=0;
		try 
		{
			GestionePrenotazioneDAO.updatePrenotazione(prenotazione, session);	
		}
		catch (Exception e) 
		{
			toRet=1;
			throw e;	
		}
		return toRet;
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

	public static int savePrenotazione(PrenotazioneDTO prenotazione, Session session) {
		int toRet=0;
		try 
		{
			GestionePrenotazioneDAO.savePrenotazione(prenotazione, session);	
		}
		catch (Exception e) 
		{
			toRet=1;
			throw e;	
		}
		return toRet;
		
	}
}
