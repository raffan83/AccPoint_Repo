package it.portaleSTI.bo;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestionePermessiDAO;

import it.portaleSTI.DTO.PermessoDTO;


public class GestionePermessiBO {

	
	public static PermessoDTO getPermessoById(String id_str, Session session) throws Exception {


		return GestionePermessiDAO.getPermessoById(id_str, session);
	}


}
