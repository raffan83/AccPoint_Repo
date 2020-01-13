package it.portaleSTI.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.ForCorsoAllegatiDTO;
import it.portaleSTI.DTO.ForCorsoCatAllegatiDTO;
import it.portaleSTI.DTO.ForCorsoCatDTO;
import it.portaleSTI.DTO.ForCorsoDTO;
import it.portaleSTI.DTO.ForDocenteDTO;

public class GestioneFormazioneDAO {

	public static ArrayList<ForDocenteDTO> getListaDocenti(Session session) {
		
		ArrayList<ForDocenteDTO> lista = null;
		
		Query query = session.createQuery("from ForDocenteDTO");
		
		lista = (ArrayList<ForDocenteDTO>) query.list();
		
		return lista;
	}

	public static ForDocenteDTO getDocenteFromId(int id_docente, Session session) {
		
		ArrayList<ForDocenteDTO> lista = null;
		ForDocenteDTO result = null;
		
		Query query = session.createQuery("from ForDocenteDTO where id = :_id_docente");
		query.setParameter("_id_docente", id_docente);
		
		lista = (ArrayList<ForDocenteDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static ArrayList<ForCorsoCatDTO> getListaCategorieCorsi(Session session) {
		
		ArrayList<ForCorsoCatDTO> lista = null;
		
		Query query = session.createQuery("from ForCorsoCatDTO");
		
		lista = (ArrayList<ForCorsoCatDTO>) query.list();
		
		return lista;
	}

	public static ForCorsoCatDTO getCategoriaCorsoFromId(int id_categoria, Session session) {
		
		ArrayList<ForCorsoCatDTO> lista = null;
		ForCorsoCatDTO result = null;
		
		Query query = session.createQuery("from ForCorsoCatDTO where id = :_id_categoria");
		query.setParameter("_id_categoria", id_categoria);
		
		lista = (ArrayList<ForCorsoCatDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static ArrayList<ForCorsoDTO> getListaCorsi(Session session) {
		
		ArrayList<ForCorsoDTO> lista = null;
				
		Query query = session.createQuery("from ForCorsoDTO");
				
		lista = (ArrayList<ForCorsoDTO>) query.list();		
			
		return lista;
	}

	public static ForCorsoDTO getCorsoFromId(int id_corso, Session session) {

		ArrayList<ForCorsoDTO> lista = null;
		ForCorsoDTO result = null;
		
		Query query = session.createQuery("from ForCorsoDTO where id = :_id_corso");
		query.setParameter("_id_corso", id_corso);
		
		lista = (ArrayList<ForCorsoDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}


	public static ArrayList<ForCorsoAllegatiDTO>  getAllegatiCorso(int id_corso, Session session) {
		
		ArrayList<ForCorsoAllegatiDTO> lista = null;
		
		Query query = session.createQuery("from ForCorsoAllegatiDTO where corso.id = :_id_corso");
		query.setParameter("_id_corso", id_corso);
				
		lista = (ArrayList<ForCorsoAllegatiDTO>) query.list();		
			
		return lista;
	}

	public static ArrayList<ForCorsoCatAllegatiDTO> getAllegatiCategoria(int id_categoria, Session session) {

		ArrayList<ForCorsoCatAllegatiDTO> lista = null;
		
		Query query = session.createQuery("from ForCorsoCatAllegatiDTO where corso.id = :_id_categoria");
		query.setParameter("_id_categoria", id_categoria);
				
		lista = (ArrayList<ForCorsoCatAllegatiDTO>) query.list();		
			
		return lista;
	}

	public static ForCorsoAllegatiDTO getAllegatoCorsoFormId(int id_allegato, Session session) {

		ArrayList<ForCorsoAllegatiDTO> lista = null;
		ForCorsoAllegatiDTO result = null;
		
		Query query = session.createQuery("from ForCorsoAllegatiDTO where id = :_id_allegato");
		query.setParameter("_id_allegato", id_allegato);
		
		lista = (ArrayList<ForCorsoAllegatiDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}
	
	public static ForCorsoCatAllegatiDTO getAllegatoCategoriaFormId(int id_allegato, Session session) {

		ArrayList<ForCorsoCatAllegatiDTO> lista = null;
		ForCorsoCatAllegatiDTO result = null;
		
		Query query = session.createQuery("from ForCorsoCatAllegatiDTO where id = :_id_allegato");
		query.setParameter("_id_allegato", id_allegato);
		
		lista = (ArrayList<ForCorsoCatAllegatiDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

}
