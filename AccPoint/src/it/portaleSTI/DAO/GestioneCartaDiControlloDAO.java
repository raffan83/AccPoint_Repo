package it.portaleSTI.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.CartaDiControlloDTO;

public class GestioneCartaDiControlloDAO {

	public static CartaDiControlloDTO getCartaDiControlloFromCampione(String id_campione, Session session) {
		
		ArrayList<CartaDiControlloDTO> lista = null;
		CartaDiControlloDTO result = null;
		
		Query query = session.createQuery("from CartaDiControlloDTO where campione.id = :_id_campione order by id desc");
		query.setParameter("_id_campione", Integer.parseInt(id_campione));
		
		lista = (ArrayList<CartaDiControlloDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static CartaDiControlloDTO getCartaDiControlloFromId(int id_carta, Session session) {
		
		ArrayList<CartaDiControlloDTO> lista = null;
		CartaDiControlloDTO result = null;
		
		Query query = session.createQuery("from CartaDiControlloDTO where id = :_id_carta");
		query.setParameter("_id_carta", id_carta);
		
		lista = (ArrayList<CartaDiControlloDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

}
