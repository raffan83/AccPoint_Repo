package it.portaleSTI.bo;

import it.portaleSTI.DAO.GestioneCommesseDAO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.NoteSicurezzaCommessaDTO;
import it.portaleSTI.DTO.UtenteDTO;

import java.util.ArrayList;

import org.hibernate.Session;

public class GestioneCommesseBO {

	public static ArrayList<CommessaDTO> getListaCommesse(CompanyDTO company, String categoria, UtenteDTO user, int year, boolean soloAperte) throws Exception {
		
		
		return GestioneCommesseDAO.getListaCommesse(company,categoria,user,year, soloAperte);
	}
	
	public static CommessaDTO getCommessaById(String idCommessa) throws Exception {
		
		
		return GestioneCommesseDAO.getCommessaById(idCommessa);
	}

	public static NoteSicurezzaCommessaDTO getNotaSicurezzaCommessa(String commessa, Session session) {
		
		return GestioneCommesseDAO.getNotaSicurezzaCommessa(commessa, session);
	}


}
