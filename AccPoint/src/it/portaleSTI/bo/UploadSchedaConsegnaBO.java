package it.portaleSTI.bo;

import java.io.File;

import javax.imageio.spi.ServiceRegistry;

import org.apache.commons.fileupload.FileItem;
import org.hibernate.Session;

import it.portaleSTI.DTO.SchedaConsegnaDTO;
import it.portaleSTI.Util.Costanti;

public class UploadSchedaConsegnaBO {

	public static String uploadSchedaConsegna(FileItem item, String folder) {
		
		String filename;
	
		int index=1;
		
		filename=item.getName().substring(0,item.getName().indexOf(".")) +".pdf";
		while(true) {
			
			
		File file = new File(Costanti.PATH_FOLDER+"//"+folder + "//"+ filename);
			if(file.exists()==false) {
				try {
					item.write(file);
					
					break;
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					break;
				}
			}else {
				filename=item.getName().substring(0,item.getName().indexOf("."))+"_" +index+".pdf";
				index++;
			}

		}
		return filename;
	}
	
	
	
	public static boolean saveDB(int id_intervento, String nome_file, String data, Session session) {
		
		boolean esito=false;
		

	    SchedaConsegnaDTO scheda = new SchedaConsegnaDTO();
	    
	    scheda.setId_intervento(id_intervento);
	    scheda.setNome_file(nome_file);
	    scheda.setData_caricamento(data);

	    session.save(scheda);
		
		return esito;
	}
	
	
	
}
