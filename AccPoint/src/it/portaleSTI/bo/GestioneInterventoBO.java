package it.portaleSTI.bo;

import it.portaleSTI.DAO.GestioneInterventoDAO;
import it.portaleSTI.DTO.InterventoDTO;
import java.util.ArrayList;

public class GestioneInterventoBO {

	public static ArrayList<InterventoDTO> getListaInterventi(String idCommessa) throws Exception {
		
		
		return GestioneInterventoDAO.getListaInterventi(idCommessa);
	}

	
	
}
