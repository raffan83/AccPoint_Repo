package it.portaleSTI.bo;



import java.io.File;
import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.Set;
import java.util.TimeZone;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.util.ByteArrayDataSource;
import javax.servlet.ServletContext;

import org.apache.commons.mail.EmailAttachment;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.apache.log4j.Logger;

import it.portaleSTI.DAO.GestioneFormazioneDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.ConsegnaDpiDTO;
import it.portaleSTI.DTO.DevContrattoDTO;
import it.portaleSTI.DTO.DevRegistroAttivitaDTO;
import it.portaleSTI.DTO.DevSoftwareDTO;
import it.portaleSTI.DTO.DocumTLDocumentoDTO;
import it.portaleSTI.DTO.DpiDTO;
import it.portaleSTI.DTO.ForConfInvioEmailDTO;
import it.portaleSTI.DTO.ForCorsoDTO;
import it.portaleSTI.DTO.ForDocenteDTO;
import it.portaleSTI.DTO.ForMembriGruppoDTO;
import it.portaleSTI.DTO.ForPartecipanteRuoloCorsoDTO;
import it.portaleSTI.DTO.ForPiaPianificazioneDTO;
import it.portaleSTI.DTO.ForReferenteDTO;
import it.portaleSTI.DTO.GPDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.ItServizioItDTO;
import it.portaleSTI.DTO.RapportoInterventoDTO;
import it.portaleSTI.DTO.RilInterventoDTO;
import it.portaleSTI.DTO.RilMisuraRilievoDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.VerCertificatoDTO;
import it.portaleSTI.DTO.VerMisuraDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.action.ContextListener;


