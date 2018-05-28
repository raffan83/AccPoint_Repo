package it.portaleSTI.bo;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DTO.AttivitaManutenzioneDTO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CertificatoCampioneDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.TipoManutenzioneDTO;
import it.portaleSTI.DTO.RegistroEventiDTO;
import it.portaleSTI.DTO.TipoAttivitaManutenzioneDTO;
import it.portaleSTI.DTO.ValoreCampioneDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.DTO.TipoAttivitaManutenzioneDTO;

import java.io.File;
import java.io.FileInputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletOutputStream;

import org.apache.commons.fileupload.FileItem;
import org.hibernate.Session;

public class GestioneCampioneBO {



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


	public static RegistroEventiDTO getEventoFromId(int id_evento) {
	
		return GestioneCampioneDAO.getEventoFromId(id_evento);
	}


	



}
