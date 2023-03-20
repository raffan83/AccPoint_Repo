package it.portaleSTI.action;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import it.portaleSTI.bo.GestioneControlliOperativiBO;
import it.portaleSTI.bo.GestioneDeviceBO;

public class SendEmailControlliOperativi implements Job{
	
	static final Logger logger = Logger.getLogger(SendEmailControlliOperativi.class);

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		
		
	try {
			GestioneControlliOperativiBO.aggiornaStatoControlli();
			GestioneControlliOperativiBO.sendEmailControlliOperativi();
			
			
			logger.error("Invio email controlli operativi eseguito con successo dallo scheduler di Quartz!");
			
			
		} catch (Exception e) {
		
			e.printStackTrace();
		}
		
	}

}
