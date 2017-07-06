package it.portaleSTI.DAO;

import it.portaleSTI.DTO.PrenotazioneDTO;

import java.util.List;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

public class GestionePrenotazioneDAO {




//private static String sqlUpdatePrenotazione="UPDATE prenotazioni_campione SET stato=?, dataGestione=now(),noteApprovazione=? WHERE id=?";
	
	
public static List<PrenotazioneDTO> getListPrenotazioni() throws HibernateException, Exception {

		
		List<PrenotazioneDTO> lista =null;
		
		Session session=SessionFacotryDAO.get().openSession();
		
		session.beginTransaction();
		Query query  = session.createQuery( "from PrenotazioneDTO" );
	    
	    lista =query.list();

		session.getTransaction().commit();
		session.close();
		
		return lista;	
		
	}
	
	public static List<PrenotazioneDTO> getListaPrenotazione(String idC) {
	
		List<PrenotazioneDTO> lista =null;
		
		Session session=SessionFacotryDAO.get().openSession();
		
		session.beginTransaction();
		
		Query query  = session.createQuery( "from PrenotazioneDTO where campione.id=:_idc" );
		
		query.setParameter("_idc", Integer.parseInt(idC));
	    
	    lista =query.list();

		session.getTransaction().commit();
		session.close();
		
			return lista;	
	}
	public static List<PrenotazioneDTO> getListaPrenotazioneNG(int idC) {
		
		List<PrenotazioneDTO> lista =null;
		
		Session session=SessionFacotryDAO.get().openSession();
		
		session.beginTransaction();
		
		Query query  = session.createQuery( "from PrenotazioneDTO where companyRichiedente.id=:_idc" );
		
		query.setParameter("_idc", idC);
	    
	    lista =query.list();

		session.getTransaction().commit();
		session.close();
		
			return lista;	
	}
	public static List<PrenotazioneDTO> getListaPrenotazioniRichieste(int myId) throws Exception 
	
	{
			
			List<PrenotazioneDTO> lista =null;
			
			Session session=SessionFacotryDAO.get().openSession();
			
			session.beginTransaction();
			
			Query query  = session.createQuery( "from PrenotazioneDTO where campione.company.id=:_myId and stato=0" );
			
			query.setParameter("_myId", myId);
		    
		    lista =query.list();

			session.getTransaction().commit();
			session.close();
			
				return lista;	
		
	}
	
public static List<PrenotazioneDTO> getListaPrenotazioniGestite(int myId) throws Exception 
	
	{
			
			List<PrenotazioneDTO> lista =null;
			
			Session session=SessionFacotryDAO.get().openSession();
			
			session.beginTransaction();
			
			Query query  = session.createQuery( "from PrenotazioneDTO where campione.company.id=:_myId and stato<>0" );
			
			query.setParameter("_myId", myId);
		    
		    lista =query.list();

			session.getTransaction().commit();
			session.close();
			
				return lista;	
		
	}

		public static void updatePrenotazione(PrenotazioneDTO prenotazione, Session session) throws Exception {
			

			
				 session.update(prenotazione);
		
			
		}

		public static PrenotazioneDTO getPrenotazione(int idPrenotazione) {
			
			Query query=null;
			PrenotazioneDTO prenotazione=null;
			try {
				
			Session session = SessionFacotryDAO.get().openSession();
		    
			session.beginTransaction();
			
			String s_query = "from PrenotazioneDTO WHERE id = :_id";
		    query = session.createQuery(s_query);
		    query.setParameter("_id",idPrenotazione);
			
		    prenotazione=(PrenotazioneDTO)query.list().get(0);
			session.getTransaction().commit();
			session.close();

		     } catch(Exception e)
		     {
		    	 e.printStackTrace();
		     }
			return prenotazione;
		}

		public static void savePrenotazione(PrenotazioneDTO prenotazione, Session session) {

				session.save(prenotazione);

		}

}
