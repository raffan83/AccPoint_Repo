package it.portaleSTI.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.VerAccuratezzaDTO;
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
	


}
