package it.portaleSTI.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.VerAllegatoLegalizzazioneBilanceDTO;
import it.portaleSTI.DTO.VerLegalizzazioneBilanceDTO;
import it.portaleSTI.DTO.VerTipoApprovazioneDTO;
import it.portaleSTI.DTO.VerTipoProvvedimentoDTO;

public class GestioneVerLegalizzazioneBilanceDAO {

	public static ArrayList<VerLegalizzazioneBilanceDTO> getListaLegalizzazioni(Session session) {
		
		ArrayList<VerLegalizzazioneBilanceDTO> lista = null;
		
		Query query = session.createQuery("from VerLegalizzazioneBilanceDTO");
		lista = (ArrayList<VerLegalizzazioneBilanceDTO>) query.list();
		
		
		return lista;
	}

	public static ArrayList<VerTipoApprovazioneDTO> getListaTipoApprovazione(Session session) {
		
		ArrayList<VerTipoApprovazioneDTO> lista = null;
		
		Query query = session.createQuery("from VerTipoApprovazioneDTO");
		lista = (ArrayList<VerTipoApprovazioneDTO>) query.list();
		
		
		return lista;
	}

	public static ArrayList<VerTipoProvvedimentoDTO> getListaTipoProvvedimento(Session session) {

		ArrayList<VerTipoProvvedimentoDTO> lista = null;
		
		Query query = session.createQuery("from VerTipoProvvedimentoDTO");
		lista = (ArrayList<VerTipoProvvedimentoDTO>) query.list();
		
		
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
