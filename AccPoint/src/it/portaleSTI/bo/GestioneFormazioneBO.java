package it.portaleSTI.bo;

import java.util.ArrayList;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneFormazioneDAO;
import it.portaleSTI.DTO.ForCorsoAllegatiDTO;
import it.portaleSTI.DTO.ForCorsoCatAllegatiDTO;
import it.portaleSTI.DTO.ForCorsoCatDTO;
import it.portaleSTI.DTO.ForCorsoDTO;
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

	public static ArrayList<ForCorsoDTO> getListaCorsi(Session session) {
		
		return GestioneFormazioneDAO.getListaCorsi(session);
	}

	public static ForCorsoDTO getCorsoFromId(int id_corso, Session session) {

		return GestioneFormazioneDAO.getCorsoFromId(id_corso, session);
	}


	public static ArrayList<ForCorsoAllegatiDTO>  getAllegatiCorso(int id_corso, Session session) {

		return GestioneFormazioneDAO.getAllegatiCorso(id_corso, session);
		
	}

	public static ArrayList<ForCorsoCatAllegatiDTO> getAllegatiCategoria(int id_categoria, Session session) {
	
		return GestioneFormazioneDAO.getAllegatiCategoria(id_categoria, session);
	}

	public static ForCorsoAllegatiDTO getAllegatoCorsoFormId(int id_allegato, Session session) {
		
		return GestioneFormazioneDAO.getAllegatoCorsoFormId(id_allegato, session);
	}
	
	public static ForCorsoCatAllegatiDTO getAllegatoCorsoCategoriaFormId(int id_allegato, Session session) {
		
		return GestioneFormazioneDAO.getAllegatoCategoriaFormId(id_allegato, session);
	}

}
