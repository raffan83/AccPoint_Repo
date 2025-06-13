package it.portaleSTI.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.PRRequisitoDocumentaleDTO;
import it.portaleSTI.DTO.PRRequisitoRisorsaDTO;
import it.portaleSTI.DTO.PRRequisitoSanitarioDTO;
import it.portaleSTI.DTO.PRRisorsaDTO;

public class GestioneRisorseDAO {

	public GestioneRisorseDAO() {
		// TODO Auto-generated constructor stub
	}

	public static ArrayList<PRRisorsaDTO> getListaRisorse(Session session) {
		ArrayList<PRRisorsaDTO> lista = null;
		
		Query query = session.createQuery("from PRRisorsaDTO");
		
		lista = (ArrayList<PRRisorsaDTO>) query.list();
		return lista;
	}

	public static ArrayList<PRRequisitoDocumentaleDTO> getListaRequisitiDocumentali(Session session) {
		ArrayList<PRRequisitoDocumentaleDTO> lista = null;
		
		Query query = session.createQuery("from PRRequisitoDocumentaleDTO");
		
		lista = (ArrayList<PRRequisitoDocumentaleDTO>) query.list();
		return lista;
	}

	public static ArrayList<PRRequisitoSanitarioDTO> getListaRequisitiSanitari(Session session) {
		ArrayList<PRRequisitoSanitarioDTO> lista = null;
		
		Query query = session.createQuery("from PRRequisitoSanitarioDTO");
		
		lista = (ArrayList<PRRequisitoSanitarioDTO>) query.list();
		return lista;
	}

	public static ArrayList<PRRequisitoRisorsaDTO> getListaRequisitiRisorsa(int id, Session session) {
		ArrayList<PRRequisitoRisorsaDTO> lista = null;
		
		Query query = session.createQuery("from PRRequisitoRisorsaDTO where id_pr_risorsa =:_id");
		query.setParameter("_id", id);
		
		lista = (ArrayList<PRRequisitoRisorsaDTO>) query.list();
		return lista;
	}

}
