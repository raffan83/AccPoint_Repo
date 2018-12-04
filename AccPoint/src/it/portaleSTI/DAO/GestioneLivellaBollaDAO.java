package it.portaleSTI.DAO;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.LatMisuraDTO;
import it.portaleSTI.DTO.LatPuntoLivellaDTO;
import it.portaleSTI.DTO.MagSaveStatoDTO;

public class GestioneLivellaBollaDAO {

	public static LatMisuraDTO getMisuraLivellaById(int id_misura, Session session) {

		LatMisuraDTO misura = null;
		
		Query query = session.createQuery("from LatMisuraDTO where id = :_id_misura");
		query.setParameter("_id_misura", id_misura);
		
		List<LatMisuraDTO> result = (List<LatMisuraDTO>)query.list();
		if(result.size()>0)
		{			
			return result.get(0);
		}

		return null;
	}

	public static ArrayList<LatPuntoLivellaDTO> getListaPuntiLivella(int id_misura, Session session) {
		
		ArrayList<LatPuntoLivellaDTO> lista = null;
		
		Query query = session.createQuery("from LatPuntoLivellaDTO where id_misura = :_id_misura");
		query.setParameter("_id_misura", id_misura);
		
		lista = (ArrayList<LatPuntoLivellaDTO>)query.list();
	
		return lista;
	}

}
