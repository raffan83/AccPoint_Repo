package it.portaleSTI.action;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import it.portaleSTI.DAO.DirectMySqlDAO;


public class AggiornaCampioneScheduler implements Job{

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {

		try {
			DirectMySqlDAO.updateStatoCampioneScheduler();
			System.out.println("Aggiornamento Stato Campione eseguito con successo dallo scheduler di Quartz!");
			
		} catch (Exception e) {
		
			e.printStackTrace();
		}
		
	}
	
	

}
