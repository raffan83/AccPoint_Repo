package it.portaleSTI.bo;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneAccessoDAO;
import it.portaleSTI.DAO.GestioneParcoAutoDAO;
import it.portaleSTI.DTO.PaaPrenotazioneDTO;
import it.portaleSTI.DTO.PaaRichiestaDTO;
import it.portaleSTI.DTO.PaaSegnalazioneDTO;
import it.portaleSTI.DTO.PaaTipoSegnalazioneDTO;
import it.portaleSTI.DTO.PaaVeicoloDTO;
import it.portaleSTI.DTO.RuoloDTO;
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
	public static PaaSegnalazioneDTO getSegnalazioneById(int id_segnalazione) {
		
		return GestioneParcoAutoDAO.getSegnalazioneById(id_segnalazione);
	}
	
	public static String getListaUtenteWithRuolo(String siglaRuolo,Session session){
		ArrayList<UtenteDTO> listaUtenti = null;
	    String email ="";
        try {
        	 listaUtenti =  (ArrayList<UtenteDTO>) GestioneAccessoDAO.getListUser();
			
			for(UtenteDTO utente :listaUtenti) {
				if(utente.checkRuolo(siglaRuolo)) {
					email += utente.getEMail() + ";";
				}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return email;
	}
	
	public static PaaPrenotazioneDTO getPrenotazioneByIdRichiesta(int idRichiesta,Session session) {
		return GestioneParcoAutoDAO.getPrenotazioneByIdRichiesta(idRichiesta, session);
	}
	
	public static void sendEmailRichiestaAnnullamento(String emailInvio,PaaPrenotazioneDTO prenotazione, PaaRichiestaDTO richiesta) {
		String object = "Richiesta di annullamento prenotazione veicolo";
		
		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");

	    String dataInizio = sdf.format(
	        prenotazione.getData_inizio_prenotazione());

	    String dataFine = sdf.format(
	        prenotazione.getData_fine_prenotazione());

	    String msgHtml =	
	        "<p>Con la presente si comunica che &egrave; stato richiesto " +
	        "l'annullamento della seguente prenotazione del Parco Auto.</p>" +

	        "<p><strong>Dettagli della prenotazione:</strong></p>" +

"<ul>" +
"<li><strong>ID richiesta:</strong> " + richiesta.getId() + "</li>" +
"<li><strong>Data inizio:</strong> " + dataInizio + "</li>" +
"<li><strong>Data fine:</strong> " + dataFine + "</li>" +
"<li><strong>Utente:</strong> " + richiesta.getUtente().getNominativo() + "</li>" +
"<li><strong>Veicolo:</strong> " +
    "ID " + prenotazione.getVeicolo().getId() +
    " - Modello: " + prenotazione.getVeicolo().getModello() +
    " - Targa: " + prenotazione.getVeicolo().getTarga() +
"</li>" +
"</ul>" +

	        "<p>Si invita a prendere visione della richiesta e a procedere " +
	        "con le eventuali verifiche necessarie.</p>" +

	        "<p>Cordiali saluti,<br>" +
	        "<strong>Sistema di Gestione Parco Auto</strong></p>" +

	        "<hr>" +
	        "<small>Questa email &egrave; stata generata automaticamente. " +
	        "Si prega di non rispondere.</small>";
	    
	    
	//	emailInvio = "edoardo.boccitto@ncsnetwork.it";
		try {
			SendEmailBO.sendEmail(emailInvio, object, msgHtml);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
