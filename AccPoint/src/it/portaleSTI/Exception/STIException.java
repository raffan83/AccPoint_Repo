package it.portaleSTI.Exception;


import it.portaleSTI.action.Login;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;

import com.google.gson.JsonObject;

public class STIException {
	
	static final Logger logger = Logger.getLogger(STIException.class);
	 
	//static final Logger logger = Logger.getLogger(STIException.class);
	
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
		
		JsonObject myObj = new JsonObject();
		if(e instanceof NullPointerException) {
			myObj.addProperty("messaggio", "Errore: NullPointerException, comunicaci l'errore facendo click sul pulsante Invia Report");
		}else if(e instanceof NumberFormatException) {
			myObj.addProperty("messaggio", "Errore: NumberFormatException, comunicaci l'errore facendo click sul pulsante Invia Report");
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