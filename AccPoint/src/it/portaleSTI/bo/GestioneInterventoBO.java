package it.portaleSTI.bo;

import java.io.File;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.commons.fileupload.FileItem;
import org.hibernate.Session;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.GestioneInterventoDAO;
import it.portaleSTI.DAO.SQLLiteDAO;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.ClassificazioneDTO;
import it.portaleSTI.DTO.ContatoreUtenteDTO;
import it.portaleSTI.DTO.ControlloAttivitaDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.InterventoDatiDTO;
import it.portaleSTI.DTO.LatMisuraDTO;
import it.portaleSTI.DTO.LatPuntoLivellaDTO;
import it.portaleSTI.DTO.LatPuntoLivellaElettronicaDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.ObjSavePackDTO;
import it.portaleSTI.DTO.PuntoMisuraDTO;

import it.portaleSTI.DTO.SicurezzaElettricaDTO;
import it.portaleSTI.DTO.StatoCertificatoDTO;
import it.portaleSTI.DTO.StatoPackDTO;
import it.portaleSTI.DTO.StatoRicezioneStrumentoDTO;
import it.portaleSTI.DTO.StatoStrumentoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Util.Costanti;

public class GestioneInterventoBO {

	public static List<InterventoDTO> getListaInterventi(String idCommessa, Session session) throws Exception {


		return GestioneInterventoDAO.getListaInterventi(idCommessa,session);
	}

