package it.portaleSTI.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.VerStrumentoDTO;
import it.portaleSTI.DTO.VerTipoStrumentoDTO;

public class GestioneVerStrumentiDAO {

	public static ArrayList<VerStrumentoDTO> getListaStrumenti(Session session) {
		
		ArrayList<VerStrumentoDTO> lista = null;
		
		Query query = session.createQuery("from VerStrumentoDTO");
		
		lista = (ArrayList<VerStrumentoDTO>) query.list();
		
		return lista;
	}

	public static ArrayList<VerTipoStrumentoDTO> getListaTipoStrumento(Session session) {
		
		ArrayList<VerTipoStrumentoDTO> lista = null;
		
		Query query = session.createQuery("from VerTipoStrumentoDTO");
		
		lista = (ArrayList<VerTipoStrumentoDTO>) query.list();
		
		return lista;
	}

}
