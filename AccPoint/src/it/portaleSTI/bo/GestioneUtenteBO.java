package it.portaleSTI.bo;

import java.util.ArrayList;
import java.util.Date;

import org.apache.commons.fileupload.FileItem;
import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.GestioneUtenteDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CertificatoCampioneDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.ValoreCampioneDTO;


public class GestioneUtenteBO {

	
	public static UtenteDTO getUtenteById(String id_str, Session session) throws Exception {


		return GestioneUtenteDAO.getUtenteById(id_str, session);
	}

	public static int saveUtente(UtenteDTO utente, String action, Session session) {
		int toRet=0;
		
		try{
		int idUtente=0;
		
		if(action.equals("modifica")){
			session.update(utente);
			idUtente=utente.getId();
		}
		else if(action.equals("nuovo")){
			idUtente=(Integer) session.save(utente);

		}
		
		toRet=0;	
			
		}catch (Exception ex)
		{
			toRet=1;
			throw ex;
	 		
	 		
		}
		return toRet;
		
	}


}
