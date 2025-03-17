package it.portaleSTI.DAO;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.DocumTLDocumentoDTO;
import it.portaleSTI.DTO.PaaPrenotazioneDTO;
import it.portaleSTI.DTO.PaaRichiestaDTO;
import it.portaleSTI.DTO.PaaVeicoloDTO;
import it.portaleSTI.DTO.UtenteDTO;

public class GestioneParcoAutoDAO {



	public static ArrayList<PaaVeicoloDTO> getListaVeicoli(Session session) {

		ArrayList<PaaVeicoloDTO> lista = null;
		
		Query query = session.createQuery("from PaaVeicoloDTO where disabilitato = 0");
		
		lista =(ArrayList<PaaVeicoloDTO>) query.list();
		

		return  lista;
	}

	
	public static PaaVeicoloDTO getVeicoloFromId(int id, Session session) {
		
		ArrayList<PaaVeicoloDTO> lista = null;
		PaaVeicoloDTO result = null;
		
		Query query = session.createQuery("from PaaVeicoloDTO where id =:_id");
		query.setParameter("_id",id);
		
		lista =(ArrayList<PaaVeicoloDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}

		return  result;
	}

	public static ArrayList<PaaPrenotazioneDTO> getListaPrenotazioni(Session session) {

		ArrayList<PaaPrenotazioneDTO> lista = null;
		
		Query query = session.createQuery("from PaaPrenotazioneDTO");
		
		lista =(ArrayList<PaaPrenotazioneDTO>) query.list();
		

		return  lista;
	}

	public static ArrayList<PaaPrenotazioneDTO> getListaPrenotazioniPerUtente(UtenteDTO utente,Session session) {

		ArrayList<PaaPrenotazioneDTO> lista = null;
		
		Query query = session.createQuery("from PaaPrenotazioneDTO p WHERE p.utente.id=:_id_utente");
		
		query.setParameter("_id_utente", utente.getId());
		
		lista =(ArrayList<PaaPrenotazioneDTO>) query.list();
		

		return  lista;
	}
	

	
	public static PaaPrenotazioneDTO getPrenotazioneFromId(int id, Session session) {
		ArrayList<PaaPrenotazioneDTO> lista = null;
		PaaPrenotazioneDTO result = null;
		
		Query query = session.createQuery("from PaaPrenotazioneDTO where id =:_id");
		query.setParameter("_id",id);
		
		lista =(ArrayList<PaaPrenotazioneDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}

		return  result;
	}


	public static ArrayList<PaaRichiestaDTO> getListaRichieste(Session session) {


		ArrayList<PaaRichiestaDTO> lista = null;
		
		Query query = session.createQuery("from PaaRichiestaDTO where disabilitato = 0");		
		
		lista = (ArrayList<PaaRichiestaDTO>) query.list();
		
		return lista;
	}
	
	public static PaaRichiestaDTO getRichiestaFromID(int id, Session session) {
		ArrayList<PaaRichiestaDTO> lista = null;
		PaaRichiestaDTO result = null;
		
		Query query = session.createQuery("from PaaRichiestaDTO where id =:_id");
		query.setParameter("_id",id);
		
		lista =(ArrayList<PaaRichiestaDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}

		return  result;
	}


	public static ArrayList<PaaVeicoloDTO> getListaVeicoliDisponibili(Date data_start, Date data_end, Session session) {
		ArrayList<PaaVeicoloDTO> lista = null;
		
		  String str = "from PaaVeicoloDTO veicolo where veicolo.disabilitato = 0 and veicolo.id not in (" +
	                 "select prenotazione.veicolo.id from PaaPrenotazioneDTO prenotazione " +
	                 "where prenotazione.data_inizio_prenotazione < :data_end and prenotazione.data_fine_prenotazione > :data_start)";

	    Query query = session.createQuery(str);
	    query.setParameter("data_start", data_start);
	    query.setParameter("data_end", data_end);

	    lista = (ArrayList<PaaVeicoloDTO>) query.list();
		

		return  lista;
	}


	public static ArrayList<PaaPrenotazioneDTO> getListaPrenotazioniDate(LocalDate startDate, LocalDate endDate,	Session session) {
		
		ArrayList<PaaPrenotazioneDTO> lista = null;
		
		Query query = session.createQuery("FROM PaaPrenotazioneDTO p WHERE p.data_inizio_prenotazione BETWEEN :startDate AND :endDate");
		
		query.setParameter("startDate", java.sql.Date.valueOf(startDate));
		query.setParameter("endDate", java.sql.Date.valueOf(endDate));

		        // Esegue la query e restituisce la lista
	   lista = (ArrayList<PaaPrenotazioneDTO>) query.list();

	   return lista;
	}

}
