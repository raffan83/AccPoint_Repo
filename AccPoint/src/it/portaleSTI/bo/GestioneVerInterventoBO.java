package it.portaleSTI.bo;

import java.io.File;
import java.sql.Connection;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.io.FileUtils;
import org.hibernate.HibernateException;
import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneInterventoDAO;
import it.portaleSTI.DAO.GestioneVerComunicazioniDAO;
import it.portaleSTI.DAO.GestioneVerInterventoDAO;
import it.portaleSTI.DAO.GestioneVerStrumentiDAO;
import it.portaleSTI.DAO.SQLLiteDAO;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.ClassificazioneDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.ObjSavePackDTO;
import it.portaleSTI.DTO.OffOffertaArticoloDTO;
import it.portaleSTI.DTO.OffOffertaDTO;
import it.portaleSTI.DTO.PuntoMisuraDTO;
import it.portaleSTI.DTO.StatoCertificatoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerAccuratezzaDTO;
import it.portaleSTI.DTO.VerCertificatoDTO;
import it.portaleSTI.DTO.VerDecentramentoDTO;
import it.portaleSTI.DTO.VerFamigliaStrumentoDTO;
import it.portaleSTI.DTO.VerInterventoDTO;
import it.portaleSTI.DTO.VerInterventoStrumentiDTO;
import it.portaleSTI.DTO.VerLinearitaDTO;
import it.portaleSTI.DTO.VerMisuraDTO;
import it.portaleSTI.DTO.VerMobilitaDTO;
import it.portaleSTI.DTO.VerRipetibilitaDTO;
import it.portaleSTI.DTO.VerStrumentoDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;

public class GestioneVerInterventoBO {

