package it.portaleSTI.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerAccuratezzaDTO;
import it.portaleSTI.DTO.VerCodiceDocumentoDTO;
import it.portaleSTI.DTO.VerDecentramentoDTO;
import it.portaleSTI.DTO.VerLinearitaDTO;
import it.portaleSTI.DTO.VerMisuraDTO;
import it.portaleSTI.DTO.VerMobilitaDTO;
import it.portaleSTI.DTO.VerRipetibilitaDTO;

public class GestioneVerMisuraDAO {

	public static VerMisuraDTO getMisuraFromId(int id_misura, Session session) {
		
		ArrayList<VerMisuraDTO> lista = null;
		VerMisuraDTO result = null;
		
		Query query = session.createQuery("from VerMisuraDTO where id = :_id_misura");
		query.setParameter("_id_misura", id_misura);
		
		lista = (ArrayList<VerMisuraDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static ArrayList<VerRipetibilitaDTO> getListaRipetibilita(int id_misura, Session session) {
		
		ArrayList<VerRipetibilitaDTO> lista = null;
				
		Query query = session.createQuery("from VerRipetibilitaDTO where idMisura = :_id_misura");
		query.setParameter("_id_misura", id_misura);
		
		lista = (ArrayList<VerRipetibilitaDTO>) query.list();
		
		return lista;
	}

	public static ArrayList<VerDecentramentoDTO> getListaDecentramento(int id_misura, Session session) {

		ArrayList<VerDecentramentoDTO> lista = null;
		
		Query query = session.createQuery("from VerDecentramentoDTO where idMisura = :_id_misura");
		query.setParameter("_id_misura", id_misura);
		
		lista = (ArrayList<VerDecentramentoDTO>) query.list();
		
		return lista;
	}

	public static ArrayList<VerLinearitaDTO> getListaLinearita(int id_misura, Session session) {
		
		ArrayList<VerLinearitaDTO> lista = null;
		
		Query query = session.createQuery("from VerLinearitaDTO where idMisura = :_id_misura");
		query.setParameter("_id_misura", id_misura);
		
		lista = (ArrayList<VerLinearitaDTO>) query.list();
		
		return lista;
	}

	public static ArrayList<VerAccuratezzaDTO> getListaAccuratezza(int id_misura, Session session) {

		ArrayList<VerAccuratezzaDTO> lista = null;
		
		Query query = session.createQuery("from VerAccuratezzaDTO where idMisura = :_id_misura");
		query.setParameter("_id_misura", id_misura);
		
		lista = (ArrayList<VerAccuratezzaDTO>) query.list();
		
		return lista;
	}

	public static ArrayList<VerMobilitaDTO> getListaMobilita(int id_misura, Session session) {
		
		ArrayList<VerMobilitaDTO> lista = null;
		
		Query query = session.createQuery("from VerMobilitaDTO where idMisura = :_id_misura");
		query.setParameter("_id_misura", id_misura);
		
		lista = (ArrayList<VerMobilitaDTO>) query.list();
		
		return lista;
	}

	public static ArrayList<VerMisuraDTO> getListaMisure(UtenteDTO utente,Session session) {

		ArrayList<VerMisuraDTO> lista = null;
		
		Query query = null;
		
		if(utente.isTras()) {
			
			query = session.createQuery("from VerMisuraDTO"); 
		}else {
			query = session.createQuery("from VerMisuraDTO where verIntervento.id_company = :_id_company");
			query.setParameter("_id_company", utente.getCompany().getId());
		}
				
		lista = (ArrayList<VerMisuraDTO>) query.list();
		
		return lista;
	}

	public static VerCodiceDocumentoDTO getCodiceDocumento(int id_utente, String id_famiglia, Session session) {
		
		ArrayList<VerCodiceDocumentoDTO> lista = null;
		VerCodiceDocumentoDTO result = null;
		
		Query query = session.createQuery("from VerCodiceDocumentoDTO where id_user = :_id_utente and codice_famiglia = :_id_famiglia");
		query.setParameter("_id_utente", id_utente);
		query.setParameter("_id_famiglia", id_famiglia);
		
		lista = (ArrayList<VerCodiceDocumentoDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}
	


}
