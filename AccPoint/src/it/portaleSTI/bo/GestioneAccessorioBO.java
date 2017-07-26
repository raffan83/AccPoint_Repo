package it.portaleSTI.bo;


import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneAccessorioDAO;
import it.portaleSTI.DAO.GestioneDotazioneDAO;
import it.portaleSTI.DAO.GestioneRuoloDAO;
import it.portaleSTI.DTO.AccessorioDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.DotazioneDTO;
import it.portaleSTI.DTO.TipologiaAccessoriDTO;

public class GestioneAccessorioBO {

	public static ArrayList<AccessorioDTO> getListaAccessori(CompanyDTO cmp, Session session) {
		
		
		return GestioneAccessorioDAO.getListaAccessori(cmp,session);
	}

	public static int saveAccessorio(AccessorioDTO accessorio, String action, Session session) {
		// TODO Auto-generated method stub
		return GestioneAccessorioDAO.saveAccessorio(accessorio,action,session);
	}

	public static AccessorioDTO getAccessorioById(String id, Session session) {
		// TODO Auto-generated method stub
		return GestioneAccessorioDAO.getAccessorioById(id, session);
	}

	public static int deleteAccessorio(AccessorioDTO accessorio, Session session) {
	
		return GestioneAccessorioDAO.deleteAccessorio(accessorio,session);
	}

	public static List<TipologiaAccessoriDTO> getListaTipologieAccessori(Session session) {
		
		return GestioneAccessorioDAO.getListaTipologieAccessori(session);
	}

	public static void inserisciAssociazioneArticoloAccessorio(String idArticolo, int idAccessorio,int quantita,int idCompany,int idUser) throws Exception
	{
		GestioneAccessorioDAO.inserisciAssociazioneArticoloAccessorio(idArticolo,idAccessorio,quantita,idCompany,idUser);
	}

	public static void deleteAssociazioneArticoloAccessorio(String idArticolo, int idAccessorio) throws Exception
	{
		GestioneAccessorioDAO.deleteAssociazioneArticoloAccessorio(idArticolo,idAccessorio);
	}
	
}
