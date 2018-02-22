package it.portaleSTI.bo;

import java.io.File;
import java.util.List;

import javax.imageio.spi.ServiceRegistry;

import org.apache.commons.fileupload.FileItem;
import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DTO.SchedaConsegnaDTO;
import it.portaleSTI.Util.Costanti;

public class GestioneSchedaConsegnaBO {

	
	public static List<SchedaConsegnaDTO> getListaSchedeConsegna(int id_intervento, Session session) {
		
Query query  = session.createQuery( "from SchedaConsegnaDTO WHERE id_intervento= :_id");
		
		

		query.setParameter("_id", id_intervento);
		List<SchedaConsegnaDTO> result =query.list();
		
		return result;
	}
	
	
	
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
	    scheda.setAbilitato(1);

	    session.save(scheda);
		
		return esito;
	}
	
	
	
	public static boolean deleteScheda(int id_scheda, Session session) {
		
		boolean esito= false;
		int zero=0;
		
		Query query  = session.createQuery( "UPDATE SchedaConsegnaDTO set abilitato= :zero "+ "WHERE Id= :_id");
	
		query.setParameter("zero", zero);
		query.setParameter("_id", id_scheda);

		int result = query.executeUpdate();
		if(result==1) {
			esito=true;
		}
		
		return esito;
	}
	
	
	
}
