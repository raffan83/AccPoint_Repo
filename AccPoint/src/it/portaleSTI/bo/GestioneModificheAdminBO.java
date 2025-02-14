package it.portaleSTI.bo;

import java.util.ArrayList;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneModificheAdminDAO;
import it.portaleSTI.DTO.CertificatoDTO;

public class GestioneModificheAdminBO {

	public static ArrayList<CertificatoDTO> getElementiRicerca(String tipo_ricerca, String id, Session session) {
	
		return GestioneModificheAdminDAO.getElementiRicerca(tipo_ricerca, id, session);
	}
	
	
	

}
