package it.portaleSTI.bo;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;

import java.io.File;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneFormazioneDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ForPiaPianificazioneDTO;
import it.portaleSTI.DTO.SessioneDTO;


public class GestioneSessioneBO {

	public static SessioneDTO getSessioneByIdIntervento(int id) {
		Session session=SessionFacotryDAO.get().openSession();
		
		
		session.beginTransaction();
		Query query  = session.createQuery( "from SessioneDTO WHERE id_intervento= :_id");
		
		query.setParameter("_id", id);
				
		List<SessioneDTO> result =query.list();
		if(result.size()>0)
		{			
			return result.get(0);
		}
		
		session.getTransaction().commit();
		session.close();
		
		return null;
	}
	
	
	
	
	public static void sendEmailClienteDocumentalWeb(File d, String mailTo,ServletContext ctx, SessioneDTO sessione ) throws Exception {
		
		try {
	
		
		LocalDate today = LocalDate.now();
		DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
	
		String messaggio = "Si comunica che ....";
	//	String messaggio = "Si comunica che dalla pianificazione corsi emerge che per la commessa "+p.getId_commessa()+" &egrave; presente un item nello stato \"FATTURATO SENZA ATTESTATI\" in data "+df.format(p.getData())+".";
		SendEmailBO.sendEmailClienteDocumentalWeb(d,  mailTo, ctx, sessione);
					
					
			
	
		
	}catch(Exception e) {
		e.printStackTrace();
	}
		
	}


}
