package it.portaleSTI.bo;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneDotazioneDAO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.DotazioneDTO;
import it.portaleSTI.DTO.TipologiaDotazioniDTO;

public class GestioneDotazioneBO {

	public static List<DotazioneDTO> getListaDotazioni(CompanyDTO cmp, Session session) {
		return  (List<DotazioneDTO>) GestioneDotazioneDAO.getListaDotazioni(cmp,session);
	}

	public static List<TipologiaDotazioniDTO> getListaTipologieDotazioni(Session session) {
		// TODO Auto-generated method stub
		return GestioneDotazioneDAO.getListaTipologieDotazioni(session);
	}

	public static void saveDotazione(DotazioneDTO dotazione, String action, Session session) throws Exception {
		// TODO Auto-generated method stub
 
		if(action.equals("modifica")){
			
				GestioneDotazioneDAO.updateDotazione(dotazione, session);
 
		}
		else if(action.equals("nuovo")){
 			
			 	GestioneDotazioneDAO.saveDotazione(dotazione, session);

		}
 
	}

	public static DotazioneDTO getDotazioneById(String id, Session session) {
 		return GestioneDotazioneDAO.getDotazioneById(id,session);
	}

	public static void deleteDotazione(DotazioneDTO dotazione, Session session) throws Exception {
		GestioneDotazioneDAO.deleteDotazione(dotazione, session);
	}

}
