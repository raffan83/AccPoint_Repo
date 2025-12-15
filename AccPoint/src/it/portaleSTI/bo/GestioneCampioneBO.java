package it.portaleSTI.bo;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DTO.AcAttivitaCampioneDTO;
import it.portaleSTI.DTO.AttivitaManutenzioneDTO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CertificatoCampioneDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.DocumentoCampioneDTO;
import it.portaleSTI.DTO.ObjSavePackDTO;
import it.portaleSTI.DTO.TipoManutenzioneDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.RegistroEventiDTO;
import it.portaleSTI.DTO.SequenceDTO;
import it.portaleSTI.DTO.TipoAttivitaManutenzioneDTO;
import it.portaleSTI.DTO.TipoEventoRegistroDTO;
import it.portaleSTI.DTO.ValoreCampioneDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.action.GestioneFormazione;
import it.portaleSTI.DTO.TipoAttivitaManutenzioneDTO;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.nio.file.Files;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.ServletOutputStream;

import org.apache.commons.fileupload.FileItem;
import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.google.gson.JsonArray;

public class GestioneCampioneBO {

	static final Logger logger = Logger.getLogger(GestioneCampioneBO.class);

	public static int saveCampione(CampioneDTO campione, String action, ArrayList<ValoreCampioneDTO> listaValori, FileItem fileItem, String ente_certificatore, Session session)  throws Exception{
		
		int toRet=0;
		
		try{
		int idCampione=0;
		
		if(action.equals("modifica")){
			session.update(campione);
			idCampione=campione.getId();
		}
		else if(action.equals("nuovo")){
			idCampione=(Integer) session.save(campione);
			
			for(int i=0;i<listaValori.size();i++)
			{
				session.save(listaValori.get(i));
			}
			
		}
		
		if(fileItem!=null && fileItem.getName().length()>0)
		{
		
		 
			CertificatoCampioneDTO certificatoCampioneDTO = new CertificatoCampioneDTO();
			certificatoCampioneDTO.setId_campione(idCampione);
			certificatoCampioneDTO.setDataCreazione(new Date());
			certificatoCampioneDTO.setNumero_certificato(campione.getNumeroCertificato());
			certificatoCampioneDTO.setEnte_certificatore(ente_certificatore);
			
			int idCertificatoCampione=GestioneCampioneDAO.saveCertifiactoCampione(certificatoCampioneDTO,session);
			
			String filename =salvaCertificatoCampione(fileItem,campione,idCertificatoCampione);
			
			if(filename.equals("BADFILE"))
			{
				return 2;
			}
			certificatoCampioneDTO.setFilename(filename);
			
			GestioneCampioneDAO.updateCertificatoCampione(certificatoCampioneDTO,session);
			
			
//			RegistroEventiDTO evento = new RegistroEventiDTO();
//			
//			Date today = new Date(System.currentTimeMillis());
//			evento.setData_evento(today);
//			evento.setData_scadenza(campione.getDataScadenza());
//			evento.setTipo_evento(new TipoEventoRegistroDTO(1));
//			evento.setCertificato_taratura(campione.getNumeroCertificato());
//			evento.setEnte_certificatore(ente_certificatore);
//			evento.setCampione(campione);
//			GestioneCampioneDAO.saveEventoRegistro(evento, session);
		}
			
		toRet=0;	
			
		}catch (Exception ex)
		{
			toRet=1;
			throw ex;
	 		
	 		
		}
		return toRet;
	}


	private static String salvaCertificatoCampione(FileItem fileItem,CampioneDTO campione, int idCertificatoCampione) throws Exception {
		
		File directory =new File(Costanti.PATH_FOLDER+"//Campioni//"+campione.getId());
		
		if(directory.exists()==false)
		{
			directory.mkdir();
		}
		
		if(fileItem.getName().substring(fileItem.getName().length()-3, fileItem.getName().length()).equalsIgnoreCase("pdf"))
		{
		
			File file =new File(directory.getPath()+"//"+campione.getId()+"_"+idCertificatoCampione+".pdf");
		
		fileItem.write(file);
		
		
		return file.getName();
		}
		else
		{
			return "BADFILE";
		}
	}


	public static CampioneDTO controllaCodice(String codice) {
		
		return GestioneCampioneDAO.getCampioneFromCodice(codice);
	}


