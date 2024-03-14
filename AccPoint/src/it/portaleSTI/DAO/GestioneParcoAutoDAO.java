package it.portaleSTI.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.PaaPrenotazioneDTO;
import it.portaleSTI.DTO.PaaVeicoloDTO;

public class GestioneParcoAutoDAO {



	public static ArrayList<PaaVeicoloDTO> getListaVeicoli(Session session) {

		ArrayList<PaaVeicoloDTO> lista = null;
		
		Query query = session.createQuery("from PaaVeicoloDTO");
		
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

}
