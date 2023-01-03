package it.portaleSTI.bo;

import java.util.ArrayList;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneVersionePortaleDAO;
import it.portaleSTI.DTO.VersionePortaleDTO;



public class GestioneVersionePortaleBO {

	public static ArrayList<VersionePortaleDTO> getListaVersioniPortale(Session session) {

		return GestioneVersionePortaleDAO.getListaVersioniPortale(session);
	}

	public static VersionePortaleDTO getVersioneFromId(int id_versione, Session session) {
		
		return GestioneVersionePortaleDAO.getVersioneFromId(id_versione, session);
	}

	public static String getVersioneCorrente(Session session) {
		// TODO Auto-generated method stub
		return GestioneVersionePortaleDAO.getVersioneCorrente(session);
	}

}