	public static void rendiObsoletiValoriCampione(Session session, int id) {
		
		GestioneCampioneDAO.rendiObsoletiValoriCampione(session,id);
	}


	public static void saveValoreCampione(Session session,ValoreCampioneDTO valoreCampioneDTO) throws Exception 
	{
		valoreCampioneDTO.setObsoleto("N");
		GestioneCampioneDAO.saveValoreCampione(session,valoreCampioneDTO);
		
	}
	public static ArrayList<String> getListaCampioniString(CompanyDTO cmp)  throws Exception {
		return DirectMySqlDAO.getListaCampioniString(cmp);
	}


	public static ArrayList<RegistroEventiDTO> getListaRegistroEventi(String id_campione, Session session) {
		
		return GestioneCampioneDAO.getListaRegistroEventi(id_campione, session);
	}


	public static ArrayList<AttivitaManutenzioneDTO> getListaAttivitaManutenzione(int id_evento, Session session) {
		
		return GestioneCampioneDAO.getListaAttivitaManutenzione(id_evento, session);
	}


	public static void saveAttivitaManutenzione(AttivitaManutenzioneDTO attivita, Session session) {
		GestioneCampioneDAO.saveAttivitaManutenzione(attivita, session);
		
	}
	
	public static CertificatoCampioneDTO getCertificatoFromCampione(int id_campione, Session session) {
		
		return GestioneCampioneDAO.getCertificatoFromCampione(id_campione, session);
	}


	public static ArrayList<TipoManutenzioneDTO> getListaTipoManutenzione(Session session) {
		
		return GestioneCampioneDAO.getListaTipoManutenzione(session);
	}


	public static ArrayList<TipoAttivitaManutenzioneDTO> getListaTipoAttivitaManutenzione(Session session) {

		return GestioneCampioneDAO.getListaTipoAttivitaManutenzione(session);
	}


	public static RegistroEventiDTO getEventoFromId(int id_evento, Session session) {
	
		return GestioneCampioneDAO.getEventoFromId(id_evento, session);
	}



	public static DocumentoCampioneDTO getDocumentoCampione(String idDocumento, Session session) {
		
		return GestioneCampioneDAO.getDocumentoCampione(idDocumento,session);
	}


	public static ArrayList<DocumentoCampioneDTO> getListaDocumentiEsterni(int id_campione, Session session) {
		
		return GestioneCampioneDAO.getListaDocumentiEsterni(id_campione, session);
	}


	public static ArrayList<TipoEventoRegistroDTO> getListaTipoEventoRegistro(Session session) {
		
		return GestioneCampioneDAO.getListaTipoEventoRegistro(session);
	}


	public static ArrayList<RegistroEventiDTO> getListaEvento(int id_campione, int tipo, Session session) {
		
		return GestioneCampioneDAO.getListaEvento(id_campione,tipo, session);
	}


	public static ArrayList<DocumentoCampioneDTO> getListaDocumentazioneTecnica(int id_campione, Session session) {
		
		return GestioneCampioneDAO.getListaDocumentazioneTecnica(id_campione, session);
	}


	public static ArrayList<RegistroEventiDTO> getListaManutenzioni() {
		
		return GestioneCampioneDAO.getListaManutenzioni();
	}


	public static JsonArray getCampioniScadenzaDate(String data_start, String data_end, boolean lat, int id_company, int verificazione,UtenteDTO utente, Session session) throws Exception {
		
		return GestioneCampioneDAO.getCampioniScadenzaDate(data_start, data_end, lat,id_company, verificazione, utente, session);
	}


	public static Integer[] getProgressivoCampione() {
		
		return GestioneCampioneDAO.getProgressivoCampione();
	}


	public static SequenceDTO getSequence( Session session) {
		
		return GestioneCampioneDAO.getSequence(session);
	}


	public static ArrayList<RegistroEventiDTO> getListaManutenzioniNonObsolete(Session session, String verificazione) {
		
		return GestioneCampioneDAO.getListaManutenzioniNonObsolete(session, verificazione);
	}




