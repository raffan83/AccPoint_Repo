package it.portaleSTI.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.GPDTO;

public class GestioneGreenPassDAO {

	public static ArrayList<GPDTO> getListaGreenPass(Session session) {
		
		ArrayList<GPDTO> lista = null;
		
		Query query = session.createQuery("from GPDTO");
		
		lista = (ArrayList<GPDTO>) query.list();
		
		
		
		return lista;
	}

}
