package it.portaleSTI.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.VerInterventoDTO;

public class GestioneVerInterventoDAO {

	public static ArrayList<VerInterventoDTO> getListaVerInterventi(Session session) {
		
		ArrayList<VerInterventoDTO> lista = null;
		
		Query query = session.createQuery("from VerInterventoDTO");
		
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

}
