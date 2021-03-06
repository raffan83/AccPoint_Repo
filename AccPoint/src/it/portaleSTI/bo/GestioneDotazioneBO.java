package it.portaleSTI.bo;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.fileupload.FileItem;
import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneAccessorioDAO;
import it.portaleSTI.DAO.GestioneDotazioneDAO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.DotazioneDTO;
import it.portaleSTI.DTO.TipologiaDotazioniDTO;
import it.portaleSTI.Util.Costanti;

public class GestioneDotazioneBO {

	public static ArrayList<DotazioneDTO> getListaDotazioni(CompanyDTO cmp, Session session) 
	{
		return GestioneDotazioneDAO.getListaDotazioni(cmp,session);
	}

	public static ArrayList<TipologiaDotazioniDTO> getListaTipologieDotazioni(Session session) {
		
		
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
	
	public static void inserisciAssociazioneArticoloDotazione(String idArticolo, int idTipoDotazione,int idCompany,int idUser) throws Exception
	{
		GestioneDotazioneDAO.inserisciAssociazioneArticoloDotazione(idArticolo,idTipoDotazione,idCompany,idUser);
	}

	public static void deleteAssociazioneArticoloDotazione(String idArticolo, int idTipoDotazione) throws Exception
	{
		GestioneDotazioneDAO.deleteAssociazioneArticoloDotazione(idArticolo,idTipoDotazione);
	}

	public static ArrayList<TipologiaDotazioniDTO> getListaTipologieDotazioniByArticolo(CompanyDTO cmp,String codiceArticolo) throws Exception {
		// TODO Auto-generated method stub
		return GestioneDotazioneDAO.getListaTipologieDotazioniByArticolo(cmp,codiceArticolo);
	}

}
