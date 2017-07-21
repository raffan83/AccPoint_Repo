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

	public static List<DotazioneDTO> getListaDotazioni(CompanyDTO cmp, Session session) {
		Query query  = session.createQuery( "from DotazioneDTO WHERE company_id= :_id");
		
		query.setParameter("_id",cmp.getId());
		List<DotazioneDTO> result =query.list();
		
		return result;
	}

	public static List<TipologiaDotazioniDTO> getListaTipologieDotazioni(Session session) {
			Query query  = session.createQuery( "from TipologiaDotazioniDTO");
		
		List<TipologiaDotazioniDTO> result =query.list();
		
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
	

}
