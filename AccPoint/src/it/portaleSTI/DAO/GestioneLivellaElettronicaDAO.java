package it.portaleSTI.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.LatPuntoLivellaDTO;
import it.portaleSTI.DTO.LatPuntoLivellaElettronicaDTO;

public class GestioneLivellaElettronicaDAO {

	public static ArrayList<LatPuntoLivellaElettronicaDTO> getListaPuntiLivella(int id_misura, Session session) {
		
		ArrayList<LatPuntoLivellaElettronicaDTO> lista = null;
		
		Query query = session.createQuery("from LatPuntoLivellaElettronicaDTO where id_misura = :_id_misura and tipo_prova = 'L'");
		query.setParameter("_id_misura", id_misura);
		
		lista = (ArrayList<LatPuntoLivellaElettronicaDTO>)query.list();
	
		return lista;
	}

}
