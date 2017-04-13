package it.portaleSTI.bo;

import it.portaleSTI.DAO.GestioneInterventoDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.InterventoDTO;
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
		
		session.getTransaction().commit();
		session.close();
		
	}

	
	
}
