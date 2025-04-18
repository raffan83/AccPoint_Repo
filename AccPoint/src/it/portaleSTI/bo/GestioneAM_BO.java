package it.portaleSTI.bo;

import java.text.ParseException;
import java.util.ArrayList;

import org.hibernate.HibernateException;
import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneAM_DAO;
import it.portaleSTI.DTO.AMInterventoDTO;
import it.portaleSTI.DTO.AMOggettoProvaDTO;
import it.portaleSTI.DTO.AMOperatoreDTO;
import it.portaleSTI.DTO.AMTipoCampioneDTO;
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

	
	public static AMInterventoDTO getInterventoFromID(int id_intervento, Session session) throws HibernateException, ParseException {

		return GestioneAM_DAO.getInterventoFromID(id_intervento, session);
	}

	public static ArrayList<AMOggettoProvaDTO> getListaStrumenti(Session session) throws HibernateException, ParseException {
		
		return GestioneAM_DAO.getListaStrumenti(session);
	}

	public static AMOggettoProvaDTO getOggettoProvaFromID(int id_strumento, Session session) throws HibernateException, ParseException {
	
		return GestioneAM_DAO.getOggettoProvaFromID(id_strumento, session);
	}

	public static AMCampioneDTO getCampioneFromID(int id_campione, Session session) throws HibernateException, ParseException {
		
		return GestioneAM_DAO.getCampioneFromID(id_campione, session);
	}

	public static ArrayList<AMTipoCampioneDTO> getListaTipiCampione(Session session) {
		
		return GestioneAM_DAO.getListaTipiCampione(session);
	}

	public static AMTipoCampioneDTO getTipoCampioneFromID(int id_tipo, Session session) {
		// TODO Auto-generated method stub
		return GestioneAM_DAO.getTipoCampioneFromID(id_tipo, session);
	}

}
