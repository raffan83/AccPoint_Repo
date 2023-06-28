package it.portaleSTI.bo;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import org.hibernate.Session;

import groovy.ui.SystemOutputInterceptor;
import it.portaleSTI.DAO.GestioneAssegnazioneAttivitaDAO;
import it.portaleSTI.DTO.AgendaMilestoneDTO;
import it.portaleSTI.DTO.MilestoneOperatoreDTO;

public class GestioneAssegnazioneAttivitaBO {

	public static ArrayList<MilestoneOperatoreDTO> getListaMilestoneOperatore(Session session) {
		
		return GestioneAssegnazioneAttivitaDAO.getListaMilestoneOperatore(session);
	}

	public static ArrayList<String> getListaCommesse(int id_utente, Session session) {
		
		return GestioneAssegnazioneAttivitaDAO.getListaCommesse(id_utente, session);
	}

	public static ArrayList<MilestoneOperatoreDTO> getListaMilestoneFiltrata(String id_utente, String commessa, String dateFrom, String dateTo, Session session) throws Exception, Exception {
		
		return GestioneAssegnazioneAttivitaDAO.getListaMilestoneFiltrata(id_utente, commessa, dateFrom, dateTo, session);
	}

	public static MilestoneOperatoreDTO getMilestone(int id_assegnazione, Session session) {
		// 
		return GestioneAssegnazioneAttivitaDAO.getMilestone(id_assegnazione,session);
	}

	public static void inserisciAppuntamento(AgendaMilestoneDTO agenda) throws Exception 
	{
		GestioneAssegnazioneAttivitaDAO.inserisciAgenda(agenda);
	}
	
	public static void main(String[] args) {
		
		AgendaMilestoneDTO agenda = new AgendaMilestoneDTO();
		
		agenda.setUSERNAME("raffan");
		agenda.setSTATO(1);
		agenda.setSOGGETTO("Soggetto");
		agenda.setDESCRIZIONE("Descrizione");
		agenda.setLABEL(3);
		Calendar calendar = Calendar.getInstance();
		calendar.set(2023, Calendar.JUNE, 28, 8, 0, 0);
		agenda.setSTARTDATE(calendar.getTime());
		calendar.set(2023, Calendar.JUNE, 28, 13, 0, 0);
		agenda.setENDTDATE(calendar.getTime());
		agenda.setID_ANAGEN(7011); //N.C.S
		agenda.setID_COMMESSA("NCS_NAI_0001/17");
		
		try {
			inserisciAppuntamento(agenda);
			System.out.println("Finish");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
