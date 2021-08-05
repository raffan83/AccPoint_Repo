package it.portaleSTI.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

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

	public static VerLegalizzazioneBilanceDTO getProvvedimentoFromId(int id_provvedimento, Session session) {
		
		ArrayList<VerLegalizzazioneBilanceDTO> lista = null;
		VerLegalizzazioneBilanceDTO result = null;
		
		Query query = session.createQuery("from VerLegalizzazioneBilanceDTO where id = :_id_provvedimento");
		query.setParameter("_id_provvedimento", id_provvedimento);
		
		lista = (ArrayList<VerLegalizzazioneBilanceDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static ArrayList<VerAllegatoLegalizzazioneBilanceDTO> getListaAllegati(int id_provvedimento,	Session session) {

		ArrayList<VerAllegatoLegalizzazioneBilanceDTO> lista = null;
		
		Query query = session.createQuery("from VerAllegatoLegalizzazioneBilanceDTO where id_legalizzazione_bilance = :_id_provvedimento"); 
		query.setParameter("_id_provvedimento", id_provvedimento);
		
		lista = (ArrayList<VerAllegatoLegalizzazioneBilanceDTO>) query.list();
		
		
		return lista;	
	}

	public static VerAllegatoLegalizzazioneBilanceDTO getAllegatoFromId(int id_allegato, Session session) {
		ArrayList<VerAllegatoLegalizzazioneBilanceDTO> lista = null;
		VerAllegatoLegalizzazioneBilanceDTO result = null;
		
		Query query = session.createQuery("from VerAllegatoLegalizzazioneBilanceDTO where id = :_id_allegato");
		query.setParameter("_id_allegato", id_allegato);
		
		lista = (ArrayList<VerAllegatoLegalizzazioneBilanceDTO>) query.list();
		
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

}
