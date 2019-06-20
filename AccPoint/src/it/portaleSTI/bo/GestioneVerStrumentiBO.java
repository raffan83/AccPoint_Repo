package it.portaleSTI.bo;

import java.util.ArrayList;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneVerStrumentiDAO;
import it.portaleSTI.DTO.VerStrumentoDTO;

public class GestioneVerStrumentiBO {

	public static ArrayList<VerStrumentoDTO> getListaStrumenti(Session session) {
		
		return GestioneVerStrumentiDAO.getListaStrumenti(session);
	}

	
	
}
