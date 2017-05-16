package it.portaleSTI.DAO;

import it.portaleSTI.DTO.InterventoDTO;

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

}
