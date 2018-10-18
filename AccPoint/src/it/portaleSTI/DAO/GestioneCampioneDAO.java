package it.portaleSTI.DAO;

import it.portaleSTI.DTO.AttivitaManutenzioneDTO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CertificatoCampioneDTO;
import it.portaleSTI.DTO.TipoManutenzioneDTO;
import it.portaleSTI.DTO.PrenotazioneDTO;
import it.portaleSTI.DTO.RegistroEventiDTO;
import it.portaleSTI.DTO.TipoAttivitaManutenzioneDTO;
import it.portaleSTI.DTO.ValoreCampioneDTO;
import it.portaleSTI.action.ValoriCampione;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.criterion.Restrictions;



public class GestioneCampioneDAO {

	private static String updateCompanyUtilizzatoreCampione="UPDATE campione set id_company_utilizzatore=? WHERE __id=?";

	public static ArrayList<CampioneDTO> getListaCampioni(String date, int idCompany) {
		Query query=null;
		ArrayList<CampioneDTO> list=null;
		try {
			
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
		if(idCompany==0)
		{
		
		
				if(date!=null)
				{
				String s_query = "from CampioneDTO WHERE data_scadenza = :date";
			    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		        Date dt = df.parse(date);
			    query = session.createQuery(s_query);
			    query.setParameter("date",dt);
				}
				else
				{
			     query  = session.createQuery( "from CampioneDTO");
				}
		}
		else
		{
			if(date!=null)
			{
			String s_query = "from CampioneDTO WHERE data_scadenza = :date AND id_Company=:_idc";
		    DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	        Date dt = df.parse(date);
		    query = session.createQuery(s_query);
		    query.setParameter("date",dt);
		    query.setParameter("_idc", idCompany);
			}
			else
			{
		     query  = session.createQuery( "from CampioneDTO WHERE id_Company=:_idc");
		     query.setParameter("_idc", idCompany);
			}
		}
		
		list = (ArrayList<CampioneDTO>)query.list();
		
		session.getTransaction().commit();
		session.close();
	
	     } catch(Exception e)
	     {
	    	 e.printStackTrace();
	     } 
		return list;

	}
	
	

	
	public static ArrayList<ValoreCampioneDTO> getListaValori(int id){
	Query query=null;
	ArrayList<ValoreCampioneDTO> list=null;
	try {
		
	Session session = SessionFacotryDAO.get().openSession();
    
	session.beginTransaction();
	
	String s_query = "from ValoreCampioneDTO WHERE id__campione_ = :_id AND obsoleto='N'";
    query = session.createQuery(s_query);
    query.setParameter("_id",id);
	
	list = (ArrayList<ValoreCampioneDTO>)query.list();
	
	session.getTransaction().commit();
	session.close();

     } catch(Exception e)
     {
    	 e.printStackTrace();
     } 
	return list;

	}




	
	
	public static void updateStatoCampione(PrenotazioneDTO prenotazione) throws Exception {
		
		Connection con =null;
		PreparedStatement pst =null;
		
		try 
		{
		 con =DirectMySqlDAO.getConnection();
		 pst=con.prepareStatement(updateCompanyUtilizzatoreCampione);
		 
	//	 pst.setInt(1, prenotazione.getId_companyRichiedente());
	//	 pst.setInt(2, prenotazione.getId_campione());
		 
		 pst.execute();
		} 
		catch (Exception e) {
			throw e;
		}
		
		}
	public static CampioneDTO getCampioneFromId(String campioneId) throws Exception{
		try 
		{
			Session session = SessionFacotryDAO.get().openSession();	    
			session.beginTransaction();
			
			CampioneDTO campione = (CampioneDTO) session.get(CampioneDTO.class, Integer.parseInt(campioneId));
			session.close();
			
			return campione;
		}catch (Exception e){
			throw e;
		}

	}
	public static ValoreCampioneDTO getValoreFromId(String valoreC) throws Exception{
		try 
		{
			Session session = SessionFacotryDAO.get().openSession();	    
			session.beginTransaction();
			
			ValoreCampioneDTO valoreCampione = (ValoreCampioneDTO) session.get(ValoreCampioneDTO.class, Integer.parseInt(valoreC));
			session.close();
			
			return valoreCampione;
		}catch (Exception e){
			throw e;
		}

	}

	public static CampioneDTO getCampioneFromCodice(String codice) {
		Query query=null;
		CampioneDTO campione=null;
		try {
			
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
		String s_query = "from CampioneDTO WHERE codice = :_codice ";
	    query = session.createQuery(s_query);
	    query.setParameter("_codice",codice);

	    
	    
	    if(query.list().size()>0)
	    {
	    	campione = (CampioneDTO)query.list().get(0);
	    }
		session.getTransaction().commit();
		session.close();

	     } catch(Exception e)
	     {
	    	 e.printStackTrace();
	     } 
		return campione;
	}

	public static CampioneDTO getCampioneFromCodiceCertificato(String codice) {
		Query query=null;
		CampioneDTO campione=null;
		try {
			
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
		String s_query = "from CampioneDTO cp JOIN cp.listaCertificatiCampione ccp WHERE codice = :_codice AND ccp.obsoleto='N'";
	    query = session.createQuery(s_query);
	    query.setParameter("_codice",codice);

	    
	    
	    if(query.list().size()>0)
	    {
	    	campione = (CampioneDTO)query.list().get(0);
	    }
		session.getTransaction().commit();
		session.close();

	     } catch(Exception e)
	     {
	    	 e.printStackTrace();
	     } 
		return campione;
	}



