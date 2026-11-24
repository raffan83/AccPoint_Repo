package it.portaleSTI.action;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.quartz.ExecuteInJTATransaction;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import it.portaleSTI.DAO.GestioneAM_DAO;
import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.GestioneStrumentoDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.SpedizioneDTO;
import it.portaleSTI.DTO.StatoSpedizioneDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.bo.GestioneFormazioneBO;
import it.portaleSTI.bo.GestioneSpedizioneBO;

public class AggiornaStatoSpedizioni implements Job {
	
	static final public Logger logger = Logger.getLogger(AggiornaStatoSpedizioni.class);

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		  Session session = null;

     
		try {
			  session = SessionFacotryDAO.get().openSession(); 
				session.beginTransaction();
		ArrayList<SpedizioneDTO> lista_spedizioni = (ArrayList<SpedizioneDTO>) GestioneSpedizioneBO.getListaSpedizioni(session);
		
		 Path caPem = Paths.get(Costanti.PATH_FOLDER_CERT, "sti-erp-api-ca.crt");
		  
		List<Integer> spedizione_errate = new ArrayList<>();
		
		for(SpedizioneDTO spedizione : lista_spedizioni) {
			 String risp = GestioneSpedizioneBO.send(spedizione, Costanti.URL_STI_ETICHETTA, Costanti.TOKEN_API_ETICHETTA, caPem, "stato_spedizione");
			   
			   JsonObject risposta = new JsonParser().parse(risp).getAsJsonObject();
			   JsonElement campoStato = risposta.get("stato");

			   String stato = campoStato != null && !campoStato.isJsonNull()
			           ? campoStato.getAsString()
			           : null;
			           
			           Integer idNuovoStato = null;

			
			           if ("consegnato".equals(stato)) {
			               idNuovoStato = 4;
			           } else if ("in_corso".equals(stato)) {
			               idNuovoStato = 1;
			           } else if ("annullato".equals(stato)) {
			               idNuovoStato = 6;
			           }  else if ("annullato".equals(stato)) {
			               idNuovoStato = 6;
			           } else {
			        	   idNuovoStato = 7;
			           }
			           
			           if (idNuovoStato == null || idNuovoStato ==7) {
			        	    logger.warn("Stato non riconosciuto per la spedizione "
			        	            + spedizione.getId() + ": " + stato);
			        	    spedizione_errate.add(spedizione.getId());
			        	    continue;
			        	}
	
			               StatoSpedizioneDTO statoAttuale = spedizione.getStato();
			               boolean cambiato = statoAttuale == null
			                       || !idNuovoStato.equals(statoAttuale.getId());

			               if (cambiato) {
			                   StatoSpedizioneDTO nuovoStato = (StatoSpedizioneDTO)
			                           session.get(StatoSpedizioneDTO.class, idNuovoStato);

			                   if (nuovoStato == null) {
			                	    logger.error("Stato spedizione non trovato: " + idNuovoStato);
			                	    spedizione_errate.add(spedizione.getId());
			                	    continue;
			                	}

			                   spedizione.setStato(nuovoStato);
			                   GestioneSpedizioneBO.updateSpedizone(spedizione, session);
			               }
			               if(spedizione_errate.size()!=0) {
			            	   logger.error("Attenzione, trovati " + spedizione_errate.size() + " errate" );
			            	
			               }

			           
		}
		
			
			session.getTransaction().commit();
			 logger.error("Aggiornamento stato spedizioni completato.");
			
		
		  } catch (Exception e) {
		        try {
		            if (session != null && session.getTransaction().isActive()) {
		                session.getTransaction().rollback();
		            }
		        } catch (RuntimeException erroreRollback) {
		            e.addSuppressed(erroreRollback);
		        }

		        throw new JobExecutionException("Errore durante l'aggiornamento delle spedizioni", e);
		    } finally {
		        if (session != null && session.isOpen()) {
		            session.close();
		        }
		    }
	}
}
		