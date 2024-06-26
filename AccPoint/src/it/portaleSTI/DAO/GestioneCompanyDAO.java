package it.portaleSTI.DAO;


import it.portaleSTI.DTO.CompanyDTO;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

public class GestioneCompanyDAO {


public static CompanyDTO getCompanyById(String id, Session session)throws HibernateException, Exception {


	Query query  = session.createQuery( "from CompanyDTO WHERE id= :_id");
	
	query.setParameter("_id", Integer.parseInt(id));
	List<CompanyDTO> result =query.list();
	
	if(result.size()>0)
	{			
		return result.get(0);
	}
	return null;
	
}

public static ArrayList<CompanyDTO> getAllCompany(Session session) {
	Query query  = session.createQuery( "from CompanyDTO");
	
 	List<CompanyDTO> result =query.list();
	
	if(result.size()>0)
	{			
		return (ArrayList<CompanyDTO>) result;
	}
	return null;
}


}
