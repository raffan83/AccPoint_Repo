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
import it.portaleSTI.DTO.VerMisuraDTO;

public class GestioneVerCertificatoBO {

	public static LinkedHashMap<String, String> getClientiPerVerCertificato(UtenteDTO utente, Session session)throws Exception {
		
		
		return GestioneVerCertificatoDAO.getClientiPerVerCertificato(utente, session);			
		
	}

	public static ArrayList<VerCertificatoDTO> getListaCertificati(int stato, int filtro_emissione, int idCliente, int idSede, boolean obsoleti,Session session) {
	
		return GestioneVerCertificatoDAO.getListaCertificati(stato,filtro_emissione, idCliente, idSede, obsoleti,session);
	}

	public static VerCertificatoDTO getCertificatoById(int id, Session session) {
		
		return GestioneVerCertificatoDAO.getCertificatoById(id, session);
	}
	
	public static  VerCertificatoDTO getCertificatoByMisura(VerMisuraDTO misura) throws Exception 
	{
		return GestioneVerCertificatoDAO.getCertificatoByMisura(misura);
	}
}
