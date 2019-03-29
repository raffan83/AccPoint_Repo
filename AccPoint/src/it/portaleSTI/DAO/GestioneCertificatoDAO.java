package it.portaleSTI.DAO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.InterventoDatiDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.StatoCertificatoDTO;
import it.portaleSTI.DTO.UtenteDTO;

public class GestioneCertificatoDAO {

	public static ArrayList<CertificatoDTO> getListaCertificati(StatoCertificatoDTO stato,InterventoDatiDTO interventoDatiDTO, CompanyDTO cmp, UtenteDTO utente, String obsoleto, String idCliente, String idSede)throws Exception {
		
		Query query=null;
		ArrayList<CertificatoDTO>  listaCertificato=null;

		try
		{	
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
		String s_query ="from CertificatoDTO";
		Boolean isWhere = true;
		Boolean isAnd = false;
					
		if(stato!=null)
		{
			if(isWhere) {
				 s_query += " WHERE ";
				 isWhere = false;
			}
			
			if(isAnd) {
				 s_query += " AND ";
			}
			isAnd = true;
			
			 s_query += "stato.id = "+stato.getId();
		
			 
		}
		
		if(obsoleto != null)
		{
			if(isWhere) {
				 s_query += " WHERE ";
				 isWhere = false;
			}
			
			if(isAnd) {
				 s_query += " AND ";
			}
			isAnd = true;
			
			 s_query += "misura.obsoleto = '"+obsoleto+"'";
	
			 
		}
		
		if(interventoDatiDTO!=null)
		{
			if(isWhere) {
				 s_query += " WHERE ";
				 isWhere = false;
			}
			
			if(isAnd) {
				 s_query += " AND ";
			}
			isAnd = true;
			
			 s_query += "misura.interventoDati.id= "+interventoDatiDTO.getId();
			
		}


		if(idCliente!=null)
		{
			if(isWhere) {
				 s_query += " WHERE ";
				 isWhere = false;
			}
			
			if(isAnd) {
				 s_query += " AND ";
			}
			isAnd = true;
			
			 s_query += "misura.intervento.id_cliente= "+Integer.parseInt(idCliente);
			
		}
		
		if(idSede!=null)
		{
			if(isWhere) {
				 s_query += " WHERE ";
				 isWhere = false;
			}
			
			if(isAnd) {
				 s_query += " AND ";
			}
			isAnd = true;
			
			 s_query += "misura.intervento.idSede= "+Integer.parseInt(idSede);
			
		}
		
		if(!utente.isTras())
		{
		
			if(isWhere) {
				 s_query += " WHERE ";
				 isWhere = false;
			}
			
			if(isAnd) {
				 s_query += " AND ";
			}
			isAnd = true;
			
			 s_query += "misura.intervento.company.id = "+cmp.getId();

			
		}
		
		query = session.createQuery(s_query);
			  
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
	
	
public static ArrayList<CertificatoDTO> getListaCertificatiByIntervento(StatoCertificatoDTO stato,InterventoDTO interventoDTO, CompanyDTO cmp, UtenteDTO utente, String obsoleto, String idCliente, String idSede)throws Exception {
		
		Query query=null;
		ArrayList<CertificatoDTO>  listaCertificato=null;

		try
		{	
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
		String s_query ="from CertificatoDTO";
		Boolean isWhere = true;
		Boolean isAnd = false;
					
		if(stato!=null)
		{
			if(isWhere) {
				 s_query += " WHERE ";
				 isWhere = false;
			}
			
			if(isAnd) {
				 s_query += " AND ";
			}
			isAnd = true;
			
			 s_query += "stato.id = "+stato.getId();
		
			 
		}
		
		if(obsoleto != null)
		{
			if(isWhere) {
				 s_query += " WHERE ";
				 isWhere = false;
			}
			
			if(isAnd) {
				 s_query += " AND ";
			}
			isAnd = true;
			
			 s_query += "misura.obsoleto = '"+obsoleto+"'";
	
			 
		}
		
		if(interventoDTO!=null)
		{
			if(isWhere) {
				 s_query += " WHERE ";
				 isWhere = false;
			}
			
			if(isAnd) {
				 s_query += " AND ";
			}
			isAnd = true;
			
			 s_query += "misura.intervento.id= "+interventoDTO.getId();
			
		}


		if(idCliente!=null)
		{
			if(isWhere) {
				 s_query += " WHERE ";
				 isWhere = false;
			}
			
			if(isAnd) {
				 s_query += " AND ";
			}
			isAnd = true;
			
			 s_query += "misura.intervento.id_cliente= "+Integer.parseInt(idCliente);
			
		}
		
		if(idSede!=null)
		{
			if(isWhere) {
				 s_query += " WHERE ";
				 isWhere = false;
			}
			
			if(isAnd) {
				 s_query += " AND ";
			}
			isAnd = true;
			
			 s_query += "misura.intervento.idSede= "+Integer.parseInt(idSede);
			
		}
		
		if(!utente.isTras())
		{
		
			if(isWhere) {
				 s_query += " WHERE ";
				 isWhere = false;
			}
			
			if(isAnd) {
				 s_query += " AND ";
			}
			isAnd = true;
			
			 s_query += "misura.intervento.company.id = "+cmp.getId();

			
		}
		
		query = session.createQuery(s_query);
			  
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

//	public static LinkedHashMap<String, String> getClientiPerCertificato()throws Exception {
//		
//		Query query=null;
//		LinkedHashMap<String, String> lista= new LinkedHashMap<>();
//		try
//		{	
//		Session session = SessionFacotryDAO.get().openSession();
//	    
//		session.beginTransaction();
//		
//		String s_query ="";
//		
//		 s_query = "select DISTINCT(int.misura.intervento.nome_sede),int.misura.intervento.nome_cliente,int.misura.intervento.id_cliente,int.misura.intervento.idSede from CertificatoDTO as int order by int.misura.intervento.nome_cliente asc";
//			 query = session.createQuery(s_query);
//			 
//	    
//			 List<Object> listaCert =query.list();
//	   
//			 for (int i = 0; i < listaCert.size(); i++) 
//			 {
//				 Object[] obj=(Object[]) listaCert.get(i);
//
//				 String key = obj[2]+"_"+obj[3];
//
//
//				 if(!lista.containsKey(key)) {
//					 String val ="";
//					 if(obj[1]!=null) {
//						 val += obj[1]+" - ";
//					 }
//					 if(obj[0]!=null) {
//						 val += obj[0];
//					 }
//					 
//					 lista.put(key, val);
//				 }
//				
//				 
//				
//			}
//			 
//		session.getTransaction().commit();
//		session.close();
//		
//		}
//		catch(Exception ex)
//		{
//			ex.printStackTrace();
//				throw ex;
//		}
//	     
//		return lista;
//		
//	}
	
	
public static LinkedHashMap<String, String> getClientiPerCertificato(int id_company, UtenteDTO utente)throws Exception {
		
		Query query=null;
		LinkedHashMap<String, String> lista= new LinkedHashMap<>();
		try
		{	
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
		String s_query ="";
		
			if(utente.isTras()) 
			{
				 s_query = "select DISTINCT(int.misura.intervento.nome_sede),int.misura.intervento.nome_cliente,int.misura.intervento.id_cliente,int.misura.intervento.idSede from CertificatoDTO as int order by int.misura.intervento.nome_cliente asc";
				 query = session.createQuery(s_query);
			}else 
			{
				 s_query = "select DISTINCT(int.misura.intervento.nome_sede),int.misura.intervento.nome_cliente,int.misura.intervento.id_cliente,int.misura.intervento.idSede from CertificatoDTO as int where int.misura.intervento.company.id = :_id_company order by int.misura.intervento.nome_cliente asc";
				 query = session.createQuery(s_query);
				 query.setParameter("_id_company", id_company);
			}
		    
	    
			 List<Object> listaCert =query.list();
	   
			 for (int i = 0; i < listaCert.size(); i++) 
			 {
				 Object[] obj=(Object[]) listaCert.get(i);

				 String key = obj[2]+"_"+obj[3];


				 if(!lista.containsKey(key)) {
					 String val ="";
					 if(obj[1]!=null) {
						 val += obj[1]+" - ";
					 }
					 if(obj[0]!=null) {
						 val += obj[0];
					 }
					 
					 lista.put(key, val);
				 }
				
				 
				
			}
			 
		session.getTransaction().commit();
		session.close();
		
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
				throw ex;
		}
	     
		return lista;
		
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


	public static ArrayList<CertificatoDTO> getListaCertificatiCampioneStrumento(Integer id_strumento, Session session) {
		
		ArrayList<CertificatoDTO> lista = null;
		
		Query query =session.createQuery("from CertificatoDTO where misura.strumento.__id =:_id_strumento");
		query.setParameter("_id_strumento", id_strumento);
		

	          
		lista=(ArrayList<CertificatoDTO>)query.list();
		
		
		return lista;
	}
}
