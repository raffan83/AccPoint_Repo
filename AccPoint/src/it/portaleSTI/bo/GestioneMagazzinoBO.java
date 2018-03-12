package it.portaleSTI.bo;

import java.util.ArrayList;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneCommesseDAO;
import it.portaleSTI.DAO.GestioneMagazzinoDAO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.LogMagazzinoDTO;
import it.portaleSTI.DTO.MagPaccoDTO;

public class GestioneMagazzinoBO {

//	public static void save(LogMagazzinoDTO logMagazzino, Session session) throws Exception {
//		GestioneMagazzinoDAO.save(logMagazzino,session);
//		
//	}
	
	public static ArrayList<MagPaccoDTO> getListaPacchi(int id_company, Session session) throws Exception {
		
		
		return GestioneMagazzinoDAO.getPacchi(id_company, session);
	}

}
