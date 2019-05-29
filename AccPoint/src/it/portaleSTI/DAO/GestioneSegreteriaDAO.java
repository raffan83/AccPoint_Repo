package it.portaleSTI.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.SegreteriaDTO;

public class GestioneSegreteriaDAO {

	public static ArrayList<SegreteriaDTO> getListaSegreteria(Session session) {
		
		ArrayList<SegreteriaDTO> lista = null;
		
		Query query = session.createQuery("from SegreteriaDTO");
		
		lista = (ArrayList<SegreteriaDTO>) query.list();
		
		return lista;
	}

	public static SegreteriaDTO getItemSegreteriaFromId(int id, Session session) {
		
		ArrayList<SegreteriaDTO> lista = null;
		SegreteriaDTO result = null;
		Query query = session.createQuery("from SegreteriaDTO where id =:_id");
		query.setParameter("_id", id);
		
		lista = (ArrayList<SegreteriaDTO>) query.list();
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

}
