package it.portaleSTI.bo;

import java.io.File;
import java.util.ArrayList;

import org.apache.commons.fileupload.FileItem;
import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneConfigurazioneClienteDAO;
import it.portaleSTI.DTO.ConfigurazioneClienteDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.action.GestioneConfigurazioniClienti;

public class GestioneConfigurazioneClienteBO {

	public static ArrayList<ConfigurazioneClienteDTO> getListaConfigurazioniCliente( Session session) {

		return GestioneConfigurazioneClienteDAO.getListaConfigurazioneCliente(session);
	}

	public static void uploadFile(FileItem item, int id_cliente, int id_sede) throws Exception{

		File folder = new File(Costanti.PATH_FOLDER+"\\LoghiCompany\\ConfigurazioneClienti\\"+id_cliente+"\\"+id_sede);
		if(!folder.exists()) {
			folder.mkdirs();
		}
		File file = new File(Costanti.PATH_FOLDER+"\\"+"LoghiCompany\\ConfigurazioneClienti\\"+id_cliente+"\\"+id_sede+"\\"+item.getName());
		
		while(true) {
			item.write(file);			
			break;			
		}	
	
	}

	public static boolean checkPresente(int id_cliente, int id_sede, int tipo_rapporto, Session session) {
		
		return GestioneConfigurazioneClienteDAO.chekPresente(id_cliente, id_sede, tipo_rapporto, session);
	}

	public static ConfigurazioneClienteDTO getConfigurazioneClienteFromId(int id_cliente, int id_sede,	int tipo_rapporto, Session session) {
		
		return GestioneConfigurazioneClienteDAO.getConfigurazioneClienteFromId(id_cliente, id_sede, tipo_rapporto, session);
	}
	
	public static ArrayList<ConfigurazioneClienteDTO> getConfigurazioneClienteFromIdCliente_idSede(int id_cliente, int id_sede, Session session) {
		
		return GestioneConfigurazioneClienteDAO.getConfigurazioneClienteFromIdCliente_idSede(id_cliente, id_sede, session);
	}

}
