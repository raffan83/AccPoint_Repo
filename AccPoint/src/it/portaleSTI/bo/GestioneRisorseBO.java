package it.portaleSTI.bo;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneRisorseDAO;
import it.portaleSTI.DTO.PRInterventoRisorsaDTO;
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

	public static ArrayList<PRInterventoRisorsaDTO> getListaInterventoRisorseAll(Session session) {
		// TODO Auto-generated method stub
		return GestioneRisorseDAO.getListaInterventoRisorseAll(session);
	}

	public static  ArrayList<PRInterventoRisorsaDTO> getListaInterventiRisorsa(int id, LocalDate data, Session session) {
		// TODO Auto-generated method stub
		return  GestioneRisorseDAO.getListaInterventiRisorsa(id, data, session);
	}

	public static ArrayList<PRInterventoRisorsaDTO> getRisorsaIntervento(int id, Date dataCreazione, Session session) {
		// TODO Auto-generated method stub
		 LocalDate localDate =	dataCreazione.toInstant()
        .atZone(ZoneId.systemDefault())
        .toLocalDate();
		return GestioneRisorseDAO.getRisorsaIntervento(id, localDate, session);
	}

	public static ArrayList<PRRisorsaDTO> getListaRisorseLibere(LocalDate date, Session session) {
		// TODO Auto-generated method stub
		return GestioneRisorseDAO.getListaRisorseLibere(date, session);
	}

	public static boolean getRisorsaAssente(int id_risorsa, Date data_inizio_assegnazione, Date data_fine_assegnazione,
			Session session) {
		// TODO Auto-generated method stub
		return GestioneRisorseDAO.getRisorsaAssente(id_risorsa, data_inizio_assegnazione, data_fine_assegnazione, session);
	}
	
	
	
	

}