public class SendEmailBO {
	
	
	private final static String FIRMA_CALCE_CRESCO="<br><em><b>Segreteria didattica<br>CRESCO Formazione e Consulenza Srl</b></em> <br>" +
											"<em></b><br>Via Tofaro 42, E - 03039 Sora (FR)<br>" + 
											"Tel +39 0776.18151 - Int (104) oppure (115)</em> <br>" + 
											"Web: </em>www.crescosrl.net<br>" + 
											"Mail: </em>segreteria@crescosrl.net<br><br>" + 
											"<br /><img width='250' src='https://www.calver.it/images/cresco_dnv.png'><br>" + 
											"<span style=color:#7C7C7C><font size='2'>Ente Accreditato dalla Regione Lazio<br>con Determinazione N.G10842 del 31.7.2017</font></span><br><br>" + 
											"<br><font size='2'>Questa e-mail e gli allegati sono destinati esclusivamente al destinatario specificato e contengono dati personali e informazioni riservate. Qualsiasi utilizzo, diffusione, copia o distribuzione non autorizzata &egrave; vietato.<br>" + 
											"Se avete ricevuto questa comunicazione per errore, vi preghiamo di informare il mittente e di eliminare questa e-mail e gli allegati da tutti i dispositivi. <br>" + 
											"I dati personali sono trattati in conformit&agrave; al D. Lgs. 196/2003 Codice della privacy e al Regolamento UE 2016/679 e secondo le indicazioni riportate nel documento &quot;Informativa privacy servizi&quot; disponibile nel footer del sito www.crescosrl.net.<br>" + 
											"Ogni utilizzo improprio sar&agrave; perseguito ai sensi della legge applicabile. Grazie per la collaborazione <br></font><br>";
	
	
	
	
	public static void sendEmailCertificato(CertificatoDTO certificato, String mailTo, ServletContext ctx) throws Exception {
				
		
		String filename = certificato.getNomeCertificato();
		String pack = certificato.getMisura().getIntervento().getNomePack();
		
		  // Create the attachment
		  EmailAttachment attachment = new EmailAttachment();
		  attachment.setPath(Costanti.PATH_FOLDER+pack+"/"+filename);
		  attachment.setDisposition(EmailAttachment.ATTACHMENT);
		  attachment.setDescription("Certificato "+certificato.getId());
		  attachment.setName(certificato.getNomeCertificato());
		  
		  // Create the email message
		  HtmlEmail email = new HtmlEmail();
		  email.setHostName("smtps.aruba.it");
  		 //email.setDebug(true);
		 // email.setAuthentication("calver@accpoint.it", "7LwqE9w4tu");
		  email.setAuthentication("calver@accpoint.it", Costanti.PASS_EMAIL_ACC);



	        email.getMailSession().getProperties().put("mail.smtp.auth", "true");
	        email.getMailSession().getProperties().put("mail.debug", "true");
	        email.getMailSession().getProperties().put("mail.smtp.port", "465");
	        email.getMailSession().getProperties().put("mail.smtp.socketFactory.port", "465");
	        email.getMailSession().getProperties().put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	        email.getMailSession().getProperties().put("mail.smtp.socketFactory.fallback", "false");
	        email.getMailSession().getProperties().put("mail.smtp.ssl.enable", "true");

		  

		  email.addTo(mailTo);
		  email.setFrom("calver@accpoint.it", "Calver");
		  email.setSubject("Certificato "+certificato.getId());
		  
		  // embed the image and get the content id

//		  File image = new File(ctx.getRealPath("images/logo_calver_v2.png"));
//		  String cid = email.embed(image, "Calver logo");
		  
		  // set the html message
		  email.setHtmlMsg("<html>In allegato Certificato "+certificato.getId()+" <br />  <br /> <br /> <img width=\"200\" src=\""+Costanti.LOGO_EMAIL_FOOTER+" \"></html>");


		  // set the alternative message
		  email.setTextMsg("In allegato Certificato");

		  // add the attachment
		  email.attach(attachment);
		  
		  // send the email
		  email.send();
		  
		  
		  
 	}
	
//	
//public static void sendEmailCertificatoVerificazione(VerCertificatoDTO certificato, String mailTo, ServletContext ctx) throws Exception {
//				
//		
//		String filenameAtt = certificato.getNomeCertificato();
//		String filenameRap = certificato.getNomeRapporto();
//		String filenameP7m = certificato.getNomeCertificato()+".p7m";
//		String pack = certificato.getMisura().getVerIntervento().getNome_pack();
//		
//		  // Create the attachment
//		  EmailAttachment attachment = new EmailAttachment();
//		  attachment.setPath(Costanti.PATH_FOLDER+pack+"/"+filenameAtt);
//		  attachment.setDisposition(EmailAttachment.ATTACHMENT);
//		  attachment.setDescription(certificato.getNomeCertificato());
//		  attachment.setName(certificato.getNomeCertificato());
//		  
//		  
//		  EmailAttachment attachmentRap = new EmailAttachment();
//		  attachmentRap.setPath(Costanti.PATH_FOLDER+pack+"/Rapporto/"+filenameRap);
//		  attachmentRap.setDisposition(EmailAttachment.ATTACHMENT);
//		  attachmentRap.setDescription(certificato.getNomeRapporto());
//		  attachmentRap.setName(certificato.getNomeRapporto());
//		  
//		  
//		  
//		  EmailAttachment attachmentP7m = new EmailAttachment();
//		  attachmentP7m.setPath(Costanti.PATH_FOLDER+pack+"/"+filenameP7m);
//		  attachmentP7m.setDisposition(EmailAttachment.ATTACHMENT);
//		  attachmentP7m.setDescription(certificato.getNomeCertificato()+".p7m");
//		  attachmentP7m.setName(certificato.getNomeCertificato()+".p7m");
//		  
//		  // Create the email message
//		  HtmlEmail email = new HtmlEmail();
//		  email.setHostName("smtps.aruba.it");
//  		 //email.setDebug(true);
//		  email.setAuthentication("calver@accpoint.it", "7LwqE9w4tu");
//
//
//
//	        email.getMailSession().getProperties().put("mail.smtp.auth", "true");
//	        email.getMailSession().getProperties().put("mail.debug", "true");
//	        email.getMailSession().getProperties().put("mail.smtp.port", "465");
//	        email.getMailSession().getProperties().put("mail.smtp.socketFactory.port", "465");
//	        email.getMailSession().getProperties().put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
//	        email.getMailSession().getProperties().put("mail.smtp.socketFactory.fallback", "false");
//	        email.getMailSession().getProperties().put("mail.smtp.ssl.enable", "true");
//
//		  
//
//		  email.addTo(mailTo);
//		  email.setFrom("commerciale@stisrl.com", "Calver");
//		  email.setSubject("Trasmissione rapporti di verificazione periodica Vs. bilance");
//		  
//
//		  File img = new File(Costanti.PATH_FOLDER_LOGHI +"logo_sti_ddt.png");
//
//		  StringBuffer msg = new StringBuffer();
//		  msg.append("<html><body>");
//		  msg.append("<html>Gentile Cliente, <br /> " + 
//		  		"Inviamo in allegato il Rapporto e l'Attestato di verificazione periodica dei Vs. strumenti di misura. <br /> " + 
//		  		"Con l'occasione Vi ricordiamo che tale documentazione deve essere conservata, unitamente al libretto metrologico, per tutto il periodo di validit&agrave; della verificazione (tre anni dalla data di svolgimento), ed esibita agli Enti incaricati in occasione delle attivit&agrave; di vigilanza e controllo. <br /> " + 		
//		  		" <br />  <br /> <br /></html>");
//		  msg.append("<img width='350' src=cid:").append(email.embed(img)).append(">");
//	
//		  msg.append("</body><small><br><br>In ottemperanza al D.L. n. 196 del 30/6/2003 e Reg. UE n.2016/679 (GDPR) in materia di protezione dei dati personali, le informazioni contenute in questo messaggio sono strettamente confidenziali e riservate ed esclusivamente indirizzate al destinatario indicato (oppure alla persona responsabile di rimetterlo al destinatario). " + 
//		  		"Vogliate tener presente che qualsiasi uso, riproduzione o divulgazione di questo messaggio &egrave; vietato. Nel caso in cui aveste ricevuto questo messaggio per errore, vogliate cortesemente avvertire il mittente e distruggere il presente messaggio.<br><br>" + 
//		  		"According to Italian law D.L. 196/2003 and Reg. UE n.2016/679 (GDPR)  concerning privacy, if you are not the addressee (or responsible for delivery of the message to such person) you are hereby notified that any disclosure, reproduction, distribution or other dissemination or use of this communication is strictly prohibited. If you have received this message in error, please destroy it and notify us by email.\n" + 
//		  		"</small></html>");
//		  email.setHtmlMsg(msg.toString());
//		  
//		  // add the attachment
//		  email.attach(attachment);
//		  email.attach(attachmentRap);
//		  email.attach(attachmentP7m);
//		  
//		  // send the email
//		  email.send();
//		  
//		  
//		  
// 	}
	
	
	
	
public static void sendEmailCertificatoVerificazione(VerCertificatoDTO certificato, String mailTo, ServletContext ctx) throws Exception {
			
		// change accordingly 

			// change accordingly 
			String from = "commerciale@stisrl.com"; 
			
			// or IP address 
			String host = "smtps.aruba.it"; 
			
			// mail id 
			final String username = "calver@accpoint.it";
			
			// correct password for gmail id 
			final String password = Costanti.PASS_EMAIL_ACC; 
			

			System.out.println("TLSEmail Start"); 
			// Get the session object 
			
			// Get system properties 
			Properties properties = System.getProperties(); 
			
			// Setup mail server 
			properties.setProperty("mail.smtp.host", host); 
			
			// SSL Port 
			properties.put("mail.smtp.port", "465"); 
			
			// enable authentication 
			properties.put("mail.smtp.auth", "true"); 
			
			// SSL Factory 
			properties.put("mail.smtp.socketFactory.class", 
					"javax.net.ssl.SSLSocketFactory"); 

			properties.put("mail.transport.protocol", "smtp");
			properties.put("mail.smtp.from", "calver@accpoint.it");
			// creating Session instance referenced to 
			// Authenticator object to pass in 
			// Session.getInstance argument 
			Session session = Session.getDefaultInstance(properties, 
				new javax.mail.Authenticator() { 
					
					// override the getPasswordAuthentication 
					// method 
					protected PasswordAuthentication 
							getPasswordAuthentication() { 
						return new PasswordAuthentication(username,password); 
					} 
				}); 

	//compose the message 

		// javax.mail.internet.MimeMessage class is mostly 
		// used for abstraction. 
		MimeMessage message = new MimeMessage(session); 
		
		// header field of the header. 
		message.setFrom(new InternetAddress(from)); 	
		
		InternetAddress[] address = InternetAddress.parse(mailTo.trim().replace(";", ","));
		
		message.addRecipients(Message.RecipientType.TO, address); 
		
		message.setSubject("Trasmissione rapporti di verificazione periodica Vs. bilance"); 
			
		StringBuffer msg = new StringBuffer();
		  msg.append("<html><body>");
		  if(certificato.getNomeRapporto()!=null) {
			  msg.append("<html>Gentile Cliente, <br /> " + 
			  		"Inviamo in allegato il Rapporto e l'Attestato di verificazione periodica dei Vs. strumenti di misura. <br /> " + 
			  		"Con l'occasione Vi ricordiamo che tale documentazione deve essere conservata, unitamente al libretto metrologico, per tutto il periodo di validit&agrave; della verificazione (tre anni dalla data di svolgimento), ed esibita agli Enti incaricati in occasione delle attivit&agrave; di vigilanza e controllo. <br /> " + 		
			  		"<br />Restiamo a disposizione per qualsiasi chiarimento in merito.<br>" + 
			  		"Distinti saluti." + 
			  		"  <br /> <br />"
			  		+ "<em><b>S.T.I. Sviluppo Tecnologie Industriali Srl</b><br>Via Tofaro 42, B - 03039 Sora (FR)</em><br><br>" + 
			  		"<em>Tel + 39 0776.18151 - Fax+ 39 0776.814169 <br> "
			  		+ "Mail: </em>commerciale@stisrl.com<br>" + 
			  		"<em>Web: </em>http://www.stisrl.com<br>" + 
			  		"<br/></html>");
			//  msg.append("<img width='350' src=cid:").append(message.embed(img)).append(">");
			  msg.append("<img width='250' src=\"cid:image1\">");
			  msg.append(" <img width='100' src=\"cid:image2\">");
		
			  msg.append("</body><font size='1'><br><br>In ottemperanza al D.L. n. 196 del 30/6/2003 e Reg. UE n.2016/679 (GDPR) in materia di protezione dei dati personali, le informazioni contenute in questo messaggio sono strettamente confidenziali e riservate ed esclusivamente indirizzate al destinatario indicato (oppure alla persona responsabile di rimetterlo al destinatario). " + 
			  		"Vogliate tener presente che qualsiasi uso, riproduzione o divulgazione di questo messaggio &egrave; vietato. Nel caso in cui aveste ricevuto questo messaggio per errore, vogliate cortesemente avvertire il mittente e distruggere il presente messaggio.<br><br>" + 
			  		"According to Italian law D.L. 196/2003 and Reg. UE n.2016/679 (GDPR)  concerning privacy, if you are not the addressee (or responsible for delivery of the message to such person) you are hereby notified that any disclosure, reproduction, distribution or other dissemination or use of this communication is strictly prohibited. If you have received this message in error, please destroy it and notify us by email.\n" + 
			  		"</font></html>");
		  }else {
			  msg.append("<html>Gentile Cliente, <br /> " + 
				  		"Inviamo in allegato l'Attestato di verificazione periodica dei Vs. strumenti di misura. <br /> " + 
				  		"Con l'occasione Vi ricordiamo che tale documentazione deve essere conservata, unitamente al libretto metrologico, per tutto il periodo di validit&agrave; della verificazione (tre anni dalla data di svolgimento), ed esibita agli Enti incaricati in occasione delle attivit&agrave; di vigilanza e controllo. <br /> " + 		
				  		"<br />Restiamo a disposizione per qualsiasi chiarimento in merito.<br>" + 
				  		"Distinti saluti." + 
				  		"  <br /> <br />"
				  		+ "<em><b>S.T.I. Sviluppo Tecnologie Industriali Srl</b><br>Via Tofaro 42, B - 03039 Sora (FR)</em><br><br>" + 
				  		"<em>Tel + 39 0776.18151 - Fax+ 39 0776.814169 <br> "
				  		+ "Mail: </em>commerciale@stisrl.com<br>" + 
				  		"<em>Web: </em>http://www.stisrl.com<br>" + 
				  		"<br/></html>");
				//  msg.append("<img width='350' src=cid:").append(message.embed(img)).append(">");
				  msg.append("<img width='250' src=\"cid:image1\">");
				  msg.append(" <img width='100' src=\"cid:image2\">");
			
				  msg.append("</body><font size='1'><br><br>In ottemperanza al D.L. n. 196 del 30/6/2003 e Reg. UE n.2016/679 (GDPR) in materia di protezione dei dati personali, le informazioni contenute in questo messaggio sono strettamente confidenziali e riservate ed esclusivamente indirizzate al destinatario indicato (oppure alla persona responsabile di rimetterlo al destinatario). " + 
				  		"Vogliate tener presente che qualsiasi uso, riproduzione o divulgazione di questo messaggio &egrave; vietato. Nel caso in cui aveste ricevuto questo messaggio per errore, vogliate cortesemente avvertire il mittente e distruggere il presente messaggio.<br><br>" + 
				  		"According to Italian law D.L. 196/2003 and Reg. UE n.2016/679 (GDPR)  concerning privacy, if you are not the addressee (or responsible for delivery of the message to such person) you are hereby notified that any disclosure, reproduction, distribution or other dissemination or use of this communication is strictly prohibited. If you have received this message in error, please destroy it and notify us by email.\n" + 
				  		"</font></html>");
		  }

		  BodyPart messageBodyPart = new MimeBodyPart();
		  messageBodyPart.setContent(msg.toString(),"text/html");
		  
		  BodyPart attachAttestato = new MimeBodyPart();
		  BodyPart attachRapporto = new MimeBodyPart();
		  BodyPart attachP7m = new MimeBodyPart();
		 		  
		  BodyPart image = new MimeBodyPart();
		  BodyPart image_ann = new MimeBodyPart();
		  DataSource fds = new FileDataSource(Costanti.PATH_FOLDER_LOGHI +"logo_sti.png");

		  image.setDataHandler(new DataHandler(fds));
		  image.setHeader("Content-ID", "<image1>");
		  
		  DataSource fds_ann = new FileDataSource(Costanti.PATH_FOLDER_LOGHI +"anniversario.png");
		  image_ann.setDataHandler(new DataHandler(fds_ann));
		  image_ann.setHeader("Content-ID", "<image2>");
		  
		  Multipart multipart = new MimeMultipart();
		  
		    String filenameAtt = certificato.getNomeCertificato();
			String filenameRap = certificato.getNomeRapporto();
			String filenameP7m = certificato.getNomeCertificato()+".p7m";
			String pack = certificato.getMisura().getVerIntervento().getNome_pack();
			
			// Create the attachment
 
	         DataSource source = new FileDataSource(Costanti.PATH_FOLDER+pack+"/"+filenameAtt);
	         attachAttestato.setDataHandler(new DataHandler(source));
	         attachAttestato.setFileName(certificato.getNomeCertificato());
	         
	         if(certificato.getNomeRapporto()!=null) {
	        	 source = new FileDataSource(Costanti.PATH_FOLDER+pack+"/Rapporto/"+filenameRap);
	        	 attachRapporto.setDataHandler(new DataHandler(source));
	        	 attachRapporto.setFileName(certificato.getNomeRapporto());
	         }
	         
	         source = new FileDataSource(Costanti.PATH_FOLDER+pack+"/"+filenameP7m);
	         attachP7m.setDataHandler(new DataHandler(source));
	         attachP7m.setFileName(certificato.getNomeCertificato()+".p7m");
	         
	         multipart.addBodyPart(messageBodyPart);
	         multipart.addBodyPart(attachAttestato);
	         if(certificato.getNomeRapporto()!=null) {
	        	 multipart.addBodyPart(attachRapporto);
	         }
	         multipart.addBodyPart(attachP7m);
	         multipart.addBodyPart(image);
	         multipart.addBodyPart(image_ann);
	         // Send the complete message parts
	         message.setContent(multipart);

		// Send message 
		//Transport.send(message);
	         
	         Transport transport = session.getTransport();
	    
	          System.out.println("Sending ....");
	          transport.connect(host, 465, from, password);
	          transport.sendMessage(message,
	          message.getRecipients(Message.RecipientType.TO));
	          System.out.println("Sending done ...");
	        
	         transport.close();


 	}





public static void sendPECCertificatoVerificazione(VerCertificatoDTO certificato, String mailTo, boolean second_host, ServletContext ctx) throws Exception {
	
		Logger logger = Logger.getLogger(SendEmailBO.class);
		
	   String from = "metrologiasti@pec.it";
	   String SMTP_HOST_NAME = "smtps.pec.aruba.it";
	   
	   if(second_host) {
		    SMTP_HOST_NAME = "smtp2rid.arubapec.it";
	   }
	   
	   int SMTP_HOST_PORT = 465;
	   String SMTP_AUTH_USER = "metrologiasti@pec.it";
	  // String SMTP_AUTH_PWD  = "XkGiDri9&";
	   String SMTP_AUTH_PWD  = Costanti.PASS_PEC_VER;
	   
	   Properties props = new Properties();

       props.put("mail.transport.protocol", "smtps");
       props.put("mail.smtps.host", SMTP_HOST_NAME);
       props.put("mail.smtps.auth", true);    
       props.put("mail.smtps.port", 465);      
       props.put("mail.smtps.auth",true);
       props.put("mail.smtps.user","metrologiasti@pec.it");
       props.put("mail.debug", "true");
       props.put("mail.smtps.port", 465);
       props.put("mail.smtps.socketFactory.port", 465);
       props.put("mail.smtps.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
       props.put("mail.smtps.socketFactory.fallback", "false");
       props.put("mail.smtps.ssl.enable", true);
       props.put("mail.smtps.ssl.protocols", "TLSv1.2");
       //props.put("mail.smtps.ssl.protocols", "TLSv1 TLSv1.1 TLSv1.2");
       
       
       
       Session mailSession = Session.getDefaultInstance(props);
       
       
    
       MimeMessage message = new MimeMessage(mailSession); 
		
		// header field of the header. 
		message.setFrom(new InternetAddress(from)); 	
		
		InternetAddress[] address = InternetAddress.parse(mailTo.trim().replace(";", ","));
		
		message.addRecipients(Message.RecipientType.TO, address); 
		
		message.setSubject("Trasmissione rapporti di verificazione periodica Vs. bilance - MATRICOLA: "+certificato.getMisura().getVerStrumento().getMatricola()); 
			
		StringBuffer msg = new StringBuffer();
		
		  msg.append("<html><body>");
		  if(certificato.getNomeRapporto()!=null) {
			  msg.append("<html>Gentile Cliente, <br /> " + 
				  		"Inviamo in allegato il Rapporto e l'Attestato di verificazione periodica dei Vs. strumenti di misura. <br /> " + 
				  		"Si ricorda che tale documentazione deve essere conservata, unitamente al libretto metrologico, per tutto il periodo di utilizzo degli strumenti di misura, ed esibita agli Enti incaricati in occasione delle attivit&agrave; di vigilanza e controllo. <br /> " +
				  		
				  		"Con l'occasione si comunica che, in caso di smarrimento del libretto originale, lo scrivente Organismo potr&agrave; fornire una copia (duplicato) dello stesso solo a seguito del rilascio da parte del Titolare dello strumento di un'apposita dichiarazione di smarrimento resa ai sensi del DPR 445/2000 e corredata dalla copia in corso di validit&agrave; del documento di identit&agrave; del sottoscrittore."+
				  		"<br>Si riportano infine gli ulteriori obblighi per i titolari di strumenti di misura con funzione di misura legale:"+
				  		"<ul><li>sottoporre gli strumenti a verificazione periodica secondo le periodicit&agrave; definite dal DM 93/17 o a seguito di riparazione dello strumento se comportante la rimozione di sigilli di protezione anche di tipo elettronico. Il titolare dello strumento di misura richiede una nuova verificazione periodica almeno cinque giorni lavorativi prima della scadenza della precedente o entro dieci giorni lavorativi dall'avvenuta riparazione dei propri strumenti se tale riparazione ha comportato la rimozione di etichette o di ogni altro sigillo anche di tipo elettronico;</li>"+
				  		"<li>comunicare entro 30 giorni alla Camera di commercio della circoscrizione in cui lo strumento &egrave; in servizio, la data di inizio dell'utilizzo degli strumenti e quella di fine dell'utilizzo;</li>"+
				  		"<li>mantenere l'integrit&agrave; del contrassegno apposto in sede di verificazione periodica, nonch&eacute; di ogni altro marchio, sigillo, anche di tipo elettronico, o elemento di protezione;</li>"+
				  		"<li>curare l'integrit&agrave; dei sigilli provvisori applicati dal riparatore;</li>"+
				  		"<li>curare il corretto funzionamento degli strumenti e non utilizzarli quando sono palesemente difettosi o inaffidabili dal punto di vista metrologico.</li></ul>"+
				  		"Restiamo a disposizione per qualsiasi chiarimento in merito.<br>" + 
				  		"Distinti saluti." + 
				  		"  <br /> <br />"
				  		+ "<em><b>S.T.I. Sviluppo Tecnologie Industriali Srl</b><br>Via Tofaro 42, B - 03039 Sora (FR)</em><br>" + 
				  		"<em>Tel + 39 0776.18151 - Fax+ 39 0776.814169 <br> "
				  		+ "Mail: </em>commerciale@stisrl.com<br>" + 
				  		"<em>Web: </em>http://www.stisrl.com<br>" + 
				  		"<br/></html>");
			//  msg.append("<img width='350' src=cid:").append(message.embed(img)).append(">");
			  msg.append("<a href='www.stisrl.com'><img width='350' src=\"cid:image1\"></a>");
			  msg.append("<a href='www.stisrl.com/servizi/piattaforma-calver'> <img width='350' src=\"cid:image2\"></a>");
		
			  msg.append("</body><font size='1'><br><br>In ottemperanza al D.L. n. 196 del 30/6/2003 e Reg. UE n.2016/679 (GDPR) in materia di protezione dei dati personali, le informazioni contenute in questo messaggio sono strettamente confidenziali e riservate ed esclusivamente indirizzate al destinatario indicato (oppure alla persona responsabile di rimetterlo al destinatario). " + 
			  		"Vogliate tener presente che qualsiasi uso, riproduzione o divulgazione di questo messaggio &egrave; vietato. Nel caso in cui aveste ricevuto questo messaggio per errore, vogliate cortesemente avvertire il mittente e distruggere il presente messaggio.<br><br>" + 
			  		"According to Italian law D.L. 196/2003 and Reg. UE n.2016/679 (GDPR)  concerning privacy, if you are not the addressee (or responsible for delivery of the message to such person) you are hereby notified that any disclosure, reproduction, distribution or other dissemination or use of this communication is strictly prohibited. If you have received this message in error, please destroy it and notify us by email.\n" + 
			  		"</font></html>");
		  }else {
			  msg.append("<html>Gentile Cliente, <br /> " + 
				  		"Inviamo in allegato l'Attestato di verificazione periodica dei Vs. strumenti di misura. <br /> " + 
				  		"Si ricorda che tale documentazione deve essere conservata, unitamente al libretto metrologico, per tutto il periodo di utilizzo degli strumenti di misura, ed esibita agli Enti incaricati in occasione delle attivit&agrave; di vigilanza e controllo. <br /> " +
				  		
				  		"Con l'occasione si comunica che, in caso di smarrimento del libretto originale, lo scrivente Organismo potr&agrave; fornire una copia (duplicato) dello stesso solo a seguito del rilascio da parte del Titolare dello strumento di un'apposita dichiarazione di smarrimento  resa ai sensi del DPR 445/2000 e corredata dalla copia in corso di validit&agrave; del documento di identit&agrave; del sottoscrittore."+
				  		"<br>Si riportano infine gli ulteriori obblighi per i titolari di strumenti di misura con funzione di misura legale:"+
				  		"<ul><li>sottoporre gli strumenti a verificazione periodica secondo le periodicit&agrave; definite dal DM 93/17 o a seguito di riparazione dello strumento se comportante la rimozione di sigilli di protezione anche di tipo elettronico. Il titolare dello strumento di misura richiede una nuova verificazione periodica almeno cinque giorni lavorativi prima della scadenza della precedente o entro dieci giorni lavorativi dall'avvenuta riparazione dei propri strumenti se tale riparazione ha comportato la rimozione di etichette o di ogni altro sigillo anche di tipo elettronico;</li>"+
				  		"<li>comunicare entro 30 giorni alla Camera di commercio della circoscrizione in cui lo strumento &egrave; in servizio, la data di inizio dell'utilizzo degli strumenti e quella di fine dell'utilizzo;</li>"+
				  		"<li>mantenere l'integrit&agrave; del contrassegno apposto in sede di verificazione periodica, nonch&eacute; di ogni altro marchio, sigillo, anche di tipo elettronico, o elemento di protezione;</li>"+
				  		"<li>curare l'integrit&agrave; dei sigilli provvisori applicati dal riparatore;</li>"+
				  		"<li>curare il corretto funzionamento degli strumenti e non utilizzarli quando sono palesemente difettosi o inaffidabili dal punto di vista metrologico.</li></ul>"+
				  		"Restiamo a disposizione per qualsiasi chiarimento in merito.<br>" + 
				  		"Distinti saluti." + 
				  		"  <br /> <br />"
				  		+ "<em><b>S.T.I. Sviluppo Tecnologie Industriali Srl</b><br>Via Tofaro 42, B - 03039 Sora (FR)</em><br>" + 
				  		"<em>Tel + 39 0776.18151 - Fax+ 39 0776.814169 <br> "
				  		+ "Mail: </em>commerciale@stisrl.com<br>" + 
				  		"<em>Web: </em>http://www.stisrl.com<br>" + 
				  		"<br/></html>");
				//  msg.append("<img width='350' src=cid:").append(message.embed(img)).append(">");
				  msg.append("<a href='www.stisrl.com'><img width='350' src=\"cid:image1\"></a>");
				  msg.append("<a href='www.stisrl.com/servizi/piattaforma-calver'> <img width='350' src=\"cid:image2\"></a>");
			
				  msg.append("</body><font size='1'><br><br>In ottemperanza al D.L. n. 196 del 30/6/2003 e Reg. UE n.2016/679 (GDPR) in materia di protezione dei dati personali, le informazioni contenute in questo messaggio sono strettamente confidenziali e riservate ed esclusivamente indirizzate al destinatario indicato (oppure alla persona responsabile di rimetterlo al destinatario). " + 
				  		"Vogliate tener presente che qualsiasi uso, riproduzione o divulgazione di questo messaggio &egrave; vietato. Nel caso in cui aveste ricevuto questo messaggio per errore, vogliate cortesemente avvertire il mittente e distruggere il presente messaggio.<br><br>" + 
				  		"According to Italian law D.L. 196/2003 and Reg. UE n.2016/679 (GDPR)  concerning privacy, if you are not the addressee (or responsible for delivery of the message to such person) you are hereby notified that any disclosure, reproduction, distribution or other dissemination or use of this communication is strictly prohibited. If you have received this message in error, please destroy it and notify us by email.\n" + 
				  		"</font></html>");
		  }

		  BodyPart messageBodyPart = new MimeBodyPart();
		  messageBodyPart.setContent(msg.toString(),"text/html");
		  
		  BodyPart attachAttestato = new MimeBodyPart();
		  BodyPart attachRapporto = new MimeBodyPart();
		  BodyPart attachP7m = new MimeBodyPart();
		 		  
		  BodyPart image = new MimeBodyPart();
		  BodyPart image_ann = new MimeBodyPart();
		 // DataSource fds = new FileDataSource(Costanti.PATH_FOLDER_LOGHI +"logo_sti.png");
		  DataSource fds = new FileDataSource(Costanti.PATH_FOLDER_LOGHI +"sito_sti.png");

		  image.setDataHandler(new DataHandler(fds));
		  image.setHeader("Content-ID", "<image1>");
		  
		  //DataSource fds_ann = new FileDataSource(Costanti.PATH_FOLDER_LOGHI +"anniversario.png");
		  DataSource fds_ann = new FileDataSource(Costanti.PATH_FOLDER_LOGHI +"sito_calver.png");
		  image_ann.setDataHandler(new DataHandler(fds_ann));
		  image_ann.setHeader("Content-ID", "<image2>");
		  
		  Multipart multipart = new MimeMultipart();
		  
		    String filenameAtt = certificato.getNomeCertificato();
			String filenameRap = certificato.getNomeRapporto();
			String filenameP7m = certificato.getNomeCertificato()+".p7m";
			String pack = certificato.getMisura().getVerIntervento().getNome_pack();
			
			// Create the attachment

	         DataSource source = new FileDataSource(Costanti.PATH_FOLDER+pack+"/"+filenameAtt);
	         attachAttestato.setDataHandler(new DataHandler(source));
	         attachAttestato.setFileName(certificato.getNomeCertificato());
	         
	         if(certificato.getNomeRapporto()!=null) {
	        	 source = new FileDataSource(Costanti.PATH_FOLDER+pack+"/Rapporto/"+filenameRap);
	        	 attachRapporto.setDataHandler(new DataHandler(source));
	        	 attachRapporto.setFileName(certificato.getNomeRapporto());
	         }
	         
	         source = new FileDataSource(Costanti.PATH_FOLDER+pack+"/"+filenameP7m);
	         attachP7m.setDataHandler(new DataHandler(source));
	         attachP7m.setFileName(certificato.getNomeCertificato()+".p7m");
	         
	         multipart.addBodyPart(messageBodyPart);
	         multipart.addBodyPart(attachAttestato);
	         if(certificato.getNomeRapporto()!=null) {
	        	 multipart.addBodyPart(attachRapporto);
	         }
	         multipart.addBodyPart(attachP7m);
	         multipart.addBodyPart(image);
	         multipart.addBodyPart(image_ann);
	         // Send the complete message parts
	         message.setContent(multipart);
       
	         logger.error(mailSession.getProperty("mail.transport.protocol"));
	         Transport tr = mailSession.getTransport("smtps");
	         
	         tr.connect(SMTP_HOST_NAME, SMTP_HOST_PORT, SMTP_AUTH_USER, SMTP_AUTH_PWD);
	         message.saveChanges();      // don't forget this
	         tr.sendMessage(message, message.getAllRecipients());
	         tr.close();
	         

	}

	
public static void sendEmailPaccoInRitardo(ArrayList<String> lista_string_origini, String mailTo) throws Exception {
		
	  
	  // Create the email message
	  HtmlEmail email = new HtmlEmail();
	  email.setHostName("smtps.aruba.it");
		 //email.setDebug(true);
	  email.setAuthentication("calver@accpoint.it", Costanti.PASS_EMAIL_ACC);


        email.getMailSession().getProperties().put("mail.smtp.auth", "true");
        email.getMailSession().getProperties().put("mail.debug", "true");
        email.getMailSession().getProperties().put("mail.smtp.port", "465");
        email.getMailSession().getProperties().put("mail.smtp.socketFactory.port", "465");
        email.getMailSession().getProperties().put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        email.getMailSession().getProperties().put("mail.smtp.socketFactory.fallback", "false");
        email.getMailSession().getProperties().put("mail.smtp.ssl.enable", "true");

	  String[] to = mailTo.split(";");
	  for(int i = 0; i<to.length;i++) {
		  email.addTo(to[i]);  
	  }
	  
	  email.setFrom("commerciale@stisrl.com", "Calver");
	  email.setSubject("OGGETTO: avviso permanenza strumenti in magazzino");


	  StringBuffer msg = new StringBuffer();
	  msg.append("<html><body>");
	  msg.append("<html><br>" + 
	  		"Si comunica la presenza in magazzino dei seguenti pacchi in attesa di lavorazione:<br /><br />");
	  
	  
	  
	  msg.append("<table style='border-collapse: collapse; width: 100%; border: 1px solid #dddddd;'><thead><tr><th style=\"border: 1px solid #dddddd\">Pacco Origine</th><th style=\"border: 1px solid #dddddd;\">Cliente</th><th style=\"border: 1px solid #dddddd;\">Commessa</th><th style=\"border: 1px solid #dddddd;width:110px\">Data Commessa</th><th style=\"border: 1px solid #dddddd;width:110px\">Data arrivo</th><th style=\"border: 1px solid #dddddd;width:110px\">Data creazione</th><th style=\"border: 1px solid #dddddd;\">Diff.</th><th style=\"border: 1px solid #dddddd;\">Note</th></tr></thead><tbody>");
	  
	  for (String origine : lista_string_origini) {
		  msg.append("<tr>");
		  
		  msg.append("<td style=\"border: 1px solid #dddddd;\">"+origine.split(";")[0]+"</td>");
		  msg.append("<td style=\"border: 1px solid #dddddd;\">"+origine.split(";")[1]+"</td>");	  
			
			if(origine.split(";").length>2) {
				if(!origine.split(";")[2].equals("")) {
					msg.append("<td style=\"border: 1px solid #dddddd;\">"+origine.split(";")[2]+"</td>");
				}else {
					msg.append("<td style=\"border: 1px solid #dddddd;\"></td>");
				}
				if(origine.split(";").length>3) {
					
					msg.append("<td style=\"border: 1px solid #dddddd;\">"+origine.split(";")[3]+"</td>");
				}else {
					msg.append("<td style=\"border: 1px solid #dddddd;\"></td><td style=\"border: 1px solid #dddddd;\"></td><td style=\"border: 1px solid #dddddd;\"></td>");
				}
				
				if(origine.split(";").length>4) {
					
					msg.append("<td style=\"border: 1px solid #dddddd;\">"+origine.split(";")[4]+"</td>");
				}else {
					msg.append("<td></td><td></td>");
				}
				if(origine.split(";").length>5) {
					msg.append("<td style=\"border: 1px solid #dddddd;\">"+origine.split(";")[5]+"</td>");
					
				}else {
					msg.append("<td style=\"border: 1px solid #dddddd;\"></td>");
				}
				if(origine.split(";").length>6) {
					msg.append("<td style=\"border: 1px solid #dddddd;\">"+origine.split(";")[6]+"</td>");
					
				}else {
					msg.append("<td style=\"border: 1px solid #dddddd;\"></td>");
				}
				if(origine.split(";").length>7) {
					msg.append("<td style=\"border: 1px solid #dddddd;\">"+origine.split(";")[7]+"</td>");
					
				}else {
					msg.append("<td style=\"border: 1px solid #dddddd;\"></td>");
				}
				
				
				msg.append("</tr>");
				
				
			}else {
				
				msg.append("<td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td></tr>");
				//msg.append("<br>");
			}
		  }
		  
		  
	  msg.append("</tbody></table>");
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
		  
//		msg.append("- "+origine.split(";")[0]+" - "+origine.split(";")[1]);
//		
//		if(origine.split(";").length>2) {
//			if(!origine.split(";")[2].equals("")) {
//				msg.append(" - Commessa: "+origine.split(";")[2]);
//			}
//			if(origine.split(";").length>3) {
//				
//				msg.append(" - " + origine.split(";")[3]);
//				
//				if(origine.split(";").length>4) {
//					
//					msg.append(" - " + origine.split(";")[4]);
//				}else {
//					msg.append("<br>");
//				}
//				if(origine.split(";").length>5) {
//					
//					msg.append(" - " + origine.split(";")[5]+"<br>");
//				}else {
//					msg.append("<br>");
//				}
//			}else {
//				msg.append("<br>");
//			}
//		}else {
//			msg.append("<br>");
//		}
//	  }
	  msg.append(" <br />  <br /> <br /></html>");

	  email.setHtmlMsg(msg.toString());
	  
	  // add the attachment
	  
	  // send the email
	  email.send();
	  
	  
	  
	}


public static void sendEmailDocumento(DocumTLDocumentoDTO documento, String mailTo, String mailCc, String motivo_rifiuto,ServletContext ctx) throws Exception {
	
	
	String filename = documento.getNome_documento();
	
	
	  // Create the attachment
//	  EmailAttachment attachment = new EmailAttachment();
//	  attachment.setPath(Costanti.PATH_FOLDER+pack+"/"+filename);
//	  attachment.setDisposition(EmailAttachment.ATTACHMENT);
//	  attachment.setDescription("Documento "+documento.getId());
//	  attachment.setName(certificato.getNomeCertificato());
	  
	  // Create the email message
	  HtmlEmail email = new HtmlEmail();
	  email.setHostName("smtps.aruba.it");
		 //email.setDebug(true);
	  email.setAuthentication("calver@accpoint.it", Costanti.PASS_EMAIL_ACC);

        email.getMailSession().getProperties().put("mail.smtp.auth", "true");
        email.getMailSession().getProperties().put("mail.debug", "true");
        email.getMailSession().getProperties().put("mail.smtp.port", "465");
        email.getMailSession().getProperties().put("mail.smtp.socketFactory.port", "465");
        email.getMailSession().getProperties().put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        email.getMailSession().getProperties().put("mail.smtp.socketFactory.fallback", "false");
        email.getMailSession().getProperties().put("mail.smtp.ssl.enable", "true");


        String[] destinatari = mailTo.split(";"); 
        
        for (String dest : destinatari) {
        	email.addTo(dest);
		}
	  
	  if(mailCc!=null && !mailCc.equals("")) {
		  email.addCc(mailCc);  
	  }
	  
	  email.setFrom("calver@accpoint.it", "Calver");
	  email.setSubject("Documento "+documento.getNome_documento());
	  
	  // embed the image and get the content id

	  File image = new File(ctx.getRealPath("images/logo_calver_v2.png"));
	  String cid = email.embed(image, "Calver logo");
	  
	  // set the html message
	  
	  if(motivo_rifiuto!=null) {
		  email.setHtmlMsg("<html>Il documento "+documento.getNome_documento()+" &egrave stato rifiutato. "
			  		+ "Motivo rifiuto: "
			  		+ "<br /> "
			  		+ motivo_rifiuto
			  		+ " <br /> <br /> <img width=\"200\" src=\""+Costanti.PATH_FOLDER_LOGHI +"\\sito_calver.png"+" \"></html>");

	  }else {
		  email.setHtmlMsg("<html>Il documento "+documento.getNome_documento()+" &egrave scaduto! "
			  		+ "Fai click sul link per ricaricare il documento aggiornato"
			  		+ "<br /> "
			  		+ "https://portale.ecisrl.it/FormInputDoc/index.jsp?id_documento="+Utility.encryptData(documento.getId()+"")
			  		+" <br /> <br /> <img width='250' src=\"cid:"+cid+"\">");
			  		//+ " <br /> <br /> <img width=\"200\" src=\""+Costanti.PATH_FOLDER_LOGHI +"\\sito_calver.png"+" \"></html>");

	  }


	  // set the alternative message
	 // email.setTextMsg("In allegato Certificato");

	  // add the attachment
	 // email.attach(attachment);
	  
	  // send the email
	  email.send();
	  
	  
	  
	}

public static void sendEmailSchedaConsegnaDocumentale(ArrayList<DocumTLDocumentoDTO> lista_documenti, String parziale, String mailTo,ServletContext ctx) throws EmailException {
	
	

	  // Create the email message
	  HtmlEmail email = new HtmlEmail();
	  email.setHostName("smtps.aruba.it");
		 //email.setDebug(true);
	  email.setAuthentication("calver@accpoint.it", Costanti.PASS_EMAIL_ACC);

      email.getMailSession().getProperties().put("mail.smtp.auth", "true");
      email.getMailSession().getProperties().put("mail.debug", "true");
      email.getMailSession().getProperties().put("mail.smtp.port", "465");
      email.getMailSession().getProperties().put("mail.smtp.socketFactory.port", "465");
      email.getMailSession().getProperties().put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
      email.getMailSession().getProperties().put("mail.smtp.socketFactory.fallback", "false");
      email.getMailSession().getProperties().put("mail.smtp.ssl.enable", "true");


      String[] destinatari = mailTo.split(";"); 
      
      for (String dest : destinatari) {
      	email.addTo(dest);
		}
	  
	  
	  email.setFrom("calver@accpoint.it", "Calver");
	  email.setSubject("Scheda consegna documenti");
	  
	  // embed the image and get the content id

	  File image = new File(ctx.getRealPath("images/logo_calver_v2.png"));
	  String cid = email.embed(image, "Calver logo");
	  
	  String lista_doc ="";
	  
	 
	  
	  for (DocumTLDocumentoDTO doc : lista_documenti) {
		  String tipo_documento = "";
		  
		  if(doc.getTipo_documento()!=null) {
			  tipo_documento = doc.getTipo_documento().getDescrizione();
		  }
		  lista_doc += "ID: "+doc.getId()+" Committente: "+doc.getCommittente().getNome_cliente() +" - "+doc.getCommittente().getIndirizzo_cliente()+
		   " Fornitore: "+doc.getFornitore().getRagione_sociale() +" Nome documento: "+doc.getNome_documento()+" Tipo documento: "+tipo_documento+"<br><br>";		  
	  }
	  
	  String tipo_consegna = "CONSEGNA TOTALE";
	  if(parziale.equals("1")) {
		  tipo_consegna = "CONSEGNA PARZIALE";
	  }

		  email.setHtmlMsg("<html>Si avvisa che i seguenti documenti sono pronti per essere consegnati:<br>"
		  
				  +lista_doc
			  	+"Tipo consegna: "+tipo_consegna
			  		+" <br /> <br /> <img width='250' src=\"cid:"+cid+"\">");
			  		//+ " <br /> <br /> <img width=\"200\" src=\""+Costanti.PATH_FOLDER_LOGHI +"\\sito_calver.png"+" \"></html>");


	  email.send();
	
}

public static void sendEmailFormazione(ForCorsoDTO corso, String mailTo, ServletContext ctx) throws Exception {
	  HtmlEmail email = new HtmlEmail();
	  email.setHostName("mail.vianova.it");
		 //email.setDebug(true);
	  email.setAuthentication("segreteria@crescosrl.net", Costanti.PASS_EMAIL_CRESCO);

      email.getMailSession().getProperties().put("mail.smtp.auth", "true");
      email.getMailSession().getProperties().put("mail.debug", "true");
      email.getMailSession().getProperties().put("mail.smtp.port", "587");
      email.getMailSession().getProperties().put("mail.smtp.socketFactory.port", "587");
      email.getMailSession().getProperties().put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
      email.getMailSession().getProperties().put("mail.smtp.socketFactory.fallback", "true");
      email.getMailSession().getProperties().put("mail.smtp.ssl.enable", "false");
      
      email.addTo(mailTo);
	
	  email.setFrom("segreteria@crescosrl.net", "Segreteria Cresco Srl");
	  email.setSubject("Scheda consegna attestati di formazione - Corso: "+corso.getCorso_cat().getDescrizione());
	  
	  // embed the image and get the content id
	  
	  DateFormat df = new SimpleDateFormat("dd/MM/yyyy");

	//  File image = new File(ctx.getRealPath("images/calver_cresco.png"));
	//  String cid = email.embed(image, "Calver logo");

		  email.setHtmlMsg("<html>Gentile Cliente,<br>"
		  
			  	+"Si avvisa che gli attestati di formazione sono pronti per essere scaricati tramite il ns. software CALVER. <br><br>"
			  	+"ID: "+corso.getId()+" - Corso: "+corso.getCorso_cat().getDescrizione()+" - Data inizio: "+df.format(corso.getData_corso())+" - Commessa: +" +corso.getCommessa()+"<br><br>"
			  	+"Tipo consegna: CONSEGNA TOTALE <br><br>"
			  	
			  	+"Restiamo a disposizione per qualsiasi chiarimento in merito.<br>"
			  	+"Distinti saluti.<br><br>"
			  	
			  	
					+"<em><b>CRESCO Formazione e Consulenza Srl</b></em> <br>"+
					
						"<em></b><br>Via Tofaro 42, E - 03039 Sora (FR)<br>" + 
						"Tel int. +39 0776.1815115 - Fax +39 0776.814169</em> <br> "
						+ "Web: </em>www.crescosrl.net<br>" 
						+ "Mail: </em>segreteria@crescosrl.net<br>" + 
				
						"<br/></html>"
			  	
			  		+" <br /><a href='https://www.crescosrl.net/wp-content/uploads/2020/09/CALVER_SOFTWARE_FORMAZIONE_Rev.0.pdf'> <img width='450' src=\"https:/www.calver.it/images/cresco.jpg\"><a><br>"
			  		
			  		
				  +"<font size='1'><br><br>In ottemperanza al D.L. n. 196 del 30/6/2003 e Reg. UE n.2016/679 (GDPR) in materia di protezione dei dati personali, le informazioni contenute in questo messaggio sono strettamente confidenziali e riservate ed esclusivamente indirizzate al destinatario indicato (oppure alla persona responsabile di rimetterlo al destinatario). " + 
			  		"Vogliate tener presente che qualsiasi uso, riproduzione o divulgazione di questo messaggio &egrave; vietato. Nel caso in cui aveste ricevuto questo messaggio per errore, vogliate cortesemente avvertire il mittente e distruggere il presente messaggio.<br><br>" + 
			  		"According to Italian law D.L. 196/2003 and Reg. UE n.2016/679 (GDPR) concerning privacy, if you are not the addressee (or responsible for delivery of the message to such person) you are hereby notified that any disclosure, reproduction, distribution or other dissemination or use of this communication is strictly prohibited. If you have received this message in error, please destroy it and notify us by email." + 
			  		"</font>"
				  );
			
	  email.send();
}

public static void sendEmailAccettazioneConsegna(ConsegnaDpiDTO consegna, ServletContext ctx) throws Exception {
	
	
	  // Create the email message
	  HtmlEmail email = new HtmlEmail();
	  email.setHostName("smtps.aruba.it");
		 //email.setDebug(true);
	  email.setAuthentication("calver@accpoint.it", Costanti.PASS_EMAIL_ACC);

    email.getMailSession().getProperties().put("mail.smtp.auth", "true");
    email.getMailSession().getProperties().put("mail.debug", "true");
    email.getMailSession().getProperties().put("mail.smtp.port", "465");
    email.getMailSession().getProperties().put("mail.smtp.socketFactory.port", "465");
    email.getMailSession().getProperties().put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
    email.getMailSession().getProperties().put("mail.smtp.socketFactory.fallback", "false");
    email.getMailSession().getProperties().put("mail.smtp.ssl.enable", "true");


    DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
	  email.addTo(consegna.getLavoratore().getEmail());
	  email.setFrom("calver@accpoint.it", "Calver");
	  email.setSubject("Consegna DPI "+consegna.getDpi().getId());
	  
	  // embed the image and get the content id

	  File image = new File(ctx.getRealPath("images/logo_calver_v2.png"));
	  String cid = email.embed(image, "Calver logo");
	  	
		  email.setHtmlMsg("<html>Gentile "+consegna.getLavoratore().getNome() + " "+consegna.getLavoratore().getCognome()+",<br>"
		  	  	+"In data "+df.format(consegna.getData_consegna())+" ti &egrave; stato consegnato il seguente DPI: <br><br>"
				  +"TIPO: "+consegna.getDpi().getTipo_dpi().getDescrizione()
				  +"<br>DESCRIZIONE: "+consegna.getDpi().getDescrizione()
				  +"<br>MODELLO: " +consegna.getDpi().getModello()
				  //+"<br><br>http://portale.ecisrl.it/FormInputDoc/accettazioneDpi.jsp?id_consegna="+Utility.encryptData(""+consegna.getId())
				  +"<br><br><a class='btn btn-primary' href='https://portale.ecisrl.it/FormInputDoc/accettazioneDpi.jsp?id_consegna="+Utility.encryptData(""+consegna.getId())+"'> Clicca qui per accettare la consegna</a>"
				  
			  		+" <br /> <br /> <img width='250' src=\"cid:"+cid+"\">");
			  		//+ " <br /> <br /> <img width=\"200\" src=\""+Costanti.PATH_FOLDER_LOGHI +"\\sito_calver.png"+" \"></html>");


	  email.send();
	
}

public static void sendEmailRiconsegnaDPI(ConsegnaDpiDTO consegna, ServletContext ctx) throws Exception {
	

	  HtmlEmail email = new HtmlEmail();
	  email.setHostName("smtps.aruba.it");
		 //email.setDebug(true);
	  email.setAuthentication("calver@accpoint.it", Costanti.PASS_EMAIL_ACC);

  email.getMailSession().getProperties().put("mail.smtp.auth", "true");
  email.getMailSession().getProperties().put("mail.debug", "true");
  email.getMailSession().getProperties().put("mail.smtp.port", "465");
  email.getMailSession().getProperties().put("mail.smtp.socketFactory.port", "465");
  email.getMailSession().getProperties().put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
  email.getMailSession().getProperties().put("mail.smtp.socketFactory.fallback", "false");
  email.getMailSession().getProperties().put("mail.smtp.ssl.enable", "true");

  DateFormat df = new SimpleDateFormat("dd/MM/yyyy");

	  email.addTo(consegna.getLavoratore().getEmail());
	  email.setFrom("calver@accpoint.it", "Calver");
	  email.setSubject("Riconsegna DPI "+consegna.getDpi().getId());
	  
	  // embed the image and get the content id

	  File image = new File(ctx.getRealPath("images/logo_calver_v2.png"));
	  String cid = email.embed(image, "Calver logo");
	  	
		  email.setHtmlMsg("<html>Gentile "+consegna.getLavoratore().getNome() + " "+consegna.getLavoratore().getCognome()+",<br>"
		  	  	+"In data "+df.format(consegna.getRestituzione().getData_consegna())+" hai riconsegnato il seguente DPI: <br><br>"
				  +"TIPO: "+consegna.getDpi().getTipo_dpi().getDescrizione()
				  +"<br>DESCRIZIONE: "+consegna.getDpi().getDescrizione()
				  +"<br>MODELLO: " +consegna.getDpi().getModello()
				  +"<br>MOTIVAZIONE: "+consegna.getRestituzione().getMotivazione()
				  +"<br><br><a class='btn btn-primary' href='https://portale.ecisrl.it/FormInputDoc/accettazioneDpi.jsp?id_consegna="+Utility.encryptData(""+consegna.getId())+"&id_riconsegna="+Utility.encryptData(""+consegna.getRestituzione().getId())+"'> Clicca qui per confermare la riconsegna</a>"
				  
				  
			  		+" <br /> <br /> <img width='250' src=\"cid:"+cid+"\">");
			  		//+ " <br /> <br /> <img width=\"200\" src=\""+Costanti.PATH_FOLDER_LOGHI +"\\sito_calver.png"+" \"></html>");


	  email.send();
}

public static void sendEmailAperturaChiusuraIntevento(String apertura_chiusura,ServletContext ctx, InterventoDTO intervento, RilInterventoDTO ril_intervento, org.hibernate.Session session) throws Exception {
	
	
	
	 HtmlEmail email = new HtmlEmail();
	  email.setHostName("smtps.aruba.it");
		 //email.setDebug(true);
	  email.setAuthentication("calver@accpoint.it", Costanti.PASS_EMAIL_ACC);

 email.getMailSession().getProperties().put("mail.smtp.auth", "true");
 email.getMailSession().getProperties().put("mail.debug", "true");
 email.getMailSession().getProperties().put("mail.smtp.port", "465");
 email.getMailSession().getProperties().put("mail.smtp.socketFactory.port", "465");
 email.getMailSession().getProperties().put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
 email.getMailSession().getProperties().put("mail.smtp.socketFactory.fallback", "false");
 email.getMailSession().getProperties().put("mail.smtp.ssl.enable", "true");

 DateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");

	  email.addTo("giuseppe.gabriele@stisrl.com");
	  email.addTo("sara.massaro@stisrl.com");
// email.addTo("antonio.dicivita@ncsnetwork.it");
	  email.setFrom("calver@accpoint.it", "Calver");
	  File image = new File(ctx.getRealPath("images/logo_calver_v2.png"));
	  String cid = email.embed(image, "Calver logo");
	  ArrayList<RilMisuraRilievoDTO> lista_rilievi = null;
	  if(apertura_chiusura.equals("A")) {
		  
		  
		  if(ril_intervento !=null) {
			  String messaggio = "<html>Si comunica l'apertura del seguente intervento rilievi:<br><br>"
				  	  	+"ID INTERVENTO: "+ril_intervento.getId()
						  +"<br>COMMESSA: "+ril_intervento.getCommessa()
						  +"<br>CLIENTE: "+ril_intervento.getNome_cliente()
						  +"<br>SEDE: " +ril_intervento.getNome_sede()										 
						  +"<br>DATA APERTURA: "+df.format(new Date())
						  +"<br><br> LISTA RILIEVI ";
			  
			  lista_rilievi = GestioneRilieviBO.getListaRilieviIntervento(ril_intervento.getId(), session);
			  for (RilMisuraRilievoDTO rilievo : lista_rilievi) {
				messaggio += "<br>ID Rilievo: "+rilievo.getId();
				messaggio += " - Disegno: "+rilievo.getDisegno();
				messaggio += " - Variante: "+rilievo.getVariante();
				messaggio += " - Pezzi in ingresso: "+rilievo.getPezzi_ingresso();
			}
			  email.setSubject("Apertura intervento rilievi ID: "+ril_intervento.getId());
			  email.setHtmlMsg(messaggio +" <br /> <br /> <img width='250' src=\"cid:"+cid+"\">");
		  }else {
			  email.setSubject("Apertura intervento ID: "+intervento.getId());
			  email.setHtmlMsg("<html>Si comunica l'apertura del seguente intervento:<br><br>"
				  	  	+"ID: "+intervento.getId()
						  +"<br>COMMESSA: "+intervento.getIdCommessa()
						  +"<br>CLIENTE: "+intervento.getNome_cliente()
						  +"<br>SEDE: " +intervento.getNome_sede()
						  +"<br>RESPONSABILE: "+intervento.getUser().getNominativo()					 
						  +"<br>DATA APERTURA: "+df.format(new Date())
						  
					  		+" <br /> <br /> <img width='250' src=\"cid:"+cid+"\">");
		  }
		 
		  
		  
	  }else{
		  
		  if(ril_intervento !=null) {
			  
			  email.setSubject("Chiusura intervento rilievi ID: "+ril_intervento.getId());
				  	  	
			  String messaggio = "<html>Si comunica la chiusura del seguente intervento rilievi:<br><br>"
				  	  	+"ID INTERVENTO: "+ril_intervento.getId()
						  +"<br>COMMESSA: "+ril_intervento.getCommessa()
						  +"<br>CLIENTE: "+ril_intervento.getNome_cliente()
						  +"<br>SEDE: " +ril_intervento.getNome_sede()										 
						  +"<br>DATA APERTURA: "+df.format(new Date())
						  +"<br><br> LISTA RILIEVI ";
			  
						 lista_rilievi = GestioneRilieviBO.getListaRilieviIntervento(ril_intervento.getId(), session);
						  for (RilMisuraRilievoDTO rilievo : lista_rilievi) {
							messaggio += " <br>ID Rilievo: "+rilievo.getId();
							messaggio += " - Disegno: "+rilievo.getDisegno();
							messaggio += " - Variante: "+rilievo.getVariante();
							
							if(rilievo.getStato_rilievo().getId()==2 && rilievo.getControfirmato()==1) {
								messaggio += " - Stato: APPROVATO";
							}else {
								messaggio += " - Stato: "+rilievo.getStato_rilievo().getDescrizione();
							}
							
							
							if(rilievo.getStato_rilievo().getId() == 2 && rilievo.getSmaltimento()==1) {
								messaggio += " - DA SMALTIRE";
							}else if(rilievo.getStato_rilievo().getId() == 2 && rilievo.getSmaltimento()==0){
								messaggio += " - DA RISPEDIRE";
							}
						}
						
						  email.setHtmlMsg(messaggio +" <br /> <br /> <img width='250' src=\"cid:"+cid+"\">");
					  
					 
			  
		  }else {
			  email.setSubject("Chiusura intervento rilievi ID: "+intervento.getId());
			  email.setHtmlMsg("<html>Si comunica la chiusura del seguente intervento:<br><br>"
				  	  	+"ID: "+intervento.getId()+""
						  +"<br>COMMESSA: "+intervento.getIdCommessa()
						  +"<br>CLIENTE: "+intervento.getNome_cliente()
						  +"<br>SEDE: " +intervento.getNome_sede()
						  +"<br>RESPONSABILE: "+intervento.getUser().getNominativo()
						  +"<br>DATA CHIUSURA: "+df.format(new Date())
						  
						  
						  
					  		+" <br /> <br /> <img width='250' src=\"cid:"+cid+"\">");
		  }
		  
		  
		  
	  }
	  


	  email.send();
	
}

public static void sendEmailScadenzaAttivitaDevice(DevRegistroAttivitaDTO attivita, String messaggio, String referenti) throws EmailException {
	
	HtmlEmail email = new HtmlEmail();
	  email.setHostName("smtps.aruba.it");
		 //email.setDebug(true);
	  email.setAuthentication("calver@accpoint.it", Costanti.PASS_EMAIL_ACC);

email.getMailSession().getProperties().put("mail.smtp.auth", "true");
email.getMailSession().getProperties().put("mail.debug", "true");
email.getMailSession().getProperties().put("mail.smtp.port", "465");
email.getMailSession().getProperties().put("mail.smtp.socketFactory.port", "465");
email.getMailSession().getProperties().put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
email.getMailSession().getProperties().put("mail.smtp.socketFactory.fallback", "false");
email.getMailSession().getProperties().put("mail.smtp.ssl.enable", "true");

DateFormat df = new SimpleDateFormat("dd/MM/yyyy");

	  //email.addTo("giuseppe.gabriele@stisrl.com");
	  //email.addTo("sara.massaro@stisrl.com");
String nominativo = "";
if(attivita.getDevice().getDipendente()!=null && attivita.getDevice().getDipendente().getEmail()!=null && !attivita.getDevice().getDipendente().getEmail().equals("")) {
	email.addTo(attivita.getDevice().getDipendente().getEmail());
//	nominativo = "Gentile "+attivita.getDevice().getDipendente().getNome()+" "+attivita.getDevice().getDipendente().getCognome()+" <br>";
}

String[] to = referenti.split(";");

for (String string : to) {
	email.addTo(string);
}


	  email.setFrom("calver@accpoint.it", "Calver");
	  File image = new File(Costanti.PATH_FOLDER+"LoghiCompany\\logo_calver_v2.png");
	  String cid = email.embed(image, "Calver logo");
	 
	  email.setSubject("Attività programmata sul device "+attivita.getDevice().getDenominazione() +" ("+attivita.getDevice().getCodice_interno()+")");
	   
//	 email.setHtmlMsg("<html>Gentile utente,<br><br>"
//			  	  	+"Si comunica che il giorno "+df.format(attivita.getData_prossima())+" &egrave; in scadenza un'attività programmata sul device in oggetto. "
//					
//					  
//				  		+" <br /> <br /> <img width='250' src=\"cid:"+cid+"\">");
		  
		  
	  email.setHtmlMsg(nominativo+messaggio.replaceAll("à", "&agrave;").replaceAll("è", "&egrave;").replaceAll("ì", "&igrave;").replaceAll("ò", "&ograve;").replaceAll("ù", "&ugrave;")
				  
			  		+" <br /> <br /> <img width='250' src=\"cid:"+cid+"\">");


	  email.send();
	
}

public static void sendEmailGreenPass(GPDTO greenPass, String destinatario) throws EmailException {
	
	
	
	 HtmlEmail email = new HtmlEmail();
	  email.setHostName("smtps.aruba.it");
		 //email.setDebug(true);
	  email.setAuthentication("calver@accpoint.it", Costanti.PASS_EMAIL_ACC);

email.getMailSession().getProperties().put("mail.smtp.auth", "true");
email.getMailSession().getProperties().put("mail.debug", "true");
email.getMailSession().getProperties().put("mail.smtp.port", "465");
email.getMailSession().getProperties().put("mail.smtp.socketFactory.port", "465");
email.getMailSession().getProperties().put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
email.getMailSession().getProperties().put("mail.smtp.socketFactory.fallback", "false");
email.getMailSession().getProperties().put("mail.smtp.ssl.enable", "true");

DateFormat df = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
DateFormat df_dataNascita = new SimpleDateFormat("dd/MM/yyyy");

	  email.addTo(destinatario);
	  
	  email.setFrom("system@ncsnetwork.it", "GP Control");
	

		  email.setSubject("GREEN PASS INVALID");
		  
		  email.setHtmlMsg("<html>Rilevato Green Pass non valido:<br><br>"
				  	  +"<br>COGNOME: "+greenPass.getCognome()
					  +"<br>NOME: "+greenPass.getNome()
					  +"<br>DATA NASCITA: " +df_dataNascita.format(greenPass.getDataNascita())
					  +"<br>DATA VERIFICA: "+df.format(greenPass.getDataVerifica())					 
					  +" <br /> <br />");
		  
	  email.send();
	
}

public static void sendEmailDocumentiInScadenza() throws EmailException {
	
	ArrayList<DocumTLDocumentoDTO> lista_documenti = GestioneDocumentaleBO.getListaDocumentiStato(6, null);
	
	String messaggio = "";
	
	DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
	
	if(lista_documenti.size()>0) {
		for (DocumTLDocumentoDTO doc : lista_documenti) {
			
			if(doc.getObsoleto()==0 && doc.getDisabilitato()==0) {
				messaggio += "ID: "+doc.getId()+" - ";
				messaggio += "Committente: " + doc.getCommittente().getNome_cliente()+" - ";
				messaggio += "Nome documento: " + doc.getNome_documento()+" - ";
				messaggio += "Data scadenza: " + df.format(doc.getData_scadenza())+"<br>";
			}
		}
		
		 HtmlEmail email = new HtmlEmail();
		  email.setHostName("smtps.aruba.it");
			 //email.setDebug(true);
		  email.setAuthentication("calver@accpoint.it", Costanti.PASS_EMAIL_ACC);

	email.getMailSession().getProperties().put("mail.smtp.auth", "true");
	email.getMailSession().getProperties().put("mail.debug", "true");
	email.getMailSession().getProperties().put("mail.smtp.port", "465");
	email.getMailSession().getProperties().put("mail.smtp.socketFactory.port", "465");
	email.getMailSession().getProperties().put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	email.getMailSession().getProperties().put("mail.smtp.socketFactory.fallback", "false");
	email.getMailSession().getProperties().put("mail.smtp.ssl.enable", "true");



	email.addTo("valeria.rotondi@stisrl.com");
	email.addTo("claudia.perruzza@stisrl.com");

		  
		  email.setFrom("calver@accpoint.it", "Calver Documentale");
		

			  email.setSubject("AVVISO DOCUMENTI IN SCADENZA");
			  
			  email.setHtmlMsg("<html>Si riporta di seguito l&lsquo;elencazione dei documenti in scadenza:<br><br>"
					  	 +messaggio+"</html>");
			  
		  email.send();
	}
	
}



public static void sendEmailDPIInScadenza(ArrayList<DpiDTO> lista_dpi) throws EmailException {
	

	String messaggio = "";
	
	DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
	
	
		for (DpiDTO dpi : lista_dpi) {
			
		
				messaggio += "ID: "+dpi.getId()+" - ";
				messaggio += "TIPO DPI: " + dpi.getTipo_dpi().getDescrizione()+" - ";
				messaggio += "Company: " + dpi.getCompany().getRagione_sociale()+" - ";
				messaggio += "Lavoratore: " + dpi.getNome_lavoratore()+" - ";
				messaggio += "Data scadenza: " + df.format(dpi.getData_scadenza())+"<br>";
			}
		
		
		 HtmlEmail email = new HtmlEmail();
		  email.setHostName("smtps.aruba.it");
			 //email.setDebug(true);
		  email.setAuthentication("calver@accpoint.it", Costanti.PASS_EMAIL_ACC);

	email.getMailSession().getProperties().put("mail.smtp.auth", "true");
	email.getMailSession().getProperties().put("mail.debug", "true");
	email.getMailSession().getProperties().put("mail.smtp.port", "465");
	email.getMailSession().getProperties().put("mail.smtp.socketFactory.port", "465");
	email.getMailSession().getProperties().put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	email.getMailSession().getProperties().put("mail.smtp.socketFactory.fallback", "false");
	email.getMailSession().getProperties().put("mail.smtp.ssl.enable", "true");



	
	email.addTo("giuseppe.gabriele@stisrl.com");

		  
		  email.setFrom("calver@accpoint.it", "Calver - Gestione DPI");
		

			  email.setSubject("AVVISO DPI IN SCADENZA");
			  
			  email.setHtmlMsg("<html>Si riporta di seguito l&lsquo;elencazione dei dpi in scadenza:<br><br>"
					  	 +messaggio+"</html>");
			  
		  email.send();
	}
	



public static void sendEmailControlli(String messaggio) throws EmailException {
	

	
	DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
	

		
		
		 HtmlEmail email = new HtmlEmail();
		  email.setHostName("smtps.aruba.it");
			 //email.setDebug(true);
		  email.setAuthentication("calver@accpoint.it", Costanti.PASS_EMAIL_ACC);

	email.getMailSession().getProperties().put("mail.smtp.auth", "true");
	email.getMailSession().getProperties().put("mail.debug", "true");
	email.getMailSession().getProperties().put("mail.smtp.port", "465");
	email.getMailSession().getProperties().put("mail.smtp.socketFactory.port", "465");
	email.getMailSession().getProperties().put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	email.getMailSession().getProperties().put("mail.smtp.socketFactory.fallback", "false");
	email.getMailSession().getProperties().put("mail.smtp.ssl.enable", "true");


	email.addTo("giuseppe.gabriele@stisrl.com");
	email.addTo("antonio.dicivita@ncsnetwork.it");

		  
		  email.setFrom("calver@accpoint.it", "Calver - Gestione CONTROLLI OPERATIVI");
		

			  email.setSubject("AVVISO CONTROLLI OPERATIVI IN SCADENZA");
			  
			  email.setHtmlMsg("<html>Si riporta di seguito l&lsquo;elenco dei controlli operativi e delle attrezzature in scadenza:<br><br>"
					  	 +messaggio+"</html>");
			  
		  email.send();
	}



public static void sendEmailCorsiInScadenza(String messaggio, ForCorsoDTO corso,String path) throws EmailException {
	

	
	DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
	
		
		 HtmlEmail email = new HtmlEmail();

	
	email.setHostName("mail.vianova.it");
	
	 email.setAuthentication("segreteria@crescosrl.net", Costanti.PASS_EMAIL_CRESCO);

	 email.getMailSession().getProperties().put("mail.smtp.auth", "true");
	 email.getMailSession().getProperties().put("mail.debug", "true");
	 email.getMailSession().getProperties().put("mail.smtp.port", "587");
	 email.getMailSession().getProperties().put("mail.smtp.socketFactory.port", "587");
	 email.getMailSession().getProperties().put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	 email.getMailSession().getProperties().put("mail.smtp.socketFactory.fallback", "true");
	 email.getMailSession().getProperties().put("mail.smtp.ssl.enable", "false");

	for(ForReferenteDTO referente : corso.getListaReferenti()) {
		if(referente.getEmail()!=null && !referente.getEmail().equals("")) {
			email.addTo(referente.getEmail());
		}
	}
	email.addTo("lisa.lombardozzi@crescosrl.net");
	email.addTo("segreteria@crescosrl.net");
	
		  
		  email.setFrom("segreteria@crescosrl.net", "CRESCO - Formazione e consulenza Srl");
		

			  email.setSubject("SCADENZE CORSI OBBLIGATORI");
			  
		//	  File image = new File(path.replace("WEB-INF/classes", "")+"/images/calver_cresco.png");
		//	  String cid = email.embed(image, "Calver logo");
			  
			  messaggio += "<font size='2'>La presente e-mail &egrave; stata generata automaticamente da un indirizzo di posta elettronica di solo invio; si chiede pertanto di non rispondere al messaggio. <br>";
			  messaggio += "Per qualsiasi informazione si prega di contattare CRESCO Formazione e Consulenza Srl all'indirizzo </em>segreteria@crescosrl.net o ai numeri 0776/1815104 - 0776/1815115</font><br><br><br>";
			  
			  messaggio += "<em><b>CRESCO Formazione e Consulenza Srl</b></em> <br>"+
					
						"<em></b><br>Via Tofaro 42, E - 03039 Sora (FR)<br>" + 
						"Tel int. +39 0776.1815115 - Fax +39 0776.814169</em> <br> "
						+ "Web: </em>www.crescosrl.net<br>" 
						+ "Mail: </em>segreteria@crescosrl.net<br>" + 
				
						"<br/></html>"
			  	
			  		+" <br /><a href='https://www.crescosrl.net/wp-content/uploads/2020/09/CALVER_SOFTWARE_FORMAZIONE_Rev.0.pdf'> <img width='450' src=\"https:/www.calver.it/images/cresco.jpg\"><a><br>" ;
		
			
			  
			  email.setHtmlMsg("<html>"
					  	 +messaggio+"</html>");
			  
		  email.send();
	}

//public static void sendEmailPianificazione(ForPiaPianificazioneDTO pianificazione, CommessaDTO commessa, ServletContext ctx) throws EmailException, MessagingException, IOException {
//
//	DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
//	
//		
//		 HtmlEmail email = new HtmlEmail();
//		  email.setHostName("smtps.aruba.it");
//			 //email.setDebug(true);
//		  email.setAuthentication("calver@accpoint.it", Costanti.PASS_EMAIL_ACC);
//
//	email.getMailSession().getProperties().put("mail.smtp.auth", "true");
//	email.getMailSession().getProperties().put("mail.debug", "true");
//	email.getMailSession().getProperties().put("mail.smtp.port", "465");
//	email.getMailSession().getProperties().put("mail.smtp.socketFactory.port", "465");
//	email.getMailSession().getProperties().put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
//	email.getMailSession().getProperties().put("mail.smtp.socketFactory.fallback", "false");
//	email.getMailSession().getProperties().put("mail.smtp.ssl.enable", "true");
//
//
//	//email.addTo("giuseppe.gabriele@stisrl.com");
//	
//	
//	for(ForDocenteDTO docente : pianificazione.getListaDocenti()) {
//		if(docente.getEmail()!=null && !docente.getEmail().equals("")) {
//			email.addTo(docente.getEmail());
//		}
//	}
//	email.addTo("lisa.lombardozzi@crescosrl.net");
//	email.addTo("segreteria@crescosrl.net");
//	String messaggio = null;
//	
//	
//	if(pianificazione.getOra_inizio()!=null && !pianificazione.getOra_inizio().equals("")) {
//		messaggio = "Si comunica che &egrave; stata effettuata la seguente pianificazione corso per il "+df.format(pianificazione.getData())+" dalle ore "+pianificazione.getOra_inizio()+" per la commessa "+pianificazione.getId_commessa()+" - Cliente: "+commessa.getID_ANAGEN_NOME()+": <br><br>";
//		if(pianificazione.getOra_fine()!=null && !pianificazione.getOra_fine().equals("")) {
//			messaggio = "Si comunica che &egrave; stata effettuata la seguente pianificazione corso per il "+df.format(pianificazione.getData())+" dalle ore "+pianificazione.getOra_inizio()+ " alle ore " +pianificazione.getOra_fine() +" per la commessa "+pianificazione.getId_commessa()+" - Cliente: "+commessa.getID_ANAGEN_NOME()+": <br><br>";
//		}
//	}else {
//		messaggio = "Si comunica che &egrave; stata effettuata la seguente pianificazione corso per il "+df.format(pianificazione.getData())+" per la commessa "+pianificazione.getId_commessa()+" - Cliente: "+commessa.getID_ANAGEN_NOME()+": <br><br>";
//	}
//	
//	
//		  
//		  email.setFrom("calver@accpoint.it", "CRESCO - Formazione e consulenza Srl");
//		
//
//			  email.setSubject("PIANIFICAZIONE CORSO - DATA "+df.format(pianificazione.getData()));
//			  
//		//	  File image = new File(ctx.getRealPath("images/calver_cresco.png"));
//		//	  String cid = email.embed(image, "Calver logo");
//			  
//			  messaggio += pianificazione.getDescrizione().replaceAll("à", "&agrave;").replaceAll("è", "&egrave;").replaceAll("ì", "&igrave;").replaceAll("ò", "&ograve;").replaceAll("ù", "&ugrave;");
//			  
//			  
//			  messaggio += "<br><br><font size='2'>La presente e-mail &egrave; stata generata automaticamente da un indirizzo di posta elettronica di solo invio; si chiede pertanto di non rispondere al messaggio. <br>";
//			  messaggio += "Per qualsiasi informazione si prega di contattare CRESCO Formazione e Consulenza Srl all'indirizzo </em>segreteria@crescosrl.net o ai numeri 0776/1815104 - 0776/1815115</font><br><br><br>";
//			  
//			  messaggio += "<em><b>CRESCO Formazione e Consulenza Srl</b></em> <br>"+
//					
//						"<em></b><br>Via Tofaro 42, E - 03039 Sora (FR)<br>" + 
//						"Tel int. +39 0776.1815115 - Fax +39 0776.814169</em> <br> "
//						+ "Web: </em>www.crescosrl.net<br>" 
//						+ "Mail: </em>segreteria@crescosrl.net<br>" + 
//				
//						"<br/></html>"
//			  	
//			  		+" <br /><a href='https://www.crescosrl.net/wp-content/uploads/2020/09/CALVER_SOFTWARE_FORMAZIONE_Rev.0.pdf'><img width='450' src=\"https:/www.calver.it/images/cresco.jpg\"><a><br>" ;
//		
//			
//			  
//			  email.setHtmlMsg("<html>"
//					  	 +messaggio+"</html>");
//			  
//			  email.buildMimeMessage();
//			  MimeMessage message = email.getMimeMessage();
//
//			  MimeMultipart multipart = (MimeMultipart) message.getContent();
//			  
//			  
//			  String icsContent =
//					    "BEGIN:VCALENDAR\n" +
//					    "METHOD:REQUEST\n" +
//					    "PRODID: -//CRESCO//Calendario//IT\n" +
//					    "VERSION:2.0\n" +
//					    "BEGIN:VEVENT\n" +
//					    "DTSTAMP:" + new java.text.SimpleDateFormat("yyyyMMdd'T'HHmmss'Z'").format(new Date()) + "\n" +
//					    "DTSTART:" + new java.text.SimpleDateFormat("yyyyMMdd'T'HHmmss'Z'").format(pianificazione.getData()) + "\n" +
//					    "DTEND:" + new java.text.SimpleDateFormat("yyyyMMdd'T'HHmmss'Z'").format(pianificazione.getData()) + "\n" +
//					    "SUMMARY:" + "TEST1234" + "\n" +
//					    "DESCRIPTION:" + pianificazione.getDescrizione().replaceAll("\n", "\\n") + "\n" +
//					    "LOCATION:" + commessa.getID_ANAGEN_NOME() + "\n" +
//					    "ORGANIZER;CN=CRESCO:mailto:calver@accpoint.it\n" +
//					    "END:VEVENT\n" +
//					    "END:VCALENDAR";
//
//					// Creiamo una parte per l’invito
//					MimeBodyPart calendarPart = new MimeBodyPart();
//					calendarPart.setDataHandler(new DataHandler(
//					    new ByteArrayDataSource(icsContent, "text/calendar;method=REQUEST;charset=UTF-8")));
//					calendarPart.setFileName("invito.ics");
//					
//					email.buildMimeMessage();
//
//					// Recuperiamo il contenuto già preparato da HtmlEmail
////					MimeMultipart multipart = (MimeMultipart) email.getMimeMessage().getContent();
//					multipart.addBodyPart(calendarPart);
//
//					// Reimpostiamo il contenuto sul messaggio
//					email.getMimeMessage().setContent(multipart);
//					email.getMimeMessage().saveChanges();
//			  
//		  email.send();
//		  Transport.send(message);
//}
//


public static void sendEmailPianificazione(ForPiaPianificazioneDTO pianificazione, CommessaDTO commessa, ServletContext ctx) throws EmailException, MessagingException, IOException, ParseException {

	DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
	
		
//		 HtmlEmail email = new HtmlEmail();
//		  email.setHostName("smtps.aruba.it");
//			 //email.setDebug(true);
//		  email.setAuthentication("calver@accpoint.it", Costanti.PASS_EMAIL_ACC);
//
//	email.getMailSession().getProperties().put("mail.smtp.auth", "true");
//	email.getMailSession().getProperties().put("mail.debug", "true");
//	email.getMailSession().getProperties().put("mail.smtp.port", "465");
//	email.getMailSession().getProperties().put("mail.smtp.socketFactory.port", "465");
//	email.getMailSession().getProperties().put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
//	email.getMailSession().getProperties().put("mail.smtp.socketFactory.fallback", "false");
//	email.getMailSession().getProperties().put("mail.smtp.ssl.enable", "true");

	 Properties props = new Properties();
     props.put("mail.smtp.host", "smtps.aruba.it");
     props.put("mail.smtp.port", "465");
     props.put("mail.smtp.auth", "true");
     props.put("mail.smtp.ssl.enable", "true");
     
     props.put("mail.smtp.auth", "true");
     props.put("mail.debug", "true");
     props.put("mail.smtp.port", "465");
     props.put("mail.smtp.socketFactory.port", "465");
     props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
     props.put("mail.smtp.socketFactory.fallback", "false");
     props.put("mail.smtp.ssl.enable", "true");


     Session session = Session.getInstance(props, new Authenticator() {
         protected PasswordAuthentication getPasswordAuthentication() {
             return new PasswordAuthentication("calver@accpoint.it", Costanti.PASS_EMAIL_ACC);
        	 
         }
     });
     
     String destinatari="";
 	for(ForDocenteDTO docente : pianificazione.getListaDocenti()) {
		if(docente.getEmail()!=null && !docente.getEmail().equals("")) {
			destinatari+=docente.getEmail()+",";
		}
	}
 	destinatari+="lisa.lombardozzi@crescosrl.net,";
 	destinatari+="segreteria@crescosrl.net";
 
     MimeMessage message = new MimeMessage(session);
     message.setFrom(new InternetAddress("calver@accpoint.it", "CRESCO - Formazione e consulenza Srl"));
     message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatari));
     message.setSubject("PIANIFICAZIONE CORSO - DATA "+df.format(pianificazione.getData()));
     
     
     String messaggio = null;
 	
 	
 	if(pianificazione.getOra_inizio()!=null && !pianificazione.getOra_inizio().equals("")) {
 		messaggio = "Si comunica che &egrave; stata effettuata la seguente pianificazione corso per il "+df.format(pianificazione.getData())+" dalle ore "+pianificazione.getOra_inizio()+" per la commessa "+pianificazione.getId_commessa()+" - Cliente: "+commessa.getID_ANAGEN_NOME()+": <br><br>";
 		if(pianificazione.getOra_fine()!=null && !pianificazione.getOra_fine().equals("")) {
 			messaggio = "Si comunica che &egrave; stata effettuata la seguente pianificazione corso per il "+df.format(pianificazione.getData())+" dalle ore "+pianificazione.getOra_inizio()+ " alle ore " +pianificazione.getOra_fine() +" per la commessa "+pianificazione.getId_commessa()+" - Cliente: "+commessa.getID_ANAGEN_NOME()+": <br><br>";
 		}
 	}else {
 		messaggio = "Si comunica che &egrave; stata effettuata la seguente pianificazione corso per il "+df.format(pianificazione.getData())+" per la commessa "+pianificazione.getId_commessa()+" - Cliente: "+commessa.getID_ANAGEN_NOME()+": <br><br>";
 	}
 	
 	

