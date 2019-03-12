package it.portaleSTI.bo;

import java.util.ArrayList;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneLivellaElettronicaDAO;
import it.portaleSTI.DTO.LatPuntoLivellaElettronicaDTO;

public class GestioneLivellaElettronicaBO {

	public static ArrayList<LatPuntoLivellaElettronicaDTO> getListaPuntiLivella(int id_misura, Session session) {
		
		return GestioneLivellaElettronicaDAO.getListaPuntiLivella(id_misura, session);
	}
	
	

}
