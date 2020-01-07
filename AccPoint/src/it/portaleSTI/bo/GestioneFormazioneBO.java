package it.portaleSTI.bo;

import java.util.ArrayList;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneFormazioneDAO;
import it.portaleSTI.DTO.ForCorsoCatDTO;
import it.portaleSTI.DTO.ForDocenteDTO;

public class GestioneFormazioneBO {

	public static ArrayList<ForDocenteDTO> getListaDocenti(Session session) {
	
		return GestioneFormazioneDAO.getListaDocenti(session);
	}

	public static ForDocenteDTO getDocenteFromId(int id_docente, Session session) {
		
		return GestioneFormazioneDAO.getDocenteFromId(id_docente, session);
	}

	public static ArrayList<ForCorsoCatDTO> getListaCategorieCorsi(Session session) {
		
		return GestioneFormazioneDAO.getListaCategorieCorsi(session);
	}

	public static ForCorsoCatDTO getCategoriaCorsoFromId(int id_categoria, Session session) {

		return GestioneFormazioneDAO.getCategoriaCorsoFromId(id_categoria, session);
	}

}