 			  messaggio += pianificazione.getDescrizione().replaceAll("à", "&agrave;").replaceAll("è", "&egrave;").replaceAll("ì", "&igrave;").replaceAll("ò", "&ograve;").replaceAll("ù", "&ugrave;");
 			  
 			  
 			  messaggio += "<br><br><font size='2'>La presente e-mail &egrave; stata generata automaticamente da un indirizzo di posta elettronica di solo invio; si chiede pertanto di non rispondere al messaggio. <br>";
 			  messaggio += "Per qualsiasi informazione si prega di contattare CRESCO Formazione e Consulenza Srl all'indirizzo </em>segreteria@crescosrl.net o ai numeri 0776/1815104 - 0776/1815115</font><br><br><br>";
 			  
 			  messaggio += "<em><b>CRESCO Formazione e Consulenza Srl</b></em> <br>"+
 					
 						"<em></b><br>Via Tofaro 42, E - 03039 Sora (FR)<br>" + 
 						"Tel int. +39 0776.1815115 - Fax +39 0776.814169</em> <br> "
 						+ "Web: </em>www.crescosrl.net<br>" 
 						+ "Mail: </em>segreteria@crescosrl.net<br>" + 
 				
 						"<br/></html>"
 			  	
 			  		+" <br /><a href='https://www.crescosrl.net/wp-content/uploads/2020/09/CALVER_SOFTWARE_FORMAZIONE_Rev.0.pdf'><img width='450' src=\"https:/www.calver.it/images/cresco.jpg\"><a><br>" ;
 		


