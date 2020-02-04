package it.portaleSTI.DAO;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.AcAttivitaCampioneDTO;
import it.portaleSTI.DTO.ForCorsoAllegatiDTO;
import it.portaleSTI.DTO.ForCorsoCatAllegatiDTO;
import it.portaleSTI.DTO.ForCorsoCatDTO;
import it.portaleSTI.DTO.ForCorsoDTO;
import it.portaleSTI.DTO.ForDocenteDTO;
import it.portaleSTI.DTO.ForPartecipanteDTO;
import it.portaleSTI.DTO.ForPartecipanteRuoloCorsoDTO;
import it.portaleSTI.DTO.ForRuoloDTO;

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

	public static ArrayList<ForPartecipanteDTO> getListaPartecipanti(Session session) {
		
		ArrayList<ForPartecipanteDTO> lista = null;
		
		Query query = session.createQuery("from ForPartecipanteDTO");
				
		lista = (ArrayList<ForPartecipanteDTO>) query.list();
					
		return lista;
	}

	public static ForPartecipanteDTO getPartecipanteFromId(int id_partecipante, Session session) {
		
		ArrayList<ForPartecipanteDTO> lista = null;
		ForPartecipanteDTO result = null;
		
		Query query = session.createQuery("from ForPartecipanteDTO where id = :_id_partecipante");
		query.setParameter("_id_partecipante", id_partecipante);
		
		lista = (ArrayList<ForPartecipanteDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static ArrayList<ForRuoloDTO> getListaRuoli(Session session) {

		ArrayList<ForRuoloDTO> lista = null;
		
		Query query = session.createQuery("from ForRuoloDTO");
				
		lista = (ArrayList<ForRuoloDTO>) query.list();
					
		return lista;
	}

	public static ArrayList<ForPartecipanteRuoloCorsoDTO> getListaPartecipantiCorso(int id_corso, Session session) {

		ArrayList<ForPartecipanteRuoloCorsoDTO> lista = null;
		
		
		Query query = session.createQuery("from ForPartecipanteRuoloCorsoDTO where corso.id = :_id_corso");
		query.setParameter("_id_corso", id_corso);
		
		lista = (ArrayList<ForPartecipanteRuoloCorsoDTO>) query.list();
		
		
		return lista;
	}

	public static ForPartecipanteRuoloCorsoDTO getPartecipanteFromCorso(int id_corso, int id_partecipante,int id_ruolo, Session session) {
		
		ArrayList<ForPartecipanteRuoloCorsoDTO> lista = null;
		ForPartecipanteRuoloCorsoDTO result = null;
		
		Query query = session.createQuery("from ForPartecipanteRuoloCorsoDTO where partecipante.id = :_id_partecipante and corso.id = :_id_corso and ruolo.id = :_id_ruolo");
		query.setParameter("_id_partecipante", id_partecipante);
		query.setParameter("_id_corso", id_corso);
		query.setParameter("_id_ruolo", id_ruolo);
		
		lista = (ArrayList<ForPartecipanteRuoloCorsoDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static ArrayList<ForPartecipanteRuoloCorsoDTO> getListaCorsiFromPartecipante(int id_partecipante, Session session) {

		ArrayList<ForPartecipanteRuoloCorsoDTO> lista = null;
				
		Query query = session.createQuery("from ForPartecipanteRuoloCorsoDTO p where p.partecipante.id = :_id_partecipante");
		query.setParameter("_id_partecipante", id_partecipante);		
		
		lista = (ArrayList<ForPartecipanteRuoloCorsoDTO>) query.list();
		
				
		return lista;
	}

	public static HashMap<String, Integer> getListaScadenzeCorsi(int id_partecipante, Session session) {

		Query query=null;
		
		HashMap<String, Integer> mapScadenze = new HashMap<String, Integer>();
				
		List<ForCorsoDTO> lista =null;
		
		query  = session.createQuery( "select p.corso from ForPartecipanteRuoloCorsoDTO p where p.partecipante.id = :_id_partecipante");	
		query.setParameter("_id_partecipante", id_partecipante);
		
		lista=query.list();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		for (ForCorsoDTO corso: lista) {
			
			int i=1;
			if(mapScadenze.get(sdf.format(corso.getData_scadenza()))!=null) {					
						
				i= mapScadenze.get(sdf.format(corso.getData_scadenza()))+1;
			}
					
			mapScadenze.put(sdf.format(corso.getData_scadenza()), i);
							
		}
		
		return mapScadenze;
	}

	public static ArrayList<ForCorsoDTO> getListaCorsiPartecipanteScadenza(int id_partecipante, String data_scadenza, Session session) throws Exception {		
		
		ArrayList<ForCorsoDTO> lista = null;
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Query query = session.createQuery("select p.corso from ForPartecipanteRuoloCorsoDTO p where p.partecipante.id = :_id_partecipante and p.corso.data_scadenza = :_data_scadenza");
		query.setParameter("_id_partecipante", id_partecipante);
		query.setParameter("_data_scadenza", sdf.parse(data_scadenza));		
		
		lista = (ArrayList<ForCorsoDTO>) query.list();
		
				
		return lista;
		
	}

}
