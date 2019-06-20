package it.portaleSTI.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.VerStrumentoDTO;

public class GestioneVerStrumentiDAO {

	public static ArrayList<VerStrumentoDTO> getListaStrumenti(Session session) {
		
		ArrayList<VerStrumentoDTO> lista = null;
		
		Query query = session.createQuery("from VerStrumentoDTO");
		
		lista = (ArrayList<VerStrumentoDTO>) query.list();
		
		return lista;
	}

}