     // -------- Parte HTML --------
     MimeBodyPart htmlPart = new MimeBodyPart();
     htmlPart.setContent("<html>" + messaggio +  "<br/><br/>", "text/html; charset=UTF-8");


     // -------- Parte ICS --------
     SimpleDateFormat icsFormat = new SimpleDateFormat("yyyyMMdd'T'HHmmss");
     icsFormat.setTimeZone(TimeZone.getTimeZone("Europe/Rome"));

     
     Date data = pianificazione.getData();
     String oraInizio = pianificazione.getOra_inizio(); // es. "14:00"
     String oraFine = pianificazione.getOra_fine();
     
     Date startDate = null;
     Date endDate = null;
     String dtStart = null;
     String dtEnd = null;
     StringBuilder sb = new StringBuilder();
     
     if(oraInizio == null || oraInizio.equals("")) {
    	 startDate = new SimpleDateFormat("yyyy-MM-dd").parse(new SimpleDateFormat("yyyy-MM-dd").format(data));
    	 
    	 Calendar c = Calendar.getInstance();
    	    c.setTime(startDate);
    	    c.add(Calendar.DATE, 1); // DTEND deve essere il giorno dopo
    	    endDate = c.getTime();
    	    
    	    // Usa DATE (senza ore) per ICS
    	    dtStart = new SimpleDateFormat("yyyyMMdd").format(startDate);
    	    dtEnd   = new SimpleDateFormat("yyyyMMdd").format(endDate);
     }else {
    	 startDate = new SimpleDateFormat("yyyy-MM-dd HH:mm")
    	         .parse(new SimpleDateFormat("yyyy-MM-dd").format(data) +" "+ oraInizio);
    	 
    	 endDate = new SimpleDateFormat("yyyy-MM-dd HH:mm")
    	            .parse(new SimpleDateFormat("yyyy-MM-dd").format(data) +" "+ oraFine);

    	    dtStart = icsFormat.format(startDate);
    	    dtEnd   = icsFormat.format(endDate);
    	  
     }

     
     
    
     sb.append("BEGIN:VCALENDAR\r\n");
     sb.append("METHOD:REQUEST\r\n");
     sb.append("PRODID:-//CRESCO//FORMAZIONE//IT\r\n");
     sb.append("VERSION:2.0\r\n");

     
     sb.append("BEGIN:VTIMEZONE\r\n");
     sb.append("TZID:Europe/Rome\r\n");
     sb.append("X-LIC-LOCATION:Europe/Rome\r\n");
     sb.append("BEGIN:DAYLIGHT\r\n");
     sb.append("TZOFFSETFROM:+0100\r\n");
     sb.append("TZOFFSETTO:+0200\r\n");
     sb.append("TZNAME:CEST\r\n");
     sb.append("DTSTART:19700329T020000\r\n");
     sb.append("RRULE:FREQ=YEARLY;BYMONTH=3;BYDAY=-1SU\r\n");
     sb.append("END:DAYLIGHT\r\n");
     sb.append("BEGIN:STANDARD\r\n");
     sb.append("TZOFFSETFROM:+0200\r\n");
     sb.append("TZOFFSETTO:+0100\r\n");
     sb.append("TZNAME:CET\r\n");
     sb.append("DTSTART:19701025T030000\r\n");
     sb.append("RRULE:FREQ=YEARLY;BYMONTH=10;BYDAY=-1SU\r\n");
     sb.append("END:STANDARD\r\n");
     sb.append("END:VTIMEZONE\r\n");
     
     
     sb.append("BEGIN:VEVENT\r\n");
     sb.append("UID:meeting-"+pianificazione.getId()+"-001@mycalendar.app\r\n");
     sb.append("DTSTAMP:" + icsFormat.format(new Date()) + "\n");
     sb.append("DTSTART;TZID=Europe/Rome:"+dtStart + "\r\n");
     sb.append("DTEND;TZID=Europe/Rome:" +  dtEnd + "\r\n");