	public static int saveCertifiactoCampione(
		CertificatoCampioneDTO certificatoCampioneDTO, Session session) {
		
		
		return (Integer) session.save(certificatoCampioneDTO);
	}


	public static void updateCertificatoCampione(
			CertificatoCampioneDTO certificatoCampioneDTO, Session session) {
	
		session.update(certificatoCampioneDTO);
		
	}




	public static void rendiObsoletiValoriCampione(Session session, int id) {
		
		Query query=null;
		try {
	    
		session.beginTransaction();
		
		String s_query = "UPDATE ValoreCampioneDTO set obsoleto = 'S' WHERE campione.id = :_id";

		query = session.createQuery(s_query);
	
		query.setParameter("_id", id);

	    query.executeUpdate();
		
	  
	     } catch(Exception e)
	     {
	    	 e.printStackTrace();
	    	 throw e;
	     } 
		
	}




	public static void saveValoreCampione(Session session,ValoreCampioneDTO valoreCampioneDTO)throws Exception {
		
		session.save(valoreCampioneDTO);
		
	}




	public static CertificatoCampioneDTO getCertifiactoCampioneById(String idCert) throws Exception{
		Query query=null;
		CertificatoCampioneDTO campione=null;
		try {
			
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
		String s_query = "from CertificatoCampioneDTO WHERE id = :_id";
	    query = session.createQuery(s_query);
	    query.setParameter("_id",Integer.parseInt(idCert));
		
	    if(query.list().size()>0)
	    {
	    	campione = (CertificatoCampioneDTO)query.list().get(0);
	    }
		session.getTransaction().commit();
		session.close();

	     } catch(Exception e)
	     {
	    	 e.printStackTrace();
	    	 throw e;
	     } 
		return campione;
	}




	public static ArrayList<RegistroEventiDTO> getListaRegistroEventi(String id_campione, Session session) {
		
		ArrayList<RegistroEventiDTO> evento = null;
		
		Query query = session.createQuery("from RegistroEventiDTO where campione.id = :_campione");
		
		query.setParameter("_campione", Integer.parseInt(id_campione));
		
		evento = (ArrayList<RegistroEventiDTO>) query.list();
		
		return evento;
	}




	public static void saveEventoRegistro(RegistroEventiDTO evento, Session session) {
		session.save(evento);
		
	}
	

	public static void saveAttivitaManutenzione(AttivitaManutenzioneDTO attivita, Session session) {
		session.save(attivita);
		
	}

	public static ArrayList<AttivitaManutenzioneDTO> getListaAttivitaManutenzione(int id_evento, Session session_) throws HibernateException{
		
		
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
		ArrayList<AttivitaManutenzioneDTO> lista = null;
		
		Query query = session.createQuery("from AttivitaManutenzioneDTO where evento.id = :_id_evento");
		
		query.setParameter("_id_evento", id_evento);
		
		lista = (ArrayList<AttivitaManutenzioneDTO>) query.list();
		
		session.getTransaction().commit();
		session.close();
		
		return lista;
	}




	public static CertificatoCampioneDTO getCertificatoFromCampione(int id_campione, Session session) {
		
		CertificatoCampioneDTO lista = null;
		
		Query query = session.createQuery("from CertificatoCampioneDTO where id_campione = :_id_campione");
		
		query.setParameter("_id_campione", id_campione);
		
		lista = (CertificatoCampioneDTO) query.list().get(0);
		
		return lista;
	}




	public static ArrayList<TipoManutenzioneDTO> getListaTipoManutenzione(Session session) {

		ArrayList<TipoManutenzioneDTO> lista = null;
		
		Query query = session.createQuery("from TipoManutenzioneDTO");
		
		lista = (ArrayList<TipoManutenzioneDTO>) query.list();
		
		return lista;
	}




	public static ArrayList<TipoAttivitaManutenzioneDTO> getListaTipoAttivitaManutenzione(Session session) {
		ArrayList<TipoAttivitaManutenzioneDTO> lista = null;
		
		Query query = session.createQuery("from TipoAttivitaManutenzioneDTO");
		
		lista = (ArrayList<TipoAttivitaManutenzioneDTO>) query.list();
		
		return lista;
	}




	public static RegistroEventiDTO getEventoFromId(int id_evento) {
		
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
		RegistroEventiDTO evento = null;
		
		Query query = session.createQuery("from RegistroEventiDTO where id = :_id_evento");
		
		query.setParameter("_id_evento", id_evento);
		
		evento = (RegistroEventiDTO) query.list().get(0);
		session.close();
		return evento;	
	}




	public static ArrayList<CampioneDTO> getListaCampioniPrenotabili() {
		Query query=null;
		ArrayList<CampioneDTO> list=new ArrayList<CampioneDTO>();
		try {
			
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
		
	   String s_query = "from CampioneDTO WHERE prenotabile = 'S'";

       query = session.createQuery(s_query);
			  
		
		
		list = (ArrayList<CampioneDTO>)query.list();
		
		session.getTransaction().commit();
		session.close();
	
	     } catch(Exception e)
	     {
	    	 e.printStackTrace();
	     } 
		return list;
	}
	
	


	
	}
