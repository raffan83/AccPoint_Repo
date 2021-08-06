package it.portaleSTI.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.VerAllegatoDocumentoDTO;
import it.portaleSTI.DTO.VerAllegatoLegalizzazioneBilanceDTO;
import it.portaleSTI.DTO.VerDocumentoDTO;
import it.portaleSTI.DTO.VerLegalizzazioneBilanceDTO;
import it.portaleSTI.DTO.VerTipoDocumentoDTO;
import it.portaleSTI.DTO.VerTipoProvvedimentoDTO;

public class GestioneVerDocumentiDAO {

	public static ArrayList<VerDocumentoDTO> getListaDocumenti(Session session) {
		
		ArrayList<VerDocumentoDTO> lista = null;
		
		Query query = session.createQuery("from VerDocumentoDTO");
		lista = (ArrayList<VerDocumentoDTO>) query.list();
		
		
		return lista;
	}


	public static ArrayList<VerTipoDocumentoDTO> getListaTipoDocumento(Session session) {

		ArrayList<VerTipoDocumentoDTO> lista = null;
		
		Query query = session.createQuery("from VerTipoDocumentoDTO");
		lista = (ArrayList<VerTipoDocumentoDTO>) query.list();
		
		
		return lista;	
	}

	public static VerDocumentoDTO getDocumentoFromId(int id_documento, Session session) {
		
		ArrayList<VerDocumentoDTO> lista = null;
		VerDocumentoDTO result = null;
		
		Query query = session.createQuery("from VerDocumentoDTO where id = :_id_documento");
		query.setParameter("_id_documento", id_documento);
		
		lista = (ArrayList<VerDocumentoDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static ArrayList<VerAllegatoDocumentoDTO> getListaAllegati(int id_documento,	Session session) {

		ArrayList<VerAllegatoDocumentoDTO> lista = null;
		
		Query query = session.createQuery("from VerAllegatoDocumentoDTO where id_documento = :_id_documento"); 
		query.setParameter("_id_documento", id_documento);
		
		lista = (ArrayList<VerAllegatoDocumentoDTO>) query.list();
		
		
		return lista;	
	}

	public static VerAllegatoDocumentoDTO getAllegatoFromId(int id_allegato, Session session) {
		ArrayList<VerAllegatoDocumentoDTO> lista = null;
		VerAllegatoDocumentoDTO result = null;
		
		Query query = session.createQuery("from VerAllegatoDocumentoDTO where id = :_id_allegato");
		query.setParameter("_id_allegato", id_allegato);
		
		lista = (ArrayList<VerAllegatoDocumentoDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

}
