package it.portaleSTI.bo;

import java.util.ArrayList;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneRisorseDAO;
import it.portaleSTI.DTO.PRRequisitoDocumentaleDTO;
import it.portaleSTI.DTO.PRRequisitoRisorsaDTO;
import it.portaleSTI.DTO.PRRequisitoSanitarioDTO;
import it.portaleSTI.DTO.PRRisorsaDTO;

public class GestioneRisorseBO {

	public GestioneRisorseBO() {
		// TODO Auto-generated constructor stub
	}

	public static ArrayList<PRRisorsaDTO> getListaRisorse(Session session) {
		
		return GestioneRisorseDAO.getListaRisorse(session);
	}

	public static ArrayList<PRRequisitoDocumentaleDTO> getListaRequisitiDocumentali(Session session) {
		// TODO Auto-generated method stub
		return GestioneRisorseDAO.getListaRequisitiDocumentali(session);
	}

	public static ArrayList<PRRequisitoSanitarioDTO> getListaRequisitiSanitari(Session session) {
		// TODO Auto-generated method stub
		return GestioneRisorseDAO.getListaRequisitiSanitari(session);
	}

	public static ArrayList<PRRequisitoRisorsaDTO> getListaRequisitiRisorsa(int id, Session session) {
		// TODO Auto-generated method stub
		return GestioneRisorseDAO.getListaRequisitiRisorsa(id, session);
	}
	
	
	
	

}
