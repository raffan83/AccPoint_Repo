package it.portaleSTI.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.VerFamigliaStrumentoDTO;
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

}
