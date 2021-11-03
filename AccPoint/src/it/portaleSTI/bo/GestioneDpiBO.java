package it.portaleSTI.bo;

import java.text.ParseException;
import java.util.ArrayList;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneDpiDAO;
import it.portaleSTI.DTO.ConsegnaDpiDTO;
import it.portaleSTI.DTO.DpiAllegatiDTO;
import it.portaleSTI.DTO.DpiDTO;
import it.portaleSTI.DTO.DpiManualeDTO;
import it.portaleSTI.DTO.TipoDpiDTO;

public class GestioneDpiBO {

	public static ArrayList<TipoDpiDTO> getListaTipoDPI(Session session) {
		
		return GestioneDpiDAO.getListaTipoDPI(session);
	}

	public static ArrayList<ConsegnaDpiDTO> getListaConsegneDpi(Session session) {
		
		return GestioneDpiDAO.getListaConsegneDpi(session);
	}

	public static ConsegnaDpiDTO getCosegnaFromID(int id_consegna, Session session) {
		
		return GestioneDpiDAO.getCosegnaFromID(id_consegna, session);
	}

	public static TipoDpiDTO getTipoDPIFromId(int id_tipo, Session session) {
		
		return GestioneDpiDAO.getTipoDPIFromId(id_tipo,session);
	}

	public static ArrayList<DpiDTO> getListaDpi(Session session) {
		
		return GestioneDpiDAO.getListaDpi(session);
	}

	public static DpiDTO getDpiFormId(int id_dpi, Session session) {
		
		return GestioneDpiDAO.getDpiFormId(id_dpi, session);
	}

	public static ArrayList<ConsegnaDpiDTO> getListaEventiFromDPI(int id_dpi, Session session) {
		
		return GestioneDpiDAO.getListaEventiFromDPI(id_dpi, session);
	}

	public static ArrayList<DpiDTO> getListaDpiScadenzario(String dateFrom, String dateTo, Session session) throws Exception, Exception {
		
		return GestioneDpiDAO.getListaDpiScadenzario(dateFrom, dateTo, session);
	}

	public static DpiManualeDTO getManualeFromId(int id_manuale, Session session) {
		
		return GestioneDpiDAO.getManualeFromId(id_manuale, session);
	}

	public static ArrayList<DpiManualeDTO> getListaManuali(Session session) {
		
		return GestioneDpiDAO.getListaManuali(session);
	}

	public static DpiAllegatiDTO getAllegatoFromID(int id_allegato, Session session) {
		
		return GestioneDpiDAO.getAllegatoFromID(id_allegato, session);
	}

	public static ArrayList<DpiAllegatiDTO> getListaAllegati(int id_manuale, Session session) {

		return GestioneDpiDAO.getListaAllegati(id_manuale, session);
	}

}
