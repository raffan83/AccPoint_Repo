package it.portaleSTI.bo;

import java.util.ArrayList;

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneInterventoDAO;
import it.portaleSTI.DAO.GestioneMisuraDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.MisuraDTO;

public class GestioneMisuraBO {

	public static MisuraDTO getMiruraByID(int idMisura)throws Exception
	{
		
			return GestioneMisuraDAO.getMiruraByID(idMisura);
		
	}
}
