package it.portaleSTI.DAO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.GPDTO;

public class GestioneGreenPassDAO {

	public static ArrayList<GPDTO> getListaGreenPass(Session session) {
		
		ArrayList<GPDTO> lista = null;
		
		Query query = session.createQuery("from GPDTO WHERE visibile=0");
		
		lista = (ArrayList<GPDTO>) query.list();
		
		
		
		return lista;
	}

	public static void deleteLettureGP() {
	
		Session session =SessionFacotryDAO.get().openSession();
 		session.beginTransaction();
 		
 		Query query = session.createQuery("update GPDTO set visibile = 1");
 		
 		query.executeUpdate();
 		
 		session.getTransaction().commit();
 		session.close();
		
	}

}
