package it.portaleSTI.bo;

import java.util.ArrayList;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneVerDocumentiDAO;
import it.portaleSTI.DTO.VerDocumentoDTO;
import it.portaleSTI.DTO.VerTipoDocumentoDTO;

public class GestioneVerDocumentiBO {

	public static ArrayList<VerDocumentoDTO> getListaDocumenti(Session session) {
		
		return GestioneVerDocumentiDAO.getListaDocumenti(session);
	}

	public static ArrayList<VerTipoDocumentoDTO> getListaTipoDocumenti(Session session) {
		
		return GestioneVerDocumentiDAO.getListaTipoDocumento(session);
	}
//
//	public static ArrayList<VerTipoProvvedimentoDTO> getListaTipoProvvedimento(Session session) {
//		
//		return GestioneVerLegalizzazioneBilanceDAO.getListaTipoProvvedimento(session);
//	}
//
//	public static VerLegalizzazioneBilanceDTO getProvvedimentoFromId(int id_provvedimento, Session session) {
//		
//		return GestioneVerLegalizzazioneBilanceDAO.getProvvedimentoFromId(id_provvedimento, session);
//	}
//
//	public static ArrayList<VerAllegatoLegalizzazioneBilanceDTO> getListaAllegati(int id_provvedimento, Session session) {
//		
//		return GestioneVerLegalizzazioneBilanceDAO.getListaAllegati(id_provvedimento, session);
//	}
//
//	public static VerAllegatoLegalizzazioneBilanceDTO getAllegatoFromId(int id_allegato, Session session) {
//		
//		return GestioneVerLegalizzazioneBilanceDAO.getAllegatoFromId(id_allegato, session);
//	}

}
