package it.portaleSTI.action;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import it.portaleSTI.bo.GestioneDeviceBO;



public class SendEmailDeviceScheduler implements Job{

	static final Logger logger = Logger.getLogger(SendEmailDeviceScheduler.class);
	
	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {

		try {
			GestioneDeviceBO.sendEmailAttivitaScadute();
			GestioneDeviceBO.sendEmailAttivitaScaduteSollecito();
			
			
			
			logger.error("Invio email device eseguito con successo dallo scheduler di Quartz!");
			
			
		} catch (Exception e) {
		
			e.printStackTrace();
		}
		
	}
	

}
