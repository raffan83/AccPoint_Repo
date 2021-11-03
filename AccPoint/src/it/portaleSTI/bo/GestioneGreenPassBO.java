package it.portaleSTI.bo;

import java.util.ArrayList;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneGreenPassDAO;
import it.portaleSTI.DTO.GPDTO;

public class GestioneGreenPassBO {

	public static ArrayList<GPDTO> getListaGreenPass(Session session) {
		
		return GestioneGreenPassDAO.getListaGreenPass(session);
	}

}
