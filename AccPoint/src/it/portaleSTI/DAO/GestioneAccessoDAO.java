package it.portaleSTI.DAO;

import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.PermessoDTO;
import it.portaleSTI.DTO.RuoloDTO;
import it.portaleSTI.DTO.UtenteDTO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

public class GestioneAccessoDAO {
	
	public static UtenteDTO controllaAccesso(String user, String pwd) throws Exception {
		UtenteDTO utente=null;
		Session session=null;
		try
		{
		session=SessionFacotryDAO.get().openSession();
		
		session.beginTransaction();
		Query query  = session.createQuery( "from UtenteDTO WHERE user= :_user AND passw=:_passw" );
		query.setParameter("_user", user);
		query.setParameter("_passw", DirectMySqlDAO.getPassword(pwd));
	    
		List<UtenteDTO> result =query.list();
		if(result.size()>0)
		{			
			return result.get(0);
		}
		
		}
		catch (Exception e) {
			throw e;
		}finally
		{
			session.getTransaction().commit();
			session.close();
		}
		return utente;
	}
	
	public static CompanyDTO getCompany(int id_user) throws HibernateException, Exception
	{
		CompanyDTO comp=null;
		Session session=SessionFacotryDAO.get().openSession();
		
		session.beginTransaction();
		Query query  = session.createQuery( "from CompanyDTO WHERE id= :_id_comp" );
		query.setParameter("_id_comp", id_user);
	    
		List<CompanyDTO> result =query.list();
		if(result.size()>0)
		{			
			return result.get(0);
		}
		session.getTransaction().commit();
		session.close();
		
		return comp;
		
		
	}
	public static List<CompanyDTO> getListCompany() throws HibernateException, Exception
	{
		CompanyDTO comp=null;
		Session session=SessionFacotryDAO.get().openSession();
		
		session.beginTransaction();
		Query query  = session.createQuery( "from CompanyDTO" );

	    
		List<CompanyDTO> result =query.list();
		
	
		session.getTransaction().commit();
		session.close();
		
		return result;
		
		
	}
	
	public static void updateUser(UtenteDTO user){
		
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		session.update(user);
		session.getTransaction().commit();
		session.close();

	}
	
	public static void updateCompany(CompanyDTO company){
		Session session=SessionFacotryDAO.get().openSession();
		
		session.beginTransaction();
		session.update(company);
		session.getTransaction().commit();
		session.close();

	}
	
	public static List<UtenteDTO> getListUser() throws HibernateException, Exception
	{
		
		Session session=SessionFacotryDAO.get().openSession();
		
		session.beginTransaction();
		
		Query query  = session.createQuery( "from UtenteDTO" );
	    
		List<UtenteDTO> result =query.list();
	
		
		
		session.getTransaction().commit();
		session.close();
		
		return result;	
	}
	
	public static List<RuoloDTO> getListRole() throws HibernateException, Exception
	{
		
		Session session=SessionFacotryDAO.get().openSession();
		
		session.beginTransaction();
		
		Query query  = session.createQuery( "from RuoloDTO" );
	    
		List<RuoloDTO> result =query.list();

		session.getTransaction().commit();
		session.close();
		
		return result;	
	}
	
	public static List<PermessoDTO> getListPermission() throws HibernateException, Exception
	{
		
		Session session=SessionFacotryDAO.get().openSession();
		
		session.beginTransaction();
		
		Query query  = session.createQuery( "from PermessoDTO" );
	    
		List<PermessoDTO> result =query.list();

		session.getTransaction().commit();
		session.close();
		
		return result;	
	}

	public static ArrayList<UtenteDTO> getListUserPerCompany(CompanyDTO company) {
		Session session=SessionFacotryDAO.get().openSession();
		
		session.beginTransaction();
		
		Query query  = session.createQuery( "from UtenteDTO WHERE company.id= :_id_comp" );
		query.setParameter("_id_comp", company.getId());
		List<UtenteDTO> result =query.list();
	
		
		
		session.getTransaction().commit();
		session.close();
		
		return (ArrayList<UtenteDTO>) result;	
	}

	public static Boolean controlloUsername(String user) {
		UtenteDTO utente=null;
		Session session=null;
		try
		{
		session=SessionFacotryDAO.get().openSession();
		
		session.beginTransaction();
		Query query  = session.createQuery( "from UtenteDTO WHERE user= :_user" );
		query.setParameter("_user", user);
 	    
		List<UtenteDTO> result =query.list();
		if(result.size()>0)
		{			
			return true;
		}
		session.getTransaction().commit();
		session.close();
		}
		catch (Exception e) {
			throw e;
		}
		return false;
	}

}
