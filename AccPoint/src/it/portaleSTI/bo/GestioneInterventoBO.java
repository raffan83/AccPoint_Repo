package it.portaleSTI.bo;

import it.portaleSTI.DAO.GestioneInterventoDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.InterventoDatiDTO;
import it.portaleSTI.DTO.StatoPackDTO;

import java.util.ArrayList;


import org.hibernate.Session;



public class GestioneInterventoBO {

	public static ArrayList<InterventoDTO> getListaInterventi(String idCommessa) throws Exception {
		
		
		return GestioneInterventoDAO.getListaInterventi(idCommessa);
	}

	public static void save(InterventoDTO intervento) {
		
	Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
		session.save(intervento);
		
		InterventoDatiDTO intDati = new InterventoDatiDTO();
		intDati.setId_intervento(intervento.getId());
		intDati.setDataCreazione(intervento.getDataCreazione());
		intDati.setNomePack(intervento.getNomePack());
		intDati.setNumStrMis(0);
		intDati.setNumStrNuovi(0);
		intDati.setStato(new StatoPackDTO(1));
		intDati.setUtente(intervento.getUser());
		session.save(intDati);
		
		session.getTransaction().commit();
		session.close();
		
	}

	
	
}
