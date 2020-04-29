package it.portaleSTI.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.VerAllegatoStrumentoDTO;
import it.portaleSTI.DTO.VerFamigliaStrumentoDTO;
import it.portaleSTI.DTO.VerInterventoStrumentiDTO;
import it.portaleSTI.DTO.VerStrumentoDTO;
import it.portaleSTI.DTO.VerTipoStrumentoDTO;
import it.portaleSTI.DTO.VerTipologiaStrumentoDTO;

public class GestioneVerStrumentiDAO {

	public static ArrayList<VerStrumentoDTO> getListaStrumenti(Session session) {
		
		ArrayList<VerStrumentoDTO> lista = null;
		
		Query query = session.createQuery("from VerStrumentoDTO");
		
		lista = (ArrayList<VerStrumentoDTO>) query.list();
		
		return lista;
	}

	public static ArrayList<VerTipoStrumentoDTO> getListaTipoStrumento(Session session) {
		
		ArrayList<VerTipoStrumentoDTO> lista = null;
		
		Query query = session.createQuery("from VerTipoStrumentoDTO");
		
		lista = (ArrayList<VerTipoStrumentoDTO>) query.list();
		
		return lista;
	}

	public static ArrayList<VerStrumentoDTO> getStrumentiClienteSede(int cliente, int sede, Session session) {
		
		ArrayList<VerStrumentoDTO> lista = null;
				
		Query query = session.createQuery("from VerStrumentoDTO where id_cliente =:_id_cliente and id_sede =:_id_sede");
		query.setParameter("_id_cliente", cliente);
		query.setParameter("_id_sede", sede);
		
		lista = (ArrayList<VerStrumentoDTO>) query.list();
		
		return lista;
	}

	public static VerStrumentoDTO getVerStrumentoFromId(int id_strumento, Session session) {
		
		ArrayList<VerStrumentoDTO> lista = null;
		VerStrumentoDTO result = null;
		
		Query query = session.createQuery("from VerStrumentoDTO where id =:_id_strumento");
		query.setParameter("_id_strumento", id_strumento);
		
		lista = (ArrayList<VerStrumentoDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static ArrayList<VerTipologiaStrumentoDTO> getListaTipologieStrumento(Session session) {

		ArrayList<VerTipologiaStrumentoDTO> lista = null;
		
		Query query = session.createQuery("from VerTipologiaStrumentoDTO");
		
		lista = (ArrayList<VerTipologiaStrumentoDTO>) query.list();
		
		return lista;
	}

	public static ArrayList<VerFamigliaStrumentoDTO> getListaFamiglieStrumento(Session session) {
		
		ArrayList<VerFamigliaStrumentoDTO> lista = null;
		
		Query query = session.createQuery("from VerFamigliaStrumentoDTO");
		
		lista = (ArrayList<VerFamigliaStrumentoDTO>) query.list();
		
		return lista;
	}

	public static ArrayList<VerInterventoStrumentiDTO> getListaStrumentiIntervento(int id_intervento, Session session) {
		
		ArrayList<VerInterventoStrumentiDTO> lista = null;
		
		Query query = session.createQuery("from VerInterventoStrumentiDTO a where a.id_intervento =:_id_intervento");
		query.setParameter("_id_intervento", id_intervento);
		
		lista = (ArrayList<VerInterventoStrumentiDTO>) query.list();
		
		return lista;
	}

	public static ArrayList<VerAllegatoStrumentoDTO> getListaAllegatiStrumento(int id_strumento, Session session) {

	ArrayList<VerAllegatoStrumentoDTO> lista = null;
		
		Query query = session.createQuery("from VerAllegatoStrumentoDTO a where a.strumento.id =:_id_strumento");
		query.setParameter("_id_strumento", id_strumento);
		
		lista = (ArrayList<VerAllegatoStrumentoDTO>) query.list();
		
		return lista;
	}

	public static VerAllegatoStrumentoDTO getAllegatoStrumentoFormId(int id_allegato, Session session) {

		ArrayList<VerAllegatoStrumentoDTO> lista = null;
		VerAllegatoStrumentoDTO result = null;
		
		Query query = session.createQuery("from VerAllegatoStrumentoDTO where id =:_id_allegato");
		query.setParameter("_id_allegato", id_allegato);
		
		lista = (ArrayList<VerAllegatoStrumentoDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

}
