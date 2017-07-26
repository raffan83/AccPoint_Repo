package it.portaleSTI.bo;

import it.portaleSTI.DAO.GestioneCampionamentoDAO;
import it.portaleSTI.DTO.ArticoloMilestoneDTO;
import it.portaleSTI.DTO.CompanyDTO;

import java.util.ArrayList;

public class GestioneCampionamentoBO {

	
	public static ArrayList<ArticoloMilestoneDTO> getListaArticoli(CompanyDTO company) throws Exception
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
