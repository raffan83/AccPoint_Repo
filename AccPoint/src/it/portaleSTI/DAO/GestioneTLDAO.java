package it.portaleSTI.DAO;

import it.portaleSTI.DTO.ClassificazioneDTO;
import it.portaleSTI.DTO.LuogoVerificaDTO;
import it.portaleSTI.DTO.StatoInterventoDTO;
import it.portaleSTI.DTO.StatoStrumentoDTO;
import it.portaleSTI.DTO.TipoCampioneDTO;
import it.portaleSTI.DTO.TipoGrandezzaDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.DTO.UnitaMisuraDTO;
import it.portaleSTI.DTO.ValoreCampioneDTO;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

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
		
		
		Collections.sort(list, new Comparator<TipoStrumentoDTO>() {
            public int compare(TipoStrumentoDTO v1, TipoStrumentoDTO v2) {
                return v1.getNome().compareTo(v2.getNome());
            }
        });

		
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
	public static ArrayList<StatoStrumentoDTO> getListaStatoStrumento(){
		Query query=null;
		ArrayList<StatoStrumentoDTO> list=null;
		try {
			
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
		String s_query = "from StatoStrumentoDTO";
	    query = session.createQuery(s_query);
	    
		
		list = (ArrayList<StatoStrumentoDTO>)query.list();
		
		session.getTransaction().commit();
		session.close();

	     } catch(Exception e)
	     {
	    	 e.printStackTrace();
	     } 
		return list;

		}
	
	public static ArrayList<LuogoVerificaDTO> getListaLuogoVerifica(){
		Query query=null;
		ArrayList<LuogoVerificaDTO> list=null;
		try {
			
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
		String s_query = "from LuogoVerificaDTO";
	    query = session.createQuery(s_query);
	    
		
		list = (ArrayList<LuogoVerificaDTO>)query.list();
		
		session.getTransaction().commit();
		session.close();

	     } catch(Exception e)
	     {
	    	 e.printStackTrace();
	     } 
		return list;

		}
	public static ArrayList<ClassificazioneDTO> getListaClassificazione(){
		Query query=null;
		ArrayList<ClassificazioneDTO> list=null;
		try {
			
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
		String s_query = "from ClassificazioneDTO";
	    query = session.createQuery(s_query);
	    
		
		list = (ArrayList<ClassificazioneDTO>)query.list();
		
		session.getTransaction().commit();
		session.close();

	     } catch(Exception e)
	     {
	    	 e.printStackTrace();
	     } 
		return list;

		}

	public static ArrayList<TipoCampioneDTO> getListaTipoCampione() {
		Query query=null;
		ArrayList<TipoCampioneDTO> list=null;
		try {
			
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
		String s_query = "from TipoCampioneDTO";
	    query = session.createQuery(s_query);
	    
		
		list = (ArrayList<TipoCampioneDTO>)query.list();
		
		session.getTransaction().commit();
		session.close();

	     } catch(Exception e)
	     {
	    	 e.printStackTrace();
	     } 
		return list;

	}

	public static ArrayList<StatoInterventoDTO> getListaStatoIntervento() {
		Query query=null;
		ArrayList<StatoInterventoDTO> list=null;
		try {
			
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
		String s_query = "from StatoInterventoDTO";
	    query = session.createQuery(s_query);
	    
		
		list = (ArrayList<StatoInterventoDTO>)query.list();
		
		session.getTransaction().commit();
		session.close();

	     } catch(Exception e)
	     {
	    	 e.printStackTrace();
	     } 
		return list;
	}
}
