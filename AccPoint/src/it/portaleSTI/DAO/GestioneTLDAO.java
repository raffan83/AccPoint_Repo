package it.portaleSTI.DAO;

import it.portaleSTI.DTO.TipoGrandezzaDTO;
import it.portaleSTI.DTO.UnitaMisuraDTO;
import it.portaleSTI.DTO.ValoreCampioneDTO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

public class GestioneTLDAO {

	@SuppressWarnings("unchecked")
	public static ArrayList<UnitaMisuraDTO> getListaUnitaMisura(){
		Query query=null;
		ArrayList<UnitaMisuraDTO> list=null;
		try {
			
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
		String s_query = "from UnitaMisuraDTO";
	    query = session.createQuery(s_query);
	    
		
		list = (ArrayList<UnitaMisuraDTO>)query.list();
		
		session.getTransaction().commit();
		session.close();

	     } catch(Exception e)
	     {
	    	 e.printStackTrace();
	     } 
		return list;

		}
	
	@SuppressWarnings("unchecked")
	public static ArrayList<TipoGrandezzaDTO> getListaTipoGrandezza(){
		Query query=null;
		ArrayList<TipoGrandezzaDTO> list=null;
		try {
			
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
		String s_query = "from TipoGrandezzaDTO";
	    query = session.createQuery(s_query);
	    
		
		list = (ArrayList<TipoGrandezzaDTO>)query.list();
		
		session.getTransaction().commit();
		session.close();

	     } catch(Exception e)
	     {
	    	 e.printStackTrace();
	     } 
		return list;

		}
}
