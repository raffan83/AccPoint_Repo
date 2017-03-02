package it.portaleSTI.DAO;

import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.UtenteDTO;

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
		session.getTransaction().commit();
		session.close();
		}
		catch (Exception e) {
			//
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
	
	public static HashMap<Integer,String> getListCompany() throws HibernateException, Exception
	{
		HashMap<Integer, String> comp=new HashMap<>();
		
		Session session=SessionFacotryDAO.get().openSession();
		
		session.beginTransaction();
		Query query  = session.createQuery( "from CompanyDTO" );
	    
		List<CompanyDTO> result =query.list();
		
		for (CompanyDTO company  :result)
		{
			comp.put(company.getId(), company.getDenominazione());
		}
		
		
		session.getTransaction().commit();
		session.close();
		
		return comp;	
		
	}
	
	

}
