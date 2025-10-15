package it.portaleSTI.DAO;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.OffOffertaArticoloDTO;
import it.portaleSTI.DTO.OffOffertaDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerInterventoDTO;
import it.portaleSTI.DTO.VerInterventoStrumentiDTO;
import it.portaleSTI.DTO.VerMisuraDTO;
import it.portaleSTI.DTO.VerStrumentoDTO;

public class GestioneVerInterventoDAO {

	public static ArrayList<VerInterventoDTO> getListaVerInterventi(UtenteDTO utente, String dateFrom, String dateTo, Session session) throws HibernateException, ParseException {
		
		ArrayList<VerInterventoDTO> lista = null;
		Query query = null;
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		if(utente.isTras()) {
						
			query = session.createQuery("from VerInterventoDTO where data_creazione between :_dateFrom and :_dateTo");
			
		}else {
			
			query = session.createQuery("from VerInterventoDTO where company.id = :_id_company and data_creazione between :_dateFrom and :_dateTo");
			query.setParameter("_id_company", utente.getCompany().getId());
		}		
		
		query.setParameter("_dateFrom", sdf.parse(dateFrom));
		query.setParameter("_dateTo", sdf.parse(dateTo));
		
		lista = (ArrayList<VerInterventoDTO>) query.list();
		
		return lista;
	}

	public static VerInterventoDTO getInterventoFromId(int id_intervento, Session session) {
		
		ArrayList<VerInterventoDTO> lista = null;
		VerInterventoDTO result = null;
		
		Query query = session.createQuery("from VerInterventoDTO where id = :_id");
		query.setParameter("_id", id_intervento);
		
		lista = (ArrayList<VerInterventoDTO>) query.list();
		if(lista.size()>0) {
			result = lista.get(0);
		}
		
		return result;
	}

	public static ArrayList<VerMisuraDTO> getListaMisureFromIntervento(int id_intervento, Session session) {
		
		ArrayList<VerMisuraDTO> lista = null;
			
		Query query = session.createQuery("from VerMisuraDTO where verIntervento.id = :_id_intervento");
		query.setParameter("_id_intervento", id_intervento);
		
		lista = (ArrayList<VerMisuraDTO>) query.list();
		
		return lista;
	}

	public static boolean isPresentVerStrumento(int id_intevento, VerStrumentoDTO verStrumento, Session session) {

		if(verStrumento.getCreato().equals("S")) 
		{
			return false;
		}
		
		Query query=null;
		boolean isPresent=false;
		List<MisuraDTO> misura=null;
		try {
			Session session1=SessionFacotryDAO.get().openSession();	
			session1.beginTransaction();
			
		String s_query = "from VerMisuraDTO WHERE verIntervento.id = :_intervento AND verStrumento.id =:_strumento";
						  
	    query = session1.createQuery(s_query);
	    query.setParameter("_intervento",id_intevento);
	    query.setParameter("_strumento",verStrumento.getId());
		
	    misura=(List<MisuraDTO>)query.list();
		
	    session1.getTransaction().commit();
		session1.close();
		
	    if(misura.size()>0)
	    {
	    	return true;
	    }
	    	else
	    {
	    	return false;
	    }
	    
	    
		
	     } catch(Exception e)
	     {
	    	 e.printStackTrace();
	     }
		
		
		return isPresent;
	}

	public static ArrayList<VerMisuraDTO> getMisuraObsoleta(int id, String idStr) {
		
		Query query=null;
		ArrayList<VerMisuraDTO> misura=new ArrayList<VerMisuraDTO>();

			
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
		String s_query = "from VerMisuraDTO WHERE verIntervento.id = :_idIntervento AND verStrumento.id =:_idStrumento";
					  //  from MisuraDTO WHERE intervento.id =36              
	    query = session.createQuery(s_query);
	    query.setParameter("_idIntervento",id);
	    query.setParameter("_idStrumento",Integer.parseInt(idStr));
		
	    misura=(ArrayList<VerMisuraDTO>)query.list();
		session.getTransaction().commit();
		session.close();

	     
		return misura;
	}

	public static void misuraObsoleta(VerMisuraDTO misura, Session session) {


		Query query=null;
		
		
		String s_query = "update VerMisuraDTO SET obsoleta='S' WHERE id = :_id";
						  
	    query = session.createQuery(s_query);
	    query.setParameter("_id",misura.getId());
		
	   query.executeUpdate();
	}

	public static VerInterventoStrumentiDTO getInterventoStrumento(int id_intervento, int id_strumento, Session session) {

		ArrayList<VerInterventoStrumentiDTO> lista = null;
		VerInterventoStrumentiDTO result = null;			

		Query query = session.createQuery("from VerInterventoStrumentiDTO WHERE id_intervento = :_idIntervento AND verStrumento.id =:_idStrumento");
	    query.setParameter("_idIntervento",id_intervento);
	    query.setParameter("_idStrumento",id_strumento);
		
	    lista = (ArrayList<VerInterventoStrumentiDTO>)query.list();
	    
	    if(lista.size()>0) {
	    	result = lista.get(0);
	    }
	    
		return result;
	}

	public static ArrayList<VerInterventoDTO> getListaInterventiCommessa(String idCommessa, Session session) {

		ArrayList<VerInterventoDTO> lista = null;
				

		Query query = session.createQuery("from VerInterventoDTO WHERE commessa= :_idCommessa");
	    query.setParameter("_idCommessa",idCommessa);
	    		
	    lista = (ArrayList<VerInterventoDTO>)query.list();
	    
	    
		return lista;
	}

	public static ArrayList<OffOffertaDTO> getListaOfferte(UtenteDTO utente, Session session) {
		ArrayList<OffOffertaDTO> lista = null;

		String str = "";
		if(!utente.isTras()) {
			str = " where utente = :_utente";
		}

		Query query = session.createQuery("from OffOffertaDTO" +str);
		if(!utente.isTras()) {
			query.setParameter("_utente", utente.getCodice_agente());
		}
	    		
	    lista = (ArrayList<OffOffertaDTO>)query.list();
	    
	    
		return lista;
	}
	
	public static ArrayList<OffOffertaArticoloDTO> getListaOfferteArticoli(int id_offerta, Session session) {
		ArrayList<OffOffertaArticoloDTO> lista = null;


		Query query = session.createQuery("from OffOffertaArticoloDTO where offerta.id = :_id" );
	
			query.setParameter("_id", id_offerta);
	
	    		
	    lista = (ArrayList<OffOffertaArticoloDTO>)query.list();
	    
	    
		return lista;
	}
}
