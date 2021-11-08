package it.portaleSTI.bo;

import java.io.File;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import javax.imageio.spi.ServiceRegistry;

import org.apache.commons.fileupload.FileItem;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneRilieviDAO;
import it.portaleSTI.DAO.GestioneSchedaConsegnaDAO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.RilMisuraRilievoDTO;
import it.portaleSTI.DTO.SchedaConsegnaDTO;
import it.portaleSTI.DTO.SchedaConsegnaRilieviDTO;
import it.portaleSTI.Util.Costanti;

public class GestioneSchedaConsegnaBO {

	
	public static List<SchedaConsegnaDTO> getListaSchedeConsegna(int id_intervento, Session session) {
		
		return GestioneSchedaConsegnaDAO.getListaSchedeConsegna(id_intervento, session);
	}
	
	
	
	public static String uploadSchedaConsegna(FileItem item, String folder) {
		
		String filename;
	
		int index=1;
		
		//filename=item.getName().substring(0,item.getName().indexOf(".")) +".pdf";
		filename = "SC_"+index + ".pdf";
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
				//filename=item.getName().substring(0,item.getName().indexOf("."))+"_" +index+".pdf";
				index++;
				filename = "SC_"+index + ".pdf";
			}

		}
		return filename;
	}
	
	
	
	public static boolean saveDB(InterventoDTO intervento, String nome_file, String data, Session session) {
			
		return GestioneSchedaConsegnaDAO.saveDB(intervento, nome_file, data, session);
	}
	
	
	
	public static boolean deleteScheda(int id_scheda, Session session) {		

		return GestioneSchedaConsegnaDAO.deleteScheda(id_scheda, session);
	}


	public static int getUltimaScheda(Session session) {
		
		return GestioneSchedaConsegnaDAO.getUltimaScheda(session);
	}

	public static ArrayList<SchedaConsegnaRilieviDTO> getListaSchedeConsegnaRilievi(int start_year, int id_cliente, int id_sede, Session session) {

		return GestioneSchedaConsegnaDAO.getListaSchedeConsegnaRilievi(start_year, id_cliente, id_sede, session);
	}

	public static SchedaConsegnaRilieviDTO getSchedaConsegnaRilievoFromId(int id_scheda, Session session) {
	
		return GestioneSchedaConsegnaDAO.getSchedaConsegnaRilievoFromId(id_scheda, session);
	}	

	public static ArrayList<SchedaConsegnaDTO> getListaSchedeConsegnaAll(int start_year, Session session) {
		
		return GestioneSchedaConsegnaDAO.getListaSchedeConsegnaAll(start_year, session);
	}



	public static SchedaConsegnaDTO getSchedaConsegnaFromId(int id_scheda, Session session) {
		
		return GestioneSchedaConsegnaDAO.getSchedaConsegnaFromId(id_scheda, session);
	}



	public static ArrayList<SchedaConsegnaDTO> getListaSchedeConsegnaDate(String dateFrom, String dateTo, Session session) throws HibernateException, ParseException {
	
		return GestioneSchedaConsegnaDAO.getListaSchedeConsegnaDate(dateFrom, dateTo, session);
	}
	
	
	public static ArrayList<SchedaConsegnaRilieviDTO> getListaSchedeConsegnaRilieviDate(String dateFrom, String dateTo, Session session) throws HibernateException, ParseException {
		
		return GestioneSchedaConsegnaDAO.getListaSchedeConsegnaRilieviDate(dateFrom, dateTo, session);
	}



	public static ArrayList<SchedaConsegnaDTO> getListaSchedeConsegnaVerificazioneDate(String dateFrom,
			String dateTo, Session session) throws HibernateException, ParseException {
		// TODO Auto-generated method stub
		return GestioneSchedaConsegnaDAO.getListaSchedeConsegnaVerificazioneDate(dateFrom, dateTo, session);
	}



	public static List<SchedaConsegnaDTO> getListaSchedeConsegnaVerificazione(int ver_intervento, Session session) {
		// TODO Auto-generated method stub
		return GestioneSchedaConsegnaDAO.getListaSchedeConsegnaVerificazione(ver_intervento, session);
	}



	
	
	
}
