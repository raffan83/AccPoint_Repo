package it.portaleSTI.bo;

import it.portaleSTI.DAO.GestioneInterventoDAO;
import it.portaleSTI.DAO.SQLLiteDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.InterventoDatiDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.ObjSavePackDTO;
import it.portaleSTI.DTO.PuntoMisuraDTO;
import it.portaleSTI.DTO.StatoCertificatoDTO;
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

	public static List<InterventoDTO> getListaInterventi(String idCommessa, Session session) throws Exception {


		return GestioneInterventoDAO.getListaInterventi(idCommessa,session);
	}

	public static void save(InterventoDTO intervento, Session session) throws Exception {

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

	public static ObjSavePackDTO saveDataDB(ObjSavePackDTO esito, InterventoDTO intervento,UtenteDTO utente, Session session) throws Exception {
		
		InterventoDatiDTO interventoDati = new InterventoDatiDTO();
		try {
	
			
			String nomeDB=esito.getPackNameAssigned().getPath();
			
			Connection con =SQLLiteDAO.getConnection(nomeDB);
			
			ArrayList<MisuraDTO> listaMisure=SQLLiteDAO.getListaMisure(con,intervento);

			esito.setEsito(1);
			
			interventoDati.setId_intervento(intervento.getId());
			interventoDati.setNomePack(esito.getPackNameAssigned().getName().substring(0,esito.getPackNameAssigned().getName().length()-3));
			interventoDati.setDataCreazione(new Date());
			interventoDati.setStato(new StatoPackDTO(3));
			interventoDati.setNumStrMis(0);
			interventoDati.setNumStrNuovi(0);
			interventoDati.setUtente(utente);
			session.save(interventoDati);
			
			esito.setInterventoDati(interventoDati);
			
			int strumentiDuplicati=0;
			
		    for (int i = 0; i < listaMisure.size(); i++) 
		    {
		    	MisuraDTO misura = listaMisure.get(i);
		    	
		   	if(misura.getStrumento().getCreato().equals("S") &&
		   			misura.getStrumento().getCreato().equals("N"))
		    	{
		    //		GestioneStrumentoBO.createStrumeto(con,misura.getStrumento().get__id());
		    	}
		    	
		    	boolean isPresent=GestioneInterventoDAO.isPresentStrumento(intervento.getId(),misura.getStrumento(),session);
			
		    	if(isPresent==false)
		    	{
		    		misura.setInterventoDati(interventoDati);
		    		misura.setUser(utente);
		    		int idTemp=misura.getId();
		    		session.save(misura);
		    		
		    		int totale=intervento.getnStrumentiMisurati()+1;
		    		
		    		intervento.setnStrumentiMisurati(totale);
		    		session.update(intervento);
		    		
		    		
		    		ArrayList<PuntoMisuraDTO> listaPuntiMisura = SQLLiteDAO.getListaPunti(con,idTemp,misura.getId());
		    		for (int j = 0; j < listaPuntiMisura .size(); j++) 
		    		{
		    			session.save(listaPuntiMisura.get(j));
					}
		    		
		    		int nStr=interventoDati.getNumStrMis()+1;
		    		interventoDati.setNumStrMis(nStr);
		    		session.update(interventoDati);
		    		
		    		CertificatoDTO certificato = new CertificatoDTO();
		    		certificato.setMisura(misura);
		    		certificato.setStato(new StatoCertificatoDTO(1));
		    		certificato.setUtente(misura.getUser());
		    		
		    		session.save(certificato);
		    	}
		    		else
		    	{
		    		esito.getListaStrumentiDuplicati().add(misura.getStrumento());	
		    		strumentiDuplicati++;
		    		esito.setEsito(1);
		    	}
		    }
			
		    if(strumentiDuplicati!=0)
		    {
		    	esito.setDuplicati(true);
		    }		    
			
		} catch (ClassNotFoundException | SQLException e) 
		{
		
			esito.setEsito(0);
			esito.setErrorMsg("Errore Connessione DB: "+e.getMessage());
			e.printStackTrace();
		}
		
		return esito;
	}

	public static void removeInterventoDati(InterventoDatiDTO interventoDati, Session session) {
	
		session.delete(interventoDati);
		
	}

	public static void updateMisura(String idStr, ObjSavePackDTO esito, InterventoDTO intervento, UtenteDTO utente, Session session) throws Exception {
	
		try{
		
			
			
			String nomeDB=esito.getPackNameAssigned().getPath();
			
			Connection con =SQLLiteDAO.getConnection(nomeDB);
			
			ArrayList<MisuraDTO> listaMisure=SQLLiteDAO.getListaMisure(con,intervento);
			
			
			for (int i = 0; i < listaMisure.size(); i++) 
			{
				MisuraDTO misura = listaMisure.get(i);
				
				if(listaMisure.get(i).getStrumento().get__id()==Integer.parseInt(idStr))
				{
					int idTemp=misura.getId();
					misura.setInterventoDati(esito.getInterventoDati());
		    		misura.setUser(utente);
					
					session.save(listaMisure.get(i));
					
					MisuraDTO misuraObsoleta = GestioneInterventoDAO.getMisuraObsoleta(intervento.getId(),idStr);
					GestioneInterventoDAO.misuraObsoleta(misuraObsoleta,session);
					
					ArrayList<PuntoMisuraDTO> listaPuntiMisura = SQLLiteDAO.getListaPunti(con,idTemp,misura.getId());
		    		for (int j = 0; j < listaPuntiMisura .size(); j++) 
		    		{
		    			session.save(listaPuntiMisura.get(j));
		    			GestioneInterventoDAO.puntoMisuraObsoleto(misuraObsoleta.getId());
					}
				}
				
			}
		
		}catch (Exception e) {
				e.printStackTrace();
				esito.setEsito(0);
				esito.setErrorMsg("Errore Connessione DB: "+e.getMessage());
				e.printStackTrace();
				throw e;
			}
		
	}
	
	public static ArrayList<MisuraDTO> getListaMirureByInterventoDati(int idIntervento)throws Exception
	{
		
			return GestioneInterventoDAO.getListaMirureByInterventoDati(idIntervento);
			
		
	}

	public static void update(InterventoDTO intervento, Session session) {
	
		session.update(intervento);
	
	}
}
