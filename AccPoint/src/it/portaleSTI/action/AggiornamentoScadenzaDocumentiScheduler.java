package it.portaleSTI.action;

import org.apache.log4j.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import it.portaleSTI.DAO.GestioneDocumentaleDAO;
import it.portaleSTI.bo.SendEmailBO;


public class AggiornamentoScadenzaDocumentiScheduler implements Job{

static final Logger logger = Logger.getLogger(AggiornamentoScadenzaDocumentiScheduler.class);
	
	
	public void execute(JobExecutionContext arg0) throws JobExecutionException {

		try {

			GestioneDocumentaleDAO.AggiornamentoStatoDocumenti();
			SendEmailBO.sendEmailDocumentiInScadenza();
			
			logger.error("Aggiornamento stato documenti eseguito con successo dallo scheduler di Quartz!");
			
			
		} catch (Exception e) {
		
			e.printStackTrace();
		}
		
	}
	
	
}
