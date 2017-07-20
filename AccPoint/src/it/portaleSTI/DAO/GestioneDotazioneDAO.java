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
		Query query  = session.createQuery( "from Dotazion eDTO WHERE company_id= :_id");
		
		query.setParameter("_id",cmp.getId());
		List<DotazioneDTO> result =query.list();
		
		return result;
	}

	public static List<TipologiaDotazioniDTO> getListaTipologieDotazioni(Session session) {
			Query query  = session.createQuery( "from TipologiaDotazioniDTO");
		
		List<TipologiaDotazioniDTO> result =query.list();
		
		return result;
	}

}
