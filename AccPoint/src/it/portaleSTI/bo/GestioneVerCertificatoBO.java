package it.portaleSTI.bo;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneVerCertificatoDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerCertificatoDTO;

public class GestioneVerCertificatoBO {

	public static LinkedHashMap<String, String> getClientiPerVerCertificato(Session session)throws Exception {
		
		return GestioneVerCertificatoDAO.getClientiPerVerCertificato(session);
	}

	public static ArrayList<VerCertificatoDTO> getListaCertificati(int stato, int idCliente, int idSede, Session session) {
	
		return GestioneVerCertificatoDAO.getListaCertificati(stato, idCliente, idSede, session);
	}

	public static VerCertificatoDTO getCertificatoById(int id, Session session) {
		
		return GestioneVerCertificatoDAO.getCertificatoById(id, session);
	}
	
}
