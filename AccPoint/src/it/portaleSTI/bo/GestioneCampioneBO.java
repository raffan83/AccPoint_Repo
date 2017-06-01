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



	public static Boolean saveCampione(CampioneDTO campione, String action, ArrayList<ValoreCampioneDTO> listaValori, FileItem fileItem, Session session)  throws Exception{
		
		boolean toRet=false;
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
			
			certificatoCampioneDTO.setFilename(filename);
			
			GestioneCampioneDAO.updateCertificatoCampione(certificatoCampioneDTO,session);
		}
			
		toRet=true;	
			
		}catch (Exception ex)
		{
			toRet=false;
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
		
		File file =new File(directory.getPath()+"//"+campione.getId()+"_"+idCertificatoCampione+".pdf");
		
		fileItem.write(file);
		
		
		return null;
	}
}
