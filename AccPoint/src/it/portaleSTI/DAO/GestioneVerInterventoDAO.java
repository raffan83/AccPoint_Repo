package it.portaleSTI.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerInterventoDTO;
import it.portaleSTI.DTO.VerMisuraDTO;

public class GestioneVerInterventoDAO {

	public static ArrayList<VerInterventoDTO> getListaVerInterventi(UtenteDTO utente, Session session) {
		
		ArrayList<VerInterventoDTO> lista = null;
		Query query = null;
		if(utente.isTras()) {
						
			query = session.createQuery("from VerInterventoDTO");
			
		}else {
			
			query = session.createQuery("from VerInterventoDTO where id_company = :_id_company");
			query.setParameter("_id_company", utente.getCompany().getId());
		}		
		
		lista = (ArrayList<VerInterventoDTO>) query.list();
		
		return lista;
	}

	public static VerInterventoDTO getInterventoFromId(int id_intervento, Session session) {
		
		ArrayList<VerInterventoDTO> lista = null;
		VerInterventoDTO result = null;
		
		Query query = session.createQuery("from VerInterventoDTO where id = :_id");
		query.setParameter("_id", id_intervento);
		
		lista = (ArrayList<VerInterventoDTO>) query.list();
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static ArrayList<VerMisuraDTO> getListaMisureFromIntervento(int id_intervento, Session session) {
		
		ArrayList<VerMisuraDTO> lista = null;
			
		Query query = session.createQuery("from VerMisuraDTO where verIntervento.id = :_id_intervento");
		query.setParameter("_id_intervento", id_intervento);
		
		lista = (ArrayList<VerMisuraDTO>) query.list();
		
		return lista;
	}

}
