package it.portaleSTI.bo;

import java.io.File;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.fileupload.FileItem;
import org.hibernate.HibernateException;
import org.hibernate.Session;

import com.google.gson.JsonArray;

import it.portaleSTI.DAO.GestioneCommesseDAO;
import it.portaleSTI.DAO.GestioneMagazzinoDAO;
import it.portaleSTI.DAO.GestioneStrumentoDAO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.LogMagazzinoDTO;
import it.portaleSTI.DTO.MagAccessorioDTO;
import it.portaleSTI.DTO.MagAllegatoDTO;
import it.portaleSTI.DTO.MagAllegatoItemDTO;
import it.portaleSTI.DTO.MagAspettoDTO;
import it.portaleSTI.DTO.MagAttivitaItemDTO;
import it.portaleSTI.DTO.MagCategoriaDTO;
import it.portaleSTI.DTO.MagCausaleDTO;
import it.portaleSTI.DTO.MagDdtDTO;
import it.portaleSTI.DTO.MagItemDTO;
import it.portaleSTI.DTO.MagItemPaccoDTO;
import it.portaleSTI.DTO.MagNoteDdtDTO;
import it.portaleSTI.DTO.MagPaccoDTO;
import it.portaleSTI.DTO.MagSaveStatoDTO;
import it.portaleSTI.DTO.MagStatoLavorazioneDTO;
import it.portaleSTI.DTO.MagTipoDdtDTO;
import it.portaleSTI.DTO.MagTipoItemDTO;
import it.portaleSTI.DTO.MagTipoNotaPaccoDTO;
import it.portaleSTI.DTO.MagTipoPortoDTO;
import it.portaleSTI.DTO.MagTipoTrasportoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
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


