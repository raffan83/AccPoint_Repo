package it.portaleSTI.action;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.Exception.STIException;


public class AggiornaCampioneScheduler implements Job{
	static final Logger logger = Logger.getLogger(STIException.class);
	
	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {

		try {
			DirectMySqlDAO.updateStatoCampioneScheduler();
			logger.debug("Aggiornamento Stato Campione eseguito con successo dallo scheduler di Quartz!");
			logger.error("Aggiornamento Stato Campione eseguito con successo dallo scheduler di Quartz!");
			System.out.println("Aggiornamento Stato Campione eseguito con successo dallo scheduler di Quartz!");
			
			
		} catch (Exception e) {
		
			e.printStackTrace();
		}
		
	}
	
	

}
