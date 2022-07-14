package it.portaleSTI.bo;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneAssegnazioneAttivitaDAO;
import it.portaleSTI.DAO.GestioneAttivitaCampioneDAO;
import it.portaleSTI.DTO.AcAttivitaCampioneDTO;
import it.portaleSTI.DTO.AcTipoAttivitaCampioniDTO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.TaraturaEsternaCampioneDTO;

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

	public static ArrayList<TaraturaEsternaCampioneDTO> getListaTaratureEsterneCampione(int id_campione, Session session) {
		
		return GestioneAttivitaCampioneDAO.getListaTaratureEsterneCampione(id_campione, session);
	}
	
	public static ArrayList<AcAttivitaCampioneDTO> getListaVerificheIntermedie(int id_campione, Session session) {
		
		return GestioneAttivitaCampioneDAO.getListaVerificheIntermedie(id_campione, session);
	}

	public static TaraturaEsternaCampioneDTO getTaraturaEsternaById(int id_taratura, Session session) {
		
		return GestioneAttivitaCampioneDAO.getTaraturaEsternaById(id_taratura,session);
	}

	public static ArrayList<HashMap<String, Integer>> getListaAttivitaScadenziario(Session session) {
		
		return GestioneAttivitaCampioneDAO.getListaAttivitaScadenziario(session);
	}

	public static ArrayList<HashMap<String, Integer>> getListaAttivitaScadenziarioCampione(CampioneDTO campione, Session session) {
		
		return GestioneAttivitaCampioneDAO.getListaAttivitaScadenziarioCampione(campione, session);
	}
	public static ArrayList<CampioneDTO> getListaCampioniPerData(String data, String tipo_data_lat, String tipo_evento, int verificazione) throws ParseException, Exception {
		
		return GestioneAttivitaCampioneDAO.getListaCampioniPerData(data,tipo_data_lat, tipo_evento, verificazione);
	}

	public static void updateObsolete(String idC, int tipo_attivita, Date data,  Session session) {
	
		GestioneAttivitaCampioneDAO.updateObsolete(idC, tipo_attivita, data, session);
	}

	public static ArrayList<AcAttivitaCampioneDTO> getListaFuoriServizio(int parseInt, Session session) {

		return GestioneAttivitaCampioneDAO.getListaFuoriServizio(parseInt, session);
	}

	public static ArrayList<CampioneDTO> getListaCampioniAffini(String codice, Session session) {

		return GestioneAttivitaCampioneDAO.getListaCampioniAffini(codice, session);
	}
	
}
