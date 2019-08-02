package it.portaleSTI.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.VerCertificatoDTO;
import it.portaleSTI.DTO.VerMisuraDTO;

public class GestioneVerCertificatoDAO {

	public static VerCertificatoDTO getCertificatoByMisura(VerMisuraDTO misuraDTO)throws Exception {
		
		Query query=null;
		VerCertificatoDTO certificato = null;
		try
		{	
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
		String s_query ="";
		
		 s_query = "from VerCertificatoDTO WHERE misura.id= :_idMisura";
			 query = session.createQuery(s_query);
			 query.setParameter("_idMisura",misuraDTO.getId());
	       
	    
			 ArrayList<VerCertificatoDTO> listaCert = (ArrayList<VerCertificatoDTO>)query.list();
	   

			 if(listaCert.isEmpty()) {
				 certificato = null;
			 }else {
				 certificato=listaCert.get(0);
			 }
			 
		session.getTransaction().commit();
		session.close();
		
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
				throw ex;
		}
	     
		return certificato;
		
	}
}
