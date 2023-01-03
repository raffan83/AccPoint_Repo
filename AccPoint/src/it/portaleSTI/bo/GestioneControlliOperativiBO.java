package it.portaleSTI.bo;

import java.util.ArrayList;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneControlliOperativiDAO;
import it.portaleSTI.DTO.CoAllegatoAttrezzaturaDTO;
import it.portaleSTI.DTO.CoAttrezzaturaTipoControlloDTO;
import it.portaleSTI.DTO.CoControlloDTO;

public class GestioneControlliOperativiBO {

	public static <E> ArrayList<E> getLista(E type,  Session session) {

		return GestioneControlliOperativiDAO.getLista(type, session);
	}
	

	public static <E> E getElement(E type,int id, Session session) {
		
		return GestioneControlliOperativiDAO.getElement(type,id, session);
	}
	


	public static ArrayList<CoAttrezzaturaTipoControlloDTO> getListaAttrezzaturaTipoControllo(int parseInt,Session session) {
		
		return GestioneControlliOperativiDAO.getListaAttrezzaturaTipoControllo(parseInt, session);
	}


	public static CoAttrezzaturaTipoControlloDTO getAttrezzaturaTipoControllo(int id_attrezzatura, int id_controllo, Session session) {
		
		return GestioneControlliOperativiDAO.getAttrezzaturaTipoControllo(id_attrezzatura,id_controllo, session);
	}


	public static ArrayList<CoAllegatoAttrezzaturaDTO> getListaAllegatiAttrezzatura(int id_attrezzatura, Session session) {
		// 
		return GestioneControlliOperativiDAO.getListaAllegatiAttrezzatura(id_attrezzatura, session);
	}


	public static ArrayList<CoControlloDTO> getListaControlliAttrezzatura(int id, Session session) {

		return GestioneControlliOperativiDAO.getListaControlliAttrezzatura(id, session);
	}

}
