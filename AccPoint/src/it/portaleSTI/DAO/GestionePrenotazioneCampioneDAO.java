package it.portaleSTI.DAO;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CampionePrenotazioneDTO;
import it.portaleSTI.DTO.UtenteDTO;

public class GestionePrenotazioneCampioneDAO {


	public static ArrayList<CampionePrenotazioneDTO> getListaPrenotazioni(Session session) {

		ArrayList<CampionePrenotazioneDTO> lista = null;
		
		Query query = session.createQuery("from CampionePrenotazioneDTO");
		
		lista =(ArrayList<CampionePrenotazioneDTO>) query.list();
		

		return  lista;
	}

	public static ArrayList<CampionePrenotazioneDTO> getListaPrenotazioniPerUtente(UtenteDTO utente,Session session) {

		ArrayList<CampionePrenotazioneDTO> lista = null;
		
		Query query = session.createQuery("from CampionePrenotazioneDTO p WHERE p.utente.id=:_id_utente");
		
		query.setParameter("_id_utente", utente.getId());
		
		lista =(ArrayList<CampionePrenotazioneDTO>) query.list();
		

		return  lista;
	}
	

	
	public static CampionePrenotazioneDTO getPrenotazioneFromId(int id, Session session) {
		ArrayList<CampionePrenotazioneDTO> lista = null;
		CampionePrenotazioneDTO result = null;
		
		Query query = session.createQuery("from CampionePrenotazioneDTO where id =:_id");
		query.setParameter("_id",id);
		
		lista =(ArrayList<CampionePrenotazioneDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}

		return  result;
	}

	public static ArrayList<CampionePrenotazioneDTO> getListaPrenotazioniDate(LocalDate startDate, LocalDate endDate,	Session session) {
		
		ArrayList<CampionePrenotazioneDTO> lista = null;
		
		Query query = session.createQuery("FROM CampionePrenotazioneDTO p WHERE (p.data_inizio_prenotazione BETWEEN :startDate AND :endDate or p.data_fine_prenotazione BETWEEN :startDate AND :endDate) AND abilitato=0");
		
		query.setParameter("startDate", java.sql.Date.valueOf(startDate));
		query.setParameter("endDate", java.sql.Date.valueOf(endDate));

		        // Esegue la query e restituisce la lista
	   lista = (ArrayList<CampionePrenotazioneDTO>) query.list();

	   return lista;
	}

	
	public static ArrayList<CampioneDTO> getListaCampioniDisponibiliDate(
	        LocalDateTime startDateTime,
	        LocalDateTime endDateTime,
	        Session session) {

		ArrayList<CampioneDTO> lista = null;
	    String hql =
	        "select c " +
	        "from CampioneDTO c " +
	        "where not exists ( " +
	        "   select 1 " +
	        "   from CampionePrenotazioneDTO p " +
	        "   join p.listaCampioni pc " +
	        "   where pc.id = c.id " +
	        "     and p.data_inizio_prenotazione <= :dataFine " +
	        "     and p.data_fine_prenotazione  >= :dataInizio " +
	        ") " +
	        "order by c.codice";

	    Query query = session.createQuery(hql);

	    query.setTimestamp("dataInizio", Timestamp.valueOf(startDateTime));
	    query.setTimestamp("dataFine",   Timestamp.valueOf(endDateTime));

	    lista = (ArrayList<CampioneDTO>) query.list();

		   return lista;
	    
	}
}
