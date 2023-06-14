package it.portaleSTI.bo;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.mail.EmailException;
import org.hibernate.HibernateException;
import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneControlliOperativiDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CoAllegatoAttrezzaturaDTO;
import it.portaleSTI.DTO.CoAttrezzaturaDTO;
import it.portaleSTI.DTO.CoAttrezzaturaTipoControlloDTO;
import it.portaleSTI.DTO.CoControlloDTO;
import it.portaleSTI.DTO.DevRegistroAttivitaDTO;
import it.portaleSTI.DTO.DevTestoEmailDTO;

public class GestioneControlliOperativiBO {

	public static <E> ArrayList<E> getLista(E type,  Session session) {

		return GestioneControlliOperativiDAO.getLista(type, session);
	}
	

	public static <E> E getElement(E type,int id, Session session) {
		
		return GestioneControlliOperativiDAO.getElement(type,id, session);
	}
	


	public static ArrayList<CoAttrezzaturaTipoControlloDTO> getListaAttrezzaturaTipoControllo(int parseInt,Session session) {
		
		return GestioneControlliOperativiDAO.getListaAttrezzaturaTipoControllo(parseInt, session);
	}


	public static CoAttrezzaturaTipoControlloDTO getAttrezzaturaTipoControllo(int id_attrezzatura, int id_controllo, Session session) {
		
		return GestioneControlliOperativiDAO.getAttrezzaturaTipoControllo(id_attrezzatura,id_controllo, session);
	}


	public static ArrayList<CoAllegatoAttrezzaturaDTO> getListaAllegatiAttrezzatura(int id_attrezzatura, Session session) {
		// 
		return GestioneControlliOperativiDAO.getListaAllegatiAttrezzatura(id_attrezzatura, session);
	}


	public static ArrayList<CoControlloDTO> getListaControlliAttrezzatura(int id, Session session) {

		return GestioneControlliOperativiDAO.getListaControlliAttrezzatura(id, session);
	}


	public static void sendEmailControlliOperativi() throws HibernateException, ParseException, EmailException {
		
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		Date today = new Date();
		
		Calendar cal = Calendar.getInstance();
		cal.setTime(today);
		cal.add(Calendar.DATE, 10);
		Date nextDate = cal.getTime();
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		
		ArrayList<CoControlloDTO> lista_controlli = GestioneControlliOperativiDAO.getControlliScadenza(df.format(nextDate),session);
		ArrayList<CoAttrezzaturaDTO> lista_attrezzature = GestioneControlliOperativiDAO.getAttrezzatureScadenza(df.format(nextDate),session);
		
	
		df = new SimpleDateFormat("dd/MM/yyyy");
		
		String messaggio ="";
		
		if(lista_controlli.size()>0 || lista_attrezzature.size()>0)	{
			
			if(lista_controlli.size()>0) {
				messaggio += "Si comunica che i seguenti controlli operativi sono in scadenza:<br>";
				
				for (CoControlloDTO controllo : lista_controlli) {
					
					messaggio += "<br>ID controllo: "+controllo.getId()+" - Attrezzatura: ID("+controllo.getAttrezzatura().getId()+") "+controllo.getAttrezzatura().getDescrizione()+" - Scadenza "+df.format(controllo.getData_prossimo_controllo())+"<br><br>";
						
				}
			}
			if(lista_attrezzature.size()>0) {
				messaggio += "Si comunica che le seguenti attrezzature sono in scadenza:<br>";
				
				for (CoAttrezzaturaDTO attrezzatura : lista_attrezzature) {
					
					messaggio += "<br>ID Attrezzatura: "+attrezzatura.getId()+" - Codice: "+attrezzatura.getCodice()+" - Scadenza "+df.format(attrezzatura.getData_scadenza());
						
				}
			}
			
			
			
			SendEmailBO.sendEmailControlli(messaggio);
			
			
			for (CoControlloDTO controllo : lista_controlli) {
				controllo.setEmail_inviata(1);
				session.update(controllo);
			}
			
			
		}
		
		
		
		session.getTransaction().commit();
		session.close();
		
		
	}


	public static void aggiornaStatoControlli() throws HibernateException, ParseException {
		
	
		
		GestioneControlliOperativiDAO.aggiornaStatoControlli();
		
		
		
	}

}
