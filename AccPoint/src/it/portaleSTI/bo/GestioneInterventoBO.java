package it.portaleSTI.bo;

import it.portaleSTI.DAO.GestioneInterventoDAO;
import it.portaleSTI.DAO.SQLLiteDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.InterventoDatiDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.ObjSavePackDTO;
import it.portaleSTI.DTO.PuntoMisuraDTO;
import it.portaleSTI.DTO.StatoPackDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Util.Costanti;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.fileupload.FileItem;
import org.hibernate.Session;

public class GestioneInterventoBO {

	public static List<InterventoDTO> getListaInterventi(String idCommessa) throws Exception {


		return GestioneInterventoDAO.getListaInterventi(idCommessa);
	}

	public static void save(InterventoDTO intervento) {

		Session session = SessionFacotryDAO.get().openSession();

		session.beginTransaction();

		session.save(intervento);

		InterventoDatiDTO intDati = new InterventoDatiDTO();
		intDati.setId_intervento(intervento.getId());
		intDati.setDataCreazione(intervento.getDataCreazione());
		intDati.setNomePack(intervento.getNomePack());
		intDati.setNumStrMis(0);
		intDati.setNumStrNuovi(0);
		intDati.setStato(new StatoPackDTO(1));
		intDati.setUtente(intervento.getUser());
		session.save(intDati);

		session.getTransaction().commit();

		session.close();

	}

	public static void save(InterventoDatiDTO interventoDati) {

		Session session = SessionFacotryDAO.get().openSession();

		session.beginTransaction();

		session.save(interventoDati);

		session.getTransaction().commit();
		session.close();

	}

	public static InterventoDTO getIntervento(String idIntervento) {

		return GestioneInterventoDAO.getIntervento(idIntervento);

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
				File file = new File(Costanti.PATH_FOLDER+"//"+folder+"//"+folder+"_"+index+".db");

				if(file.exists()==false)
				{

					try {
						item.write(file);
						
						objSave.setPackNameAssigned(file);
						objSave.setEsito(1);
						break;
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

	public static ObjSavePackDTO saveDataDB(ObjSavePackDTO esito, InterventoDTO intervento,UtenteDTO utente) throws Exception {
		Session session=null;
		InterventoDatiDTO interventoDati = new InterventoDatiDTO();
		try {
			session = SessionFacotryDAO.get().openSession();
			session.beginTransaction();
			
			String nomeDB=esito.getPackNameAssigned().getPath();
			
			Connection con =SQLLiteDAO.getConnection(nomeDB);
			
			ArrayList<MisuraDTO> listaMisure=SQLLiteDAO.getListaMisure(con,intervento);

			interventoDati.setId_intervento(intervento.getId());
			interventoDati.setNomePack(esito.getPackNameAssigned().getName().substring(0,esito.getPackNameAssigned().getName().length()-3));
			interventoDati.setDataCreazione(new Date());
			interventoDati.setStato(new StatoPackDTO(3));
			interventoDati.setNumStrMis(listaMisure.size());
			interventoDati.setNumStrNuovi(0);
			interventoDati.setUtente(utente);
			session.save(interventoDati);
			
			int strumentiDuplicati=0;
			
		    for (int i = 0; i < listaMisure.size(); i++) 
		    {
		    	MisuraDTO misura = listaMisure.get(i);
		    	boolean isPresent=GestioneInterventoDAO.isPresentStrumento(intervento.getId(),misura.getStrumento(),session);
			
		    	if(isPresent==false)
		    	{
		    		misura.setInterventoDati(interventoDati);
		    		misura.setUser(utente);
		    		int idTemp=misura.getId();
		    		session.save(misura);
		    		
		    		ArrayList<PuntoMisuraDTO> listaPuntiMisura = SQLLiteDAO.getListaPunti(con,idTemp,misura.getId());
		    		for (int j = 0; j < listaMisure.size(); j++) {
		    			session.save(listaPuntiMisura.get(j));
					}
		    		
		
		    	}
		    		else
		    	{
		    		esito.getListaStrumentiDuplicati().add(misura.getStrumento());	
		    		strumentiDuplicati++;
		    	}
		    }
			
		    if(strumentiDuplicati!=0)
		    {
		    	esito.setDuplicati(true);
		    }
		    
			session.getTransaction().commit();
			session.close();
			
		} catch (ClassNotFoundException | SQLException e) 
		{
			session.getTransaction().rollback();
			esito.setEsito(0);
			esito.setErrorMsg("Errore Connessione DB: "+e.getMessage());
			e.printStackTrace();
		}
		
		return esito;
	}
}
