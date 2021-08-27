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
import it.portaleSTI.DTO.VerEmailDTO;
import it.portaleSTI.DTO.VerMisuraDTO;

public class GestioneVerCertificatoBO {

	public static LinkedHashMap<String, String> getClientiPerVerCertificato(UtenteDTO utente, Session session)throws Exception {
		
		
		return GestioneVerCertificatoDAO.getClientiPerVerCertificato(utente, session);			
		
	}

	public static ArrayList<VerCertificatoDTO> getListaCertificati(int stato, int filtro_emissione, int idCliente, int idSede,String company, boolean obsoleti,Session session) {
	
		return GestioneVerCertificatoDAO.getListaCertificati(stato,filtro_emissione, idCliente, idSede, company,obsoleti,session);
	}

	public static VerCertificatoDTO getCertificatoById(int id, Session session) {
		
		return GestioneVerCertificatoDAO.getCertificatoById(id, session);
	}
	
	public static  VerCertificatoDTO getCertificatoByMisura(VerMisuraDTO misura) throws Exception 
	{
		return GestioneVerCertificatoDAO.getCertificatoByMisura(misura);
	}

	public static ArrayList<VerEmailDTO> getListaEmailCertificato(int id_certificato, Session session) {
		
		return GestioneVerCertificatoDAO.getListaEmailCertificato(id_certificato,session);
	}

	public static ArrayList<VerCertificatoDTO> getListaCertificatiPrecedenti(int id_strumento,  Session session) {
		
		return GestioneVerCertificatoDAO.getListaCertificatiPrecedenti(id_strumento, session);
	}
}
