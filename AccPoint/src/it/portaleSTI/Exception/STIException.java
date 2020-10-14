package it.portaleSTI.Exception;


import javax.mail.SendFailedException;

import org.apache.log4j.Logger;
import org.hibernate.exception.ConstraintViolationException;

import com.google.gson.JsonObject;
import com.sun.mail.smtp.SMTPAddressFailedException;

public class STIException extends Exception{
	
	static final Logger logger = Logger.getLogger(STIException.class);
	 
	//static final Logger logger = Logger.getLogger(STIException.class);
	
	public STIException(String string) {
	
		super(string);
	}

	public static String[] callException(Exception ex)
	{
		//logger.debug(ex);
		logger.error( "Fatal - ", ex );
		StackTraceElement[] element=ex.getStackTrace();
		String[] buff= new String[element.length+1];
		buff[0]=ex.toString();
		for(int i=0;i<element.length;i++)
		{
		buff[i+1]=(element[i].getClassName()+"."+element[i].getMethodName()+"("+element[i].getFileName()+":"+element[i].getLineNumber()+")");
		}
		
		return buff;
	}
	
	public static JsonObject getException(Exception e) {
		
		logger.error( "Fatal - ", e );
		JsonObject myObj = new JsonObject();
		if(e instanceof NullPointerException) {
			myObj.addProperty("messaggio", "Errore: NullPointerException, comunicaci l'errore facendo click sul pulsante Invia Report");
		}else if(e instanceof NumberFormatException) {
			myObj.addProperty("messaggio", "Errore: NumberFormatException, comunicaci l'errore facendo click sul pulsante Invia Report");
		}
		else if(e instanceof ConstraintViolationException) {
			myObj.addProperty("messaggio", "Il sitema di caricamento è temporaneamente occupato, riprovare a breve");
		}
		else if(e instanceof SendFailedException && ((SendFailedException) e).getNextException() instanceof SMTPAddressFailedException) {
			myObj.addProperty("messaggio", "Attenzione! Errore sul dominio dell'indirizzo!");
		}
		else if(e instanceof javax.mail.AuthenticationFailedException) 
		{
			myObj.addProperty("messaggio", "Errore invio eMail (Auth-error)");
		}
		else if(e instanceof javax.mail.MessagingException) 
		{
			myObj.addProperty("messaggio", "Errore invio eMail (Messaging-error)");
				
		}else {
			myObj.addProperty("messaggio", "Errore Generico, comunicaci l'errore facendo click sul pulsante Invia Report");
		}
		
		myObj.addProperty("success", false);
		return myObj;
		
	}
	
	public static JsonObject getSuccessMessage(String messaggio) {
		JsonObject myObj = new JsonObject();
		
		myObj.addProperty("messaggio", messaggio);
		myObj.addProperty("success", true);
		
		return myObj;
	}
}