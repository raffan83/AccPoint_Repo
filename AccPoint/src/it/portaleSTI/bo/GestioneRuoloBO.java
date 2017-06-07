package it.portaleSTI.bo;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneRuoloDAO;

import it.portaleSTI.DTO.RuoloDTO;



public class GestioneRuoloBO {

	
	public static RuoloDTO getRuoloById(String id_str, Session session) throws Exception {


		return GestioneRuoloDAO.getRuoloById(id_str, session);
	}


}
