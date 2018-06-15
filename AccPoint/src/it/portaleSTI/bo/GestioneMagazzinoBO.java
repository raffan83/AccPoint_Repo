package it.portaleSTI.bo;

import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import org.apache.commons.fileupload.FileItem;
import org.hibernate.Session;

import com.google.gson.JsonArray;

import it.portaleSTI.DAO.GestioneCommesseDAO;
import it.portaleSTI.DAO.GestioneMagazzinoDAO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.LogMagazzinoDTO;
import it.portaleSTI.DTO.MagAccessorioDTO;
import it.portaleSTI.DTO.MagAllegatoDTO;
import it.portaleSTI.DTO.MagAspettoDTO;
import it.portaleSTI.DTO.MagAttivitaPaccoDTO;
import it.portaleSTI.DTO.MagCategoriaDTO;
import it.portaleSTI.DTO.MagDdtDTO;
import it.portaleSTI.DTO.MagItemDTO;
import it.portaleSTI.DTO.MagItemPaccoDTO;
import it.portaleSTI.DTO.MagPaccoDTO;
import it.portaleSTI.DTO.MagStatoLavorazioneDTO;
import it.portaleSTI.DTO.MagTipoDdtDTO;
import it.portaleSTI.DTO.MagTipoItemDTO;
import it.portaleSTI.DTO.MagTipoNotaPaccoDTO;
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
	File file = new File(Costanti.PATH_FOLDER+"\\"+"Magazzino" + "\\"+ filename);
	
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
	return filename;
}


public static String uploadImage(FileItem item, String codice_pacco) {
	

	String path = Costanti.PATH_FOLDER+"Magazzino" + "\\"+"Allegati\\"+codice_pacco+"\\";
	
		File folder = new File(path);
		folder.mkdir();
		
		int index=1;
		
		String extension = item.getName().substring(item.getName().indexOf("."), item.getName().length());
		String filename = item.getName().substring(0, item.getName().indexOf("."))+extension;
	while(true) {
		File file =new File(path + filename);
			try {
				if(!file.exists()) {

					item.write(file);
					break;
				}else {
					//file = new File(path + item.getName().substring(0, item.getName().indexOf("."))+"_"+index +extension);
					filename = item.getName().substring(0, item.getName().indexOf("."))+"_"+index +extension;
							//filename=item.getName().substring(0,item.getName().indexOf("."))+"_" +index+".pdf";
					//item.write(file);
					index++;
				}
				
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				break;
			}
		

	}
	return filename;
}

public static void updateAllegati(MagPaccoDTO pacco, Session session) {
	GestioneMagazzinoDAO.updateAllegati(pacco, session);
}

public static void saveItem(MagItemDTO mag_item, Session session) {
	
	GestioneMagazzinoDAO.saveItem(mag_item, session);
}


public static void saveItemPacco(MagItemPaccoDTO item_pacco, Session session) {

	GestioneMagazzinoDAO.saveItemPacco(item_pacco, session);
}

public static ArrayList<MagItemPaccoDTO> getListaItemPacco(int id_pacco, Session session) {
	
	return GestioneMagazzinoDAO.getItemPaccoByPacco(id_pacco, session);
}

public static ArrayList<MagItemPaccoDTO> getListaItemPacco(Session session) {
	
	return GestioneMagazzinoDAO.getListaItemPacco(session);
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

public static ArrayList<MagCategoriaDTO> getListaCategorie(Session session) {
	
	return GestioneMagazzinoDAO.getListaCategorie(session);
}

public static void saveGenerico(MagAccessorioDTO generico, Session session) {

	session.save(generico);
	
}

public static void saveAllegato(MagAllegatoDTO allegato, Session session) {

	session.save(allegato);
	
}

public static ArrayList<MagAllegatoDTO> getAllegatiFromPacco(String id_pacco, Session session) {

	return GestioneMagazzinoDAO.getAllegatiFromPacco(id_pacco, session);
}

public static void eliminaAllegato(int id_allegato, Session session) {
	
	 GestioneMagazzinoDAO.deleteAllegato(id_allegato, session);
}

public static void cambiaStatoStrumento(int id_strumento, int stato, Session session) {
	
	 GestioneMagazzinoDAO.cambiaStatoStrumento(id_strumento,stato, session);
}

public static ArrayList<MagPaccoDTO> getPaccoByCommessa(String id_commessa, Session session) {
	
	return GestioneMagazzinoDAO.getPaccoByCommessa(id_commessa, session);
}


public static ArrayList<MagItemDTO> getListaItemByPacco(int id_pacco, Session session) {
	
	return GestioneMagazzinoDAO.getListaItemByPacco(id_pacco, session);
}

public static ArrayList<MagAttivitaPaccoDTO> getListaAttivitaPacco(Session session) {
	
	return GestioneMagazzinoDAO.getListaAttivitaPacco(session);
}

public static ArrayList<MagTipoNotaPaccoDTO> getListaTipoNotaPacco(Session session) {
	
	return GestioneMagazzinoDAO.getListaTipoNotaPacco(session);
}

public static void chiudiPacchiCommessa(String commessa, Session session) {
	
	ArrayList<MagPaccoDTO> lista_pacchi = GestioneMagazzinoDAO.getListaPacchiByCommessa(commessa, session);
	
	GestioneMagazzinoDAO.chiudiPacchiCommessa(lista_pacchi, session);
	
	
}

public static void accettaItem(JsonArray acc, JsonArray non_acc, JsonArray note_acc,JsonArray note_non_acc, String id_pacco, Session session) {
	GestioneMagazzinoDAO.accettaItem(acc,non_acc,note_acc, note_non_acc,id_pacco, session);
}

	

}
