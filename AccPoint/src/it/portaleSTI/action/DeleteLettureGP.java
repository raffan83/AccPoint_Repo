package it.portaleSTI.action;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import it.portaleSTI.DAO.GestioneGreenPassDAO;


public class DeleteLettureGP implements Job{
	
	static final Logger logger = Logger.getLogger(DeleteLettureGP.class);
	
	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {

		try {
			GestioneGreenPassDAO.deleteLettureGP();
			//GestioneMagazzinoDAO.getItemInRitardo();
			logger.debug("Cancellazione letture Green Pass eseguita con successo dallo scheduler di Quartz!");
			logger.error("Cancellazione letture Green Pass eseguita con successo dallo scheduler di Quartz!");
			
			
		} catch (Exception e) {
		
			e.printStackTrace();
		}
		
	}

}
