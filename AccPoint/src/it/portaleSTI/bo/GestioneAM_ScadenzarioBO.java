package it.portaleSTI.bo;

import java.text.ParseException;
import java.util.ArrayList;

import org.hibernate.HibernateException;
import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneAM_ScadenzarioDAO;
import it.portaleSTI.DTO.AmScAllegatoDTO;
import it.portaleSTI.DTO.AmScAttivitaDTO;
import it.portaleSTI.DTO.AmScAttrezzaturaDTO;
import it.portaleSTI.DTO.AmScScadenzarioDTO;

public class GestioneAM_ScadenzarioBO {

	public GestioneAM_ScadenzarioBO() {
		// TODO Auto-generated constructor stub
	}

	public static ArrayList<AmScAttrezzaturaDTO> getListaAttrezzature(int id_cliente, int id_sede,Session session) {
		
		return GestioneAM_ScadenzarioDAO.getListaAttrezzature( id_cliente,  id_sede,session);
	}

	public static ArrayList<AmScScadenzarioDTO> getListaScadenze(int id_cliente, int id_sede, int anno, Session session) {
		// TODO Auto-generated method stub
		return GestioneAM_ScadenzarioDAO.getListaScadenze( id_cliente,  id_sede, anno, session);
	}

	public static ArrayList<AmScScadenzarioDTO> getListaScadenzeAttrezzatura(int id_attrezzatura, int numeroMese, int anno, boolean interoAnno,
			Session session) {
		// TODO Auto-generated method stub
		return GestioneAM_ScadenzarioDAO.getListaScadenzeAttrezzatura(id_attrezzatura, numeroMese, anno, interoAnno,session);
	}

	public static ArrayList<AmScAttivitaDTO> getListaAttivita(Session session) {
		// TODO Auto-generated method stub
		return GestioneAM_ScadenzarioDAO.getListaAttivita( session);
	}

	public static ArrayList<AmScAllegatoDTO> getListaAllegatiScadenza(int id, Session session) {
		// TODO Auto-generated method stub
		return GestioneAM_ScadenzarioDAO.getListaAllegatiScadenza(id, session);
	}

	public static ArrayList<AmScScadenzarioDTO> getListaAttivitaDate(String dateFrom, String dateTo, int id_cliente,
			int id_sede, Session session) throws HibernateException, ParseException {
		// TODO Auto-generated method stub
		return GestioneAM_ScadenzarioDAO.getListaAttivitaDate( dateFrom,  dateTo,  id_cliente,
			 id_sede,  session);
	}

}
