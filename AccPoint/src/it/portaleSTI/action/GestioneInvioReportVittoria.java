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
import com.jcraft.jsch.SftpATTRS;
import com.jcraft.jsch.SftpException;

import it.portaleSTI.DAO.GestioneFormazioneDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ForConfInvioEmailDTO;
import it.portaleSTI.DTO.ForMembriGruppoDTO;
import it.portaleSTI.DTO.ForPartecipanteDTO;
import it.portaleSTI.DTO.ForPartecipanteRuoloCorsoDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.bo.GestioneFormazioneBO;

public class GestioneInvioReportVittoria implements Job{


	static final public Logger logger = Logger.getLogger(GestioneInvioReportVittoria.class);

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {

		inviaReportVittoria();

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

			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

			sdf.format(new Date());

			String path=Costanti.PATH_FOLDER+"ReportVittoria\\"+sdf.format(new Date());

			String PATH_ATTESTATI="\\\\10.10.42.10\\Attestati";

			File f= new File(path);

			f.mkdir();

			Session session=SessionFacotryDAO.get().openSession();
			session.beginTransaction();
			ArrayList<ForConfInvioEmailDTO> lista_conf = GestioneFormazioneBO.getListaConfigurazioniInvioEmailData(null,session);
			HashMap<String, String> listaCorsi=new HashMap<>();
			HashMap<String	, String> listaCorsiPresenti=new HashMap<>();


			logger.error("Tentativo connessione sFTP");
			/*Connsessione sFTP*/
			JSch jsch = new JSch();
			sessionSftp = jsch.getSession(user, host, port);
			sessionSftp.setPassword(password);

			// Evita problemi di host key
			sessionSftp.setConfig("StrictHostKeyChecking", "no");
			sessionSftp.connect();

			channelSftp = (ChannelSftp) sessionSftp.openChannel("sftp");
			channelSftp.connect();

			logger.error("Connessione sFTP - STABILITA");
			
			File fileCorsi=new File(path+"/CorsiCalver.csv");
			FileOutputStream fosCorsi= new FileOutputStream(fileCorsi);
			PrintStream psCorsi= new PrintStream(fosCorsi);


			File filePartecipanti=new File(path+"/PartecipantiCalver.csv");
			FileOutputStream fosPartecipanti= new FileOutputStream(filePartecipanti);
			PrintStream psPartecipanti= new PrintStream(fosPartecipanti);

			logger.error("Lista configurazioni recuperata");
			for (ForConfInvioEmailDTO c : lista_conf) {
				String value = c.getCodiceCorsoVittoria()+"|"+0+"|"+0+"|"+c.getDescrizione_corso();

				if(!listaCorsiPresenti.containsKey(c.getCodiceCorsoVittoria())) 
				{
					psCorsi.println(value);
				}
				listaCorsiPresenti.put(c.getCodiceCorsoVittoria(), c.getCodiceCorsoVittoria());
				listaCorsi.put(value, value);


				ArrayList<ForMembriGruppoDTO> lista_membri_gruppo = GestioneFormazioneBO.getMembriGruppoVittoria(c.getId_gruppo(), c.getId_corso());

				ArrayList<ForMembriGruppoDTO> lista_membri_nc = GestioneFormazioneDAO.getListaUtentiNonCompleti(c.getId_corso(), c.getId_gruppo());

				for (ForMembriGruppoDTO m : lista_membri_gruppo) {

					
					ForPartecipanteDTO partecipante= GestioneFormazioneBO.getPartecipanteFromCf(m.getCf(), session);

					logger.error("Partecipante "+m.getCf());
					
					String attestato="";

					if(partecipante!=null) {

						ArrayList<ForPartecipanteRuoloCorsoDTO> lista=GestioneFormazioneBO.getListaCorsiFromPartecipante(partecipante.getId(),session);



						for (ForPartecipanteRuoloCorsoDTO forPartecipanteRuoloCorsoDTO : lista) {

							if(forPartecipanteRuoloCorsoDTO.getCorso().getId_corso_moodle()==c.getId_corso()) 
							{

								String attestato_source=forPartecipanteRuoloCorsoDTO.getAttestato();

								attestato=forPartecipanteRuoloCorsoDTO.getCorso().getId()+"_"+forPartecipanteRuoloCorsoDTO.getPartecipante().getId()+".pdf";

								if(!isPresent(channelSftp, "attestati/"+attestato)) {

									String input=PATH_ATTESTATI+"//"+forPartecipanteRuoloCorsoDTO.getCorso().getId()+"//"+forPartecipanteRuoloCorsoDTO.getPartecipante().getId()+"//"+attestato_source;

									String output = path+"//"+attestato;

									comprimiPdf(input, output);

									InputStream inputStream = new FileInputStream(output);

									channelSftp.put(inputStream, "/attestati/" +attestato);
									
									logger.error("Attesatto trasferito: "+output);

								} else {
									logger.error("Attesatto già presente");
								}






								//Utility.copiaFile(PATH_ATTESTATI+"//"+forPartecipanteRuoloCorsoDTO.getCorso().getId()+"//"+forPartecipanteRuoloCorsoDTO.getPartecipante().getId()+"//"+attestato_source, path+"//"+attestato);
							}
						}
					}
					String val = c.getCodiceCorsoVittoria()+"|"+m.getCf()+"|"+getDateFromLong(m.getDataEsecuzione()) +"|"+isPresent(m.getId(),lista_membri_nc)+"|"+attestato;

					psPartecipanti.println(val);
				}
			}


			psCorsi.close();
			psPartecipanti.close();




			try (InputStream input = new FileInputStream(path+"/CorsiCalver.csv")) {
				channelSftp.cd(remoteDir);
				channelSftp.put(input, "CorsiCalver.csv");
				logger.error("Trasferimento CorsiCalver.csv");
			}

			
			
			try (InputStream input = new FileInputStream(path+"/PartecipantiCalver.csv")) {
				channelSftp.cd(remoteDir);
				channelSftp.put(input, "PartecipantiCalver.csv");
				logger.error("Trasferimento PartecipantiCalver.csv");
			}

			session.close();

			logger.error("Report inviato corrrettamente");


		}
		catch(Exception ex) 
		{
			logger.error("Errore durante l'invio del report", ex);
			ex.printStackTrace();

		}

	}


	public static void main(String[] args) {

		try {
			ContextListener.configCostantApplication();
			inviaReportVittoria();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	public static boolean comprimiPdf(String inputPdf, String outputPdf) {
		try {
			String ghostscriptPath = "C:\\Program Files\\gs\\gs10.03.1\\bin\\gswin64c.exe";

			ProcessBuilder pb = new ProcessBuilder(
					ghostscriptPath,
					"-sDEVICE=pdfwrite",
					"-dCompatibilityLevel=1.4",
					"-dPDFSETTINGS=/ebook",
					"-dNOPAUSE",
					"-dQUIET",
					"-dBATCH",
					"-sOutputFile=" + outputPdf,
					inputPdf
					);

			Process process = pb.start();
			int exitCode = process.waitFor();

			return exitCode == 0;

		} catch (Exception e) {
			e.printStackTrace();
			return false;
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

	public static boolean isPresent(ChannelSftp sftp, String percorsoFile) {

		try {
			SftpATTRS attrs = sftp.lstat(percorsoFile);
			return attrs != null;

		} catch (SftpException e) {

			// File non trovato
			if (e.id == ChannelSftp.SSH_FX_NO_SUCH_FILE) {
				return false;
			}

			// Altro errore
			throw new RuntimeException(e);
		}
	}
}
