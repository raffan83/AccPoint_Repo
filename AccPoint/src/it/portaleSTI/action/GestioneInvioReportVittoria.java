package it.portaleSTI.action;

import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Date;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneFormazioneDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ForConfInvioEmailDTO;
import it.portaleSTI.DTO.ForMembriGruppoDTO;
import it.portaleSTI.bo.GestioneFormazioneBO;

public class GestioneInvioReportVittoria {

	public static void main(String[] args) {

		try {
			File fileCorsi=new File("C://Users/antonio.dicivita/Desktop/CorsiCalver.csv");
			FileOutputStream fosCorsi= new FileOutputStream(fileCorsi);
			PrintStream psCorsi= new PrintStream(fosCorsi);
		
			File filePartecipanti=new File("C://Users/antonio.dicivita/Desktop/PartecipantiCalver.csv");
			FileOutputStream fosPartecipanti= new FileOutputStream(filePartecipanti);
			PrintStream psPartecipanti= new PrintStream(fosPartecipanti);
			
			ContextListener.configCostantApplication();
			
		
			Session session=SessionFacotryDAO.get().openSession();
			session.beginTransaction();
			ArrayList<ForConfInvioEmailDTO> lista_conf = GestioneFormazioneBO.getListaConfigurazioniInvioEmailData(null,session);
			
			
			for (ForConfInvioEmailDTO c : lista_conf) {
				String value = c.getId_corso()+"_"+c.getId_gruppo()+"|"+0+"|"+0+"|"+c.getDescrizione_corso();
				psCorsi.println(value);
				
				
				ArrayList<ForMembriGruppoDTO> lista_membri_gruppo = GestioneFormazioneBO.getMembriGruppo(c.getId_gruppo(), c.getId_corso());
				
				ArrayList<ForMembriGruppoDTO> lista_membri_nc = GestioneFormazioneDAO.getListaUtentiNonCompleti(c.getId_corso(), c.getId_gruppo());
				
				for (ForMembriGruppoDTO m : lista_membri_gruppo) {
					
					
					
					String val = c.getId_corso()+"_"+c.getId_gruppo()+"|"+m.getCf()+"|"+isPresent(m.getId(),lista_membri_nc );
					
					psPartecipanti.println(val);
				}
			}
			
			
			
			session.close();
			
		}
		catch(Exception ex) 
		{
			ex.printStackTrace();
		}

	}

	private static int isPresent(int id, ArrayList<ForMembriGruppoDTO> lista_membri_nc) {
		
		int ret = 1;
		
		for (ForMembriGruppoDTO m : lista_membri_nc) {
			if(m.getId()== id) {
				return 0;
			}
		}
		
		
		return ret;
	}

}
