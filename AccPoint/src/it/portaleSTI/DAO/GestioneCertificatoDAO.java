package it.portaleSTI.DAO;

import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.InterventoDatiDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.StatoCertificatoDTO;
import it.portaleSTI.DTO.UtenteDTO;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

public class GestioneCertificatoDAO {

	public static ArrayList<CertificatoDTO> getListaCertificati(StatoCertificatoDTO stato,InterventoDatiDTO interventoDatiDTO, CompanyDTO cmp, UtenteDTO utente)throws Exception {
		
		Query query=null;
		ArrayList<CertificatoDTO>  listaCertificato=null;

		try
		{	
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
		String s_query ="";
		
		if(utente.isTras())
		{
			if(stato==null && interventoDatiDTO==null)
			{
				 s_query = "from CertificatoDTO";
				 query = session.createQuery(s_query);
			}
			
			if(stato!=null && interventoDatiDTO==null)
			{
				 s_query = "from CertificatoDTO WHERE stato.id = :_stato";
				 query = session.createQuery(s_query);
				 query.setParameter("_stato",stato.getId());
				 
			}
			
			if(stato==null && interventoDatiDTO!=null)
			{
				 s_query = "from CertificatoDTO WHERE misura.interventoDati.id= :_idInterventoDati ";
				 query = session.createQuery(s_query);
				 query.setParameter("_idInterventoDati",interventoDatiDTO.getId());
			}
			
			if(stato!=null && interventoDatiDTO!=null)
			{
				 s_query = "from CertificatoDTO WHERE misura.interventoDati.id= _idInterventoDati AND stato.id = :_stato";
				 query = session.createQuery(s_query);
				 query.setParameter("_idInterventoDati",interventoDatiDTO.getId());
				 query.setParameter("_stato",stato.getId());
				 
			}
		}
		else
		{
				if(stato==null && interventoDatiDTO==null)
				{
					 s_query = "from CertificatoDTO WHERE misura.intervento.company.id =:_company";
					 query = session.createQuery(s_query);
					 query.setParameter("_company",cmp.getId());
				}
				
				if(stato!=null && interventoDatiDTO==null)
				{
					 s_query = "from CertificatoDTO WHERE stato.id = :_stato AND misura.intervento.company.id =:_company";
					 query = session.createQuery(s_query);
					 query.setParameter("_stato",stato.getId());
					 query.setParameter("_company",cmp.getId());
					 
				}
				
				if(stato==null && interventoDatiDTO!=null)
				{
					 s_query = "from CertificatoDTO WHERE misura.interventoDati.id= :_idInterventoDati AND misura.intervento.company.id =:_company ";
					 query = session.createQuery(s_query);
					 query.setParameter("_idInterventoDati",interventoDatiDTO.getId());
					 query.setParameter("_company",cmp.getId());
				}
				
				if(stato!=null && interventoDatiDTO!=null)
				{
					 s_query = "from CertificatoDTO WHERE misura.interventoDati.id= _idInterventoDati AND stato.id = :_stato AND misura.intervento.company.id =:_company";
					 query = session.createQuery(s_query);
					 query.setParameter("_idInterventoDati",interventoDatiDTO.getId());
					 query.setParameter("_stato",stato.getId());
					 query.setParameter("_company",cmp.getId());
					 
				}
		}       
	    listaCertificato=(ArrayList<CertificatoDTO>)query.list();
		session.getTransaction().commit();
		session.close();
		
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
				throw ex;
		}
	     
		return listaCertificato;
		
	}

	public static CertificatoDTO getCertificatoByMisura(MisuraDTO misuraDTO)throws Exception {
		
		Query query=null;
		CertificatoDTO certificato = null;
		try
		{	
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
		String s_query ="";
		
		 s_query = "from CertificatoDTO WHERE misura.id= :_idMisura";
			 query = session.createQuery(s_query);
			 query.setParameter("_idMisura",misuraDTO.getId());
	       
	    
			 ArrayList<CertificatoDTO> listaCert = (ArrayList<CertificatoDTO>)query.list();
	   

			 if(listaCert.isEmpty()) {
				 certificato = null;
			 }else {
				 certificato=listaCert.get(0);
			 }
			 
		session.getTransaction().commit();
		session.close();
		
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
				throw ex;
		}
	     
		return certificato;
		
	}

	public static CertificatoDTO getCertificatoById(String id) {
		Query query=null;
		CertificatoDTO  certificato=null;

		try
		{	
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
		String s_query ="";
		
		
			 s_query = "from CertificatoDTO WHERE id = :_id";
			 query = session.createQuery(s_query);
			 query.setParameter("_id",Integer.parseInt(id));
			 
	
		          
	    certificato=(CertificatoDTO)query.list().get(0);
		session.getTransaction().commit();
		session.close();
		
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
				throw ex;
		}
	     
		return certificato;
	}
}
