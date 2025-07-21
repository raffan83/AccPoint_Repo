package it.portaleSTI.bo;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneParcoAutoDAO;
import it.portaleSTI.DTO.PaaPrenotazioneDTO;
import it.portaleSTI.DTO.PaaRichiestaDTO;
import it.portaleSTI.DTO.PaaSegnalazioneDTO;
import it.portaleSTI.DTO.PaaTipoSegnalazioneDTO;
import it.portaleSTI.DTO.PaaVeicoloDTO;
import it.portaleSTI.DTO.UtenteDTO;

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
	
	public static ArrayList<PaaPrenotazioneDTO> getListaPrenotazioniPerUtente(UtenteDTO utente, Session session) {
		// TODO Auto-generated method stub
		return GestioneParcoAutoDAO.getListaPrenotazioniPerUtente(utente,session);
	}

	public static PaaPrenotazioneDTO getPrenotazioneFromId(int id, Session session) {

		return GestioneParcoAutoDAO.getPrenotazioneFromId(id, session);
	}

	public static ArrayList<PaaRichiestaDTO> getListaRichieste(Session session) {
		// TODO Auto-generated method stub
		return GestioneParcoAutoDAO.getListaRichieste(session);
	}

	public static PaaRichiestaDTO getRichiestaFromID(int parseInt, Session session) {
		// TODO Auto-generated method stub
		return GestioneParcoAutoDAO.getRichiestaFromID(parseInt, session);
	}

	public static ArrayList<PaaVeicoloDTO> getListaVeicoliDisponibili(Date data_start, Date data_end, Session session) {
		// TODO Auto-generated method stub
		return GestioneParcoAutoDAO.getListaVeicoliDisponibili(data_start, data_end, session);
	}

	public static ArrayList<PaaPrenotazioneDTO> getListaPrenotazioniDate(LocalDate startDate, LocalDate endDate,
			Session session) {
		// TODO Auto-generated method stub
		return GestioneParcoAutoDAO.getListaPrenotazioniDate(startDate, endDate, session);
	}

	public static ArrayList<PaaTipoSegnalazioneDTO> getListaTipiSegnalazione(Session session) {
		// TODO Auto-generated method stub
		return GestioneParcoAutoDAO.getListaTipiSegnalazione(session);
	}

	public static ArrayList<PaaSegnalazioneDTO> getListaSegnalazioni(int prenotazione, int veicolo, Date data, Session session) {
		// TODO Auto-generated method stub
		return GestioneParcoAutoDAO.getListaSegnalazioni(prenotazione,veicolo, data, session);
	}

	public static void deleteSegnalazioni(int id_prenotazione, int id_tipo,Session session) {
		// TODO Auto-generated method stub
		 GestioneParcoAutoDAO.deleteSegnalazioni(id_prenotazione, id_tipo, session);
	}

	public static PaaSegnalazioneDTO getSegnalazione(int id_prenotazione, int id_tipo, Session session) {
		
		return GestioneParcoAutoDAO.getSegnalazione(id_prenotazione, id_tipo, session);
	}
}