     sb.append("SUMMARY:PIANIFICAZIONE CORSO - DATA "+df.format(pianificazione.getData())+"\r\n");
     sb.append("DESCRIPTION:"+pianificazione.getDescrizione()+"\r\n");
     sb.append("LOCATION:"+pianificazione.getTipo().getDescrizione()+"\r\n");
     sb.append("ORGANIZER;CN=CRESCO:mailto:calver@accpoint.it\r\n");

     sb.append("END:VEVENT\r\n");
     sb.append("END:VCALENDAR\r\n");

     String icsContent = sb.toString();

     MimeBodyPart calendarPart = new MimeBodyPart();
     calendarPart.setDataHandler(new DataHandler(
             new ByteArrayDataSource(icsContent, "text/calendar;method=REQUEST;charset=UTF-8")));
     calendarPart.setFileName("AggiungiAlCalendario.ics");
     calendarPart.setHeader("Content-ID", "<AggiungiAlCalendario>");
     calendarPart.setDisposition(MimeBodyPart.INLINE);

     // -------- Multipart finale --------
     MimeMultipart multipart = new MimeMultipart();
     multipart.addBodyPart(htmlPart);
     multipart.addBodyPart(calendarPart);

     message.setContent(multipart);

     // -------- Invio --------
     Transport.send(message);

