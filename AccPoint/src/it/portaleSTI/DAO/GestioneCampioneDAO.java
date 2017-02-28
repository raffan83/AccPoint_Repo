package it.portaleSTI.DAO;

import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.PrenotazioneDTO;
import it.portaleSTI.DTO.ValoreCampioneDTO;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;



public class GestioneCampioneDAO {

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
	
	String s_query = "from ValoreCampioneDTO WHERE id__campione_ = :_id";
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




	public static HashMap<Integer, Integer> getListPrenotazioni() throws HibernateException, Exception {

		HashMap<Integer, Integer> pren=new HashMap<>();
		
		Session session=SessionFacotryDAO.get().openSession();
		
		session.beginTransaction();
		Query query  = session.createQuery( "from PrenotazioneDTO" );
	    
		List<PrenotazioneDTO> result =query.list();
		
		for (PrenotazioneDTO prenotazione  :result)
		{
			pren.put(prenotazione.getId_campione(), prenotazione.getStato());
		}
		
		
		session.getTransaction().commit();
		session.close();
		
		return pren;	
		
	}
	}
