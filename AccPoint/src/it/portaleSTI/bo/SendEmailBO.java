package it.portaleSTI.bo;



import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Properties;
import java.util.Set;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.ServletContext;

import org.apache.commons.mail.EmailAttachment;
import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.apache.log4j.Logger;

import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.ConsegnaDpiDTO;
import it.portaleSTI.DTO.DevRegistroAttivitaDTO;
import it.portaleSTI.DTO.DocumTLDocumentoDTO;
import it.portaleSTI.DTO.DpiDTO;
import it.portaleSTI.DTO.ForCorsoDTO;
import it.portaleSTI.DTO.ForDocenteDTO;
import it.portaleSTI.DTO.ForPiaPianificazioneDTO;
import it.portaleSTI.DTO.ForReferenteDTO;
import it.portaleSTI.DTO.GPDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.VerCertificatoDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;


public class SendEmailBO {
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
			  msg.append("<a href='www.stisrl.com'><img width='350' src=\"cid:image1\"></a>");
			  msg.append("<a href='www.stisrl.com/servizi/piattaforma-calver'> <img width='350' src=\"cid:image2\"></a>");
		
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
	  		"Si comunica la presenza in magazzino dei seguenti pacchi in attesa di lavorazione:<br />");
	  
	  for (String origine : lista_string_origini) {
		msg.append("- "+origine.split(";")[0]+" - "+origine.split(";")[1]);
		
		if(origine.split(";").length>2) {
			if(!origine.split(";")[2].equals("")) {
				msg.append(" - Commessa: "+origine.split(";")[2]);
			}
			if(origine.split(";").length>3) {
				
				msg.append(" - " + origine.split(";")[3]+"<br>");
			}else {
				msg.append("<br>");
			}
		}else {
			msg.append("<br>");
		}
	  }
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
			  		+ "http://portale.ecisrl.it/FormInputDoc/index.jsp?id_documento="+Utility.encryptData(documento.getId()+"")
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

	  File image = new File(ctx.getRealPath("images/calver_cresco.png"));
	  String cid = email.embed(image, "Calver logo");

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
			  	
			  		+" <br /><a href='https://www.crescosrl.net/wp-content/uploads/2020/09/CALVER_SOFTWARE_FORMAZIONE_Rev.0.pdf'> <img width='450' src=\"cid:"+cid+"\"><a><br>"
			  		
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
				  +"TIPO: "+consegna.getDpi().getTipo().getDescrizione()
				  +"<br>DESCRIZIONE: "+consegna.getDpi().getDescrizione()
				  +"<br>MODELLO: " +consegna.getDpi().getModello()
				  //+"<br><br>http://portale.ecisrl.it/FormInputDoc/accettazioneDpi.jsp?id_consegna="+Utility.encryptData(""+consegna.getId())
				  +"<br><br><a class='btn btn-primary' href='http://portale.ecisrl.it/FormInputDoc/accettazioneDpi.jsp?id_consegna="+Utility.encryptData(""+consegna.getId())+"'> Clicca qui per accettare la consegna</a>"
				  
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
				  +"TIPO: "+consegna.getDpi().getTipo().getDescrizione()
				  +"<br>DESCRIZIONE: "+consegna.getDpi().getDescrizione()
				  +"<br>MODELLO: " +consegna.getDpi().getModello()
				  +"<br>MOTIVAZIONE: "+consegna.getRestituzione().getMotivazione()
				  +"<br><br><a class='btn btn-primary' href='http://portale.ecisrl.it/FormInputDoc/accettazioneDpi.jsp?id_consegna="+Utility.encryptData(""+consegna.getId())+"&id_riconsegna="+Utility.encryptData(""+consegna.getRestituzione().getId())+"'> Clicca qui per confermare la riconsegna</a>"
				  
				  
			  		+" <br /> <br /> <img width='250' src=\"cid:"+cid+"\">");
			  		//+ " <br /> <br /> <img width=\"200\" src=\""+Costanti.PATH_FOLDER_LOGHI +"\\sito_calver.png"+" \"></html>");


	  email.send();
}