     System.out.println("Email inviata con invito calendario!");
}


public static void sendEmailReminderPianificazione(String messaggio, String path) throws EmailException {
	

	DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
	

		
		
		 HtmlEmail email = new HtmlEmail();
		  email.setHostName("smtps.aruba.it");
			 //email.setDebug(true);
		  email.setAuthentication("calver@accpoint.it", Costanti.PASS_EMAIL_ACC);

	email.getMailSession().getProperties().put("mail.smtp.auth", "true");
	email.getMailSession().getProperties().put("mail.debug", "true");
	email.getMailSession().getProperties().put("mail.smtp.port", "465");
	email.getMailSession().getProperties().put("mail.smtp.socketFactory.port", "465");
	email.getMailSession().getProperties().put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	email.getMailSession().getProperties().put("mail.smtp.socketFactory.fallback", "false");
	email.getMailSession().getProperties().put("mail.smtp.ssl.enable", "true");



	
	email.addTo("lisa.lombardozzi@crescosrl.net");
	email.addTo("segreteria@crescosrl.net");
	email.addTo("antonio.dicivita@ncsnetwork.it");
		  
		  email.setFrom("calver@accpoint.it", "CRESCO - Formazione e consulenza Srl");
		

			  email.setSubject("CORSI FATTURATI SENZA ATTESTATI");
			  
			 // File image = new File(path.replace("WEB-INF/classes", "")+"/images/calver_cresco.png");
			//  String cid = email.embed(image, "Calver logo");
			  
			  messaggio += "<br><br><font size='2'>La presente e-mail &egrave; stata generata automaticamente da un indirizzo di posta elettronica di solo invio; si chiede pertanto di non rispondere al messaggio. <br>";
			  messaggio += "Per qualsiasi informazione si prega di contattare CRESCO Formazione e Consulenza Srl all'indirizzo </em>segreteria@crescosrl.net o ai numeri 0776/1815104 - 0776/1815115</font><br><br><br>";
			  
			  messaggio += "<em><b>CRESCO Formazione e Consulenza Srl</b></em> <br>"+
					
						"<em></b><br>Via Tofaro 42, E - 03039 Sora (FR)<br>" + 
						"Tel int. +39 0776.1815115 - Fax +39 0776.814169</em> <br> "
						+ "Web: </em>www.crescosrl.net<br>" 
						+ "Mail: </em>segreteria@crescosrl.net<br>" + 
				
						"<br/></html>"
			  	
			  		+" <br /><a href='https://www.crescosrl.net/wp-content/uploads/2020/09/CALVER_SOFTWARE_FORMAZIONE_Rev.0.pdf'> <img width='450' src=\"https:/www.calver.it/images/cresco.jpg\"><a><br>" ;
		
			
			  
			  email.setHtmlMsg("<html>"
					  	 +messaggio+"</html>");
			  
		  email.send();
}

