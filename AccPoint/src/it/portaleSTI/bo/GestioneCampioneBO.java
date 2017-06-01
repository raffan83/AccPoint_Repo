package it.portaleSTI.bo;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CertificatoCampioneDTO;
import it.portaleSTI.DTO.ValoreCampioneDTO;
import it.portaleSTI.Util.Costanti;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;

import org.apache.commons.fileupload.FileItem;
import org.hibernate.Session;

public class GestioneCampioneBO {



	public static int saveCampione(CampioneDTO campione, String action, ArrayList<ValoreCampioneDTO> listaValori, FileItem fileItem, Session session)  throws Exception{
		
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
		
		if(fileItem!=null)
		{
		
		 
			CertificatoCampioneDTO certificatoCampioneDTO = new CertificatoCampioneDTO();
			certificatoCampioneDTO.setId(idCampione);
			certificatoCampioneDTO.setDataCreazione(new Date());
			certificatoCampioneDTO.setNumero_certificato(campione.getNumeroCertificato());
			
			int idCertificatoCampione=GestioneCampioneDAO.saveCertifiactoCampione(certificatoCampioneDTO,session);
			
			String filename =salvaCertificatoCampione(fileItem,campione,idCertificatoCampione);
			
			if(filename.equals("BADFILE"))
			{
				return 2;
			}
			certificatoCampioneDTO.setFilename(filename);
			
			GestioneCampioneDAO.updateCertificatoCampione(certificatoCampioneDTO,session);
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
		
		if(fileItem.getName().substring(fileItem.getName().length()-3, fileItem.getName().length()).equals("pdf"))
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



}
