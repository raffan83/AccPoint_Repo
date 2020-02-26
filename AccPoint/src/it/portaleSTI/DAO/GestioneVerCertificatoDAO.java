package it.portaleSTI.DAO;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerCertificatoDTO;
import it.portaleSTI.DTO.VerEmailDTO;
import it.portaleSTI.DTO.VerMisuraDTO;

public class GestioneVerCertificatoDAO {

	public static VerCertificatoDTO getCertificatoByMisura(VerMisuraDTO misuraDTO)throws Exception {
		
		Query query=null;
		VerCertificatoDTO certificato = null;
		try
		{	
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
		String s_query ="";
		
		 s_query = "from VerCertificatoDTO WHERE misura.id= :_idMisura";
			 query = session.createQuery(s_query);
			 query.setParameter("_idMisura",misuraDTO.getId());
	       
	    
			 ArrayList<VerCertificatoDTO> listaCert = (ArrayList<VerCertificatoDTO>)query.list();
	   

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
	
	
public static LinkedHashMap<String, String> getClientiPerVerCertificato(UtenteDTO utente, Session session)throws Exception {
		
		Query query=null;
		LinkedHashMap<String, String> lista= new LinkedHashMap<>();
		String  s_query = "";
		if(utente.isTras()) {
			s_query = "select DISTINCT(int.misura.verIntervento.nome_sede),int.misura.verIntervento.nome_cliente,int.misura.verIntervento.id_cliente,int.misura.verIntervento.id_sede from VerCertificatoDTO as int order by int.misura.verIntervento.nome_cliente asc";
			query = session.createQuery(s_query);
		}else {
			s_query = "select DISTINCT(int.misura.verIntervento.nome_sede),int.misura.verIntervento.nome_cliente,int.misura.verIntervento.id_cliente,int.misura.verIntervento.id_sede from VerCertificatoDTO as int where int.misura.verIntervento.company.id = :_id_company order by int.misura.verIntervento.nome_cliente asc";
			query = session.createQuery(s_query);
			query.setParameter("_id_company", utente.getCompany().getId());
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
			 

		return lista;
		
	}


public static ArrayList<VerCertificatoDTO> getListaCertificati(int stato,int filtro_emissione, int idCliente, int idSede,String company, boolean obsoleti,Session session) {
	
	ArrayList<VerCertificatoDTO> lista = null;	
	String s_query = "";
	
	if(idCliente == 0 && idSede== 0) {
		if(company!=null && !company.equals("")) {
			s_query = "from VerCertificatoDTO certificato WHERE certificato.misura.verIntervento.company.id =:_company";
		}else {
			s_query = "from VerCertificatoDTO certificato";	
		}
		
	}else {
		s_query ="from VerCertificatoDTO certificato WHERE certificato.misura.verIntervento.id_cliente = :_id_cliente and certificato.misura.verIntervento.id_sede = :_id_sede"; 
	}		
	
	if(obsoleti) {
		
		if(idCliente == 0 && idSede== 0) {
			if(company!=null && !company.equals("")) {
				s_query = s_query +" and certificato.misura.obsoleta='S'";
			}else {
				s_query = s_query +" where certificato.misura.obsoleta='S'";
			}
		}else {
			s_query = s_query +" and certificato.misura.obsoleta='S'";
		}
		
		Query query = session.createQuery(s_query);
		if(idCliente != 0) {
			query.setParameter("_id_cliente",idCliente);
			query.setParameter("_id_sede",idSede);			
		}
		if(company!=null && !company.equals("")) {
			query.setParameter("_company",Integer.parseInt(company));
		}
		lista = (ArrayList<VerCertificatoDTO>)query.list();
		
	}else {
	
		if(idCliente!=0 && stato!=0) {
			s_query = s_query + " and certificato.stato.id= :_stato";	
			s_query = s_query + "  and certificato.misura.obsoleta='N'";			 
		}else if(idCliente == 0 && stato!=0) {
			if(company!=null && !company.equals("")) {
				s_query = s_query + " and certificato.stato.id= :_stato";
				
			}else {
				s_query = s_query + " where certificato.stato.id= :_stato";	
			}			
			s_query = s_query + "  and certificato.misura.obsoleta='N'";
		}
		
		if(stato!=0) {
			s_query = s_query +" and certificato.firmato = :_filtro_emissione";
		}
					
		Query query = session.createQuery(s_query);
		if(stato != 0) {
			query.setParameter("_stato",stato);
			query.setParameter("_filtro_emissione",filtro_emissione);	
		}	
		if(idCliente != 0) {
			query.setParameter("_id_cliente",idCliente);
			query.setParameter("_id_sede",idSede);
		}
			
		if(company!=null && !company.equals("")) {
			query.setParameter("_company",Integer.parseInt(company));
		}
		
		lista = (ArrayList<VerCertificatoDTO>)query.list();
	}

	return lista;
}


public static VerCertificatoDTO getCertificatoById(int id, Session session) {

	ArrayList<VerCertificatoDTO> lista = null;	
	VerCertificatoDTO result = null;

	Query query = session.createQuery("from VerCertificatoDTO where id = :_id");

	query.setParameter("_id",id);
    
	lista = (ArrayList<VerCertificatoDTO>)query.list();
	
	if(lista!=null && lista.size()>0) {
		result = lista.get(0);
	}

	return result;
}


public static ArrayList<VerEmailDTO> getListaEmailCertificato(int id_certificato, Session session) {
	
	ArrayList<VerEmailDTO> lista = null;	

	Query query = session.createQuery("from VerEmailDTO where certificato.id = :_id");

	query.setParameter("_id",id_certificato);
    
	lista = (ArrayList<VerEmailDTO>)query.list();
	
	
	return lista;
}


}
