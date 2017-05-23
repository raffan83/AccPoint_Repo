package it.portaleSTI.bo;

import java.io.File;

import org.apache.commons.fileupload.FileItem;

import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.ObjSavePackDTO;
import it.portaleSTI.Util.Costanti;

public class GestioneCampioneBO {

	public static Boolean saveCertificatoUpload(FileItem item, CampioneDTO campione) {

	
		String folder=String.valueOf(campione.getId());

				File file = new File(Costanti.PATH_FOLDER+"//campioni//certificati//"+folder+"//"+item.getName()+"_"+folder+".pdf");

					try {
						item.write(file);
						
					
						return true; 
					} catch (Exception e) {

				
						return false; 
					}
	}

}
