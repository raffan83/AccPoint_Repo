package it.portaleSTI.action;

import java.io.File;
import java.io.FileOutputStream;
import java.io.PrintStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import org.hibernate.Session;

import it.portaleSTI.DAO.GestioneFormazioneDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ForConfInvioEmailDTO;
import it.portaleSTI.DTO.ForMembriGruppoDTO;
import it.portaleSTI.bo.GestioneFormazioneBO;

public class GestioneInvioReportVittoria {

	public static void main(String[] args) {

		try {
			File fileCorsi=new File("C://Users/raffaele.fantini/Desktop/CorsiCalver.csv");
			FileOutputStream fosCorsi= new FileOutputStream(fileCorsi);
			PrintStream psCorsi= new PrintStream(fosCorsi);
		
			System.out.println("Inizzialize");
			
			File filePartecipanti=new File("C://Users/raffaele.fantini/Desktop/PartecipantiCalver.csv");
			FileOutputStream fosPartecipanti= new FileOutputStream(filePartecipanti);
			PrintStream psPartecipanti= new PrintStream(fosPartecipanti);
			
			ContextListener.configCostantApplication();
			
		
			Session session=SessionFacotryDAO.get().openSession();
			session.beginTransaction();
			ArrayList<ForConfInvioEmailDTO> lista_conf = GestioneFormazioneBO.getListaConfigurazioniInvioEmailData(null,session);
			HashMap<String, String> listaCorsi=new HashMap<>();
			
			for (ForConfInvioEmailDTO c : lista_conf) {
				String value = c.getId_corso()+"|"+0+"|"+0+"|"+c.getDescrizione_corso();
				
				if(!listaCorsi.containsKey(value)) 
				{
					psCorsi.println(value);
				}
				listaCorsi.put(value, value);
				
			//	if(c.getId_corso()==167 && c.getId_gruppo()==141) {
					ArrayList<ForMembriGruppoDTO> lista_membri_gruppo = GestioneFormazioneBO.getMembriGruppoVittoria(c.getId_gruppo(), c.getId_corso());
					
					ArrayList<ForMembriGruppoDTO> lista_membri_nc = GestioneFormazioneDAO.getListaUtentiNonCompleti(c.getId_corso(), c.getId_gruppo());
					
					for (ForMembriGruppoDTO m : lista_membri_gruppo) {
						
						
						
						String val = c.getId_corso()+"|"+m.getCf()+"|"+getDateFromLong(m.getDataEsecuzione()) +"|"+isPresent(m.getId(),lista_membri_nc );
						
						psPartecipanti.println(val);
					}
				}
			
			//}
			
			System.out.println("Terminate");
			
			session.close();
			
		}
		catch(Exception ex) 
		{
			ex.printStackTrace();
		}

	}

	private static String getDateFromLong(Long dataEsecuzione) {
		
		if(dataEsecuzione==0) 
		{
			return "";
		}
		
		else 
		
		{
		  Date d= new Date(dataEsecuzione*1000);
		  
		  SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		  
		  return sdf.format(d);
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
