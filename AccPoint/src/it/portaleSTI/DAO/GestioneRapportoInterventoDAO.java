package it.portaleSTI.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.RapportoInterventoDTO;

public class GestioneRapportoInterventoDAO {

	public GestioneRapportoInterventoDAO() {
		// TODO Auto-generated constructor stub
	}

	public static ArrayList<RapportoInterventoDTO> getListaRapporti(Session session) {
		
		ArrayList<RapportoInterventoDTO> lista = null;
		
		Query q = session.createQuery("from RapportoInterventoDTO");
		lista = (ArrayList<RapportoInterventoDTO>) q.list();
		
		return lista;
	}

}
