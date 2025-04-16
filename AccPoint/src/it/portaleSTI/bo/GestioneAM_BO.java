package it.portaleSTI.bo;

import java.text.ParseException;
import java.util.ArrayList;

import org.hibernate.HibernateException;
import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneAM_DAO;
import it.portaleSTI.DTO.AMInterventoDTO;
import it.portaleSTI.DTO.AMOperatoreDTO;
import it.portaleSTI.DTO.AMCampioneDTO;
import it.portaleSTI.DTO.UtenteDTO;

public class GestioneAM_BO {

	public static ArrayList<AMInterventoDTO> getListaInterventi(UtenteDTO utente, String dateFrom, String dateTo,Session session) throws HibernateException, ParseException {
	
		return GestioneAM_DAO.getListaInterventi(utente, dateFrom, dateTo,session);
	}

	public static ArrayList<AMOperatoreDTO> getListaOperatoriAll(Session session) throws HibernateException, ParseException {
		
		return GestioneAM_DAO.getListaOperatoriAll(session);
		
		
	}

	public static ArrayList<AMCampioneDTO> getListaCampioni(Session session) throws HibernateException, ParseException {
		
		return GestioneAM_DAO.getListaCampioni(session);
	}

}
