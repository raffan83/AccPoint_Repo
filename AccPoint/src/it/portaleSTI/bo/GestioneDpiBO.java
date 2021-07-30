package it.portaleSTI.bo;

import java.util.ArrayList;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneDpiDAO;
import it.portaleSTI.DTO.ConsegnaDpiDTO;
import it.portaleSTI.DTO.TipoDpiDTO;

public class GestioneDpiBO {

	public static ArrayList<TipoDpiDTO> getListaTipoDPI(Session session) {
		
		return GestioneDpiDAO.getListaTipoDPI(session);
	}

	public static ArrayList<ConsegnaDpiDTO> getListaConsegneDpi(Session session) {
		
		return GestioneDpiDAO.getListaConsegneDpi(session);
	}

	public static ConsegnaDpiDTO getCosegnaFromID(int id_consegna, Session session) {
		
		return GestioneDpiDAO.getCosegnaFromID(id_consegna, session);
	}

	public static TipoDpiDTO getTipoDPIFromId(int id_tipo, Session session) {
		
		return GestioneDpiDAO.getTipoDPIFromId(id_tipo,session);
	}

}
