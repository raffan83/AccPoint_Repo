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

import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;

import it.portaleSTI.DAO.GestioneFormazioneDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ForConfInvioEmailDTO;
import it.portaleSTI.DTO.ForMembriGruppoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.bo.GestioneFormazioneBO;

public class GestioneInvioReportVittoria implements Job{
	
	
	static final public Logger logger = Logger.getLogger(GestioneInvioReportVittoria.class);
	
	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		
		inviaReportVittoria();
		logger.error("Report Vittoria inviato correttamente !");
	}
	

	public static void inviaReportVittoria(){
		
		 String host = "sftp.vittoriarms.eu";
	        int port = 22;
	        String user = "Sole24h";
	        String password = "A^wmN5UgshKa*2Mg";
	        String remoteDir = "/";

	        com.jcraft.jsch.Session sessionSftp = null;
	        ChannelSftp channelSftp = null;

		try {
			
			
			ContextListener.configCostantApplication();
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			
			sdf.format(new Date());
		
			String path=Costanti.PATH_FOLDER+"ReportVittoria\\"+sdf.format(new Date());
			
			File f= new File(path);
			
			f.mkdir();
		
			Session session=SessionFacotryDAO.get().openSession();
			session.beginTransaction();
			ArrayList<ForConfInvioEmailDTO> lista_conf = GestioneFormazioneBO.getListaConfigurazioniInvioEmailData(null,session);
			HashMap<String, String> listaCorsi=new HashMap<>();
			
			
			File fileCorsi=new File(path+"/CorsiCalver.csv");
			FileOutputStream fosCorsi= new FileOutputStream(fileCorsi);
			PrintStream psCorsi= new PrintStream(fosCorsi);
		
			System.out.println("Inizzialize");
			
			File filePartecipanti=new File(path+"/PartecipantiCalver.csv");
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

            try (InputStream input = new FileInputStream(path+"/CorsiCalver.csv")) {
                channelSftp.cd(remoteDir);
                channelSftp.put(input, "CorsiCalver.csv");
            }
            
            try (InputStream input = new FileInputStream(path+"/PartecipantiCalver.csv")) {
                channelSftp.cd(remoteDir);
                channelSftp.put(input, "PartecipantiCalver.csv");
            }
            

            System.out.println("File caricato con successo!");
            
			
			System.out.println("Terminate");
			
			session.close();
			
		}
		catch(Exception ex) 
		{
			logger.error("Errore durante l'invio del report", ex);
			ex.printStackTrace();
		}

	}

	
	public static void main(String[] args) {
		
		inviaReportVittoria();
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
