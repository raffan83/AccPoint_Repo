package it.portaleSTI.bo;

import java.util.ArrayList;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneCompanyDAO;

import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.RuoloDTO;


public class GestioneCompanyBO {

	
	public static CompanyDTO getCompanyById(String id_str, Session session) throws Exception {


		return GestioneCompanyDAO.getCompanyById(id_str, session);
	}

	public static int saveCompany(CompanyDTO company, String action, Session session) {
		int toRet=0;
		
		try{
		int idCompany=0;
		
		if(action.equals("modifica")){
			session.update(company);
			idCompany=company.getId();
		}
		else if(action.equals("nuovo")){
			idCompany=(Integer) session.save(company);

		}
		
		toRet=0;	
			
		}catch (Exception ex)
		{
			toRet=1;
			throw ex;
	 		
	 		
		}
		return toRet;
		
	}

	public static ArrayList<CompanyDTO> getAllCompany(Session session) {
		// TODO Auto-generated method stub
		return GestioneCompanyDAO.getAllCompany(session);
	}
}
