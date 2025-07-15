package it.portaleSTI.action;

import javax.servlet.http.HttpServlet;

import org.apache.log4j.Logger;
import org.apache.tomcat.util.net.URL;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import it.portaleSTI.bo.GestioneFormazioneBO;
import it.portaleSTI.bo.SendEmailBO;



public class SendEmailFormazione  implements Job {
	
	static final public Logger logger = Logger.getLogger(SendEmailFormazione.class);

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		
		
	try {
		java.net.URL resource = getClass().getResource("/");
		String path = resource.getPath();	
		
			//GestioneFormazioneBO.sendEmailCorsiInScadenza(path);
			//GestioneFormazioneBO.sendEmailAttestatiNonConsegnati(path);
			//GestioneFormazioneBO.sendEmailCorsiNonCompleti(path);	
			GestioneFormazioneBO.sendEmailValutazioneEfficacia(path);
		
		
			logger.error("Invio email corsi in scadenza eseguito con successo dallo scheduler di Quartz!");
			
			
		} catch (Exception e) {
		
			logger.error(e);
			e.printStackTrace();
		}
		
	}

}
