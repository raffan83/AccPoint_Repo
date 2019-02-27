package it.portaleSTI.bo;

import java.util.ArrayList;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneAttivitaCampioneDAO;
import it.portaleSTI.DTO.AcAttivitaCampioneDTO;
import it.portaleSTI.DTO.AcTipoAttivitaCampioniDTO;

public class GestioneAttivitaCampioneBO {

	public static ArrayList<AcAttivitaCampioneDTO> getListaAttivita(int idC, Session session) {
		
		return GestioneAttivitaCampioneDAO.getListaAttivita(idC, session);
	}

	public static ArrayList<AcTipoAttivitaCampioniDTO> getListaTipoAttivitaCampione(Session session) {

		return GestioneAttivitaCampioneDAO.getListaTipoAttivitaCampione(session);
	}

	public static AcAttivitaCampioneDTO getAttivitaFromId(int id_attivita, Session session) {
		
		return GestioneAttivitaCampioneDAO.getAttivitaFromId(id_attivita, session);
	}

	public static ArrayList<AcAttivitaCampioneDTO> getListaManutenzioni(int id_campione, Session session) {
		
		return GestioneAttivitaCampioneDAO.getListaManutenzioni(id_campione, session);
	}
	
	public static ArrayList<AcAttivitaCampioneDTO> getListaTaratureVerificheIntermedie(int id_campione, Session session) {
		
		return GestioneAttivitaCampioneDAO.getListaTaratureVerificheIntermedie(id_campione, session);
	}
}
