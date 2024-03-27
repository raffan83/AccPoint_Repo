package it.portaleSTI.bo;

import java.io.File;
import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Date;
import java.util.Properties;

import org.apache.commons.fileupload.FileItem;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.lowagie.text.Utilities;
import com.sun.mail.smtp.SMTPTransport;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.GestioneUtenteDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CertificatoCampioneDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.ValoreCampioneDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;


public class GestioneUtenteBO {

	
	public static UtenteDTO getUtenteById(String id_str, Session session) throws Exception {


		return GestioneUtenteDAO.getUtenteById(id_str, session);
	}


	public static void save(UtenteDTO utente, Session session) throws Exception {
		
		GestioneUtenteDAO.save(session,utente);
	}
	
	public static int saveUtente(UtenteDTO utente, String action, Session session) throws Exception {
		int toRet=0;
		
		try{
		int idUtente=0;
		
		if(action.equals("modifica")){
			session.update(utente);
			idUtente=utente.getId();
		}
		else if(action.equals("nuovo")){
			idUtente=(Integer) session.save(utente);

		}
	
		
		toRet=0;	
			
		}catch (Exception ex)
		{
			toRet=1;
			throw ex;
		}
		return toRet;
	}


	public static UtenteDTO getUtenteByUsername(String to, Session session) {
		return GestioneUtenteDAO.getUtenteByUsername(to, session);
	}


	public static JsonObject sendEmail(String username, Session sessionH, String url) throws Exception {
		 UtenteDTO utente = GestioneUtenteBO.getUtenteByUsername(username, sessionH);
		 JsonObject myObj = new JsonObject(); 
		 if(utente != null) {
			  String to = utente.getEMail();
			  String subject = "Calver.it Password Reset";
			  	
			  SecureRandom random = new SecureRandom();
		     
			  int rand_int1 = random.nextInt(1000000000); 
			  
		      
		      String token = ""+rand_int1;
		        
		      String hmtlMex = "<h3>Salve "+utente.getNominativo()+", <br /> Per recuperare la tua password fare click sul link seguente<br /><a href='"+url+"?action=resetPass&token="+token+"'>Reset Password</a></h3><br />Se hai ricevuto per sbaglio questa mail ignora il contenuto.<br />Grazie<br /><br />Calver.it";

			  Utility.sendEmail(to,subject,hmtlMex);

			  utente.setResetToken(token);
			  sessionH.save(utente);

				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Ti &egrave; stata inviata una mail sulla tua casella di posta con la procedura di reset Password.");
		      
			 }else {
				 myObj.addProperty("success", false);
				 myObj.addProperty("messaggio", "Username inesistente");
			 }
		return myObj;
	}


	public static JsonObject sendEmailChange(String username, String passwordUser, String token, Session sessionH) throws Exception {
		 UtenteDTO utente = GestioneUtenteBO.getUtenteByUsername(username, sessionH);
		 JsonObject myObj = new JsonObject(); 
		 if(utente != null && utente.getResetToken() != null && !utente.getResetToken().equals("") && utente.getResetToken().equals(token)){
			  String to = utente.getEMail();
			  String subject = "Calver.it Conferma Reset Password";
			  String hmtlMex = "<h3>Salve "+utente.getNominativo()+", <br /> La tua password è stata cambiata con successo<br /></h3><br />Se hai ricevuto per sbaglio questa mail ignora il suo contenuto.<br />Grazie<br /><br />Calver.it";

			  Utility.sendEmail(to,subject,hmtlMex);
			  
			  utente.setResetToken(null);
			 // utente.setPassw(DirectMySqlDAO.getPassword(passwordUser));
			  DirectMySqlDAO.resPwd(utente,passwordUser);
			  sessionH.save(utente);

			  myObj.addProperty("success", true);
			  myObj.addProperty("messaggio", "Ti &egrave; stata inviata una mail di conferma");
		      
		 }else {
				myObj.addProperty("success", false);
		 		myObj.addProperty("messaggio", "Username o token errati, riprova da capo con la procedura");
		 }
		return myObj;
	}
	
	
	public static JsonObject sendEmailNuovoUtente(String username, String passw, Session sessionH) throws Exception {
		 UtenteDTO utente = GestioneUtenteBO.getUtenteByUsername(username, sessionH);
		 JsonObject myObj = new JsonObject(); 
		 if(utente != null) {
			  String to = utente.getEMail();
			  String subject = "Calver.it Nuovo Utente";
			  
		      String hmtlMex = "<h3><img src=\"https://www.calver.it/images/logo_calver_v2.png\" width=\"480px\" height=\"160px\"/></h3><br><br><br><br />Salve "+utente.getNominativo()+", <br />  	&Eacute; stato creato il suo utente per l'accesso a Calver.it <br /><br/>Utente: "+username+"<br  />Password: "+passw+"<br  /><br />Per modificare la password è sufficiente accedere al sito e andare nella sezione di modifica password . \r\n" + 
		      		"Grazie e buon lavoro.\r\n" + 
		      		"<br/><br/><br />Calver.it";
		      	      
			  Utility.sendEmail(to,subject,hmtlMex);

			  sessionH.save(utente);

				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Ti &egrave; stata inviata una mail con la procedura di reset Password su "+utente.getEMail());
		      
			 }else {
				 myObj.addProperty("success", false);
				 myObj.addProperty("messaggio", "Username inesistente");
			 }
		return myObj;
	}
	
