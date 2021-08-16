package it.portaleSTI.bo;

import java.util.ArrayList;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneVerDocumentiDAO;
import it.portaleSTI.DTO.VerAllegatoDocumentoDTO;
import it.portaleSTI.DTO.VerDocumentoDTO;
import it.portaleSTI.DTO.VerTipoDocumentoDTO;

public class GestioneVerDocumentiBO {

	public static ArrayList<VerDocumentoDTO> getListaDocumenti(Session session) {
		
		return GestioneVerDocumentiDAO.getListaDocumenti(session);
	}

	public static ArrayList<VerTipoDocumentoDTO> getListaTipoDocumenti(Session session) {
		
		return GestioneVerDocumentiDAO.getListaTipoDocumento(session);
	}

	public static VerDocumentoDTO getDocumentoFromId(int id_documento, Session session) {
		
		return GestioneVerDocumentiDAO.getDocumentoFromId(id_documento, session);
	}

	public static ArrayList<VerAllegatoDocumentoDTO> getListaAllegati(int id_documento, Session session) {
		
		return GestioneVerDocumentiDAO.getListaAllegati(id_documento, session);
	}

	public static VerAllegatoDocumentoDTO getAllegatoFromId(int id_allegato, Session session) {
		
		return GestioneVerDocumentiDAO.getAllegatoFromId(id_allegato, session);
	}

}
