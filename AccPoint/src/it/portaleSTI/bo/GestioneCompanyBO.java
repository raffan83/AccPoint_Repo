package it.portaleSTI.bo;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneCompanyDAO;

import it.portaleSTI.DTO.CompanyDTO;


public class GestioneCompanyBO {

	
	public static CompanyDTO getCompanyById(String id_str, Session session) throws Exception {


		return GestioneCompanyDAO.getCompanyById(id_str, session);
	}


}
