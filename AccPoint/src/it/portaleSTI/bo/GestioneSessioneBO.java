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

import org.apache.log4j.Logger;
import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.GestioneFormazioneDAO;
import it.portaleSTI.DAO.GestioneSessioneDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ForPiaPianificazioneDTO;
import it.portaleSTI.DTO.SessioneDTO;
import it.portaleSTI.DTO.UtenteDTO;


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
	
	public static SessioneDTO getSessioneByIdInterventoAndAbilitato(int id, int abilitato) {
		Session session=SessionFacotryDAO.get().openSession();
		
		
		session.beginTransaction();
		Query query  = session.createQuery( "from SessioneDTO WHERE id_intervento= :_id AND abilitato= :_abilitato");
		
		query.setParameter("_id", id);
		query.setParameter("_abilitato", abilitato);
				
		List<SessioneDTO> result =query.list();
		int idS=1;
		if(result.size()>0)
		{			
			int maxId = idS;
			int i=0;
			int iMax=0;
			for(SessioneDTO s: result) {
				if(s.getId()>maxId) {
					maxId= s.getId();
					iMax=i;
				}
				i++;
			}
			return result.get(iMax);
		}
		
		session.getTransaction().commit();
		session.close();
		
		return null;
	}
	
	public static ArrayList<SessioneDTO> getListaSessioniScadute(Date today){
		 ArrayList<SessioneDTO> sessione = GestioneSessioneDAO.getListaSessioniScadute(today);
		 return sessione;
	}
	
	
	public static void updateAbilitato(SessioneDTO sessione, UtenteDTO utente, Session session,String noteDisab) {
		GestioneSessioneDAO.updateAbilitato(sessione,utente,session,noteDisab);
	}
	
	public static ArrayList<SessioneDTO> getSessioni(int year) throws Exception{

		List<SessioneDTO> listaSessioni= new ArrayList<>();
		listaSessioni= DirectMySqlDAO.getAllSessioni(year);
		
		return (ArrayList) listaSessioni;
	}
	


	
	public static void sendEmailClienteDocumentalWeb(File d, String mailTo,ServletContext ctx, SessioneDTO sessione  ) throws Exception {
	

		
		try {
	
		
		LocalDate today = LocalDate.now();
		DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
	
		String messaggio = "Si comunica che ....";
	//	String messaggio = "Si comunica che dalla pianificazione corsi emerge che per la commessa "+p.getId_commessa()+" &egrave; presente un item nello stato \"FATTURATO SENZA ATTESTATI\" in data "+df.format(p.getData())+".";
	SendEmailBO.sendEmailClienteDocumentalWeb(d,  mailTo, ctx, sessione);
					
		
	}catch(Exception e) {
		e.printStackTrace();
		throw new RuntimeException("Errore invio email: " + e.getMessage(), e);
	}
		
	}


}
