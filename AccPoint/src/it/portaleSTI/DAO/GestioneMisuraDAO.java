package it.portaleSTI.DAO;

import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.MisuraDTO;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

public class GestioneMisuraDAO {

	public static int getTabellePerMisura(int idMisura) {
		
		Session session=SessionFacotryDAO.get().openSession();
		
			
		session.beginTransaction();
		Query query  = session.createQuery( "from InterventoDTO WHERE id_commessa= :_id_commessa");
		
	//	query.setParameter("_id_commessa", idCommessa);
				
	//	lista=query.list();
		
		session.getTransaction().commit();
		session.close();
		
		return 0;
	}
	public static MisuraDTO getMiruraByID(int idMisura) {
		
		Query query=null;
		MisuraDTO misura=null;
		try {
			Session session =SessionFacotryDAO.get().openSession();
			misura =  (MisuraDTO) session.get(MisuraDTO.class, idMisura);
	     } 
		catch(Exception e)
	     {
	    	 e.printStackTrace();
	    	 throw e;
	     }
		
		return misura;
	}
	
}