	public static boolean copiaFileCampioni(Session session)  {
		try {
	 ArrayList<AcAttivitaCampioneDTO> listaAttivita = GestioneCampioneDAO.getListaAttivitaAll(session);

	    for (AcAttivitaCampioneDTO attivita : listaAttivita) {
	        if (attivita.getAllegato() != null) {
	            String path1 = Costanti.PATH_FOLDER + "//Campioni//" + attivita.getCampione().getId() + "//Allegati//AttivitaManutenzione//";
	            String path2 = Costanti.PATH_FOLDER + "//Campioni//" + attivita.getCampione().getId() + "//Allegati//";

	            Set<String> commonFiles = findCommonFileNames(path1, path2);

	            if (commonFiles.isEmpty()) continue;

	            for (String fileName : commonFiles) {
	                File f1 = new File(path1 + fileName);
	                File f2 = new File(path2 + fileName);

	                if (f1.exists() && f2.exists()) {
	                    long lastMod1 = f1.lastModified();
	                    long lastMod2 = f2.lastModified();

	                    // Se la data è diversa → copio da path2 → path1
	                    if (lastMod1 != lastMod2) {
	                        System.out.println("Campione " + attivita.getCampione().getId() + " → file differente: " + fileName);

	                        // Genera nome nuovo con indice progressivo
	                        String newFileName = generaNomeUnivocoConIndice(path1, fileName);

	                        File newFile = new File(path1 + newFileName);

	                        // Copia fisica del file
	                        Files.copy(f2.toPath(), newFile.toPath());

	                        System.out.println("Copiato " + fileName + " → " + newFileName);
	                        logger.error("Copiato " + fileName + " → " + newFileName);
	                        // Aggiorna l'attività nel DB
	                        attivita.setAllegato(newFileName);
	                        session.update(attivita);
	                    }
	                }
	            }
	            
	            File dir1 = new File(path1);
	            File dir2 = new File(path2);
	            String[] filesPath2 = dir2.list();
	            String[] filesPath1 = dir1.list();
	            if (filesPath2 != null) {
	                Set<String> filesInPath1 = filesPath1 != null ? new HashSet<>(Arrays.asList(filesPath1)) : new HashSet<>();

	                for (String fileName : filesPath2) {
	                    if (!filesInPath1.contains(fileName)) {
	                        File f2 = new File(path2 + fileName);
	                        if (f2.isFile()) {
	                            String newFileName = generaNomeUnivocoConIndice(path1, fileName);
	                            File newFile = new File(path1 + newFileName);
	                            Files.copy(f2.toPath(), newFile.toPath());

	                            System.out.println("Campione " + attivita.getCampione().getId() + " → copiato nuovo file: " + newFileName);
	                            logger.error("Campione " + attivita.getCampione().getId() + " → copiato nuovo file: " + newFileName);

	                            // Se vuoi aggiornare anche qui l'allegato
	                            attivita.setAllegato(newFileName);
	                            session.update(attivita);
	                        }
	                    }
	                }
	            }
	        }
	    }

	    
	    return true;
		}catch (Exception e) {
			
			e.printStackTrace();
			return false;
		}
	}


private static String generaNomeUnivocoConIndice(String directoryPath, String fileName) {
	    File dir = new File(directoryPath);
	    if (!dir.exists()) dir.mkdirs();

	    String name = fileName;
	    String ext = "";

	    int dotIndex = fileName.lastIndexOf('.');
	    if (dotIndex != -1) {
	        name = fileName.substring(0, dotIndex);
	        ext = fileName.substring(dotIndex);
	    }

	    File file = new File(dir, fileName);
	    if (!file.exists()) {
	        return fileName; // se non esiste, lo uso così com'è
	    }

	    int counter = 1;
	    String newFileName;
	    do {
	        newFileName = name + "_" + counter + ext;
	        file = new File(dir, newFileName);
	        counter++;
	    } while (file.exists());

	    return newFileName;
	}



 public static Set<String> findCommonFileNames(String dir1, String dir2) {
     Set<String> fileNames1 = listFileNames(new File(dir1));
     Set<String> fileNames2 = listFileNames(new File(dir2));

     // Trova l'intersezione
     Set<String> common = new HashSet<>(fileNames1);
     common.retainAll(fileNames2);
     return common;
 }

 private static Set<String> listFileNames(File directory) {
     Set<String> fileNames = new HashSet<>();

     if (directory.exists() && directory.isDirectory()) {
         File[] files = directory.listFiles();
         if (files != null) {
             for (File f : files) {
                 if (f.isFile()) {
                     fileNames.add(f.getName());
                 } else if (f.isDirectory()) {
                     // Ricorsione per includere sottocartelle
                     fileNames.addAll(listFileNames(f));
                 }
             }
         }
     }
     return fileNames;
 }
		



}