	public static ArrayList<VerInterventoDTO> getListaVerInterventi(UtenteDTO utente,String dateFrom, String dateTo, Session session) throws HibernateException, ParseException {
		
		return GestioneVerInterventoDAO.getListaVerInterventi(utente, dateFrom, dateTo,session);
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
				
				File dir = new File(Costanti.PATH_FOLDER+"//"+folder);
				
				if(!dir.exists()) 
				{
					dir.mkdir();
				}
				
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
			
			int strumentiDuplicati = 0;

		    for (int i = 0; i < listaMisure.size(); i++) 
		    {
		    
		   VerMisuraDTO misura = listaMisure.get(i);
	
		   boolean isPresent=GestioneVerInterventoDAO.isPresentVerStrumento(ver_intervento.getId(),misura.getVerStrumento(),session);
		   
		   if(isPresent == false) {
			   
			   int idStrumentoPerComunicazione=0;
			   
			   	if(misura.getVerStrumento().getCreato().equals("S"))
			   	{
			   		VerStrumentoDTO strumento= misura.getVerStrumento();
			    	
			   		strumento.setId_cliente(ver_intervento.getId_cliente());
			   		strumento.setId_sede(ver_intervento.getId_sede());
			   		
			   		strumento.setData_ultima_verifica(misura.getDataVerificazione());
			   		strumento.setData_prossima_verifica(misura.getDataScadenza());
			   		session.save(strumento);
			    		
			    	misura.setVerStrumento(strumento);
			    }else 
			    {
			    	VerStrumentoDTO strumentoFile=misura.getVerStrumento();
			    	
			    	VerStrumentoDTO strumentoDB=GestioneVerStrumentiDAO.getVerStrumentoFromId(strumentoFile.getId(), session);
			    	
			    	idStrumentoPerComunicazione=strumentoDB.getId();
			    	strumentoDB.setDenominazione(strumentoFile.getDenominazione());
			    	strumentoDB.setModello(strumentoFile.getModello());
			    	strumentoDB.setMatricola(strumentoFile.getMatricola());
			    	strumentoDB.setCostruttore(strumentoFile.getCostruttore());
			    	strumentoDB.setAnno_marcatura_ce(strumentoFile.getAnno_marcatura_ce());		    	
			    	strumentoDB.setData_ultima_verifica(misura.getDataVerificazione());
			    	strumentoDB.setData_prossima_verifica(misura.getDataScadenza());
			    	if(!Utility.checkDateNull(strumentoFile.getData_messa_in_servizio()).equals("-")) 
			    	{
			    		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			    		strumentoDB.setData_messa_in_servizio(sdf.parse(Utility.checkDateNull(strumentoFile.getData_messa_in_servizio())));
			    	}
			    	strumentoDB.setFreqMesi(strumentoFile.getFreqMesi());
			    	
			    	strumentoDB.setClasse(strumentoFile.getClasse());
			    	strumentoDB.setTipo(strumentoFile.getTipo());
			    	strumentoDB.setUm(strumentoFile.getUm());
			    	
			    	strumentoDB.setPortata_min_C1(strumentoFile.getPortata_min_C1());
			    	strumentoDB.setPortata_max_C1(strumentoFile.getPortata_max_C1());
			    	strumentoDB.setDiv_rel_C1(strumentoFile.getDiv_rel_C1());
			    	strumentoDB.setDiv_ver_C1(strumentoFile.getDiv_ver_C1());
			    	strumentoDB.setNumero_div_C1(strumentoFile.getNumero_div_C1());
			    	
			    	strumentoDB.setPortata_min_C2(strumentoFile.getPortata_min_C2());
			    	strumentoDB.setPortata_max_C2(strumentoFile.getPortata_max_C2());
			    	strumentoDB.setDiv_rel_C2(strumentoFile.getDiv_rel_C2());
			    	strumentoDB.setDiv_ver_C2(strumentoFile.getDiv_ver_C2());
			    	strumentoDB.setNumero_div_C2(strumentoFile.getNumero_div_C2());
			    	
			    	strumentoDB.setPortata_min_C3(strumentoFile.getPortata_min_C3());
			    	strumentoDB.setPortata_max_C3(strumentoFile.getPortata_max_C3());
			    	strumentoDB.setDiv_rel_C3(strumentoFile.getDiv_rel_C3());
			    	strumentoDB.setDiv_ver_C3(strumentoFile.getDiv_ver_C3());
			    	strumentoDB.setNumero_div_C3(strumentoFile.getNumero_div_C3());
			    	
			    	strumentoDB.setTipologia(strumentoFile.getTipologia());
			    	strumentoDB.setFreqMesi(strumentoFile.getFreqMesi());
			    	strumentoDB.setFamiglia_strumento(strumentoFile.getFamiglia_strumento());
			    	session.update(strumentoDB);
			    }
			   	
			   	
			   	misura.setComunicazione_esito("N");
			  
				if(misura.getVerStrumento().getCreato().equals("S"))
			   	{
					misura.setComunicazione_preventiva("N");
			   	}
				else 
			   	{
			   		String comunicazionePreventiva=GestioneVerComunicazioniDAO.checkComunicazionePreventiva(session,ver_intervento.getId(),idStrumentoPerComunicazione);  	
				   	misura.setComunicazione_preventiva(comunicazionePreventiva);
			   	}	   	
			   
			   	misura.setObsoleta("N");
			   	session.save(misura);
			   	
			   	if(misura.getFile_inizio_prova()!=null) 
			   	{
			   		File dir =new File(Costanti.PATH_FOLDER+"\\"+ver_intervento.getNome_pack()+"\\"+misura.getId());
			   		
			   		if(dir.exists()==false) 
			   		{
			   			dir.mkdir();
			   		}
			   		
			   		FileUtils.writeByteArrayToFile(new File(dir.getPath()+"\\"+misura.getNomeFile_inizio_prova().replace("'","_")), misura.getFile_inizio_prova());
			   	}
				
			   	if(misura.getFile_fine_prova()!=null) 
			   	{
			   		File dir =new File(Costanti.PATH_FOLDER+"\\"+ver_intervento.getNome_pack()+"\\"+misura.getId());
			   		
			   		if(dir.exists()==false) 
			   		{
			   			dir.mkdir();
			   		}
			   		
			   		FileUtils.writeByteArrayToFile(new File(dir.getPath()+"\\"+misura.getNomeFile_fine_prova().replace("'","_")), misura.getFile_fine_prova());
			   	}
			   	
			   	for (VerDecentramentoDTO dec :misura.getListaPuntiDecentramento())
			   	{
			   		dec.setIdMisura(misura.getId());
			   		session.save(dec);
			   	}
			   	
			  	for (VerMobilitaDTO mob :misura.getListaPuntiMobilita())
			   	{
			  		mob.setIdMisura(misura.getId());
			   		session.save(mob);
			   	}
			  	
			  	for (VerRipetibilitaDTO rip :misura.getListaPuntiRipetibilita())
			   	{
			   		rip.setIdMisura(misura.getId());
			   		session.save(rip);
			   	}
			  	
			  	for (VerLinearitaDTO lin :misura.getListaPuntiLinearita())
			   	{
			  		lin.setIdMisura(misura.getId());
			   		session.save(lin);
			   	}
			  	
			  	for (VerAccuratezzaDTO acc :misura.getListaPuntiAccuratezza())
			   	{
			   		acc.setIdMisura(misura.getId());
			   		session.save(acc);
			   	}
			 
			   	
			  	VerCertificatoDTO certificato = new VerCertificatoDTO();
			  	certificato.setUtente(utente);
			  	certificato.setStato(new StatoCertificatoDTO(1));
			  	certificato.setDataCreazione(new Date());
			  	certificato.setMisura(misura);
			  	int esito_misura = GestioneVerMisuraBO.getEsito(misura);
			  	if(esito_misura!=0) {
			  		misura.setEsito(0);	
			  	}else {
			  		misura.setEsito(1);
			  	}
			  	session.update(misura);
			  	
			  	session.save(certificato);
			   
		   }else {
			   esito.getListaVerStrumentiDuplicati().add(misura.getVerStrumento());	
	    		strumentiDuplicati++;
	    		esito.setEsito(1);
		   }
		   
		  
		  }
		    
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
	
	
	public static void updateMisura(String idStr, ObjSavePackDTO esito, VerInterventoDTO intervento, UtenteDTO utente, String note_obsolescenza, Session session) throws Exception {
		
		try{
							
			String nomeDB=esito.getPackNameAssigned().getPath();
			
			Connection con =SQLLiteDAO.getConnection(nomeDB);
			
			ArrayList<VerMisuraDTO> listaMisure=SQLLiteDAO.getListaMisure(con,intervento);
			
			   int idStrumentoPerComunicazione=0;
			for (int i = 0; i < listaMisure.size(); i++) 
			{
				VerMisuraDTO misura = listaMisure.get(i);
				
				
				VerStrumentoDTO strumentoFile=misura.getVerStrumento();
		    	
		    	VerStrumentoDTO strumentoDB=GestioneVerStrumentiDAO.getVerStrumentoFromId(strumentoFile.getId(), session);
		    	
		    	idStrumentoPerComunicazione=strumentoDB.getId();
		    	strumentoDB.setDenominazione(strumentoFile.getDenominazione());
		    	strumentoDB.setModello(strumentoFile.getModello());
		    	strumentoDB.setMatricola(strumentoFile.getMatricola());
		    	strumentoDB.setCostruttore(strumentoFile.getCostruttore());
		    	strumentoDB.setAnno_marcatura_ce(strumentoFile.getAnno_marcatura_ce());		    	
		    	strumentoDB.setData_ultima_verifica(misura.getDataVerificazione());
		    	strumentoDB.setData_prossima_verifica(misura.getDataScadenza());
		    	if(!Utility.checkDateNull(strumentoFile.getData_messa_in_servizio()).equals("-")) 
		    	{
		    		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		    		strumentoDB.setData_messa_in_servizio(sdf.parse(Utility.checkDateNull(strumentoFile.getData_messa_in_servizio())));
		    	}
		    	strumentoDB.setFreqMesi(strumentoFile.getFreqMesi());
		    	
		    	strumentoDB.setClasse(strumentoFile.getClasse());
		    	strumentoDB.setTipo(strumentoFile.getTipo());
		    	strumentoDB.setUm(strumentoFile.getUm());
		    	
		    	strumentoDB.setPortata_min_C1(strumentoFile.getPortata_min_C1());
		    	strumentoDB.setPortata_max_C1(strumentoFile.getPortata_max_C1());
		    	strumentoDB.setDiv_rel_C1(strumentoFile.getDiv_rel_C1());
		    	strumentoDB.setDiv_ver_C1(strumentoFile.getDiv_ver_C1());
		    	strumentoDB.setNumero_div_C1(strumentoFile.getNumero_div_C1());
		    	
		    	strumentoDB.setPortata_min_C2(strumentoFile.getPortata_min_C2());
		    	strumentoDB.setPortata_max_C2(strumentoFile.getPortata_max_C2());
		    	strumentoDB.setDiv_rel_C2(strumentoFile.getDiv_rel_C2());
		    	strumentoDB.setDiv_ver_C2(strumentoFile.getDiv_ver_C2());
		    	strumentoDB.setNumero_div_C2(strumentoFile.getNumero_div_C2());
		    	
		    	strumentoDB.setPortata_min_C3(strumentoFile.getPortata_min_C3());
		    	strumentoDB.setPortata_max_C3(strumentoFile.getPortata_max_C3());
		    	strumentoDB.setDiv_rel_C3(strumentoFile.getDiv_rel_C3());
		    	strumentoDB.setDiv_ver_C3(strumentoFile.getDiv_ver_C3());
		    	strumentoDB.setNumero_div_C3(strumentoFile.getNumero_div_C3());
		    	
		    	strumentoDB.setTipologia(strumentoFile.getTipologia());
		    	strumentoDB.setFreqMesi(strumentoFile.getFreqMesi());
		    	strumentoDB.setFamiglia_strumento(strumentoFile.getFamiglia_strumento());
		    	session.update(strumentoDB);
			
			
//				ScadenzaDTO scadenza =misura.getStrumento().getScadenzaDTO();
//	    		scadenza.setIdStrumento(misura.getStrumento().get__id());
//		    	scadenza.setDataUltimaVerifica(new java.sql.Date(misura.getDataMisura().getTime()));
//	    		GestioneStrumentoBO.saveScadenza(scadenza,session);
//				

				if(listaMisure.get(i).getVerStrumento().getId()==Integer.parseInt(idStr))
				{
					int idTemp=misura.getId();
					
		    		misura.setTecnicoVerificatore(utente);
					misura.setNote_obsolescenza(note_obsolescenza);
		    		misura.setObsoleta("N");
					misura.setComunicazione_esito("N");
					  
					if(misura.getVerStrumento().getCreato().equals("S"))
				   	{
						misura.setComunicazione_preventiva("N");
				   	}
					else 
				   	{
				   		String comunicazionePreventiva=GestioneVerComunicazioniDAO.checkComunicazionePreventiva(session,intervento.getId(),idStrumentoPerComunicazione);  	
					   	misura.setComunicazione_preventiva(comunicazionePreventiva);
				   	}	
					
		    		/*Salvo la nuova misura*/
		    		session.save(listaMisure.get(i));

		    		/*Salvo i nuovi punti*/
		    		if(misura.getFile_inizio_prova()!=null) 
				   	{
				   		File dir =new File(Costanti.PATH_FOLDER+"\\"+intervento.getNome_pack()+"\\"+misura.getId());
				   		
				   		if(dir.exists()==false) 
				   		{
				   			dir.mkdir();
				   		}
				   		
				   		FileUtils.writeByteArrayToFile(new File(dir.getPath()+"\\"+misura.getNomeFile_inizio_prova()), misura.getFile_inizio_prova());
				   	}
					
				   	if(misura.getFile_fine_prova()!=null) 
				   	{
				   		File dir =new File(Costanti.PATH_FOLDER+"\\"+intervento.getNome_pack()+"\\"+misura.getId());
				   		
				   		if(dir.exists()==false) 
				   		{
				   			dir.mkdir();
				   		}
				   		
				   		FileUtils.writeByteArrayToFile(new File(dir.getPath()+"\\"+misura.getNomeFile_fine_prova()), misura.getFile_fine_prova());
				   	}
				   	
				   	for (VerDecentramentoDTO dec :misura.getListaPuntiDecentramento())
				   	{
				   		dec.setIdMisura(misura.getId());
				   		session.save(dec);
				   	}
				   	
				  	for (VerMobilitaDTO mob :misura.getListaPuntiMobilita())
				   	{
				  		mob.setIdMisura(misura.getId());
				   		session.save(mob);
				   	}
				  	
				  	for (VerRipetibilitaDTO rip :misura.getListaPuntiRipetibilita())
				   	{
				   		rip.setIdMisura(misura.getId());
				   		session.save(rip);
				   	}
				  	
				  	for (VerLinearitaDTO lin :misura.getListaPuntiLinearita())
				   	{
				  		lin.setIdMisura(misura.getId());
				   		session.save(lin);
				   	}
				  	
				  	for (VerAccuratezzaDTO acc :misura.getListaPuntiAccuratezza())
				   	{
				   		acc.setIdMisura(misura.getId());
				   		session.save(acc);
				   	}
					
					
					/*Rendo obsoleto sia la misura che i punti precedenti*/
					ArrayList<VerMisuraDTO> listaMisuraObsoleta = GestioneVerInterventoDAO.getMisuraObsoleta(intervento.getId(),idStr);
					for (VerMisuraDTO misuraObsoleta : listaMisuraObsoleta) 
					{
						GestioneVerInterventoDAO.misuraObsoleta(misuraObsoleta,session);
						//GestioneInterventoDAO.puntoMisuraObsoleto(misuraObsoleta.getId(),session);		
					}
					
		    		VerCertificatoDTO certificato = new VerCertificatoDTO();
		    		certificato.setMisura(misura);
		    		certificato.setStato(new StatoCertificatoDTO(1));
		    		certificato.setUtente(misura.getTecnicoVerificatore());
		    		certificato.setDataCreazione(new Date());
		    		
		    		int esito_misura = GestioneVerMisuraBO.getEsito(misura);
				  	if(esito_misura!=0) {
				  		misura.setEsito(0);	
				  	}else {
				  		misura.setEsito(1);
				  	}
				  	session.update(misura);
		    		
		    		session.save(certificato);
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

	public static VerInterventoStrumentiDTO getInterventoStrumento(int id_intervento, int id_strumento, Session session) {
		
		return GestioneVerInterventoDAO.getInterventoStrumento(id_intervento, id_strumento, session);
	}

	public static ArrayList<VerInterventoDTO> getListaInterventiCommessa(String idCommessa, Session session) {
		
		return GestioneVerInterventoDAO.getListaInterventiCommessa(idCommessa,session);
	}

	public static ArrayList<OffOffertaDTO> getListaOfferte(UtenteDTO utente, Session session) {
		
		return GestioneVerInterventoDAO.getListaOfferte( utente,  session) ;
	}
	
	public static ArrayList<OffOffertaArticoloDTO> getListaOfferteArticoli(int id_offerta, Session session) {
		
		return GestioneVerInterventoDAO.getListaOfferteArticoli( id_offerta,  session) ;
	}
	

}
