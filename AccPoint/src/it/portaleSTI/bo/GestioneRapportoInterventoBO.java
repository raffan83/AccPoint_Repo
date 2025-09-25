package it.portaleSTI.bo;

import java.util.ArrayList;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneRapportoInterventoDAO;
import it.portaleSTI.DTO.RapportoInterventoDTO;

public class GestioneRapportoInterventoBO {

	public GestioneRapportoInterventoBO() {
		// TODO Auto-generated constructor stub
	}

	public static ArrayList<RapportoInterventoDTO> getListaRapporti(Session session) {
		
		return GestioneRapportoInterventoDAO.getListaRapporti(session);
	}
	
	

}
