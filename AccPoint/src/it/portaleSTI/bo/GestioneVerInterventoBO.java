package it.portaleSTI.bo;

import java.util.ArrayList;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneVerInterventoDAO;
import it.portaleSTI.DTO.VerInterventoDTO;
import it.portaleSTI.DTO.VerMisuraDTO;

public class GestioneVerInterventoBO {

	public static ArrayList<VerInterventoDTO> getListaVerInterventi(Session session) {
		
		return GestioneVerInterventoDAO.getListaVerInterventi(session);
	}

	public static VerInterventoDTO getInterventoFromId(int id_intervento, Session session) {
		
		return GestioneVerInterventoDAO.getInterventoFromId(id_intervento, session);
	}

	public static ArrayList<VerMisuraDTO> getListaMisureFromIntervento(int id_intervento, Session session) {
		
		return GestioneVerInterventoDAO.getListaMisureFromIntervento(id_intervento, session);
	}

	
}