public static void uploadPdf(FileItem item, int id_pacco, String filename) {
	
	File folder = new File(Costanti.PATH_FOLDER+"\\"+"Magazzino\\DDT\\PC_"+id_pacco+"\\");
	if(!folder.exists()) {
		folder.mkdirs();
	}
	File file = new File(Costanti.PATH_FOLDER+"\\"+"Magazzino\\DDT\\PC_"+id_pacco+"\\"+ filename);
	
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

public static ArrayList<MagAttivitaItemDTO> getListaAttivitaItem(Session session) {
	
	return GestioneMagazzinoDAO.getListaAttivitaItem(session);
}

public static ArrayList<MagTipoNotaPaccoDTO> getListaTipoNotaPacco(Session session) {
	
	return GestioneMagazzinoDAO.getListaTipoNotaPacco(session);
}

public static void chiudiPacchiCommessa(String origine, Session session) {
	
	ArrayList<MagPaccoDTO> lista_pacchi = GestioneMagazzinoDAO.getListaPacchiByOrigine(origine, session);
	
	GestioneMagazzinoDAO.chiudiPacchiOrigine(lista_pacchi, session);
	
	
}

public static void accettaItem(JsonArray acc, JsonArray non_acc, JsonArray note_acc,JsonArray note_non_acc, String id_pacco, Session session) {
	GestioneMagazzinoDAO.accettaItem(acc,non_acc,note_acc, note_non_acc,id_pacco, session);
}

public static ArrayList<MagPaccoDTO> getListaPacchiPerData(String dateFrom, String dateTo, String tipo_data, int stato, Session session) throws Exception, ParseException {
	
	return GestioneMagazzinoDAO.getListPacchiPerData(dateFrom, dateTo, tipo_data, stato, session);
}

public static MagItemDTO getItemById(int id, Session session) {
	
	return GestioneMagazzinoDAO.getItemById(id, session);
}



public static ArrayList<MagItemPaccoDTO> getListaStrumentiInEsterno(Session session) throws Exception{
	
	ArrayList<MagItemPaccoDTO> listaItem=null;
	
	ArrayList<Integer> listaItemEsterno = GestioneMagazzinoDAO.getListaStrumentiEsterni();
	
	
	if(listaItemEsterno.size()>0) 
	{
		listaItem= new ArrayList<MagItemPaccoDTO>();
		
		for (Integer idItem : listaItemEsterno) {
			
			MagItemPaccoDTO mgIt=GestioneMagazzinoDAO.getItemPaccoByIdItem(idItem, session );
			
			if(mgIt!=null) 
			{
				listaItem.add(mgIt);
			}
		}
	}
	
	return listaItem;
	}


public static ArrayList<MagPaccoDTO> getListaPacchiInEsterno(Session session) throws Exception{
	
	ArrayList<MagPaccoDTO> listaPacchi=new ArrayList<MagPaccoDTO>();

	ArrayList<MagItemPaccoDTO> listaItemPacco = getListaStrumentiInEsterno(session);
	ArrayList<Integer> inserted = new ArrayList<Integer>();
	if(listaItemPacco!=null) {
	for (MagItemPaccoDTO magItemPaccoDTO : listaItemPacco) {
		
		if(!inserted.contains(magItemPaccoDTO.getPacco().getId())) {
			listaPacchi.add(magItemPaccoDTO.getPacco());
			//insertedId = magItemPaccoDTO.getPacco().getId();
			inserted.add(magItemPaccoDTO.getPacco().getId());
		}
		
	}
	
	
	}
	
	return listaPacchi;
	}

public static ArrayList<MagPaccoDTO> getOriginiFromItem(String id_item, String matricola, Session session) {
	
	return GestioneMagazzinoDAO.getOriginiFromItem(id_item, matricola, session);
}

public static ArrayList<MagNoteDdtDTO> getListaNoteDDT(Session session) {
	
	return GestioneMagazzinoDAO.getListaNoteDDT(session);
}

public static void updateStrumento(StrumentoDTO strumento, Session session) {
	
	GestioneMagazzinoDAO.updateStrumento(strumento, session);
	
}

public static ArrayList<MagCausaleDTO> geListaCausali(Session session) {
	
	return GestioneMagazzinoDAO.getListaCausali(session);
}

public static ArrayList<MagDdtDTO> getListaDDT(Session session) {
	
	return GestioneMagazzinoDAO.getListaDDT(session);
}

public static int checkStrumentoInMagazzino(int id, String idCommessa) throws Exception {
	
	
	return GestioneMagazzinoDAO.checkStrumentoInMagazzino(id,idCommessa);
}

public static MagSaveStatoDTO getMagSaveStato(int id_cliente, int id_sede, Session session) throws Exception {
	
	
	return GestioneMagazzinoDAO.getMagSaveStato(id_cliente, id_sede, session);
}

public static ArrayList<MagSaveStatoDTO> getListaMagSaveStato(Session session) {
	
	
	return GestioneMagazzinoDAO.getListaMagSaveStato(session);
}

public static ArrayList<MagItemDTO> getListaItemSpediti(int id_pacco, Session session) throws Exception {
	
	return GestioneMagazzinoDAO.getListaitemSpediti(id_pacco, session);
}

public static Object[] getRiferimentoDDT(String origine, Session session) throws Exception {
	
	return GestioneMagazzinoDAO.getRiferimentoDDT(origine, session);
}

public static int getProgressivoDDT(Session session) throws Exception {
	
	return GestioneMagazzinoDAO.getProgressivoDDT(session);
}

public static ArrayList<MagDdtDTO> getListaDDTPerData(String dateFrom, String dateTo, Session session) throws Exception {
	
	return GestioneMagazzinoDAO.getListaDDTPerData(dateFrom, dateTo, session);
}

public static ArrayList<Integer> getListaAllegati(Session session) {
	
	return GestioneMagazzinoDAO.getListaAllegati(session);
}

public static ArrayList<MagPaccoDTO> getListaPacchiApertiChiusi(int id_company, int stato, Session session) {
	
	return GestioneMagazzinoDAO.getListaPacchiApertiChiusi(id_company,stato,session);
}

public static ArrayList<Integer> getPaccoFromStrumento(String id_strumento, Session session) {
	
	return GestioneMagazzinoDAO.getPaccoFromStrumento(id_strumento, session);
}

public static ArrayList<MagItemPaccoDTO> getListaItemPaccoApertiChiusi(int stato, Session session) {

	return GestioneMagazzinoDAO.getListaItemPaccoApertiChiusi(stato,session);
}

public static ArrayList<MagPaccoDTO> getListaPacchiInMagazzino(Session session) {
	
	return GestioneMagazzinoDAO.getListaPacchiInMagazzino(session);
}

public static void riapriOrigine(String origine, Session session) {
	 
	GestioneMagazzinoDAO.riapriOrigine(origine, session);
}

public static String getDataRicevimentoItem(StrumentoDTO strumento, Session session) {
	
	return GestioneMagazzinoDAO.getDataRicevimentoItem(strumento,session);
}

public static ArrayList<MagItemPaccoDTO> getListaStrumentiInMagazzino(Session session) {
	
	return GestioneMagazzinoDAO.getListaStrumentiInMagazzino(session);
}

public static ArrayList<MagItemPaccoDTO> getListaItemPaccoPerData(String dateFrom, String dateTo, String tipo_data, int stato, Session session) throws Exception {
	
	return GestioneMagazzinoDAO.getListaItemPaccoPerData(dateFrom, dateTo, tipo_data, stato, session);
}

public static ArrayList<MagAllegatoItemDTO> getListaAllegatiItem(MagPaccoDTO pacco, Session session) throws Exception {
	// TODO Auto-generated method stub
	return GestioneMagazzinoDAO.getListaAllegatiItem(pacco, session);
}

public static ArrayList<MagItemDTO> getListaRilieviSpediti(String origine, int id_tipo_proprio, Session session) {

	return GestioneMagazzinoDAO.getListaRilieviSpediti(origine, id_tipo_proprio, session);
}





}
