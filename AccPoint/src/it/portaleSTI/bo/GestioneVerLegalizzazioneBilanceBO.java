package it.portaleSTI.bo;

import java.util.ArrayList;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneVerLegalizzazioneBilanceDAO;
import it.portaleSTI.DTO.VerAllegatoLegalizzazioneBilanceDTO;
import it.portaleSTI.DTO.VerLegalizzazioneBilanceDTO;
import it.portaleSTI.DTO.VerTipoApprovazioneDTO;
import it.portaleSTI.DTO.VerTipoProvvedimentoDTO;

public class GestioneVerLegalizzazioneBilanceBO {

	public static ArrayList<VerLegalizzazioneBilanceDTO> getListaLegalizzazioni(Session session) {
		
		return GestioneVerLegalizzazioneBilanceDAO.getListaLegalizzazioni(session);
	}

	public static ArrayList<VerTipoApprovazioneDTO> getListaTipoApprovazione(Session session) {
		
		return GestioneVerLegalizzazioneBilanceDAO.getListaTipoApprovazione(session);
	}

	public static ArrayList<VerTipoProvvedimentoDTO> getListaTipoProvvedimento(Session session) {
		
		return GestioneVerLegalizzazioneBilanceDAO.getListaTipoProvvedimento(session);
	}

	public static VerLegalizzazioneBilanceDTO getProvvedimentoFromId(int id_provvedimento, Session session) {
		
		return GestioneVerLegalizzazioneBilanceDAO.getProvvedimentoFromId(id_provvedimento, session);
	}

	public static ArrayList<VerAllegatoLegalizzazioneBilanceDTO> getListaAllegati(int id_provvedimento, Session session) {
		
		return GestioneVerLegalizzazioneBilanceDAO.getListaAllegati(id_provvedimento, session);
	}

	public static VerAllegatoLegalizzazioneBilanceDTO getAllegatoFromId(int id_allegato, Session session) {
		
		return GestioneVerLegalizzazioneBilanceDAO.getAllegatoFromId(id_allegato, session);
	}

}
