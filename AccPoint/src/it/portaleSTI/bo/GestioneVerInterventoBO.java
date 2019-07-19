package it.portaleSTI.bo;

import java.io.File;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.fileupload.FileItem;
import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneInterventoDAO;
import it.portaleSTI.DAO.GestioneVerInterventoDAO;
import it.portaleSTI.DAO.SQLLiteDAO;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.ClassificazioneDTO;
import it.portaleSTI.DTO.InterventoDatiDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.ObjSavePackDTO;
import it.portaleSTI.DTO.PuntoMisuraDTO;
import it.portaleSTI.DTO.ScadenzaDTO;
import it.portaleSTI.DTO.StatoCertificatoDTO;
import it.portaleSTI.DTO.StatoPackDTO;
import it.portaleSTI.DTO.StatoStrumentoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerInterventoDTO;
import it.portaleSTI.DTO.VerMisuraDTO;
import it.portaleSTI.DTO.VerStrumentoDTO;
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

						objSave.setPackNameAssigned(file);
						objSave.setEsito(1);
						return objSave;
		
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
		
	}

	public static ObjSavePackDTO saveDataDB(ObjSavePackDTO esito, VerInterventoDTO ver_intervento, UtenteDTO utente,Session session) throws Exception {
		
		VerStrumentoDTO nuovoStrumento=null;
		try {
						
			String nomeDB=esito.getPackNameAssigned().getPath();
			
			Connection con =SQLLiteDAO.getConnection(nomeDB);
			ver_intervento.setUser_verificazione(utente);
			ArrayList<VerMisuraDTO> listaMisure=SQLLiteDAO.getListaMisure(con,ver_intervento);
			
			esito.setEsito(1);

		    for (int i = 0; i < listaMisure.size(); i++) 
		    {
		    
		   VerMisuraDTO misura = listaMisure.get(i);
	
		   	if(misura.getVerStrumento().getCreato().equals("S"))
		   		
		    	{
		    		session.save(misura.getVerStrumento());
		    	}
		   	
		   	session.save(misura);
		    }
		    
		    
			
		} catch (Exception e) 
		{
		
			esito.setEsito(0);
			esito.setErrorMsg("Errore Connessione DB: "+e.getMessage());
			e.printStackTrace();
			throw e;
		}

		return esito;
	}


}
