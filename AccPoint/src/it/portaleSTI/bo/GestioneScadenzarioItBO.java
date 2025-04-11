package it.portaleSTI.bo;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneControlliOperativiDAO;
import it.portaleSTI.DAO.GestioneDeviceDAO;
import it.portaleSTI.DAO.GestioneScadenzarioItDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.DevSoftwareDTO;
import it.portaleSTI.DTO.ItServizioItDTO;
import it.portaleSTI.DTO.ItTipoRinnovoDTO;
import it.portaleSTI.DTO.ItTipoServizioDTO;
import it.portaleSTI.Util.Utility;

public class GestioneScadenzarioItBO {

	public static ArrayList<ItServizioItDTO> lista_servizi_errori;

	public static ArrayList<ItServizioItDTO> getListaServizi(Session session) {
		// 
		return GestioneScadenzarioItDAO.getListaServizi(session);
	}

	public static ArrayList<ItTipoRinnovoDTO> getListaTipiRinnovo(Session session) {
		// 
		return GestioneScadenzarioItDAO.getListaTipiRinnovo(session);
	}

	public static ArrayList<ItTipoServizioDTO> getListaTipiServizi(Session session) {
		// 
		return GestioneScadenzarioItDAO.getListaTipiServizi(session);
	}

	public static <E> E getElement(E type,int id, Session session) {
		
		return GestioneScadenzarioItDAO.getElement(type,id, session);
	}

	public static void updateStatoServizi() {
		
		GestioneScadenzarioItDAO.updateStatoServizi();
		
	}

	public static void sendEmailRemindServizi() throws Exception {
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		Date today = new Date();
		
	
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		
		
		ArrayList<ItServizioItDTO> lista_remind = GestioneScadenzarioItDAO.getListaremindServizi(df.format(today),session);
		
		lista_servizi_errori = new ArrayList<ItServizioItDTO> ();
		
		for (ItServizioItDTO servizio : lista_remind) {
			
			try {
				
			

				SendEmailBO.sendEmailRemindServizi(servizio);	
				
				
				Calendar cal = Calendar.getInstance();
				cal.setTime(today);
				
				if(servizio.getStato()==2) {
					
					cal.add(Calendar.DAY_OF_YEAR, 1);
					servizio.setData_remind(cal.getTime());
				}else {
					
					cal.setTime(servizio.getData_scadenza());
					cal.add(Calendar.DATE, -15);	
					if(cal.getTime().before(today)) {
						servizio.setData_remind(servizio.getData_scadenza());
					}else {
						servizio.setData_remind(cal.getTime());
					}
					
					
				}
				
				
				session.update(servizio);
				
			}catch (Exception e) {
				e.printStackTrace();
				lista_servizi_errori.add(servizio);
			}
		}
		session.getTransaction().commit();
		session.close();
		
		if(lista_servizi_errori.size()>0) {
			
		
				String messaggio = "Non è stato possibile recapitare il remind di scadenza per i seguenti Software:<br><br>";
				for (ItServizioItDTO servizio : lista_servizi_errori) {
					messaggio+= "ID: "+servizio.getId()+" Descrizione: "+servizio.getDescrizione()+"<br>";	
				}
				
			
					Utility.sendEmail("antonio.dicivita@ncsnetwork.it","Errore invio Remind Servizio IT",messaggio);
			
		}
		
		
	}

}
