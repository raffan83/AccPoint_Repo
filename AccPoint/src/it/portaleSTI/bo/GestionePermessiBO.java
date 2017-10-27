package it.portaleSTI.bo;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestionePermessiDAO;

import it.portaleSTI.DTO.PermessoDTO;
import it.portaleSTI.DTO.RuoloDTO;


public class GestionePermessiBO {

	
	public static PermessoDTO getPermessoById(String id_str, Session session) throws Exception {


		return GestionePermessiDAO.getPermessoById(id_str, session);
	}
	
	public static int savePermesso(PermessoDTO permesso, String action, Session session) {
		int toRet=0;
		
		try{
		int idPermesso=0;
		
		if(action.equals("modifica")){
			session.update(permesso);
			idPermesso=permesso.getIdPermesso();
		}
		else if(action.equals("nuovo")){
			idPermesso=(Integer) session.save(permesso);

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
