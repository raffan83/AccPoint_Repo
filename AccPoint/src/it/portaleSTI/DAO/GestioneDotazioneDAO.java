package it.portaleSTI.DAO;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.AccessorioDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.DotazioneDTO;
import it.portaleSTI.DTO.TipologiaAccessoriDTO;
import it.portaleSTI.DTO.TipologiaDotazioniDTO;

public class GestioneDotazioneDAO {

	public static ArrayList<DotazioneDTO> getListaDotazioni(CompanyDTO cmp, Session session) {
		
		Query query  = session.createQuery( "from DotazioneDTO WHERE company_id= :_id");
		
		query.setParameter("_id",cmp.getId());
		
		ArrayList<DotazioneDTO> result =(ArrayList<DotazioneDTO>) query.list();
		
		return result;
	}

	public static ArrayList<TipologiaDotazioniDTO> getListaTipologieDotazioni(Session session) {
			Query query  = session.createQuery( "from TipologiaDotazioniDTO");
		
		ArrayList<TipologiaDotazioniDTO> result =(ArrayList<TipologiaDotazioniDTO>) query.list();
		
		return result;
	}

	public static void saveDotazione(DotazioneDTO dotazione, Session session) throws Exception {

		session.save(dotazione);
		
	}

	public static void updateDotazione(DotazioneDTO dotazione, Session session) throws Exception {
		 
		session.update(dotazione);
		
	}

	public static DotazioneDTO getDotazioneById(String id, Session session) {
		Query query  = session.createQuery( "from DotazioneDTO WHERE id= :_id");
		
		query.setParameter("_id", Integer.parseInt(id));
		List<DotazioneDTO> result =query.list();
		
		if(result.size()>0)
		{			
			return result.get(0);
		}
		return null;
	}

	public static void deleteDotazione(DotazioneDTO dotazione, Session session) throws Exception{
		
		session.delete(dotazione);
		
	}

	public static TipologiaDotazioniDTO getTipoDotazioneById(int idTipologia) {
		Session	session = SessionFacotryDAO.get().openSession();    
		session.beginTransaction();
		
		Query query  = session.createQuery( "from TipologiaDotazioniDTO WHERE id= :_id");
		
		query.setParameter("_id",idTipologia);
		List<TipologiaDotazioniDTO> result =query.list();
		
		
		session.getTransaction().commit();
		session.close();
		
		if(result.size()>0)
		{			
			return result.get(0);
		}
		return null;
	}
	

}