	public static JsonObject sendEmailAmministratoreNuovoUtente(UtenteDTO utente, Session sessionH) throws Exception {
		 	JsonObject myObj = new JsonObject(); 

		 	String area_interesse = "";
		 	
		 	if(utente.getArea_interesse()!=0) {
		 		if(utente.getArea_interesse() == 1) {
		 			area_interesse = "Tarature";
		 		}else if(utente.getArea_interesse() == 2) {
		 			area_interesse = "Rilievi dimensionali";
		 		}else if(utente.getArea_interesse() == 3) {
		 			area_interesse = "Corsi di Formazione";
		 		}else if(utente.getArea_interesse() == 4) {
		 			area_interesse = "Verificazione periodica";
		 		}
		 	}
			  
			  String to2 = utente.getEMail();
			  String subject2 = "Calver.it Registrazione Utente";
			  
		      String hmtlMex2 = "<h3><img src=\"https://www.calver.it/images/logo_calver_v2.png\" width=\"480px\" height=\"160px\"/></h3><br><br><br><br />Salve "+utente.getNominativo()+", <br />  	la registrazione &egrave; andata a buon fine, verr&agrave; ricontattato da un nostro operatore non appena saranno validate le Sue credenziali.<br /><br/> \r\n" + 
		      		"Grazie e buon lavoro.\r\n" + 
		      		"<br/><br/><br />Calver.it";
		      	      
			  Utility.sendEmail(to2,subject2,hmtlMex2);
			  
			  String to = "raffaele.fantini@ncsnetwork.it,antonio.dicivita@ncsnetwork.it,luigi.laposta@stisrl.com";
			  String subject = "Calver.it Nuovo Utente";
			  
		      String hmtlMex = "<h3><img src=\"https://www.calver.it/images/logo_calver_v2.png\" width=\"480px\" height=\"160px\"/></h3><br><br><br><br />L'utente "+utente.getNominativo()+"<br /> ha chiesto la registrazione per l'accesso a Calver.it <br /><br/>Dati:<br /><br/>Utente: "+utente.getUser()+"<br  />Email: "+utente.getEMail()+"<br  />Telefono: "+utente.getTelefono()+"<br  />Company: "+utente.getDescrizioneCompany()+"<br  /> Area d'interesse: "+area_interesse+"<br /> \r\n" + 
		      		"Grazie e buon lavoro.\r\n" + 
		      		"<br/><br/><br />Calver.it";
		      	      
			  Utility.sendEmail(to,subject,hmtlMex);

			  
			  
			  sessionH.save(utente);

 				myObj.addProperty("messaggio", "Registrazione avvenuta con successo, attenda l'email di conferma da parte di un nostro operatore");
		      
			 
		return myObj;
	}
	
	
	public static ArrayList<UtenteDTO> getUtentiFromCompany(int id_company, Session session){
		return GestioneUtenteDAO.getUtentiFromCompany(id_company, session);
	}

	public static ArrayList<UtenteDTO> getAllUtenti(Session session){
		return GestioneUtenteDAO.getAllUtenti(session);
	}


	public static JsonObject sendEmailConfermaAttivazione(UtenteDTO utente, Session session) throws Exception {
	 	JsonObject myObj = new JsonObject(); 

		  
		  String to2 = utente.getEMail();
		  String subject2 = "Calver.it Attivazione Utente";
		  
	      String hmtlMex2 = "<h3><img src=\"https://www.calver.it/images/logo_calver_v2.png\" width=\"480px\" height=\"160px\"/></h3><br><br><br><br />Salve "+utente.getNominativo()+", <br />  	il Suo account &egrave; stato attivato con successo.<br /><br/>\r\n" + 
	      		"Grazie e buon lavoro.\r\n" + 
	      		"<br/><br/><br />Calver.it";
	      
	      /*Allegato*/
	    //  File file = new File(Costanti.PATH_FOLDER_CALVER+"\\Guida_Calver.pdf");
	      
		  Utility.sendEmail(to2,subject2,hmtlMex2);
		  
		  
			myObj.addProperty("success", true);

			myObj.addProperty("messaggio", "Invio email avvenuto con successo");
	      
		 
	return myObj;
}


	public static boolean checkPINFirma(int id, String pin, Session session) {
		return GestioneUtenteDAO.checkPINFIrma(id, pin, session);
	}


	public static void updateUltimoAccesso(int id) throws Exception {
	
		DirectMySqlDAO.updateUltimoAccesso(id);
		
	}


	public static String getIdFirmaDigitale(int id, Session session) {
		
		return GestioneUtenteDAO.getIdFirmaDigitale(id, session);
	}


	public static ArrayList<UtenteDTO> getDipendenti(Session session) {
		
		return GestioneUtenteDAO.getDipendenti(session);
	}

}
