package it.portaleSTI.action;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import it.portaleSTI.DAO.GestioneDpiDAO;
import it.portaleSTI.bo.GestioneDpiBO;


public class SendEmailScadenzaDPI implements Job{

	
	
	static final Logger logger = Logger.getLogger(SendEmailScadenzaDPI.class);
	
	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {

		try {

			GestioneDpiBO.sendEmailDpiScadenza();
			
			logger.debug("Invio email dpi in scadenza eseguito con successo dallo scheduler di Quartz!");
			logger.error("Invio email dpi in scadenza eseguito con successo dallo scheduler di Quartz!");
			
			
		} catch (Exception e) {
		
			e.printStackTrace();
		}
		
	}
	
}