	public static void save(InterventoDTO intervento, Session session) throws Exception {

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

	public static void save(InterventoDatiDTO interventoDati,Session session)throws Exception {
		
		session.save(interventoDati);


	}

	public static InterventoDTO getIntervento(String idIntervento, Session session) {

		return GestioneInterventoDAO.getIntervento(idIntervento, session);

	}

	public static ObjSavePackDTO savePackUpload(FileItem item, String nomePack) {

		ObjSavePackDTO  objSave= new ObjSavePackDTO();

		/*check salvataggio nomeFile*/
		
		if(!(nomePack+".db").equals(item.getName()) && !("LAT"+nomePack+".db").equals(item.getName()))
		{
		 objSave.setEsito(0);
		 objSave.setErrorMsg("Questo pacchetto non corrisponde a quest'intervento");
		 
		 return objSave;
		 
		}
		
		
		String folder=item.getName().substring(0,item.getName().indexOf("."));
			
		if(item.getName().indexOf("LAT")>=0)
		{
			objSave.setLAT(true);
		}
		
		int index=1;
			while(true)
			{
				File file=null;
				
				if(objSave.isLAT()==false) 
				{
					file = new File(Costanti.PATH_FOLDER+"//"+folder+"//"+folder+"_"+index+".db");
				}else 
				{
					file = new File(Costanti.PATH_FOLDER+"//"+folder.substring(3,folder.length())+"//"+folder+"_"+index+".db");
				}
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

	public static boolean controllaFile(File file) throws Exception {
		
		
		return SQLLiteDAO.checkFile(file.getPath());
	}

	public static ObjSavePackDTO saveDataDB(ArrayList<MisuraDTO> listaMisure,ObjSavePackDTO esito, InterventoDTO intervento,UtenteDTO utente, boolean non_sovrascrivere, boolean da_duplicati,Session session) throws Exception {
		
		InterventoDatiDTO interventoDati = new InterventoDatiDTO();
		
		StrumentoDTO nuovoStrumento=null;
		try {
						
			String nomeDB=esito.getPackNameAssigned().getPath();
			
			Connection con =SQLLiteDAO.getConnection(nomeDB);
			
			//ArrayList<MisuraDTO> listaMisure=SQLLiteDAO.getListaMisure(con,intervento);
			
			esito.setEsito(1);
			
			interventoDati.setId_intervento(intervento.getId());
			interventoDati.setNomePack(esito.getPackNameAssigned().getName().substring(0,esito.getPackNameAssigned().getName().length()-3));
			interventoDati.setDataCreazione(new Date());
			interventoDati.setStato(new StatoPackDTO(3));
			interventoDati.setNumStrMis(0);
			interventoDati.setNumStrNuovi(0);
			interventoDati.setUtente(utente);
			
			
			
			
			
			
//			int strumentiDuplicati=0;
//			if(da_duplicati==false) {
//			 for (int i = 0; i < listaMisure.size(); i++) 
//			    {
//				 
//				 MisuraDTO misura = listaMisure.get(i);
//				    
//			    	
//				    boolean isPresent=GestioneInterventoDAO.isPresentStrumento(intervento.getId(),misura.getStrumento(),session);
//				    
//				    if(isPresent )
//					    
//				    {
//				    	esito.getListaStrumentiDuplicati().add(misura.getStrumento());	
//			    		strumentiDuplicati++;
//			    		esito.setEsito(1);
//				    }
//				 
//			    }
//			 
//			 if(strumentiDuplicati>0) {
//				 esito.setDuplicati(true);
//				 esito.setInterventoDati(interventoDati);
//				 return esito;
//			 }
//			}
			
			if(listaMisure.size()>0) {
				saveInterventoDati(interventoDati,session);
			}
			
		    for (int i = 0; i < listaMisure.size(); i++) 
		    {
		    	MisuraDTO misura = listaMisure.get(i);
		    
		    	
//		    boolean isPresent=GestioneInterventoDAO.isPresentStrumento(intervento.getId(),misura.getStrumento(),session);
//				
//		    if(isPresent==false || non_sovrascrivere== true)
//		    
//		    {
		    		
		   	if(misura.getStrumento().getCreato().equals("S") && misura.getStrumento().getImportato().equals("N"))
		   		
		    	{
		    		nuovoStrumento=GestioneStrumentoBO.createStrumeto(misura.getStrumento(),intervento,session);

		    		int nuoviStrumenti =intervento.getnStrumentiNuovi()+1;
		    		intervento.setnStrumentiNuovi(nuoviStrumenti);
		    		
		    		int nuoviStrumentiInterventoDati=interventoDati.getNumStrNuovi()+1;
		    		interventoDati.setNumStrNuovi(nuoviStrumentiInterventoDati);
		    		
		    	}
		    	
		   	if(misura.getStrumento().getStrumentoModificato()!=null && misura.getStrumento().getStrumentoModificato().equals("S")) {
		   		System.out.println(misura.getStrumento().get__id());
		   		StrumentoDTO strumentoModificato=new StrumentoDTO();
		   		
		   		strumentoModificato = GestioneStrumentoBO.getStrumentoById(""+misura.getStrumento().get__id(),session);
		   		
		   		StrumentoDTO strumentoDaFile = misura.getStrumento();
		   		
		   		strumentoModificato.setUserModifica(utente);
		   		strumentoModificato.setDataModifica(new java.sql.Date(Calendar.getInstance().getTimeInMillis()));
		   		
		   		TipoRapportoDTO tipoRapp = new TipoRapportoDTO(strumentoDaFile.getIdTipoRapporto(),"");
		   		strumentoModificato.setTipoRapporto(tipoRapp);
		   		
		   		ClassificazioneDTO classificazione = new ClassificazioneDTO(strumentoDaFile.getIdClassificazione(),"");		   		
		   		strumentoModificato.setClassificazione(classificazione);
		   		strumentoModificato.setFrequenza(strumentoDaFile.getFrequenza());
		   		strumentoModificato.setDenominazione(strumentoDaFile.getDenominazione());   	
		   		strumentoModificato.setCodice_interno(strumentoDaFile.getCodice_interno());
		   		strumentoModificato.setCostruttore(strumentoDaFile.getCostruttore());
		   		strumentoModificato.setModello(strumentoDaFile.getModello());
		   		strumentoModificato.setReparto(strumentoDaFile.getReparto());
		   		strumentoModificato.setUtilizzatore(strumentoDaFile.getUtilizzatore());
		   		strumentoModificato.setMatricola(strumentoDaFile.getMatricola());
		   		strumentoModificato.setCampo_misura(strumentoDaFile.getCampo_misura());
		   		strumentoModificato.setRisoluzione(strumentoDaFile.getRisoluzione());
		   		strumentoModificato.setNote(strumentoDaFile.getNote());
		   		strumentoModificato.setLuogo(strumentoDaFile.getLuogo());
		   		strumentoModificato.setProcedura(strumentoDaFile.getProcedura());
		   		strumentoModificato.setDataProssimaVerifica(strumentoDaFile.getDataProssimaVerifica());
		   		strumentoModificato.setDataUltimaVerifica(strumentoDaFile.getDataUltimaVerifica());
		   		strumentoModificato.setStato_strumento(new StatoStrumentoDTO(Costanti.STATO_STRUMENTO_IN_SERVIZIO, ""));
		   		strumentoModificato.setTipo_strumento(new TipoStrumentoDTO(strumentoDaFile.getTipo_strumento().getId(), ""));
		   		
		   		strumentoModificato.setNote_tecniche(strumentoDaFile.getNote_tecniche());
		   		
		   		GestioneStrumentoBO.update(strumentoModificato, session);
		   	}
		   	
		   	else 
		   	{
		   	StrumentoDTO	strumentoAggiormanentoScadenza = GestioneStrumentoBO.getStrumentoById(""+misura.getStrumento().get__id(),session);
		   	strumentoAggiormanentoScadenza.setDataProssimaVerifica(misura.getStrumento().getDataProssimaVerifica());
		   	strumentoAggiormanentoScadenza.setDataUltimaVerifica(misura.getStrumento().getDataUltimaVerifica());
		   	strumentoAggiormanentoScadenza.setStato_strumento(new StatoStrumentoDTO(Costanti.STATO_STRUMENTO_IN_SERVIZIO, ""));
	   		
	   		GestioneStrumentoBO.update(strumentoAggiormanentoScadenza, session);
		   	}
		   	
		   	
		    		misura.setInterventoDati(interventoDati);
		    		misura.setUser(utente);
		    		misura.setLat("N");
		    		
		    		int idTemp=misura.getId();
		    		
		    		
		    		ArrayList<PuntoMisuraDTO> listaPuntiMisuraPerCalcoloIndice = SQLLiteDAO.getListaPunti(con,idTemp,0);
		    		
		    		String indicePrestazione=null;
		    		
		    		
		    		if(misura.getStrumento().getIdTipoRapporto()==Costanti.ID_TIPO_RAPPORTO_SVT)
		    		{
		    			indicePrestazione=calcolaIndicePrestazione(listaPuntiMisuraPerCalcoloIndice);
		    		}
		    		
		    		misura.setIndice_prestazione(indicePrestazione);
		    		
		    		saveMisura(misura,session);
		    		
		    		ArrayList<PuntoMisuraDTO> listaPuntiMisura = SQLLiteDAO.getListaPunti(con,idTemp,misura.getId());
		    		
		    		for (int j = 0; j < listaPuntiMisura .size(); j++) 
		    		{
		    			saveListaPunti(listaPuntiMisura.get(j),session);
					}
		    		
		    		
		    		
		    		if(misura.getStrumento().getIdTipoRapporto()==Costanti.ID_TIPO_RAPPORTO_SVT)
		    		{
		    			boolean idoneo=getIsIdoneo(listaPuntiMisura);
		    			
		    			StrumentoDTO strumentoModificato = GestioneStrumentoBO.getStrumentoById(""+misura.getStrumento().get__id(),session);
		    			
		    			strumentoModificato.setIndice_prestazione(indicePrestazione);
		    			//strumentoModificato
		    			if(idoneo) 
		    			{
		    			 	
		    		   		strumentoModificato.setStato_strumento(new StatoStrumentoDTO(Costanti.STATO_STRUMENTO_IN_SERVIZIO, ""));
		    		   		GestioneStrumentoBO.update(strumentoModificato, session);
		    		   		misura.setObsoleto("N");
		    			}
		    			else 
		    			{
		    				strumentoModificato.setStato_strumento(new StatoStrumentoDTO(Costanti.STATO_STRUMENTO_NON_IN_SERVIZIO, ""));
		    		   		GestioneStrumentoBO.update(strumentoModificato, session);
		    		//   		misura.setObsoleto("S");
		    			}
		    		}
		    		
		    		intervento.setnStrumentiMisurati(intervento.getnStrumentiMisurati()+1);
		    		interventoDati.setNumStrMis(interventoDati.getNumStrMis()+1);
		    		
		    		
		    	//	updateInterventoDati(interventoDati,session);
		    		
		    		System.out.println(System.identityHashCode(intervento));
		    		System.out.println(System.identityHashCode(
		    		    session.get(InterventoDTO.class, intervento.getId())
		    		));
		    		
		    		update(intervento, session);
		    		
		    		
		    		CertificatoDTO certificato = new CertificatoDTO();
		    		certificato.setMisura(misura);
		    		certificato.setStato(new StatoCertificatoDTO(1));
		    		certificato.setUtente(misura.getUser());

		    		saveCertificato(certificato,session);
		    		//GestioneInterventoDAO.update(intervento,session);

		    	}
//		    		else
//		    	{
//		    		esito.getListaStrumentiDuplicati().add(misura.getStrumento());	
//		    		strumentiDuplicati++;
//		    		esito.setEsito(1);
//		    	}

		   // }
		    esito.setInterventoDati(interventoDati);
			
		    
//		    if(strumentiDuplicati!=0)
//		    {
//		    	esito.setDuplicati(true);
//		    }		    
			
		} catch (Exception e) 
		{
		
			esito.setEsito(0);
			esito.setErrorMsg("Errore Connessione DB: "+e.getMessage());
			e.printStackTrace();
			throw e;
		}
		
		
		
		return esito;
	}
	
	private static String calcolaIndicePrestazione(ArrayList<PuntoMisuraDTO> listaPuntiMisura) throws Exception {
		
		BigDecimal max = BigDecimal.ZERO;
		String indice = null;
		
		if(listaPuntiMisura.size()==0) 
		{
			return null;
		}
		for (PuntoMisuraDTO punto : listaPuntiMisura) {
			if(!punto.getTipoProva().equals("D") && punto.getApplicabile().equals("S") ){
				BigDecimal indice_prestazione = punto.getIncertezza().multiply(new BigDecimal(100)).divide(punto.getAccettabilita(),3,RoundingMode.HALF_UP);
				if(indice_prestazione.compareTo(max)==1) {
					max = indice_prestazione;
				}
			}
					
		}
		
		if(max.doubleValue() == 0) {
			return null;
		}
		
		if(max.compareTo(new BigDecimal(25))==-1 || max.compareTo(new BigDecimal(25))==0) {
			indice = "V";
		}else if(max.compareTo(new BigDecimal(25))==1 && (max.compareTo(new BigDecimal(75))==-1 || max.compareTo(new BigDecimal(75))==0)) {
			indice = "G";
		}else if(max.compareTo(new BigDecimal(75))==1 && (max.compareTo(new BigDecimal(100))==-1 || max.compareTo(new BigDecimal(100))==0)) {
			indice = "R";
		}else {
			indice = "X";
		}
		
		return indice;
	}
	

	public static ObjSavePackDTO saveDataDBSicurezzaElettrica(ObjSavePackDTO esito, InterventoDTO intervento,UtenteDTO utente, Session session) throws Exception {
		InterventoDatiDTO interventoDati = new InterventoDatiDTO();
		
		StrumentoDTO strumento,nuovoStrumento=null;
		
		SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yy");
		try {
			
			
			String nomeDB=esito.getPackNameAssigned().getPath();
			
			Connection con =SQLLiteDAO.getConnection(nomeDB);
			
			ArrayList<SicurezzaElettricaDTO> listaMisure=SQLLiteDAO.getListaMisureElettriche(con,intervento);
			
			esito.setEsito(1);
			
			interventoDati.setId_intervento(intervento.getId());
			interventoDati.setNomePack(esito.getPackNameAssigned().getName().substring(0,esito.getPackNameAssigned().getName().length()-3));
			interventoDati.setDataCreazione(new Date());
			interventoDati.setStato(new StatoPackDTO(3));
			interventoDati.setNumStrMis(0);
			interventoDati.setNumStrNuovi(0);
			interventoDati.setUtente(utente);
			
			
			saveInterventoDati(interventoDati,session);
			
			
			
			int strumentiDuplicati=0;
			
		    for (int i = 0; i < listaMisure.size(); i++) 
		    {
		    	SicurezzaElettricaDTO sicurezza = listaMisure.get(i);
		    
		    	strumento = sicurezza.getStrumento();
		    	
		    boolean isPresent=GestioneInterventoDAO.isPresentStrumento(intervento.getId(),sicurezza.getStrumento(),session);
				
		    if(isPresent==false)
		    
		    {
		    		
		   	if(sicurezza.getStrumento().getCreato().equals("S") && sicurezza.getStrumento().getImportato().equals("N"))
		   		
		    	{
		    		nuovoStrumento=GestioneStrumentoBO.createStrumeto(sicurezza.getStrumento(),intervento,session);

		    		int nuoviStrumenti =intervento.getnStrumentiNuovi()+1;
		    		intervento.setnStrumentiNuovi(nuoviStrumenti);
		    		
		    		int nuoviStrumentiInterventoDati=interventoDati.getNumStrNuovi()+1;
		    		interventoDati.setNumStrNuovi(nuoviStrumentiInterventoDati);
		    		
		    	}
		    	
		   	if(sicurezza.getStrumento().getStrumentoModificato()!=null && sicurezza.getStrumento().getStrumentoModificato().equals("S")) {
		   		
		   		StrumentoDTO strumentoModificato=new StrumentoDTO();
		   		
		   		strumentoModificato = GestioneStrumentoBO.getStrumentoById(""+sicurezza.getStrumento().get__id(),session);
		   		
		   		StrumentoDTO strumentoDaFile = sicurezza.getStrumento();
		   		
		   		strumentoModificato.setUserModifica(utente);
		   		strumentoModificato.setDataModifica(new java.sql.Date(Calendar.getInstance().getTimeInMillis()));
		   		
		   		TipoRapportoDTO tipoRapp = new TipoRapportoDTO(strumentoDaFile.getIdTipoRapporto(),"");
		   		strumentoModificato.setTipoRapporto(tipoRapp);
		   		
		   		ClassificazioneDTO classificazione = new ClassificazioneDTO(strumentoDaFile.getIdClassificazione(),"");		   		
		   		strumentoModificato.setClassificazione(classificazione);
		   		strumentoModificato.setFrequenza(strumentoDaFile.getFrequenza());
		   		strumentoModificato.setDenominazione(strumentoDaFile.getDenominazione());   	
		   		strumentoModificato.setCodice_interno(strumentoDaFile.getCodice_interno());
		   		strumentoModificato.setCostruttore(strumentoDaFile.getCostruttore());
		   		strumentoModificato.setModello(strumentoDaFile.getModello());
		   		strumentoModificato.setReparto(strumentoDaFile.getReparto());
		   		strumentoModificato.setUtilizzatore(strumentoDaFile.getUtilizzatore());
		   		strumentoModificato.setMatricola(strumentoDaFile.getMatricola());
		   		strumentoModificato.setCampo_misura(strumentoDaFile.getCampo_misura());
		   		strumentoModificato.setRisoluzione(strumentoDaFile.getRisoluzione());
		   		strumentoModificato.setNote(strumentoDaFile.getNote());
		   		strumentoModificato.setLuogo(strumentoDaFile.getLuogo());
		   		strumentoModificato.setProcedura(strumentoDaFile.getProcedura());
		   		strumentoModificato.setDataProssimaVerifica(strumentoDaFile.getDataProssimaVerifica());
		   		strumentoModificato.setDataUltimaVerifica(strumentoDaFile.getDataUltimaVerifica());
		   		strumentoModificato.setStato_strumento(new StatoStrumentoDTO(Costanti.STATO_STRUMENTO_IN_SERVIZIO, ""));
		   		strumentoModificato.setTipo_strumento(new TipoStrumentoDTO(strumentoDaFile.getTipo_strumento().getId(), ""));
		   		
		   		GestioneStrumentoBO.update(strumentoModificato, session);
		   		strumento=strumentoModificato;
		   	}
		   	
		   	else 
		   	{
		   	StrumentoDTO	strumentoAggiormanentoScadenza = GestioneStrumentoBO.getStrumentoById(""+sicurezza.getStrumento().get__id(),session);
		   	strumentoAggiormanentoScadenza.setDataProssimaVerifica(sicurezza.getStrumento().getDataProssimaVerifica());
		   	strumentoAggiormanentoScadenza.setDataUltimaVerifica(sicurezza.getStrumento().getDataUltimaVerifica());
	   		
	   		
	   		GestioneStrumentoBO.update(strumentoAggiormanentoScadenza, session);
		   	}
		   	
		    MisuraDTO misura= new MisuraDTO();
		   	
		    misura.setIntervento(intervento);
		   	misura.setInterventoDati(interventoDati);
		   	misura.setStrumento(strumento);
		    misura.setUser(utente);
		    misura.setDataMisura(sdf.parse(sicurezza.getDATA()));
		    misura.setLat("E");
		    misura.setStatoRicezione(new StatoRicezioneStrumentoDTO(8901));
		    misura.setObsoleto("N");
		    
		   if(utente.getContatoreUtente()!=null) 
		   {
			   
			   ContatoreUtenteDTO contatore=utente.getContatoreUtente();
			   
			   int count=contatore.getContatoreSE();
			   
			   String codice="SSE"+contatore.getCodiceSE()+count;
			  
			   misura.setnCertificato(codice);
			   
			   utente.getContatoreUtente().setContatoreSE(count+1);
			  
			   GestioneSicurezzaElettricaBO.updateContatoreUtente(utente);
			 //  session.update(utente.getContatoreUtente());
			   
		   }
		    
		    

		    		int idMis =saveMisura(misura,session);
		    		sicurezza.setId_misura(idMis);

		    		/*
		    		 * Salvo scadenza 
		    		 */
//		    		ScadenzaDTO scadenza =sicurezza.getStrumento().getScadenzaDTO();
//		    		scadenza.setIdStrumento(misura.getStrumento().get__id());
//			    	scadenza.setDataUltimaVerifica(new java.sql.Date(misura.getDataMisura().getTime()));
//		    		GestioneStrumentoBO.saveScadenza(scadenza,session);
		    		
		    		
		    		saveSicurezza(sicurezza,session);
			
		    		intervento.setnStrumentiMisurati(intervento.getnStrumentiMisurati()+1);
		    		interventoDati.setNumStrMis(interventoDati.getNumStrMis()+1);
		    		
		    		
		    	
		    		
		    		update(intervento, session);
		    		
		    		
		    		CertificatoDTO certificato = new CertificatoDTO();
		    		certificato.setMisura(misura);
		    		certificato.setStato(new StatoCertificatoDTO(1));
		    		certificato.setUtente(misura.getUser());

		    		saveCertificato(certificato,session);
		    		GestioneInterventoDAO.update(intervento,session);

		    	}
		    		else
		    	{
		    		esito.getListaStrumentiDuplicati().add(sicurezza.getStrumento());	
		    		strumentiDuplicati++;
		    		esito.setEsito(1);
		    	}

		    }
		    esito.setInterventoDati(interventoDati);
			
		    
		    if(strumentiDuplicati!=0)
		    {
		    	esito.setDuplicati(true);
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
	
	
	

	public static ObjSavePackDTO saveDataDB_LAT(ObjSavePackDTO esito, InterventoDTO intervento, UtenteDTO utente,Session session) throws Exception {
	InterventoDatiDTO interventoDati = new InterventoDatiDTO();
		
		int idStrumentoOrg=0;
		try {
						
			String nomeDB=esito.getPackNameAssigned().getPath();
			
			Connection con =SQLLiteDAO.getConnection(nomeDB);
			
			
			/*Recupero la Misura e lo strumento dal file .db*/
			ArrayList<MisuraDTO> listaMisure=SQLLiteDAO.getListaMisure(con,intervento);

			esito.setEsito(1);
			
			interventoDati.setId_intervento(intervento.getId());
			interventoDati.setNomePack(esito.getPackNameAssigned().getName().substring(0,esito.getPackNameAssigned().getName().length()-3));
			interventoDati.setDataCreazione(new Date());
			interventoDati.setStato(new StatoPackDTO(3));
			interventoDati.setNumStrMis(0);
			interventoDati.setNumStrNuovi(0);
			interventoDati.setUtente(utente);
			
			saveInterventoDati(interventoDati,session);
			
			int strumentiDuplicati=0;
			
		    for (int i = 0; i < listaMisure.size(); i++) 
		    {
		    	MisuraDTO misura = listaMisure.get(i);
		    	idStrumentoOrg=misura.getStrumento().get__id();
		    	
		   	if(misura.getStrumento().getCreato().equals("S") && misura.getStrumento().getImportato().equals("N"))
		   		
		    	{
		    		GestioneStrumentoBO.createStrumeto(misura.getStrumento(),intervento,session);

		    		int nuoviStrumenti =intervento.getnStrumentiNuovi()+1;
		    		intervento.setnStrumentiNuovi(nuoviStrumenti);
		    		
		    		int nuoviStrumentiInterventoDati=interventoDati.getNumStrNuovi()+1;
		    		interventoDati.setNumStrNuovi(nuoviStrumentiInterventoDati);
		    		
		    	}
		    	
		   	if(misura.getStrumento().getStrumentoModificato()!=null && misura.getStrumento().getStrumentoModificato().equals("S")) {
		   		
		   		StrumentoDTO strumentoModificato=new StrumentoDTO();
		   		
		   		strumentoModificato = GestioneStrumentoBO.getStrumentoById(""+misura.getStrumento().get__id(),session);
		   		
		   		StrumentoDTO strumentoDaFile = misura.getStrumento();
		   		
		   		strumentoModificato.setUserModifica(utente);
		   		strumentoModificato.setDataModifica(new java.sql.Date(Calendar.getInstance().getTimeInMillis()));
		   		
		   		TipoRapportoDTO tipoRapp = new TipoRapportoDTO(strumentoDaFile.getIdTipoRapporto(),"");
		   		strumentoModificato.setTipoRapporto(tipoRapp);
		   		
		   		ClassificazioneDTO classificazione = new ClassificazioneDTO(strumentoDaFile.getIdClassificazione(),"");		   		
		   		strumentoModificato.setClassificazione(classificazione);
		   		strumentoModificato.setFrequenza(strumentoDaFile.getFrequenza());
		   		strumentoModificato.setDenominazione(strumentoDaFile.getDenominazione());   	
		   		strumentoModificato.setCodice_interno(strumentoDaFile.getCodice_interno());
		   		strumentoModificato.setCostruttore(strumentoDaFile.getCostruttore());
		   		strumentoModificato.setModello(strumentoDaFile.getModello());
		   		strumentoModificato.setReparto(strumentoDaFile.getReparto());
		   		strumentoModificato.setUtilizzatore(strumentoDaFile.getUtilizzatore());
		   		strumentoModificato.setMatricola(strumentoDaFile.getMatricola());
		   		strumentoModificato.setCampo_misura(strumentoDaFile.getCampo_misura());
		   		strumentoModificato.setRisoluzione(strumentoDaFile.getRisoluzione());
		   		strumentoModificato.setNote(strumentoDaFile.getNote());
		   		strumentoModificato.setLuogo(strumentoDaFile.getLuogo());
		   		strumentoModificato.setProcedura(strumentoDaFile.getProcedura());
		   		strumentoModificato.setDataProssimaVerifica(strumentoDaFile.getDataProssimaVerifica());
		   		strumentoModificato.setDataUltimaVerifica(strumentoDaFile.getDataUltimaVerifica());
		   		strumentoModificato.setStato_strumento(new StatoStrumentoDTO(Costanti.STATO_STRUMENTO_IN_SERVIZIO, ""));
		   		strumentoModificato.setTipo_strumento(new TipoStrumentoDTO(strumentoDaFile.getTipo_strumento().getId(), ""));
		   		
		   		GestioneStrumentoBO.update(strumentoModificato, session);
		   	}
		   	else 
		   	{
		   	StrumentoDTO	strumentoAggiormanentoScadenza = GestioneStrumentoBO.getStrumentoById(""+misura.getStrumento().get__id(),session);
		   	strumentoAggiormanentoScadenza.setDataProssimaVerifica(misura.getStrumento().getDataProssimaVerifica());
		   	strumentoAggiormanentoScadenza.setDataUltimaVerifica(misura.getStrumento().getDataUltimaVerifica());
	   		
	   		
	   		GestioneStrumentoBO.update(strumentoAggiormanentoScadenza, session);
		   	}
		   	
		   	
		    	boolean isPresent=GestioneInterventoDAO.isPresentStrumento(intervento.getId(),misura.getStrumento(),session);
			
		    	if(isPresent==false)
		    	{
		    		
		    		LatMisuraDTO misuraLAT = SQLLiteDAO.getMisuraLAT(con,misura.getStrumento(),idStrumentoOrg);
		    		int idTemp=misuraLAT.getId();
		    		misuraLAT.setUser(utente);
		    		misuraLAT.setIntervento(intervento);
		    		misuraLAT.setIntervento_dati(interventoDati);
		    		int idMisuraLAT=saveMisuraLAT(misuraLAT,session);
		    		
		    		misura.setInterventoDati(interventoDati);
		    		misura.setUser(utente);
		    		misura.setLat("S");
		    		misura.setMisuraLAT(misuraLAT);
		    		
		    		saveMisura(misura,session);

		    		/*
		    		 * Salvo scadenza 
		    		 */
//		    		ScadenzaDTO scadenza =misura.getStrumento().getScadenzaDTO();
//		    		scadenza.setIdStrumento(misura.getStrumento().get__id());
//			    	scadenza.setDataUltimaVerifica(new java.sql.Date(misura.getDataMisura().getTime()));
//		    		GestioneStrumentoBO.saveScadenza(scadenza,session);
		    	
		    		/*Livella a Bolla*/
		    		if(misuraLAT.getMisura_lat().getId()==1) 
		    		{
		    			ArrayList<LatPuntoLivellaDTO> listaPuntiMisura = SQLLiteDAO.getListaPuntiLivella(con,idMisuraLAT,idTemp);
			    		
			    		for (int j = 0; j < listaPuntiMisura .size(); j++) 
			    		{
			    			saveListaPuntiLivella(listaPuntiMisura.get(j),session);
						}	
		    			
		    		}
		    		/*Livella Elettronica*/
		    		if(misuraLAT.getMisura_lat().getId()==2) 
		    		{
		    			ArrayList<LatPuntoLivellaElettronicaDTO> listaPuntiMisura = SQLLiteDAO.getListaPuntiLivellaElettronica(con,idMisuraLAT,idTemp);
			    		
			    		for (int j = 0; j < listaPuntiMisura .size(); j++) 
			    		{
			    			saveListaPuntiLivellaElettronica(listaPuntiMisura.get(j),session);
						}	
		    			
		    		}
		    		intervento.setnStrumentiMisurati(intervento.getnStrumentiMisurati()+1);
		    		interventoDati.setNumStrMis(interventoDati.getNumStrMis()+1);

		    		update(intervento, session);
		    		
		    		
		    		CertificatoDTO certificato = new CertificatoDTO();
		    		certificato.setMisura(misura);
		    		certificato.setStato(new StatoCertificatoDTO(1));
		    		certificato.setUtente(misura.getUser());

		    		saveCertificato(certificato,session);
		    		GestioneInterventoDAO.update(intervento,session);

		    	}
		    		else
		    	{
		    		esito.getListaStrumentiDuplicati().add(misura.getStrumento());	
		    		strumentiDuplicati++;
		    		esito.setEsito(1);
		    	}

		    }
		    esito.setInterventoDati(interventoDati);
			
		    
		    if(strumentiDuplicati!=0)
		    {
		    	esito.setDuplicati(true);
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

	

	



	private static boolean getIsIdoneo(ArrayList<PuntoMisuraDTO> listaPuntiMisura) {
		
		boolean toReturn=true;
		
			for (PuntoMisuraDTO puntoMisuraDTO : listaPuntiMisura) {
				
				if(puntoMisuraDTO.getEsito().startsWith("NON")) 
				{
					return false;
				}
			}
		
		
		return toReturn;
	}

	private static void saveCertificato(CertificatoDTO certificato,Session session)throws Exception {
		
		session.save(certificato);
	}
	
	private static int saveMisuraLAT(LatMisuraDTO misuraLAT,Session session)throws Exception {
		
		return (Integer)session.save(misuraLAT);
	}

	public static void updateInterventoDati(InterventoDatiDTO interventoDati,Session session)throws Exception {
		
		session.update(interventoDati);
	}

	private static void saveListaPunti(PuntoMisuraDTO puntoMisuraDTO,Session session)throws Exception {
		
		session.save(puntoMisuraDTO);
		
	}
	private static void saveListaPuntiLivella(LatPuntoLivellaDTO latPuntoLivellaDTO, Session session) {
		
		session.save(latPuntoLivellaDTO);
	}
	private static void saveListaPuntiLivellaElettronica(LatPuntoLivellaElettronicaDTO latPuntoLivellaElettronicaDTO,Session session) {
		
		session.save(latPuntoLivellaElettronicaDTO);
		
	}

	public static void update(InterventoDTO intervento, Session session) {
		
		session.update(intervento);
	
	}

	private static int saveMisura(MisuraDTO misura, Session session) {
		
		return (Integer)session.save(misura);
		
	}

	private static void saveInterventoDati(InterventoDatiDTO interventoDati,Session session)throws Exception {
		
		session.save(interventoDati);
		
	}

	public static void removeInterventoDati(InterventoDatiDTO interventoDati, Session session)throws Exception {
	
		session.delete(interventoDati);
		
	}

	public static ObjSavePackDTO updateMisura(ArrayList<MisuraDTO> listaMisureDP, String idStr, ObjSavePackDTO esito, InterventoDTO intervento, UtenteDTO utente, String note_obsolescenza, Session session) throws Exception {

		try{

			String nomeDB=esito.getPackNameAssigned().getPath();

			Connection con =SQLLiteDAO.getConnection(nomeDB);

			session.saveOrUpdate(esito.getInterventoDati());

			if(GestioneInterventoBO.isElectric(esito)) {

				InterventoDatiDTO interventoDati = esito.getInterventoDati();
				ArrayList<SicurezzaElettricaDTO> listaMisure=SQLLiteDAO.getListaMisureElettriche(con,intervento);

				for (int i = 0; i < listaMisure.size(); i++) 
				{
					SicurezzaElettricaDTO sicurezza = listaMisure.get(i);

					if(sicurezza.getStrumento().get__id()==Integer.parseInt(idStr)) 
					{
						
					
					StrumentoDTO strumento = sicurezza.getStrumento();



					if(sicurezza.getStrumento().getStrumentoModificato()!=null && sicurezza.getStrumento().getStrumentoModificato().equals("S")) {

						StrumentoDTO strumentoModificato=new StrumentoDTO();

						strumentoModificato = GestioneStrumentoBO.getStrumentoById(""+sicurezza.getStrumento().get__id(),session);

						StrumentoDTO strumentoDaFile = sicurezza.getStrumento();

						strumentoModificato.setUserModifica(utente);
						strumentoModificato.setDataModifica(new java.sql.Date(Calendar.getInstance().getTimeInMillis()));

						TipoRapportoDTO tipoRapp = new TipoRapportoDTO(strumentoDaFile.getIdTipoRapporto(),"");
						strumentoModificato.setTipoRapporto(tipoRapp);

						ClassificazioneDTO classificazione = new ClassificazioneDTO(strumentoDaFile.getIdClassificazione(),"");		   		
						strumentoModificato.setClassificazione(classificazione);
						strumentoModificato.setFrequenza(strumentoDaFile.getFrequenza());
						strumentoModificato.setDenominazione(strumentoDaFile.getDenominazione());   	
						strumentoModificato.setCodice_interno(strumentoDaFile.getCodice_interno());
						strumentoModificato.setCostruttore(strumentoDaFile.getCostruttore());
						strumentoModificato.setModello(strumentoDaFile.getModello());
						strumentoModificato.setReparto(strumentoDaFile.getReparto());
						strumentoModificato.setUtilizzatore(strumentoDaFile.getUtilizzatore());
						strumentoModificato.setMatricola(strumentoDaFile.getMatricola());
						strumentoModificato.setCampo_misura(strumentoDaFile.getCampo_misura());
						strumentoModificato.setRisoluzione(strumentoDaFile.getRisoluzione());
						strumentoModificato.setNote(strumentoDaFile.getNote());
						strumentoModificato.setLuogo(strumentoDaFile.getLuogo());
						strumentoModificato.setProcedura(strumentoDaFile.getProcedura());
						strumentoModificato.setDataProssimaVerifica(strumentoDaFile.getDataProssimaVerifica());
						strumentoModificato.setDataUltimaVerifica(strumentoDaFile.getDataUltimaVerifica());
						strumentoModificato.setStato_strumento(new StatoStrumentoDTO(Costanti.STATO_STRUMENTO_IN_SERVIZIO, ""));
				   		strumentoModificato.setTipo_strumento(new TipoStrumentoDTO(strumentoDaFile.getTipo_strumento().getId(), ""));

						GestioneStrumentoBO.update(strumentoModificato, session);
						strumento=strumentoModificato;
					}

					else 
					{
						StrumentoDTO	strumentoAggiormanentoScadenza = GestioneStrumentoBO.getStrumentoById(""+sicurezza.getStrumento().get__id(),session);
						strumentoAggiormanentoScadenza.setDataProssimaVerifica(sicurezza.getStrumento().getDataProssimaVerifica());
						strumentoAggiormanentoScadenza.setDataUltimaVerifica(sicurezza.getStrumento().getDataUltimaVerifica());


						GestioneStrumentoBO.update(strumentoAggiormanentoScadenza, session);
					}

					MisuraDTO misura= new MisuraDTO();

					SimpleDateFormat sdf = new SimpleDateFormat("dd.MM.yy");

					misura.setIntervento(intervento);
					misura.setInterventoDati(interventoDati);
					misura.setStrumento(strumento);
					misura.setUser(utente);
					misura.setDataMisura(sdf.parse(sicurezza.getDATA()));
					misura.setLat("E");
					misura.setStatoRicezione(new StatoRicezioneStrumentoDTO(8901));
					misura.setObsoleto("N");

					if(utente.getContatoreUtente()!=null) 
					{

						ContatoreUtenteDTO contatore=utente.getContatoreUtente();

						int count=contatore.getContatoreSE();

						String codice="SSE"+contatore.getCodiceSE()+count;

						misura.setnCertificato(codice);

						utente.getContatoreUtente().setContatoreSE(count+1);

						GestioneSicurezzaElettricaBO.updateContatoreUtente(utente);
						//  session.update(utente.getContatoreUtente());

					}



					int idMis =saveMisura(misura,session);
					sicurezza.setId_misura(idMis);

					/*
					 * Salvo scadenza 
					 */
					//			    		ScadenzaDTO scadenza =sicurezza.getStrumento().getScadenzaDTO();
					//			    		scadenza.setIdStrumento(misura.getStrumento().get__id());
					//				    	scadenza.setDataUltimaVerifica(new java.sql.Date(misura.getDataMisura().getTime()));
					//			    		GestioneStrumentoBO.saveScadenza(scadenza,session);


					saveSicurezza(sicurezza,session);

					intervento.setnStrumentiMisurati(intervento.getnStrumentiMisurati()+1);
					interventoDati.setNumStrMis(interventoDati.getNumStrMis()+1);




					update(intervento, session);
					session.update(interventoDati);


					CertificatoDTO certificato = new CertificatoDTO();
					certificato.setMisura(misura);
					certificato.setStato(new StatoCertificatoDTO(1));
					certificato.setUtente(misura.getUser());

					saveCertificato(certificato,session);
					GestioneInterventoDAO.update(intervento,session);


					}

				}

			}
			else 
			{

				//ArrayList<MisuraDTO> listaMisure=SQLLiteDAO.getListaMisure(con,intervento);

				for (int i = 0; i < listaMisureDP.size(); i++) 
				{
					MisuraDTO misura = listaMisureDP.get(i);

					if(misura.getStrumento().get__id()==Integer.parseInt(idStr)) 
					{	 

						if(misura.getStrumento().getStrumentoModificato()!=null && misura.getStrumento().getStrumentoModificato().equals("S")) {
							System.out.println(misura.getStrumento().get__id());
							StrumentoDTO strumentoModificato=new StrumentoDTO();

							strumentoModificato = GestioneStrumentoBO.getStrumentoById(""+misura.getStrumento().get__id(),session);

							StrumentoDTO strumentoDaFile = misura.getStrumento();

							strumentoModificato.setUserModifica(utente);
							strumentoModificato.setDataModifica(new java.sql.Date(Calendar.getInstance().getTimeInMillis()));

							TipoRapportoDTO tipoRapp = new TipoRapportoDTO(strumentoDaFile.getIdTipoRapporto(),"");
							strumentoModificato.setTipoRapporto(tipoRapp);

							ClassificazioneDTO classificazione = new ClassificazioneDTO(strumentoDaFile.getIdClassificazione(),"");		   		
							strumentoModificato.setClassificazione(classificazione);
							strumentoModificato.setFrequenza(strumentoDaFile.getFrequenza());
							strumentoModificato.setDenominazione(strumentoDaFile.getDenominazione());   	
							strumentoModificato.setCodice_interno(strumentoDaFile.getCodice_interno());
							strumentoModificato.setCostruttore(strumentoDaFile.getCostruttore());
							strumentoModificato.setModello(strumentoDaFile.getModello());
							strumentoModificato.setReparto(strumentoDaFile.getReparto());
							strumentoModificato.setUtilizzatore(strumentoDaFile.getUtilizzatore());
							strumentoModificato.setMatricola(strumentoDaFile.getMatricola());
							strumentoModificato.setCampo_misura(strumentoDaFile.getCampo_misura());
							strumentoModificato.setRisoluzione(strumentoDaFile.getRisoluzione());
							strumentoModificato.setNote(strumentoDaFile.getNote());
							strumentoModificato.setLuogo(strumentoDaFile.getLuogo());
							strumentoModificato.setProcedura(strumentoDaFile.getProcedura());
							strumentoModificato.setDataProssimaVerifica(strumentoDaFile.getDataProssimaVerifica());
							strumentoModificato.setDataUltimaVerifica(strumentoDaFile.getDataUltimaVerifica());
							strumentoModificato.setStato_strumento(new StatoStrumentoDTO(Costanti.STATO_STRUMENTO_IN_SERVIZIO, ""));
					   		strumentoModificato.setTipo_strumento(new TipoStrumentoDTO(strumentoDaFile.getTipo_strumento().getId(), ""));

							GestioneStrumentoBO.update(strumentoModificato, session);
						}

						//				ScadenzaDTO scadenza =misura.getStrumento().getScadenzaDTO();
						//	    		scadenza.setIdStrumento(misura.getStrumento().get__id());
						//		    	scadenza.setDataUltimaVerifica(new java.sql.Date(misura.getDataMisura().getTime()));
						//	    		GestioneStrumentoBO.saveScadenza(scadenza,session);
						//				

					
							int idTemp=misura.getId();
							misura.setInterventoDati(esito.getInterventoDati());
							misura.setUser(utente);
						//	misura.setNote_obsolescenza(note_obsolescenza);
							if(esito.isLAT())
							{
								listaMisureDP.get(i).setLat("S");


								LatMisuraDTO misuraLAT = SQLLiteDAO.getMisuraLAT(con, misura.getStrumento(), misura.getStrumento().get__id());
								misuraLAT.setIntervento_dati(esito.getInterventoDati());
								misuraLAT.setIntervento(intervento);
								misuraLAT.setUser(utente);

								idTemp = misuraLAT.getId();

								int idMisuraLAT=saveMisuraLAT(misuraLAT,session);

								if(misuraLAT.getMisura_lat().getId()==1) 
								{
									ArrayList<LatPuntoLivellaDTO> listaPuntiMisura = SQLLiteDAO.getListaPuntiLivella(con,idMisuraLAT,idTemp);

									for (int j = 0; j < listaPuntiMisura .size(); j++) 
									{
										saveListaPuntiLivella(listaPuntiMisura.get(j),session);
									}	

								}
								/*Livella Elettronica*/
								if(misuraLAT.getMisura_lat().getId()==2) 
								{
									ArrayList<LatPuntoLivellaElettronicaDTO> listaPuntiMisura = SQLLiteDAO.getListaPuntiLivellaElettronica(con,idMisuraLAT,idTemp);

									for (int j = 0; j < listaPuntiMisura .size(); j++) 
									{
										saveListaPuntiLivellaElettronica(listaPuntiMisura.get(j),session);
									}	

								}

								misura.setMisuraLAT(misuraLAT);
							}
							else
							{
								listaMisureDP.get(i).setLat("N");
							}

							/*Salvo la nuova misura*/
							session.save(listaMisureDP.get(i));

							/*Salvo i nuovi punti*/
							ArrayList<PuntoMisuraDTO> listaPuntiMisura = SQLLiteDAO.getListaPunti(con,idTemp,misura.getId());

							for (int j = 0; j < listaPuntiMisura .size(); j++) 
							{
								session.save(listaPuntiMisura.get(j));
							}

								 
							/*Rendo obsoleto sia la misura che i punti precedenti*/
								ArrayList<MisuraDTO> listaMisuraObsoleta = GestioneInterventoDAO.getMisuraObsoleta(intervento.getId(),idStr);
								for (MisuraDTO misuraObsoleta : listaMisuraObsoleta) 
								{
									
									GestioneInterventoDAO.misuraObsoleta(misuraObsoleta,note_obsolescenza,session);
									GestioneInterventoDAO.puntoMisuraObsoleto(misuraObsoleta.getId(),session);		
								}

							
							
							intervento.setnStrumentiMisurati(intervento.getnStrumentiMisurati()+1);
		 					esito.getInterventoDati().setNumStrMis(esito.getInterventoDati().getNumStrMis()+1);

							GestioneInterventoBO.updateInterventoDati(esito.getInterventoDati(),session);
							GestioneInterventoBO.update(intervento, session);
							
							CertificatoDTO certificato = new CertificatoDTO();
							certificato.setMisura(misura);
							certificato.setStato(new StatoCertificatoDTO(1));
							certificato.setUtente(misura.getUser());

							saveCertificato(certificato,session);
						

					}				

				}

			}

			return esito;
			
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
	public static ArrayList<MisuraDTO> getListaMirureByIntervento(int idIntervento, Session session)throws Exception
	{
		
			return GestioneInterventoDAO.getListaMirureByIntervento(idIntervento, session);
			
		
	}
	
	public static ArrayList<MisuraDTO> getListaMirureNonObsoleteByIntervento(int idIntervento)throws Exception
	{
		
			return GestioneInterventoDAO.getListaMirureNonObsoleteByIntervento(idIntervento);
			
		
	}
	
	private static void saveSicurezza(SicurezzaElettricaDTO sicurezza, Session session) 
	{	
		session.save(sicurezza);
	}
	

	public static ArrayList<InterventoDTO> getListaInterventiDaSede(String idCliente, String idSede, Integer idCompany, UtenteDTO user,	Session session) {
		// TODO Auto-generated method stub
		return GestioneInterventoDAO.getListaInterventiDaSede(idCliente,idSede,idCompany,user, session);
	}

	public static ArrayList<Integer> getListaClientiInterventi(int id_company) {
		// TODO Auto-generated method stub
		return GestioneInterventoDAO.getListaClientiInterventi(id_company);
	}

	public static ArrayList<Integer> getListaSediInterventi() {
		// TODO Auto-generated method stub
		return GestioneInterventoDAO.getListaSediInterventi();
	}
	
	public static ArrayList<UtenteDTO> getListaUtentiInterventoDati(Session session){
		
		return GestioneInterventoDAO.getListaUtentiInterventoDati(session);
	}

	public static boolean isElectric(ObjSavePackDTO esito) throws ClassNotFoundException, SQLException {
		
		String nomeDB=esito.getPackNameAssigned().getPath();
		
		Connection con =SQLLiteDAO.getConnection(nomeDB);
		
		return SQLLiteDAO.isElectric(con);
	}

	public static ArrayList<InterventoDTO> getListaInterventoUtente(int id_utente,String dateFrom,String dateTo, Session session) throws Exception{
		
		return GestioneInterventoDAO.getListaInterventoUtente(id_utente, dateFrom, dateTo,session);
	}

	public static ControlloAttivitaDTO getStrumentiAssegnatiUtente(int id_utente, int id_intervento, Session session) {
		
		return GestioneInterventoDAO.getStrumentiAssegnatiUtente(id_utente,id_intervento,session);
	}

	public static void setControllato(int id_intervento, int id_utente, int tipo, Session session) {
		
		GestioneInterventoDAO.setControllato(id_intervento,id_utente,tipo, session);
	}

	public static void salvaNota(int id_intervento, int id_utente, String nota, Session session) {
		
		GestioneInterventoDAO.salvaNota(id_intervento, id_utente, nota, session);
		
	}

	public static ArrayList<InterventoDTO> getListaInterventiConsegna(Session session) {
		
		return GestioneInterventoDAO.getListaInterventiConsegna(session);
	}

	public static InterventoDTO getUltimoIntervento(Integer id_cliente, Integer id_sede, Session session) {
		
		return GestioneInterventoDAO.getUltimoIntervento(id_cliente, id_sede, session);
	}

	public static ArrayList<InterventoDTO> getListaInterventiUtente(int id_utente,int id_cliente, int id_sede,  Session session) {
		
		return GestioneInterventoDAO.getListaInterventiUtente(id_utente,  id_cliente,  id_sede,  session);
	}

	public static ArrayList<InterventoDTO> getListainterventiAperti() throws Exception {
		// TODO Auto-generated method stub
		return DirectMySqlDAO.getListainterventiAperti();
	}



	
	


}
