package it.portaleSTI.bo;

import java.util.ArrayList;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneLivellaBollaDAO;
import it.portaleSTI.DTO.LatMisuraDTO;
import it.portaleSTI.DTO.LatPuntoLivellaDTO;

public class GestioneLivellaBollaBO {

	public static LatMisuraDTO getMisuraLivellaById(int id_misura, Session session) {
		
		return GestioneLivellaBollaDAO.getMisuraLivellaById(id_misura, session);
	}

	public static ArrayList<LatPuntoLivellaDTO> getListaPuntiLivella(int id_misura, Session session) {
		
		return GestioneLivellaBollaDAO.getListaPuntiLivella(id_misura, session);
	}

	
	
}
