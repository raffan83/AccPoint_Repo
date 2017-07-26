package it.portaleSTI.bo;

import it.portaleSTI.DAO.GestioneCampionamentoDAO;
import it.portaleSTI.DTO.ArticoloMilestoneDTO;
import it.portaleSTI.DTO.CompanyDTO;

import java.util.ArrayList;

import org.hibernate.Session;

public class GestioneCampionamentoBO {

	
	public static ArrayList<ArticoloMilestoneDTO> getListaArticoli(CompanyDTO company, Session session) throws Exception
	{
		return GestioneCampionamentoDAO.getListaArticoli(company);
	}


	public static ArticoloMilestoneDTO getArticoloById(String idArticolo,
			ArrayList<ArticoloMilestoneDTO> listaArticoli) {

		ArticoloMilestoneDTO articolo = null;
		for (ArticoloMilestoneDTO articoloMilestoneDTO : listaArticoli) {
			
			if(articoloMilestoneDTO.getID_ANAART().equals(idArticolo)) {
				articolo = articoloMilestoneDTO;
			}
			
		}
		
		return articolo;
	}
	
}
