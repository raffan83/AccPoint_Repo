package it.portaleSTI.action;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import it.portaleSTI.DAO.GestioneMagazzinoDAO;


public class SendEmailPaccoRitardoScheduler implements Job{
	
	
	static final Logger logger = Logger.getLogger(SendEmailPaccoRitardoScheduler.class);
	
	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {

		try {

			GestioneMagazzinoDAO.getItemInRitardo();
			
			logger.debug("Invio email pacchi in ritardo eseguito con successo dallo scheduler di Quartz!");
			logger.error("Invio email pacchi in ritardo eseguito con successo dallo scheduler di Quartz!");
			
			
		} catch (Exception e) {
		
			e.printStackTrace();
		}
		
	}

}