public static void sendEmailEliminaPianificazione(ForPiaPianificazioneDTO pianificazione, ServletContext ctx) throws EmailException {


	DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
	

		 HtmlEmail email = new HtmlEmail();
		  email.setHostName("smtps.aruba.it");
			 //email.setDebug(true);
		  email.setAuthentication("calver@accpoint.it", Costanti.PASS_EMAIL_ACC);

	email.getMailSession().getProperties().put("mail.smtp.auth", "true");
	email.getMailSession().getProperties().put("mail.debug", "true");
	email.getMailSession().getProperties().put("mail.smtp.port", "465");
	email.getMailSession().getProperties().put("mail.smtp.socketFactory.port", "465");
	email.getMailSession().getProperties().put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	email.getMailSession().getProperties().put("mail.smtp.socketFactory.fallback", "false");
	email.getMailSession().getProperties().put("mail.smtp.ssl.enable", "true");

	
	
	
	for (ForDocenteDTO docente : pianificazione.getListaDocenti()) {
		if(docente.getEmail()!=null && !docente.getEmail().equals("")) {
			email.addTo(docente.getEmail());	
		}
		
	}
	
	email.addTo("lisa.lombardozzi@crescosrl.net");
	email.addTo("segreteria@crescosrl.net");
		  
		  email.setFrom("calver@accpoint.it", "CRESCO - Formazione e consulenza Srl");
		

			  email.setSubject("Eliminazione pianificazione corso del" + df.format(pianificazione.getData())+" - Commessa: "+pianificazione.getId_commessa());
			  
			//  File image = new File(ctx.getRealPath("images/calver_cresco.png"));
			//  String cid = email.embed(image, "Calver logo");
			  
			  String messaggio = "Si comunica che la pianificazione corso del "+ df.format(pianificazione.getData()) +" della  Commessa: "+pianificazione.getId_commessa()+" &egrave; stata eliminata.";
			  
			  messaggio += "<br><br><font size='2'>La presente e-mail &egrave; stata generata automaticamente da un indirizzo di posta elettronica di solo invio; si chiede pertanto di non rispondere al messaggio. <br>";
			  messaggio += "Per qualsiasi informazione si prega di contattare CRESCO Formazione e Consulenza Srl all'indirizzo </em>segreteria@crescosrl.net o ai numeri 0776/1815104 - 0776/1815115</font><br><br><br>";
			  
			  messaggio += "<em><b>CRESCO Formazione e Consulenza Srl</b></em> <br>"+
					
						"<em></b><br>Via Tofaro 42, E - 03039 Sora (FR)<br>" + 
						"Tel int. +39 0776.1815115 - Fax +39 0776.814169</em> <br> "
						+ "Web: </em>www.crescosrl.net<br>" 
						+ "Mail: </em>segreteria@crescosrl.net<br>" + 
				
						"<br/></html>"
			  	
			  		+" <br /><a href='https://www.crescosrl.net/wp-content/uploads/2020/09/CALVER_SOFTWARE_FORMAZIONE_Rev.0.pdf'> <img width='450' src=\"https:/www.calver.it/images/cresco.jpg\"><a><br>" ;
		
			
			  
			  email.setHtmlMsg("<html>"
					  	 +messaggio+"</html>");
			  
		  email.send();
	
}
	


public static void sendEmailCorsoMoodle(ForMembriGruppoDTO utente, String descrizione_corso, String oggetto, String messaggio) {


	try {

		HtmlEmail email = new HtmlEmail();

		email.setHostName("mail.vianova.it");
		//email.setDebug(true);
		email.setAuthentication("segreteria@crescosrl.net", Costanti.PASS_EMAIL_CRESCO);

		email.getMailSession().getProperties().put("mail.smtp.auth", "true");
		email.getMailSession().getProperties().put("mail.debug", "true");
		email.getMailSession().getProperties().put("mail.smtp.port", "587");
		email.getMailSession().getProperties().put("mail.smtp.socketFactory.port", "587");
		email.getMailSession().getProperties().put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		email.getMailSession().getProperties().put("mail.smtp.socketFactory.fallback", "true");
		email.getMailSession().getProperties().put("mail.smtp.ssl.enable", "false");


		email.addTo(utente.getEmail());	

		email.setFrom("segreteria@crescosrl.net", "CRESCO - Formazione e consulenza Srl");


		email.setSubject(oggetto);


		messaggio = messaggio.replace("{NOME}", utente.getNome()).replace("{COGNOME}", utente.getCognome()).replace("{USER_NAME}", utente.getUsername()).replace("{DESCRIZIONE_CORSO}", descrizione_corso);


		messaggio += "<br><br>Segreteria CRESCO Formazione e Consulenza Srl <br>Per Assistenza e Tutoraggio dal luned&igrave; al venerd&igrave; dalle ore 8.30 alle ore 18.00 ai seguenti numeri:<br>Tel. Interno: 0776.1815115 - 0776.1815104";


		messaggio +="<br><br>"+ FIRMA_CALCE_CRESCO;

		email.setHtmlMsg("<html>"+messaggio+"</html>");


		email.send();

		  GestioneFormazioneBO.lista_utenti_inviati.add(utente);

	}catch (Exception e) 
	{
		utente.setDescrizioneErrore(e.getMessage());
		GestioneFormazioneBO.lista_utenti_mancanti.add(utente);
	} 

}

public static void sendEmailReportCorsiMoodle(ForConfInvioEmailDTO conf, ArrayList<ForMembriGruppoDTO> lista_utenti) throws EmailException {
	


	 HtmlEmail email = new HtmlEmail();



 email.setHostName("mail.vianova.it");
	 //email.setDebug(true);
 email.setAuthentication("segreteria@crescosrl.net", Costanti.PASS_EMAIL_CRESCO);

email.getMailSession().getProperties().put("mail.smtp.auth", "true");
email.getMailSession().getProperties().put("mail.debug", "true");
email.getMailSession().getProperties().put("mail.smtp.port", "587");
email.getMailSession().getProperties().put("mail.smtp.socketFactory.port", "587");
email.getMailSession().getProperties().put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
email.getMailSession().getProperties().put("mail.smtp.socketFactory.fallback", "true");
email.getMailSession().getProperties().put("mail.smtp.ssl.enable", "false");



email.addTo("lisa.lombardozzi@crescosrl.net");
email.addTo("raffaele.fantini@ncsnetwork.it");
email.addTo("antonio.dicivita@ncsnetwork.it");


	  
	  email.setFrom("segreteria@crescosrl.net", "CRESCO - Formazione e consulenza Srl");
	

		  email.setSubject("Report invio remind corsi Moodle");
		  
		  
		  String messaggio = "Si comunica che in data odierna &egrave; stato inviato il remind di non completamento del corso secondo la seguente configurazione:<br><br>";
		  
		  messaggio += "ID: "+conf.getId()+" - CORSO: "+conf.getDescrizione_corso()+" - GRUPPO: "+conf.getDescrizione_gruppo();
		  
		  messaggio += "<br><br>LISTA DESTINATARI<br><br>";
		  
		  for (ForMembriGruppoDTO utente : lista_utenti) {
			  messaggio += utente.getNome() +" "+utente.getCognome()+" - Email: "+utente.getEmail()+"<br>";
		  }
		  
		  
					  
		  messaggio += "<em><b><br><br>Segreteria didattica<br>CRESCO Formazione e Consulenza Srl</b></em> <br>"+
				
					"<em></b><br>Via Tofaro 42, E - 03039 Sora (FR)<br>" + 
					"Tel int. +39 0776.1815115 - Fax +39 0776.814169</em> <br> "
					+ "Web: </em>www.crescosrl.net<br>" 
					+ "Mail: </em>segreteria@crescosrl.net<br>" + 
			
					"<br/>" ;
	
		
		  
		  email.setHtmlMsg("<html>"
				  	 +messaggio+"</html>");
		  
	  email.send();
}

public static void sendEmailScadenzaSoftware(DevSoftwareDTO software) throws EmailException {
	
	
	HtmlEmail email = new HtmlEmail();
	  email.setHostName("smtps.aruba.it");
		 //email.setDebug(true);
	  email.setAuthentication("calver@accpoint.it", Costanti.PASS_EMAIL_ACC);

email.getMailSession().getProperties().put("mail.smtp.auth", "true");
email.getMailSession().getProperties().put("mail.debug", "true");
email.getMailSession().getProperties().put("mail.smtp.port", "465");
email.getMailSession().getProperties().put("mail.smtp.socketFactory.port", "465");
email.getMailSession().getProperties().put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
email.getMailSession().getProperties().put("mail.smtp.socketFactory.fallback", "false");
email.getMailSession().getProperties().put("mail.smtp.ssl.enable", "true");

DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
Date today = new Date();

	  //email.addTo("giuseppe.gabriele@stisrl.com");
	  //email.addTo("sara.massaro@stisrl.com");
String nominativo = "";

String[] to = software.getEmail_responsabile().split(";");


for (String string : to) {
	email.addTo(string);
}
	

	  email.setFrom("calver@accpoint.it", "Calver");
	  File image = new File(Costanti.PATH_FOLDER+"LoghiCompany\\logo_calver_v2.png");
	  String cid = email.embed(image, "Calver logo");
	 
	  email.setSubject("Scadenza software ID: "+software.getId() +" - "+software.getNome());
	  
	  String scad = "in scadenza";
	  if(today.equals(software.getData_scadenza())||today.after(software.getData_scadenza())) {
		  scad = "scaduto";
	  }
	   
	  String messaggio = "Si comunica che in data "+df.format(software.getData_scadenza()) +" è "+scad+" il seguente software:<br><br>"
	  
			  + software.getNome()+" (ID: "+software.getId()+").<br>"
			  +"Si prega di provvedere all'eventuale rinnovo della licenza.<br><br>"
			  ;

  
	  email.setHtmlMsg(nominativo+messaggio.replaceAll("à", "&agrave;").replaceAll("è", "&egrave;").replaceAll("ì", "&igrave;").replaceAll("ò", "&ograve;").replaceAll("ù", "&ugrave;")
				  
			  		+" <br /> <br /> <img width='250' src=\"cid:"+cid+"\">");


	  email.send();
	
}

public static void sendEmailRemindServizi(ItServizioItDTO servizio) throws Exception {
	
	HtmlEmail email = new HtmlEmail();
	  email.setHostName("smtps.aruba.it");
		 //email.setDebug(true);
	  email.setAuthentication("calver@accpoint.it", Costanti.PASS_EMAIL_ACC);

		email.getMailSession().getProperties().put("mail.smtp.auth", "true");
		email.getMailSession().getProperties().put("mail.debug", "true");
		email.getMailSession().getProperties().put("mail.smtp.port", "465");
		email.getMailSession().getProperties().put("mail.smtp.socketFactory.port", "465");
		email.getMailSession().getProperties().put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		email.getMailSession().getProperties().put("mail.smtp.socketFactory.fallback", "false");
		email.getMailSession().getProperties().put("mail.smtp.ssl.enable", "true");
		
		DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
		Date today = new Date();
		
			  //email.addTo("giuseppe.gabriele@stisrl.com");
			  //email.addTo("sara.massaro@stisrl.com");
		String nominativo = "";
		
		String[] to = servizio.getEmail_referenti().split(";");
		
		
		for (String string : to) {
			email.addTo(string);
		}
	

	  email.setFrom("calver@accpoint.it", "Calver");
	  File image = new File(Costanti.PATH_FOLDER+"LoghiCompany\\logo_calver_v2.png");
	  String cid = email.embed(image, "Calver logo");
	 
	  email.setSubject("Scadenza Servizio IT - ID: "+servizio.getId() +" - "+servizio.getDescrizione());
	  
	  String scad = "in scadenza";
	  if(today.equals(servizio.getData_scadenza())||today.after(servizio.getData_scadenza())) {
		  scad = "scaduto";
	  }
	  
	  String rinnovo = "NO";
	  
	  if(servizio.getRinnovo_automatico()==1) {
		  rinnovo = "SI";
	  }
	   
	  String messaggio = "Si comunica che in data "+df.format(servizio.getData_scadenza()) +" è "+scad+" il seguente servizio IT:<br><br> "
	  
			  +"ID: "+servizio.getId()+"<br>"
			  +"TIPO: "+servizio.getTipo_servizio().getDescrizione()+ "<br>"
			  +"DESCRIZIONE: " +servizio.getDescrizione()+"<br>"
			  +"FORNITORE: "+servizio.getFornitore()+"<br>"
			  +"COMPANY: "+servizio.getId_company().getRagione_sociale()+"<br>"
			  +"RINNOVO AUTOMATICO: "+rinnovo+"<br>"
			  +"Si prega di provvedere all'eventuale rinnovo.<br><br>"
			  ;


	  email.setHtmlMsg(nominativo+messaggio.replaceAll("à", "&agrave;").replaceAll("è", "&egrave;").replaceAll("ì", "&igrave;").replaceAll("ò", "&ograve;").replaceAll("ù", "&ugrave;")
				  
			  		+" <br /> <br /> <img width='250' src=\"cid:"+cid+"\">");


	  email.send();
}