public static void sendEmailAperturaChiusuraIntevento(String apertura_chiusura,ServletContext ctx, InterventoDTO intervento) throws Exception {
	
	
	
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
	  email.setFrom("calver@accpoint.it", "Calver");
	  File image = new File(ctx.getRealPath("images/logo_calver_v2.png"));
	  String cid = email.embed(image, "Calver logo");
	  if(apertura_chiusura.equals("A")) {
		  email.setSubject("Apertura intervento ID: "+intervento.getId());
		  
		  email.setHtmlMsg("<html>Si comunica l'apertura del seguente intervento:<br><br>"
			  	  	+"ID: "+intervento.getId()
					  +"<br>COMMESSA: "+intervento.getIdCommessa()
					  +"<br>CLIENTE: "+intervento.getNome_cliente()
					  +"<br>SEDE: " +intervento.getNome_sede()
					  +"<br>RESPONSABILE: "+intervento.getUser().getNominativo()					 
					  +"<br>DATA APERTURA: "+df.format(new Date())
					  
				  		+" <br /> <br /> <img width='250' src=\"cid:"+cid+"\">");
		  
		  
	  }else{
		  email.setSubject("Chiusura intervento ID: "+intervento.getId());
		  email.setHtmlMsg("<html>Si comunica la chiusura del seguente intervento:<br><br>"
			  	  	+"ID: "+intervento.getId()+""
					  +"<br>COMMESSA: "+intervento.getIdCommessa()
					  +"<br>CLIENTE: "+intervento.getNome_cliente()
					  +"<br>SEDE: " +intervento.getNome_sede()
					  +"<br>RESPONSABILE: "+intervento.getUser().getNominativo()
					  +"<br>DATA CHIUSURA: "+df.format(new Date())
					  
					  
					  
				  		+" <br /> <br /> <img width='250' src=\"cid:"+cid+"\">");
		  
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
//if(attivita.getDevice().getDipendente()!=null && attivita.getDevice().getDipendente().getEmail()!=null && !attivita.getDevice().getDipendente().getEmail().equals("")) {
//	email.addTo(attivita.getDevice().getDipendente().getEmail());
//	nominativo = "Gentile "+attivita.getDevice().getDipendente().getNome()+" "+attivita.getDevice().getDipendente().getCognome()+" <br>";
//}

String[] to = referenti.split(";");

for (String string : to) {
	email.addTo(string);
}
	

	  email.setFrom("calver@accpoint.it", "Calver");
	  File image = new File(Costanti.PATH_FOLDER+"LoghiCompany\\logo_calver_v2.png");
	  String cid = email.embed(image, "Calver logo");
	 
	  email.setSubject("Attività programmata sul device "+attivita.getDevice().getDenominazione() +"(ID: "+attivita.getDevice().getId()+")");
	   
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
				messaggio += "TIPO DPI: " + dpi.getTipo().getDescrizione()+" - ";
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


	//email.addTo("giuseppe.gabriele@stisrl.com");
	
	
	for(ForReferenteDTO referente : corso.getListaReferenti()) {
		if(referente.getEmail()!=null && !referente.getEmail().equals("")) {
			email.addTo(referente.getEmail());
		}
	}
	email.addTo("lisa.lombardozzi@crescosrl.net");
	email.addTo("segreteria@crescosrl.net");
		  
		  email.setFrom("calver@accpoint.it", "CRESCO - Formazione e consulenza Srl");
		

			  email.setSubject("SCADENZE CORSI OBBLIGATORI");
			  
			  File image = new File(path.replace("WEB-INF/classes", "")+"/images/calver_cresco.png");
			  String cid = email.embed(image, "Calver logo");
			  
			  messaggio += "<font size='2'>La presente e-mail &egrave; stata generata automaticamente da un indirizzo di posta elettronica di solo invio; si chiede pertanto di non rispondere al messaggio. <br>";
			  messaggio += "Per qualsiasi informazione si prega di contattare CRESCO Formazione e Consulenza Srl all'indirizzo </em>segreteria@crescosrl.net o ai numeri 0776/1815104 - 0776/1815115</font><br><br><br>";
			  
			  messaggio += "<em><b>CRESCO Formazione e Consulenza Srl</b></em> <br>"+
					
						"<em></b><br>Via Tofaro 42, E - 03039 Sora (FR)<br>" + 
						"Tel int. +39 0776.1815115 - Fax +39 0776.814169</em> <br> "
						+ "Web: </em>www.crescosrl.net<br>" 
						+ "Mail: </em>segreteria@crescosrl.net<br>" + 
				
						"<br/></html>"
			  	
			  		+" <br /><a href='https://www.crescosrl.net/wp-content/uploads/2020/09/CALVER_SOFTWARE_FORMAZIONE_Rev.0.pdf'> <img width='450' src=\"cid:"+cid+"\"><a><br>" ;
		
			
			  
			  email.setHtmlMsg("<html>"
					  	 +messaggio+"</html>");
			  
		  email.send();
	}

public static void sendEmailPianificazione(ForPiaPianificazioneDTO pianificazione,  ServletContext ctx) throws EmailException {

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


	//email.addTo("giuseppe.gabriele@stisrl.com");
	
	
	for(ForDocenteDTO docente : pianificazione.getListaDocenti()) {
		if(docente.getEmail()!=null && !docente.getEmail().equals("")) {
			email.addTo(docente.getEmail());
		}
	}
	email.addTo("lisa.lombardozzi@crescosrl.net");
	email.addTo("segreteria@crescosrl.net");
	String messaggio = null;
	if(pianificazione.getOra_inizio()!=null && !pianificazione.getOra_inizio().equals("")) {
		messaggio = "Si comunica che &egrave; stata effettuata la seguente pianificazione corso per il "+df.format(pianificazione.getData())+" dalle ore "+pianificazione.getOra_inizio()+" per la commessa "+pianificazione.getId_commessa()+": <br><br>";
		if(pianificazione.getOra_fine()!=null && !pianificazione.getOra_fine().equals("")) {
			messaggio = "Si comunica che &egrave; stata effettuata la seguente pianificazione corso per il "+df.format(pianificazione.getData())+" dalle ore "+pianificazione.getOra_inizio()+ " alle ore " +pianificazione.getOra_fine() +" per la commessa "+pianificazione.getId_commessa()+": <br><br>";
		}
	}else {
		messaggio = "Si comunica che &egrave; stata effettuata la seguente pianificazione corso per il "+df.format(pianificazione.getData())+" per la commessa "+pianificazione.getId_commessa()+": <br><br>";
	}
	
	
		  
		  email.setFrom("calver@accpoint.it", "CRESCO - Formazione e consulenza Srl");
		

			  email.setSubject("PIANIFICAZIONE CORSO - DATA "+df.format(pianificazione.getData()));
			  
			  File image = new File(ctx.getRealPath("images/calver_cresco.png"));
			  String cid = email.embed(image, "Calver logo");
			  
			  messaggio += pianificazione.getNote().replaceAll("à", "&agrave;").replaceAll("è", "&egrave;").replaceAll("ì", "&igrave;").replaceAll("ò", "&ograve;").replaceAll("ù", "&ugrave;");
			  
			  
			  messaggio += "<br><br><font size='2'>La presente e-mail &egrave; stata generata automaticamente da un indirizzo di posta elettronica di solo invio; si chiede pertanto di non rispondere al messaggio. <br>";
			  messaggio += "Per qualsiasi informazione si prega di contattare CRESCO Formazione e Consulenza Srl all'indirizzo </em>segreteria@crescosrl.net o ai numeri 0776/1815104 - 0776/1815115</font><br><br><br>";
			  
			  messaggio += "<em><b>CRESCO Formazione e Consulenza Srl</b></em> <br>"+
					
						"<em></b><br>Via Tofaro 42, E - 03039 Sora (FR)<br>" + 
						"Tel int. +39 0776.1815115 - Fax +39 0776.814169</em> <br> "
						+ "Web: </em>www.crescosrl.net<br>" 
						+ "Mail: </em>segreteria@crescosrl.net<br>" + 
				
						"<br/></html>"
			  	
			  		+" <br /><a href='https://www.crescosrl.net/wp-content/uploads/2020/09/CALVER_SOFTWARE_FORMAZIONE_Rev.0.pdf'> <img width='450' src=\"cid:"+cid+"\"><a><br>" ;
		
			
			  
			  email.setHtmlMsg("<html>"
					  	 +messaggio+"</html>");
			  
		  email.send();
	
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
		  
		  email.setFrom("calver@accpoint.it", "CRESCO - Formazione e consulenza Srl");
		

			  email.setSubject("CORSI FATTURATI SENZA ATTESTATI");
			  
			  File image = new File(path.replace("WEB-INF/classes", "")+"/images/calver_cresco.png");
			  String cid = email.embed(image, "Calver logo");
			  
			  messaggio += "<br><br><font size='2'>La presente e-mail &egrave; stata generata automaticamente da un indirizzo di posta elettronica di solo invio; si chiede pertanto di non rispondere al messaggio. <br>";
			  messaggio += "Per qualsiasi informazione si prega di contattare CRESCO Formazione e Consulenza Srl all'indirizzo </em>segreteria@crescosrl.net o ai numeri 0776/1815104 - 0776/1815115</font><br><br><br>";
			  
			  messaggio += "<em><b>CRESCO Formazione e Consulenza Srl</b></em> <br>"+
					
						"<em></b><br>Via Tofaro 42, E - 03039 Sora (FR)<br>" + 
						"Tel int. +39 0776.1815115 - Fax +39 0776.814169</em> <br> "
						+ "Web: </em>www.crescosrl.net<br>" 
						+ "Mail: </em>segreteria@crescosrl.net<br>" + 
				
						"<br/></html>"
			  	
			  		+" <br /><a href='https://www.crescosrl.net/wp-content/uploads/2020/09/CALVER_SOFTWARE_FORMAZIONE_Rev.0.pdf'> <img width='450' src=\"cid:"+cid+"\"><a><br>" ;
		
			
			  
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
			  
			  File image = new File(ctx.getRealPath("images/calver_cresco.png"));
			  String cid = email.embed(image, "Calver logo");
			  
			  String messaggio = "Si comunica che la pianificazione corso del "+ df.format(pianificazione.getData()) +" della  Commessa: "+pianificazione.getId_commessa()+" &egrave; stata eliminata.";
			  
			  messaggio += "<br><br><font size='2'>La presente e-mail &egrave; stata generata automaticamente da un indirizzo di posta elettronica di solo invio; si chiede pertanto di non rispondere al messaggio. <br>";
			  messaggio += "Per qualsiasi informazione si prega di contattare CRESCO Formazione e Consulenza Srl all'indirizzo </em>segreteria@crescosrl.net o ai numeri 0776/1815104 - 0776/1815115</font><br><br><br>";
			  
			  messaggio += "<em><b>CRESCO Formazione e Consulenza Srl</b></em> <br>"+
					
						"<em></b><br>Via Tofaro 42, E - 03039 Sora (FR)<br>" + 
						"Tel int. +39 0776.1815115 - Fax +39 0776.814169</em> <br> "
						+ "Web: </em>www.crescosrl.net<br>" 
						+ "Mail: </em>segreteria@crescosrl.net<br>" + 
				
						"<br/></html>"
			  	
			  		+" <br /><a href='https://www.crescosrl.net/wp-content/uploads/2020/09/CALVER_SOFTWARE_FORMAZIONE_Rev.0.pdf'> <img width='450' src=\"cid:"+cid+"\"><a><br>" ;
		
			
			  
			  email.setHtmlMsg("<html>"
					  	 +messaggio+"</html>");
			  
		  email.send();
	
}
	


	

}




