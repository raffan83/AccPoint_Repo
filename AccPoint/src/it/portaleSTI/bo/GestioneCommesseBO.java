package it.portaleSTI.bo;

import it.portaleSTI.DAO.GestioneCommesseDAO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;

import java.util.ArrayList;

public class GestioneCommesseBO {

	public static ArrayList<CommessaDTO> getListaCommesse(CompanyDTO company, String categoria) throws Exception {
		
		
		return GestioneCommesseDAO.getListaCommesse(company,categoria);
	}
	
	public static CommessaDTO getCommessaById(String idCommessa) throws Exception {
		
		
		return GestioneCommesseDAO.getCommessaById(idCommessa);
	}


}
