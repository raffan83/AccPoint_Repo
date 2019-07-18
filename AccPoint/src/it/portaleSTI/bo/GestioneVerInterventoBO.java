package it.portaleSTI.bo;

import java.io.File;
import java.util.ArrayList;

import org.apache.commons.fileupload.FileItem;
import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneVerInterventoDAO;
import it.portaleSTI.DTO.ObjSavePackDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerInterventoDTO;
import it.portaleSTI.DTO.VerMisuraDTO;
import it.portaleSTI.Util.Costanti;

public class GestioneVerInterventoBO {

	public static ArrayList<VerInterventoDTO> getListaVerInterventi(Session session) {
		
		return GestioneVerInterventoDAO.getListaVerInterventi(session);
	}

	public static VerInterventoDTO getInterventoFromId(int id_intervento, Session session) {
		
		return GestioneVerInterventoDAO.getInterventoFromId(id_intervento, session);
	}

	public static ArrayList<VerMisuraDTO> getListaMisureFromIntervento(int id_intervento, Session session) {
		
		return GestioneVerInterventoDAO.getListaMisureFromIntervento(id_intervento, session);
	}

	public static ObjSavePackDTO savePackUpload(FileItem item, String nomePack) {
		
		ObjSavePackDTO  objSave= new ObjSavePackDTO();

		/*check salvataggio nomeFile*/
		
		if(!(nomePack+".db").equals(item.getName()))
		{
		 objSave.setEsito(0);
		 objSave.setErrorMsg("Questo pacchetto non corrisponde a quest'intervento");
		 
		 return objSave;
		 
		}
		
		
		String folder=item.getName().substring(0,item.getName().indexOf("."));

		int index=1;
			while(true)
			{
				File file=null;
				
				file = new File(Costanti.PATH_FOLDER+"//"+folder+"//"+folder+"_"+index+".db");
							
				if(file.exists()==false)
				{

					try {
						
						item.write(file);
						
						boolean  checkFile=GestioneInterventoBO.controllaFile(file);
						
						if(checkFile)
						{

						objSave.setPackNameAssigned(file);
						objSave.setEsito(1);
						break;
						}
						else
						{
							objSave.setEsito(2);
							break;
						}
					} catch (Exception e) {

						e.printStackTrace();
						objSave.setEsito(0);
						objSave.setErrorMsg("Errore Salvataggio Dati");

						return objSave; 
					}
				}
				else
				{
					index++;
				}
			}
		return objSave;
	}


}
