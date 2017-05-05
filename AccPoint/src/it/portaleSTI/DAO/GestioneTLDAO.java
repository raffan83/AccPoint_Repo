package it.portaleSTI.DAO;

import it.portaleSTI.DTO.TipoGrandezzaDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
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
	@SuppressWarnings("unchecked")
	public static ArrayList<TipoStrumentoDTO> getListaTipoStrumento(){
		Query query=null;
		ArrayList<TipoStrumentoDTO> list=null;
		try {
			
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
		String s_query = "from TipoStrumentoDTO";
	    query = session.createQuery(s_query);
	    
		
		list = (ArrayList<TipoStrumentoDTO>)query.list();
		
		session.getTransaction().commit();
		session.close();

	     } catch(Exception e)
	     {
	    	 e.printStackTrace();
	     } 
		return list;

		}
	@SuppressWarnings("unchecked")
	public static ArrayList<TipoRapportoDTO> getListaTipoRapporto(){
		Query query=null;
		ArrayList<TipoRapportoDTO> list=null;
		try {
			
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
		String s_query = "from TipoRapportoDTO";
	    query = session.createQuery(s_query);
	    
		
		list = (ArrayList<TipoRapportoDTO>)query.list();
		
		session.getTransaction().commit();
		session.close();

	     } catch(Exception e)
	     {
	    	 e.printStackTrace();
	     } 
		return list;

		}
}
