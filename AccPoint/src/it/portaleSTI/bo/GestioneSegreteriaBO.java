package it.portaleSTI.bo;

import java.util.ArrayList;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneSegreteriaDAO;
import it.portaleSTI.DTO.SegreteriaDTO;

public class GestioneSegreteriaBO {

	public static ArrayList<SegreteriaDTO> getListaSegreteria(Session session) {
		
		return GestioneSegreteriaDAO.getListaSegreteria(session);
	}

	public static SegreteriaDTO getItemSegreteriaFromId(int id, Session session) {
		
		return GestioneSegreteriaDAO.getItemSegreteriaFromId(id, session);
	}

}
