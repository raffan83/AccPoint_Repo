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

}
