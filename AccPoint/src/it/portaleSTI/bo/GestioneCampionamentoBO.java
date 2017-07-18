package it.portaleSTI.bo;

import it.portaleSTI.DAO.GestioneCampionamentoDAO;
import it.portaleSTI.DTO.ArticoloMilestoneDTO;
import it.portaleSTI.DTO.CompanyDTO;

import java.util.ArrayList;

public class GestioneCampionamentoBO {

	
	public ArrayList<ArticoloMilestoneDTO> getListaArticoli(CompanyDTO company) throws Exception
	{
		return GestioneCampionamentoDAO.getListaArticoli(company);
	}
}
