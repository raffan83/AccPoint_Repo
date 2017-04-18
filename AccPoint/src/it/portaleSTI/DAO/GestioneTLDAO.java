package it.portaleSTI.DAO;

import it.portaleSTI.DTO.StatoPrenotazioneDTO;
import it.portaleSTI.DTO.TipoCampioneDTO;
import it.portaleSTI.DTO.TipoGrandezzaDTO;
import it.portaleSTI.DTO.UnitaMisuraDTO;

import java.util.HashMap;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

public class GestioneTLDAO {
	
	public static HashMap<Integer,String> getListTipoCampione() throws HibernateException, Exception
	{
		HashMap<Integer, String> tipoCMP=new HashMap<>();
		
		Session session=SessionFacotryDAO.get().openSession();
		
		session.beginTransaction();
		Query query  = session.createQuery( "from TipoCampioneDTO" );
	    
		List<TipoCampioneDTO> result =query.list();
		
		for (TipoCampioneDTO tipoCampione  :result)
		{
			tipoCMP.put(tipoCampione.getId(), tipoCampione.getNome());
		}
		
		
		session.getTransaction().commit();
		session.close();
		
		return tipoCMP;	
	}
	
	public static HashMap<Integer,String> getListTipoGrandezza() throws HibernateException, Exception
	{
		HashMap<Integer, String> tipoTG=new HashMap<>();
		
		Session session=SessionFacotryDAO.get().openSession();
		
		session.beginTransaction();
		Query query  = session.createQuery( "from TipoGrandezzaDTO" );
	    
		List<TipoGrandezzaDTO> result =query.list();
		
		for (TipoGrandezzaDTO company  :result)
		{
			tipoTG.put(company.getId(), company.getNome());
		}
		
		
		session.getTransaction().commit();
		session.close();
		
		return tipoTG;	
	}
	
	public static HashMap<Integer,String> getListUM() throws HibernateException, Exception
	{
		HashMap<Integer, String> tipoUM=new HashMap<>();
		
		Session session=SessionFacotryDAO.get().openSession();
		
		session.beginTransaction();
		Query query  = session.createQuery( "from UnitaMisuraDTO" );
	    
		List<UnitaMisuraDTO> result =query.list();
		
		for (UnitaMisuraDTO company  :result)
		{
			tipoUM.put(company.getId(), company.getNome());
		}
		
		
		session.getTransaction().commit();
		session.close();
		
		return tipoUM;	
	}
	
	public static HashMap<Integer,String> getListStatoPrenotazione() throws HibernateException, Exception
	{
		HashMap<Integer, String> listaSP=new HashMap<>();
		
		Session session=SessionFacotryDAO.get().openSession();
		
		session.beginTransaction();
		Query query  = session.createQuery( "from StatoPrenotazioneDTO" );
	    
		List<StatoPrenotazioneDTO> result =query.list();
		
		for (StatoPrenotazioneDTO stato  :result)
		{
			listaSP.put(stato.getId(), stato.getDescrizione());
		}
		
		
		session.getTransaction().commit();
		session.close();
		
		return listaSP;	
	}
	


}
