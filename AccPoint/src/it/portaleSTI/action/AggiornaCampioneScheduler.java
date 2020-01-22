package it.portaleSTI.action;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.GestioneCampionamentoDAO;
import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.GestioneMagazzinoDAO;
import it.portaleSTI.DAO.GestioneStrumentoDAO;
import it.portaleSTI.DTO.InterventoDTO;


public class AggiornaCampioneScheduler implements Job{
	static final Logger logger = Logger.getLogger(AggiornaCampioneScheduler.class);
	
	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {

		try {
			DirectMySqlDAO.updateStatoCampioneScheduler();
			InterventoDTO intervento=  new InterventoDTO();
			intervento.setId(100);
			GestioneStrumentoDAO.getListaStrumentiIntervento(intervento);
			GestioneCampioneDAO.updateCampioneScheduler();
			GestioneMagazzinoDAO.getItemInRitardo();
			logger.debug("Aggiornamento Stato Campione eseguito con successo dallo scheduler di Quartz!");
			logger.error("Aggiornamento Stato Campione eseguito con successo dallo scheduler di Quartz!");
			
			
		} catch (Exception e) {
		
			e.printStackTrace();
		}
		
	}
	
	

}
