package it.portaleSTI.bo;



import java.io.File;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.URLDataSource;
import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Multipart;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMultipart;
import javax.servlet.ServletContext;

import org.apache.commons.mail.EmailAttachment;
import org.apache.commons.mail.HtmlEmail;

import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerCertificatoDTO;
import it.portaleSTI.Util.Costanti;
 

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
		  email.setAuthentication("calver@accpoint.it", "7LwqE9w4tu");



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
	
	
public static void sendEmailCertificatoVerificazione(VerCertificatoDTO certificato, String mailTo, ServletContext ctx) throws Exception {
				
		
		String filenameAtt = certificato.getNomeCertificato();
		String filenameRap = certificato.getNomeRapporto();
		String filenameP7m = certificato.getNomeCertificato()+".p7m";
		String pack = certificato.getMisura().getVerIntervento().getNome_pack();
		
		  // Create the attachment
		  EmailAttachment attachment = new EmailAttachment();
		  attachment.setPath(Costanti.PATH_FOLDER+pack+"/"+filenameAtt);
		  attachment.setDisposition(EmailAttachment.ATTACHMENT);
		  attachment.setDescription(certificato.getNomeCertificato());
		  attachment.setName(certificato.getNomeCertificato());
		  
		  
		  EmailAttachment attachmentRap = new EmailAttachment();
		  attachmentRap.setPath(Costanti.PATH_FOLDER+pack+"/Rapporto/"+filenameRap);
		  attachmentRap.setDisposition(EmailAttachment.ATTACHMENT);
		  attachmentRap.setDescription(certificato.getNomeRapporto());
		  attachmentRap.setName(certificato.getNomeRapporto());
		  
		  
		  
		  EmailAttachment attachmentP7m = new EmailAttachment();
		  attachmentP7m.setPath(Costanti.PATH_FOLDER+pack+"/"+filenameP7m);
		  attachmentP7m.setDisposition(EmailAttachment.ATTACHMENT);
		  attachmentP7m.setDescription(certificato.getNomeCertificato()+".p7m");
		  attachmentP7m.setName(certificato.getNomeCertificato()+".p7m");
		  
		  // Create the email message
		  HtmlEmail email = new HtmlEmail();
		  email.setHostName("smtps.aruba.it");
  		 //email.setDebug(true);
		  email.setAuthentication("calver@accpoint.it", "7LwqE9w4tu");



	        email.getMailSession().getProperties().put("mail.smtp.auth", "true");
	        email.getMailSession().getProperties().put("mail.debug", "true");
	        email.getMailSession().getProperties().put("mail.smtp.port", "465");
	        email.getMailSession().getProperties().put("mail.smtp.socketFactory.port", "465");
	        email.getMailSession().getProperties().put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	        email.getMailSession().getProperties().put("mail.smtp.socketFactory.fallback", "false");
	        email.getMailSession().getProperties().put("mail.smtp.ssl.enable", "true");

		  

		  email.addTo(mailTo);
		  email.setFrom("commerciale@stisrl.com", "Calver");
		  email.setSubject("Trasmissione rapporti di verificazione periodica Vs. bilance");
		  

		  File img = new File(Costanti.PATH_FOLDER_LOGHI +"logo_sti_ddt.png");

		  StringBuffer msg = new StringBuffer();
		  msg.append("<html><body>");
		  msg.append("<html>Gentile Cliente, <br /> " + 
		  		"Inviamo in allegato il Rapporto e l'Attestato di verificazione periodica dei Vs. strumenti di misura. <br /> " + 
		  		"Con l'occasione Vi ricordiamo che tale documentazione deve essere conservata, unitamente al libretto metrologico, per tutto il periodo di validit&agrave; della verificazione (tre anni dalla data di svolgimento), ed esibita agli Enti incaricati in occasione delle attivit&agrave; di vigilanza e controllo. <br /> " + 		
		  		" <br />  <br /> <br /></html>");
		  msg.append("<img width='350' src=cid:").append(email.embed(img)).append(">");
	
		  msg.append("</body><small><br><br>In ottemperanza al D.L. n. 196 del 30/6/2003 e Reg. UE n.2016/679 (GDPR) in materia di protezione dei dati personali, le informazioni contenute in questo messaggio sono strettamente confidenziali e riservate ed esclusivamente indirizzate al destinatario indicato (oppure alla persona responsabile di rimetterlo al destinatario). " + 
		  		"Vogliate tener presente che qualsiasi uso, riproduzione o divulgazione di questo messaggio &egrave; vietato. Nel caso in cui aveste ricevuto questo messaggio per errore, vogliate cortesemente avvertire il mittente e distruggere il presente messaggio.<br><br>" + 
		  		"According to Italian law D.L. 196/2003 and Reg. UE n.2016/679 (GDPR)  concerning privacy, if you are not the addressee (or responsible for delivery of the message to such person) you are hereby notified that any disclosure, reproduction, distribution or other dissemination or use of this communication is strictly prohibited. If you have received this message in error, please destroy it and notify us by email.\n" + 
		  		"</small></html>");
		  email.setHtmlMsg(msg.toString());
		  
		  // add the attachment
		  email.attach(attachment);
		  email.attach(attachmentRap);
		  email.attach(attachmentP7m);
		  
		  // send the email
		  email.send();
		  
		  
		  
 	}
	
	

}
