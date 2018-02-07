package it.portaleSTI.bo;

import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Date;
import java.util.Properties;

import org.apache.commons.fileupload.FileItem;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
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


public class GestioneUtenteBO {

	
	public static UtenteDTO getUtenteById(String id_str, Session session) throws Exception {


		return GestioneUtenteDAO.getUtenteById(id_str, session);
	}


	public static void save(UtenteDTO utente, Session session) throws Exception {
		
		GestioneUtenteDAO.save(session,utente);
	}
	
	public static int saveUtente(UtenteDTO utente, String action, Session session) {
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

		      // Sender's email ID needs to be mentioned
		      String from = "system@ncsnetwork.it";

		      // Assuming you are sending email from localhost
		      String host = "smtps.aruba.it";
		      String password = "system2018";
		      String port = "465";
		      
		      // Get system properties
		      Properties properties = System.getProperties();

		      // Setup mail server
		      properties.setProperty("mail.smtp.host", host);
		      properties.setProperty("mail.smtp.port", port);
		      properties.setProperty("mail.smtp.auth", "true");
		      properties.setProperty("mail.transport.protocol", "smtps");
		      properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		      
		      // Get the default Session object.
		      javax.mail.Session session = javax.mail.Session.getDefaultInstance(properties);
			
			  MimeMessage message = new MimeMessage(session);

	         // Set From: header field of the header.
	         message.setFrom(new InternetAddress(from));

	         // Set To: header field of the header.
	         message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

	         // Set Subject: header field
	         message.setSubject("Calver.it Password Reset");

	         SecureRandom random = new SecureRandom();
		        byte bytes[] = new byte[20];
		        random.nextBytes(bytes);
		        String token = bytes.toString();
		        
		         String hmtlMex = "<h3>Salve "+utente.getNominativo()+", <br /> Per recuperare la tua password fare click sul link seguente<br /><a href='"+url+"?action=resetPass&token="+token+"&username="+username+"'>Reset Password</a></h3><br />Se hai ricevuto per sbaglio questa mail ignora il contenuto.<br />Grazie<br /><br />AccPoint";

	         
	        message.setText(hmtlMex, "utf-8", "html");

	         // Send message
	     	SMTPTransport t = (SMTPTransport)session.getTransport("smtps");
  		    
	        try {
  			    t.connect(host, from, password);

  			t.sendMessage(message, message.getAllRecipients());
  		    } finally {

      			t.close();  
  		    }

	       
	        
	        utente.setResetToken(token);
	        sessionH.save(utente);
	        
	        
	        
	        		

				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Ti &egrave; stata inviata una mail con la procedura di reset Password su "+utente.getEMail());
		      
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

		      // Sender's email ID needs to be mentioned
		      String from = "system@ncsnetwork.it";

		      // Assuming you are sending email from localhost
		      String host = "smtps.aruba.it";
		      String password = "system2018";
		      String port = "465";
		      
		      // Get system properties
		      Properties properties = System.getProperties();

		      // Setup mail server
		      properties.setProperty("mail.smtp.host", host);
		      properties.setProperty("mail.smtp.port", port);
		      properties.setProperty("mail.smtp.auth", "true");
		      properties.setProperty("mail.transport.protocol", "smtps");
		      properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		      
		      // Get the default Session object.
		      javax.mail.Session session = javax.mail.Session.getDefaultInstance(properties);
			
			  MimeMessage message = new MimeMessage(session);

	         // Set From: header field of the header.
	         message.setFrom(new InternetAddress(from));

	         // Set To: header field of the header.
	         message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

	         // Set Subject: header field
	         message.setSubject("Calver.it Conferma Reset Password");

	  
		        
		    String hmtlMex = "<h3>Salve "+utente.getNominativo()+", <br /> La tua password è stata cambiata con successo<br /></h3><br />Se hai ricevuto per sbaglio questa mail ignora il suo contenuto.<br />Grazie<br /><br />AccPoint";

	         
	        message.setText(hmtlMex, "utf-8", "html");

	         // Send message
	     	SMTPTransport t = (SMTPTransport)session.getTransport("smtps");
 		    
	        try {
 			    t.connect(host, from, password);

 			t.sendMessage(message, message.getAllRecipients());
 		    } finally {

     			t.close();  
 		    }

	       
	        
	        utente.setResetToken(null);
	        utente.setPassw(DirectMySqlDAO.getPassword(passwordUser));
	        sessionH.save(utente);
	        
	        
	        
	        		

				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Ti &egrave; stata inviata una mail di conferma su "+utente.getEMail());
		      
			 }else {
				 myObj.addProperty("success", false);
				 myObj.addProperty("messaggio", "Username o token errati, riprova da capo con la procedura");
			 }
		return myObj;
	}


}
