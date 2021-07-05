package it.portaleSTI.bo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneVerStrumentiDAO;
import it.portaleSTI.DTO.VerAllegatoStrumentoDTO;
import it.portaleSTI.DTO.VerFamigliaStrumentoDTO;
import it.portaleSTI.DTO.VerInterventoStrumentiDTO;
import it.portaleSTI.DTO.VerStrumentoDTO;
import it.portaleSTI.DTO.VerTipoStrumentoDTO;
import it.portaleSTI.DTO.VerTipologiaStrumentoDTO;

public class GestioneVerStrumentiBO {

	public static ArrayList<VerStrumentoDTO> getListaStrumenti(Session session) {
		
		return GestioneVerStrumentiDAO.getListaStrumenti(session);
	}

	public static ArrayList<VerTipoStrumentoDTO> getListaTipoStrumento(Session session) {
		
		return GestioneVerStrumentiDAO.getListaTipoStrumento(session);
	}

	public static ArrayList<VerStrumentoDTO> getStrumentiClienteSede(int cliente, int sede, Session session) {
		
		return GestioneVerStrumentiDAO.getStrumentiClienteSede(cliente, sede, session);
	}

	public static VerStrumentoDTO getVerStrumentoFromId(int id_strumento, Session session) {
		
		return GestioneVerStrumentiDAO.getVerStrumentoFromId(id_strumento, session);
	}

	public static ArrayList<VerTipologiaStrumentoDTO> getListaTipologieStrumento(Session session) {
		
		return GestioneVerStrumentiDAO.getListaTipologieStrumento(session);
	}

	public static ArrayList<VerFamigliaStrumentoDTO> getListaFamiglieStrumento(Session session) {
		
		return GestioneVerStrumentiDAO.getListaFamiglieStrumento(session);
	}

	public static ArrayList<VerInterventoStrumentiDTO> getListaStrumentiIntervento(int id_intervento, Session session) {
		
		return GestioneVerStrumentiDAO.getListaStrumentiIntervento(id_intervento, session);
	}

	public static ArrayList<VerAllegatoStrumentoDTO> getListaAllegatiStrumento(int id_strumento, Session session) {
		
		return GestioneVerStrumentiDAO.getListaAllegatiStrumento(id_strumento, session);
	}

	public static VerAllegatoStrumentoDTO getAllegatoStrumentoFormId(int id_allegato, Session session) {
	
		return GestioneVerStrumentiDAO.getAllegatoStrumentoFormId(id_allegato, session);
	}

	public static HashMap<String, Integer> getListaScadenzeVerificazione(Session session,List<Integer> lista_id_clienti) {
		
		return GestioneVerStrumentiDAO.getListaScadenzeVerificazione(session, lista_id_clienti);
	}

	public static ArrayList<VerStrumentoDTO> getlistaStrumentiScadenza(String dateFrom,String dateTo, Session session) throws Exception {
		
		return GestioneVerStrumentiDAO.getlistaStrumentiScadenza(dateFrom, dateTo, session);
	}

	
	
}
