package it.portaleSTI.bo;

import java.io.File;
import java.util.ArrayList;

import org.apache.commons.fileupload.FileItem;
import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneCommesseDAO;
import it.portaleSTI.DAO.GestioneMagazzinoDAO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.LogMagazzinoDTO;
import it.portaleSTI.DTO.MagAccessorioDTO;
import it.portaleSTI.DTO.MagAspettoDTO;
import it.portaleSTI.DTO.MagDdtDTO;
import it.portaleSTI.DTO.MagItemDTO;
import it.portaleSTI.DTO.MagItemPaccoDTO;
import it.portaleSTI.DTO.MagPaccoDTO;
import it.portaleSTI.DTO.MagSpedizioniereDTO;
import it.portaleSTI.DTO.MagStatoLavorazioneDTO;
import it.portaleSTI.DTO.MagTipoDdtDTO;
import it.portaleSTI.DTO.MagTipoItemDTO;
import it.portaleSTI.DTO.MagTipoPortoDTO;
import it.portaleSTI.DTO.MagTipoTrasportoDTO;
import it.portaleSTI.Util.Costanti;

public class GestioneMagazzinoBO {

//	public static void save(LogMagazzinoDTO logMagazzino, Session session) throws Exception {
//		GestioneMagazzinoDAO.save(logMagazzino,session);
//		
//	}
	
	public static ArrayList<MagPaccoDTO> getListaPacchi(int id_company, Session session) throws Exception {
		
		
		return GestioneMagazzinoDAO.getPacchi(id_company, session);
	}
	
public static MagPaccoDTO getPaccoById(int id_pacco, Session session) throws Exception {
		
		
		return GestioneMagazzinoDAO.getPaccoId(id_pacco, session);
	}
	
	
	public static void savePacco(MagPaccoDTO pacco, Session session) throws Exception{
		
		GestioneMagazzinoDAO.savePacco(pacco, session);
		
	}


	public static MagDdtDTO getDDT(String id_ddt, Session session) {
		
		return GestioneMagazzinoDAO.getDDT(id_ddt, session);
	}
	
	public static ArrayList<MagTipoDdtDTO> getListaTipoDDT(Session session){
		
		return GestioneMagazzinoDAO.getTipoDDT(session);
	}
	 
	public static ArrayList<MagTipoPortoDTO> getListaTipoPorto(Session session){
		
		return GestioneMagazzinoDAO.getTipoPorto(session);
		
	}
	
	public static ArrayList<MagTipoTrasportoDTO> getListaTipoTrasporto(Session session){
		
		
		return GestioneMagazzinoDAO.getTipoTrasporto(session);
	}
	
	public static ArrayList<MagAspettoDTO> getListaTipoAspetto(Session session){
		
		
		return GestioneMagazzinoDAO.getTipoAspetto(session);
	}
	
	public static ArrayList<MagSpedizioniereDTO> getListaSpedizionieri(Session session){
		
		
		return GestioneMagazzinoDAO.getSpedizionieri(session);
	}


	public static ArrayList<MagTipoItemDTO> getListaTipoItem(Session session) {
		
		return GestioneMagazzinoDAO.getTipoItem(session);
	}


	public static ArrayList<MagAccessorioDTO> getListaGenerici(Session session) {
	
		return GestioneMagazzinoDAO.getGenerico(session);
		
	}
	
	public static ArrayList<MagStatoLavorazioneDTO> getListaStatoLavorazione(Session session) {
		
		return GestioneMagazzinoDAO.getStatoLavorazione(session);
	}
	
public static void saveDdt(MagDdtDTO ddt, Session session) throws Exception{
		
		GestioneMagazzinoDAO.saveDdt(ddt, session);
		
	}


public static String uploadPdf(FileItem item, String filename) {
	
	filename=filename +".pdf";
	File file = new File(Costanti.PATH_FOLDER+"//"+"Magazzino" + "//"+ filename);
	while(true) {
		
	
		
			try {
				item.write(file);
				
				break;
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				break;
			}
		

	}
	return file.getPath();
}


public static void saveItem(MagItemDTO mag_item, Session session) {
	
	GestioneMagazzinoDAO.saveItem(mag_item, session);
}


public static void saveItemPacco(MagItemPaccoDTO item_pacco, Session session) {

	GestioneMagazzinoDAO.saveItemPacco(item_pacco, session);
}

public static ArrayList<MagItemPaccoDTO> getListaItemPacco(int id, Session session) {
	
	return GestioneMagazzinoDAO.getItemPacco(id, session);
}

public static void updatePacco(MagPaccoDTO pacco, Session session) {

	GestioneMagazzinoDAO.updatePacco(pacco, session);
}

public static void updateDdt(MagDdtDTO ddt, Session session) {
	
	GestioneMagazzinoDAO.updateDdt(ddt, session);
	
}

public static void deleteItemPacco(int id_pacco, Session session) {

	GestioneMagazzinoDAO.deleteItemPacco(id_pacco, session);
}

public static MagPaccoDTO getPaccoByDDT(int id, Session session) {
	
	
	return GestioneMagazzinoDAO.getPaccoByDDT(id, session);
}






	

}
