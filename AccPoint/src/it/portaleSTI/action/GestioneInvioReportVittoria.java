package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.PrintStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import org.hibernate.Session;

import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;

import it.portaleSTI.DAO.GestioneFormazioneDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ForConfInvioEmailDTO;
import it.portaleSTI.DTO.ForMembriGruppoDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.bo.GestioneFormazioneBO;

public class GestioneInvioReportVittoria {

	public static void main(String[] args) {
		
		 String host = "sftp.vittoriarms.eu";
	        int port = 22;
	        String user = "Sole24h";
	        String password = "A^wmN5UgshKa*2Mg";
	        String remoteDir = "/";

	        com.jcraft.jsch.Session sessionSftp = null;
	        ChannelSftp channelSftp = null;

		try {
			
			
			ContextListener.configCostantApplication();
			
		
			Session session=SessionFacotryDAO.get().openSession();
			session.beginTransaction();
			ArrayList<ForConfInvioEmailDTO> lista_conf = GestioneFormazioneBO.getListaConfigurazioniInvioEmailData(null,session);
			HashMap<String, String> listaCorsi=new HashMap<>();
			
			String timeStamp=""+System.currentTimeMillis();
			
			File fileCorsi=new File(Costanti.PATH_FOLDER+"/ReportVittoria/CorsiCalver_"+timeStamp+".csv");
			FileOutputStream fosCorsi= new FileOutputStream(fileCorsi);
			PrintStream psCorsi= new PrintStream(fosCorsi);
		
			System.out.println("Inizzialize");
			
			File filePartecipanti=new File(Costanti.PATH_FOLDER+"/ReportVittoria/PartecipantiCalver_"+timeStamp+".csv");
			FileOutputStream fosPartecipanti= new FileOutputStream(filePartecipanti);
			PrintStream psPartecipanti= new PrintStream(fosPartecipanti);
			
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
			
			JSch jsch = new JSch();
			sessionSftp = jsch.getSession(user, host, port);
			sessionSftp.setPassword(password);

            // Evita problemi di host key
			sessionSftp.setConfig("StrictHostKeyChecking", "no");
			sessionSftp.connect();

            channelSftp = (ChannelSftp) sessionSftp.openChannel("sftp");
            channelSftp.connect();

            try (InputStream input = new FileInputStream(Costanti.PATH_FOLDER+"/ReportVittoria/CorsiCalver_"+timeStamp+".csv")) {
                channelSftp.cd(remoteDir);
                channelSftp.put(input, "CorsiCalver_"+timeStamp+".csv");
            }
            
            try (InputStream input = new FileInputStream(Costanti.PATH_FOLDER+"/ReportVittoria/PartecipantiCalver_"+timeStamp+".csv")) {
                channelSftp.cd(remoteDir);
                channelSftp.put(input, "PartecipantiCalver_"+timeStamp+".csv");
            }
            

            System.out.println("File caricato con successo!");
            
			
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
