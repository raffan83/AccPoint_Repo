package it.portaleSTI.DAO;

import java.time.LocalDate;
import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.PRInterventoRisorsaDTO;
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
		
		Query query = session.createQuery("from PRRisorsaDTO where disabilitato = 0");
		
		lista = (ArrayList<PRRisorsaDTO>) query.list();
		return lista;
	}

	public static ArrayList<PRRequisitoDocumentaleDTO> getListaRequisitiDocumentali(Session session) {
		ArrayList<PRRequisitoDocumentaleDTO> lista = null;
		
		Query query = session.createQuery("from PRRequisitoDocumentaleDTO where disabilitato = 0");
		
		lista = (ArrayList<PRRequisitoDocumentaleDTO>) query.list();
		return lista;
	}

	public static ArrayList<PRRequisitoSanitarioDTO> getListaRequisitiSanitari(Session session) {
		ArrayList<PRRequisitoSanitarioDTO> lista = null;
		
		Query query = session.createQuery("from PRRequisitoSanitarioDTO where disabilitato = 0");
		
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

	public static ArrayList<PRInterventoRisorsaDTO> getListaInterventoRisorseAll(Session session) {
		ArrayList<PRInterventoRisorsaDTO> lista = null;
		
		Query query = session.createQuery("from PRInterventoRisorsaDTO");
		
		lista = (ArrayList<PRInterventoRisorsaDTO>) query.list();
		return lista;
	}

	public static ArrayList<PRInterventoRisorsaDTO> getListaInterventiRisorsa(int id, LocalDate data, Session session) {
	ArrayList<PRInterventoRisorsaDTO> lista = null;
		
		Query query = session.createQuery("from PRInterventoRisorsaDTO as a where a.risorsa.id = :_id_risorsa");
		query.setParameter("_id_risorsa", id);
		
		
		
		lista = (ArrayList<PRInterventoRisorsaDTO>) query.list();
		return lista;
	}
	
	public static ArrayList<PRInterventoRisorsaDTO> getRisorsaIntervento(int id_intervento, LocalDate data, Session session) {
		ArrayList<PRInterventoRisorsaDTO> lista = null;
		
		String str = "from PRInterventoRisorsaDTO as a where a.intervento = :_id_intervento";
		if(data!=null) {
			str+=" and a.data = :_data";
		}
			Query query = session.createQuery(str);
			query.setParameter("_id_intervento", id_intervento);
			if(data!=null) {
				query.setParameter("_data", java.sql.Date.valueOf(data));
			}
			
			lista = (ArrayList<PRInterventoRisorsaDTO>) query.list();
			
		
			return lista;
		}

	public static ArrayList<PRRisorsaDTO> getListaRisorseLibere(LocalDate date, Session session) {

		ArrayList<PRRisorsaDTO> lista = null;
		
			Query query = session.createQuery("from PRRisorsaDTO where id NOT IN (select b.risorsa from PRInterventoRisorsaDTO as b where data = :_data) ");

			query.setParameter("_data", java.sql.Date.valueOf(date));
			
			
			lista = (ArrayList<PRRisorsaDTO>) query.list();
			
			
			return lista;
	}

}