public static void sendEmailScadenzaContratto(DevContrattoDTO c) throws EmailException {
	
	
	HtmlEmail email = new HtmlEmail();
	  email.setHostName("smtps.aruba.it");
		 //email.setDebug(true);
	  email.setAuthentication("calver@accpoint.it", Costanti.PASS_EMAIL_ACC);

email.getMailSession().getProperties().put("mail.smtp.auth", "true");
email.getMailSession().getProperties().put("mail.debug", "true");
email.getMailSession().getProperties().put("mail.smtp.port", "465");
email.getMailSession().getProperties().put("mail.smtp.socketFactory.port", "465");
email.getMailSession().getProperties().put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
email.getMailSession().getProperties().put("mail.smtp.socketFactory.fallback", "false");
email.getMailSession().getProperties().put("mail.smtp.ssl.enable", "true");

DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
Date today = new Date();

	  //email.addTo("giuseppe.gabriele@stisrl.com");
	  //email.addTo("sara.massaro@stisrl.com");
String nominativo = "";

String[] to = c.getEmail_referenti().split(";");


for (String string : to) {
	email.addTo(string);
}
	

	  email.setFrom("calver@accpoint.it", "Calver");
	  File image = new File(Costanti.PATH_FOLDER+"LoghiCompany\\logo_calver_v2.png");
	  String cid = email.embed(image, "Calver logo");
	 
	  email.setSubject("Scadenza software ID: "+c.getId() +" - "+c.getFornitore());
	  
	  String scad = "in scadenza";
	  if(today.equals(c.getData_scadenza())||today.after(c.getData_scadenza())) {
		  scad = "scaduto";
	  }
	   
	  String messaggio = "Si comunica che in data "+df.format(c.getData_scadenza()) +" è "+scad+" il seguente contratto:<br><br>"
	  
			  + c.getFornitore()+" (ID: "+c.getId()+").<br>"
			  +"Si prega di provvedere all'eventuale rinnovo della licenza.<br><br>"
			  ;


	  email.setHtmlMsg(nominativo+messaggio.replaceAll("à", "&agrave;").replaceAll("è", "&egrave;").replaceAll("ì", "&igrave;").replaceAll("ò", "&ograve;").replaceAll("ù", "&ugrave;")
				  
			  		+" <br /> <br /> <img width='250' src=\"cid:"+cid+"\">");


	  email.send();
	
}

public static String sendEmailConsegnaAttestati(ForPartecipanteRuoloCorsoDTO p) throws Exception {
	
	
	 String errore = "";

	 try {

	DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
	
	
	 HtmlEmail email = new HtmlEmail();
	

email.setHostName("mail.vianova.it");

email.setAuthentication("segreteria@crescosrl.net", Costanti.PASS_EMAIL_CRESCO);

email.getMailSession().getProperties().put("mail.smtp.auth", "true");
email.getMailSession().getProperties().put("mail.debug", "true");
email.getMailSession().getProperties().put("mail.smtp.port", "587");
email.getMailSession().getProperties().put("mail.smtp.socketFactory.port", "587");
email.getMailSession().getProperties().put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
email.getMailSession().getProperties().put("mail.smtp.socketFactory.fallback", "true");
email.getMailSession().getProperties().put("mail.smtp.ssl.enable", "false");


if(p.getPartecipante().getEmail()!=null && !p.getPartecipante().getEmail().equals("")) {
	try {
	    InternetAddress emailAddr = new InternetAddress(p.getPartecipante().getEmail());
	    emailAddr.validate(); 
	    email.addTo(p.getPartecipante().getEmail());
	} catch (AddressException ex) {
	    errore = "Indirizzo email non valido per " + p.getPartecipante().getNome() + " " + p.getPartecipante().getCognome();
	    return errore;
	}
}

	
	  email.setFrom("segreteria@crescosrl.net", "CRESCO - Formazione e consulenza Srl");
	

		  email.setSubject("Consegna Attestati di Formazione sulla Sicurezza sul Lavoro");
		  
		  String messaggio = "Gentile "+p.getPartecipante().getNome()+" "+p.getPartecipante().getCognome()+",<br>";
		  messaggio+="Le inviamo in allegato i suoi attestati di formazione sulla sicurezza sul lavoro in formato digitale validi su tutto il territorio nazionale, relativi al corso/i frequentato/i "+p.getCorso().getDescrizione();
		  messaggio +=" in data "+df.format(p.getCorso().getData_corso())+". La preghiamo di conservare con cura questi documenti, in quanto attestano la sua formazione in materia di sicurezza e sono necessari per la sua attivit&agrave; lavorativa. La formazione sulla sicurezza &egrave; fondamentale per garantire un ambiente di lavoro sicuro e prevenire incidenti. <br>";
		  messaggio += "Restiamo a disposizione per eventuali chiarimenti<br><br>";
		  
		  messaggio += FIRMA_CALCE_CRESCO;
		  
		  email.setHtmlMsg("<html>"+messaggio+"</html>");
		  
		  
		  File attestato = new File(Costanti.PATH_FOLDER+"//Formazione//Attestati//"+p.getCorso().getId()+"//"+p.getPartecipante().getId()+"//"+p.getAttestato()); // ← Modifica con il tuo percorso
		    if (attestato.exists()) {
		        EmailAttachment attachment = new EmailAttachment();
		        attachment.setPath(attestato.getAbsolutePath());
		        attachment.setDisposition(EmailAttachment.ATTACHMENT);
		        attachment.setDescription(p.getAttestato());
		        attachment.setName("Attestato_" + p.getPartecipante().getCognome() + ".pdf");

		        email.attach(attachment);
		        
		        email.send();
		    } else {
		        System.err.println("File non trovato: " + attestato.getAbsolutePath());
		        errore = "Attestato non trovato per "+p.getPartecipante().getNome()+" "+ p.getPartecipante().getCognome();
		         
		    }
		  
	  
		    return errore;
		    
	 }catch(Exception e) {
		 e.printStackTrace();
		 errore = "Non è stato possibile inviare la mail a "+p.getPartecipante().getEmail();
		 return errore;
	 }
	
}

public static void sendEmailEfficaciaCorso(ForCorsoDTO corso,ForReferenteDTO referente) throws Exception {
	
	

	DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
	
	
	 HtmlEmail email = new HtmlEmail();
	

email.setHostName("mail.vianova.it");

email.setAuthentication("segreteria@crescosrl.net", Costanti.PASS_EMAIL_CRESCO);

email.getMailSession().getProperties().put("mail.smtp.auth", "true");
email.getMailSession().getProperties().put("mail.debug", "true");
email.getMailSession().getProperties().put("mail.smtp.port", "587");
email.getMailSession().getProperties().put("mail.smtp.socketFactory.port", "587");
email.getMailSession().getProperties().put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
email.getMailSession().getProperties().put("mail.smtp.socketFactory.fallback", "true");
email.getMailSession().getProperties().put("mail.smtp.ssl.enable", "false");

		 email.addTo(referente.getEmail());

		 ArrayList<InternetAddress> lista_cc = new ArrayList<InternetAddress>();
		 InternetAddress cc1 = new InternetAddress("segreteria@crescosrl.net");
		 InternetAddress cc2 = new InternetAddress("lisa.lombardozzi@crescosrl.net");
		 
		 lista_cc.add(cc1);
		 lista_cc.add(cc2);
		 
		 email.setCc(lista_cc);
	
	  email.setFrom("segreteria@crescosrl.net", "CRESCO - Formazione e consulenza Srl");
	

		  email.setSubject("Remind Valutazione Efficacia Corso");
		  
		  String messaggio = "Gentile "+referente.getNome()+" "+referente.getCognome()+",<br>";
		  messaggio+="Le ricordiamo che ha l'obbligo di effettuare la valutazione dell'efficacia del corso "+corso.getDescrizione();
		  messaggio +=" effettuato in data "+df.format(corso.getData_corso())+".<br>";
		  messaggio += "Restiamo a disposizione per eventuali chiarimenti<br><br>";
		  
		  messaggio +=FIRMA_CALCE_CRESCO;
		  
		  email.setHtmlMsg("<html>"+messaggio+"</html>");
		  
		  email.send();
		  	
}

public static boolean inviaEmailRapportoIntervento(RapportoInterventoDTO rapporto) throws Exception {
	
try {
	HtmlEmail email = new HtmlEmail();
	  email.setHostName("smtps.aruba.it");
		 //email.setDebug(true);
	  email.setAuthentication("calver@accpoint.it", Costanti.PASS_EMAIL_ACC);

email.getMailSession().getProperties().put("mail.smtp.auth", "true");
email.getMailSession().getProperties().put("mail.debug", "true");
email.getMailSession().getProperties().put("mail.smtp.port", "465");
email.getMailSession().getProperties().put("mail.smtp.socketFactory.port", "465");
email.getMailSession().getProperties().put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
email.getMailSession().getProperties().put("mail.smtp.socketFactory.fallback", "false");
email.getMailSession().getProperties().put("mail.smtp.ssl.enable", "true");

DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
Date today = new Date();


String nominativo = "";

String[] to = rapporto.getDestinatario_email().replaceAll(" ","").split(";");


for (String string : to) {
	email.addTo(string);
}
	

	  email.setFrom("calver@accpoint.it", "Calver");
	  File image = new File(Costanti.PATH_FOLDER+"LoghiCompany\\logo_calver_v2.png");
	  String cid = email.embed(image, "Calver logo");
	 
	  email.setSubject("Invio Rapporto Intervento");
	  
	   
	  String messaggio = "Si trasmette in allegato il seguente RAPPORTO INTERVENTO: <br><br>"
	  
			  + "ID INTERVENTO: "+rapporto.getIntervento().getId()+".<br>"
			 + "COMMESSA: "+rapporto.getIntervento().getIdCommessa()+".<br>"
			 + "DATA INTERVENTO: "+df.format(rapporto.getIntervento().getDataCreazione())+"<br>"
				+"CLIENTE: "+rapporto.getIntervento().getNome_cliente()+".<br>"
						+"SEDE: "+rapporto.getIntervento().getNome_sede()+".<br>";
			  ;


	  email.setHtmlMsg(messaggio.replaceAll("à", "&agrave;").replaceAll("è", "&egrave;").replaceAll("ì", "&igrave;").replaceAll("ò", "&ograve;").replaceAll("ù", "&ugrave;")
				  
			  		+" <br /> <br /> <img width='250' src=\"cid:"+cid+"\">");

	  
	  File allegato = new File(Costanti.PATH_FOLDER+"\\RapportoIntervento\\"+rapporto.getIntervento().getId()+"\\RAPPORTO_INTERVENTO_"+rapporto.getIntervento().getId()+".pdf"); // <-- qui metti il tuo file
	    EmailAttachment attachment = new EmailAttachment();
	    attachment.setPath(allegato.getAbsolutePath());
	    attachment.setDisposition(EmailAttachment.ATTACHMENT);
	    attachment.setName("RAPPORTO_INTERVENTO_"+rapporto.getIntervento().getId()+".pdf"); 

	    email.attach(attachment);
	
	  email.send();
	  
	  return true;
}catch(Exception e) {
	e.printStackTrace();
	return false;
}
	
}

public static void sendEmailPreavvisoCorso(ForCorsoDTO corso, org.hibernate.Session session) throws EmailException, AddressException {
	DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
	
	
	 HtmlEmail email = new HtmlEmail();
	

email.setHostName("mail.vianova.it");

email.setAuthentication("segreteria@crescosrl.net", Costanti.PASS_EMAIL_CRESCO);

email.getMailSession().getProperties().put("mail.smtp.auth", "true");
email.getMailSession().getProperties().put("mail.debug", "true");
email.getMailSession().getProperties().put("mail.smtp.port", "587");
email.getMailSession().getProperties().put("mail.smtp.socketFactory.port", "587");
email.getMailSession().getProperties().put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
email.getMailSession().getProperties().put("mail.smtp.socketFactory.fallback", "true");
email.getMailSession().getProperties().put("mail.smtp.ssl.enable", "false");

	
		for (String to : corso.getEmail_preavviso().split(";")) {
			if(to!=null && !to.equals("")) {
				email.addTo(to);
			}
			
		}
		

	  email.setFrom("segreteria@crescosrl.net", "CRESCO - Formazione e consulenza Srl");
	 
	  ForPiaPianificazioneDTO p = GestioneFormazioneDAO.getPianificazioneFromCorso(corso.getId(), session);
	  String ore = "";
	  if(p!=null && p.getOra_inizio()!=null && !p.getOra_inizio().equals("")) {
		  ore =" dalle ore: "+p.getOra_inizio()+" alle ore: "+p.getOra_fine();
	  }

		  email.setSubject("Remind Pianificazione Corso "+corso.getDescrizione());
		  
		  String docenti = "";
		  if(corso.getListaDocenti().size()>1) {
			  docenti += "I docenti del corso saranno: ";
			  for (ForDocenteDTO d : corso.getListaDocenti()) {
				docenti += d.getNome() +" "+d.getCognome()+", ";
			}
			  docenti = docenti.substring(0, docenti.length() - 2)+"<br>";
		  }else if(corso.getListaDocenti().size()==1){
			  docenti += "Il docente del corso sar&agrave;: ";
			  for (ForDocenteDTO d : corso.getListaDocenti()) {
					docenti += d.getNome() +" "+d.getCognome()+"<br>";
				}
		  }
		  
		 // String messaggio = "Gentile "+referente.getNome()+" "+referente.getCognome()+",<br>";
		  String messaggio = "Gentile Utente,<br>";
		  messaggio+="Con la presente, vi comunichiamo che in data "+df.format(corso.getData_corso())+ ore+" &egrave; stato pianificato il corso " +corso.getDescrizione()+".<br>";
		  messaggio +=docenti;
		  messaggio += "Nel caso in cui siate impossibilitati ad organizzare il corso, vi chiediamo di informaci tempestivamente per evitare inconvenienti.<br>";
		  messaggio += "Restiamo a disposizione per eventuali chiarimenti<br><br>";

		  messaggio+=FIRMA_CALCE_CRESCO;
		  
		  email.setHtmlMsg("<html>"+messaggio+"</html>");
		  
		  email.send();
}



public static void main(String[] args) throws Exception {
	new ContextListener().configCostantApplication();
	org.hibernate.classic.Session session=SessionFacotryDAO.get().openSession();
	session.beginTransaction();
	ForCorsoDTO corso = GestioneFormazioneBO.getCorsoFromId(2017, session);

//	sendEmailPreavvisoCorso(corso,  session);
	
	
	ForReferenteDTO utente = new ForReferenteDTO();
	utente.setNome("Raffaele");
	utente.setCognome("Fantini");
	utente.setEmail("raffaele.fantini@ncsnetwork.it");
	
	sendEmailEfficaciaCorso(corso,utente);
		session.getTransaction().commit();
		session.close();
		System.out.println("FINITO");
}
}




