package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.DocumCommittenteDTO;
import it.portaleSTI.DTO.ForPiaPianificazioneDTO;
import it.portaleSTI.DTO.PaaPrenotazioneDTO;
import it.portaleSTI.DTO.PaaRichiestaDTO;
import it.portaleSTI.DTO.PaaSegnalazioneDTO;
import it.portaleSTI.DTO.PaaTipoSegnalazioneDTO;
import it.portaleSTI.DTO.PaaVeicoloDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneDocumentaleBO;
import it.portaleSTI.bo.GestioneFormazioneBO;
import it.portaleSTI.bo.GestioneParcoAutoBO;
import it.portaleSTI.bo.GestioneUtenteBO;


/**
 * Servlet implementation class GestioneParcoAuto
 */
@WebServlet(name = "gestioneParcoAuto.do", urlPatterns = { "/gestioneParcoAuto.do" })
public class GestioneParcoAuto extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	static final Logger logger = Logger.getLogger(GestioneParcoAuto.class);
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneParcoAuto() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String action = request.getParameter("action");
	
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		JsonObject myObj = new JsonObject();
		try {
		
		if(action!=null && action.equals("lista_prenotazioni")) {
	
			String anno = request.getParameter("anno");
			
			int start_date = (int) request.getSession().getAttribute("start_date");
			int end_date = (int) request.getSession().getAttribute("end_date");
			
			if(anno == null) {
				anno = ""+Calendar.getInstance().get(Calendar.YEAR);
			}
			Gson g = new GsonBuilder().setDateFormat("dd/MM/yyyy HH:mm").create(); 		
			
			LocalDate startDate = LocalDate.ofYearDay(Integer.parseInt(anno), start_date);
		    LocalDate endDate = LocalDate.ofYearDay(Integer.parseInt(anno), end_date);
			
			//ArrayList<PaaPrenotazioneDTO> lista_prenotazioni = GestioneParcoAutoBO.getListaPrenotazioni(session);
			ArrayList<PaaPrenotazioneDTO> lista_prenotazioni = GestioneParcoAutoBO.getListaPrenotazioniDate(startDate, endDate, session);
				
			Collections.sort(lista_prenotazioni, new Comparator<PaaPrenotazioneDTO>() {
			    @Override
			    public int compare(PaaPrenotazioneDTO p1, PaaPrenotazioneDTO p2) {
			        return Integer.compare(p1.getVeicolo().getId(), p2.getVeicolo().getId());
			    }
			});
			
			ArrayList<Integer> lista_prenotazioni_con_segnalazione = new ArrayList<Integer>();
			 ArrayList<PaaSegnalazioneDTO> lista_segnalazioni = GestioneParcoAutoBO.getListaSegnalazioni(0,null, session);
			 for (PaaSegnalazioneDTO s : lista_segnalazioni) {
				lista_prenotazioni_con_segnalazione.add(s.getPrenotazione().getId());
			}
			
			PrintWriter out = response.getWriter();
			myObj.addProperty("success", true);
			
			
			myObj.add("lista_prenotazioni",g.toJsonTree(lista_prenotazioni));
			myObj.add("lista_prenotazioni_con_segnalazione",g.toJsonTree(lista_prenotazioni_con_segnalazione));
			

        	out.print(myObj);
        	session.getTransaction().commit();
        	session.close();
			
		}
		else if(action!=null && action.equals("get_segnalazioni")) {
			
			String prenotazione = request.getParameter("id_prenotazione");
			String cella = request.getParameter("cella");
			
			int annoCorrente = LocalDate.now(ZoneId.of("Europe/Rome")).getYear();
		    ArrayList<PaaSegnalazioneDTO> lista_segnalazioni = GestioneParcoAutoBO.getListaSegnalazioni(Integer.parseInt(prenotazione),null, session);
			
		    
		    PrintWriter out = response.getWriter();
			myObj.addProperty("success", true);
			Gson g = new GsonBuilder().setDateFormat("dd/MM/yyyy HH:mm").create(); 		
			myObj.add("lista_segnalazioni",g.toJsonTree(lista_segnalazioni));
			
			

        	out.print(myObj);
        	session.getTransaction().commit();
        	session.close();
		}
		
		else {
			doPost(request, response);		
		}
		
		}catch(Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
        	session.close();
		
				
			PrintWriter out = response.getWriter();
				
			myObj.addProperty("success", false);
	        request.getSession().setAttribute("exception", e);
	        myObj = STIException.getException(e);
	        out.print(myObj);
        	
			
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		if(Utility.validateSession(request,response,getServletContext()))return;

		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		String action = request.getParameter("action");
		UtenteDTO utente =(UtenteDTO)request.getSession().getAttribute("userObj");
		CompanyDTO company =(CompanyDTO)request.getSession().getAttribute("usrCompany");
		
		JsonObject myObj = new JsonObject();
		boolean ajax = false;
		
		try {
			
			if(action.equals("lista_veicoli")) {
				
				ArrayList<PaaVeicoloDTO> lista_veicoli = GestioneParcoAutoBO.getListaVeicoli(session);
				ArrayList<DocumCommittenteDTO> lista_committenti = GestioneDocumentaleBO.getListaCommittenti(session);				
			
				request.getSession().setAttribute("lista_committenti", lista_committenti);
				
				request.getSession().setAttribute("lista_veicoli", lista_veicoli);
				
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaVeicoli.jsp");
		     	dispatcher.forward(request,response);
				
				
			}
			
			else if(action.equals("nuovo_veicolo")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}		        
		       
				FileItem fileCartaCircolazione = null;
				String filenameCartaCircolazione = null;
				FileItem fileImmagineVeicolo = null;
				String filenameImmagineVeicolo= null;
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	            		 if(item.getFieldName().equals("fileupload_immagine_veicolo")) {
	            			 fileImmagineVeicolo = item;
	            			 filenameImmagineVeicolo = item.getName();
	            		 }
	            		 if(item.getFieldName().equals("fileupload_carta_circolazione")) {
	            			 fileCartaCircolazione = item;
	            			 filenameCartaCircolazione = item.getName();
	            		 }
	                    
	                     
	            	 }else
	            	 {
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	            	 }
	            	
	            }
		
				String targa = ret.get("targa");
				String modello = ret.get("modello");
				String id_company = ret.get("company");
				//String carta_circolazione = ret.get("carta_circolazione");
				String km_percorsi = ret.get("km_percorsi");
				String portata_max_veicolo = ret.get("portata_max");
				//String immagine_veicolo = ret.get("immagine_veicolo");
				String note = ret.get("note");
				String dispositivo_pedaggio = ret.get("dispositivo_pedaggio");
				String autorizzazione = ret.get("autorizzazione");
				
				PaaVeicoloDTO veicolo = new PaaVeicoloDTO();
				
				
				
				veicolo.setCompany(new DocumCommittenteDTO(Integer.parseInt(id_company)));
				veicolo.setModello(modello);
				veicolo.setTarga(targa);
				veicolo.setPortata_max_veicolo(portata_max_veicolo);
				
				veicolo.setNote(note);
				if(km_percorsi!=null && !km_percorsi.equals("")) {
					veicolo.setKm_percorsi(Integer.parseInt(km_percorsi));	
				}
				veicolo.setUser_update(utente);
				veicolo.setData_update(new Date());
				veicolo.setDispositivo_pedaggio(dispositivo_pedaggio);
				veicolo.setAutorizzazione(autorizzazione);
				session.save(veicolo);
				
				
				if(filenameCartaCircolazione!=null && !filenameCartaCircolazione.equals("")) {
					saveFile(fileCartaCircolazione, veicolo.getId()+"\\CartaCircolazione\\", filenameCartaCircolazione);
					veicolo.setCarta_circolazione(filenameCartaCircolazione);
				}else {
					veicolo.setCarta_circolazione(null);
				}
				
				if(filenameImmagineVeicolo!=null && !filenameImmagineVeicolo.equals("")) {
					saveFile(fileImmagineVeicolo, veicolo.getId()+"\\ImmagineVeicolo\\", filenameImmagineVeicolo);
					veicolo.setImmagine_veicolo(filenameImmagineVeicolo);
					
				}else {
					veicolo.setImmagine_veicolo(null);
				}
								
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Veicolo salvato con successo!");
				out.print(myObj);
				
			}
			else if(action.equals("modifica_veicolo")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}		        
		       
				FileItem fileCartaCircolazione = null;
				String filenameCartaCircolazione = null;
				FileItem fileImmagineVeicolo = null;
				String filenameImmagineVeicolo= null;
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	            		 if(item.getFieldName().equals("fileupload_immagine_veicolo_mod")) {
	            			 fileImmagineVeicolo = item;
	            			 filenameImmagineVeicolo = item.getName();
	            		 }
	            		 if(item.getFieldName().equals("fileupload_carta_circolazione_mod")) {
	            			 fileCartaCircolazione = item;
	            			 filenameCartaCircolazione = item.getName();
	            		 }
	                    
	                     
	            	 }else
	            	 {
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	            	 }
	            	
	            }
		
		        String id_veicolo = ret.get("id_veicolo");
				String targa = ret.get("targa_mod");
				String modello = ret.get("modello_mod");
				String id_company = ret.get("company_mod");
				//String carta_circolazione = ret.get("carta_circolazione");
				String km_percorsi = ret.get("km_percorsi_mod");
				String portata_max_veicolo = ret.get("portata_max_mod");
				//String immagine_veicolo = ret.get("immagine_veicolo");
				String note = ret.get("note_mod");
				String dispositivo_pedaggio = ret.get("dispositivo_pedaggio_mod");
				String autorizzazione = ret.get("autorizzazione_mod");
				
				PaaVeicoloDTO veicolo = GestioneParcoAutoBO.getVeicoloFromId(Integer.parseInt(id_veicolo), session);			
				
				
				veicolo.setCompany(new DocumCommittenteDTO(Integer.parseInt(id_company)));
				veicolo.setModello(modello);
				veicolo.setTarga(targa);
				veicolo.setPortata_max_veicolo(portata_max_veicolo);
				
				veicolo.setNote(note);
				if(km_percorsi!=null && !km_percorsi.equals("")) {
					veicolo.setKm_percorsi(Integer.parseInt(km_percorsi));	
				}
				veicolo.setUser_update(utente);
				veicolo.setData_update(new Date());
				veicolo.setDispositivo_pedaggio(dispositivo_pedaggio);
				veicolo.setAutorizzazione(autorizzazione);
			
				session.update(veicolo);
				
				
				if(filenameCartaCircolazione!=null && !filenameCartaCircolazione.equals("")) {
					saveFile(fileCartaCircolazione, veicolo.getId()+"\\CartaCircolazione\\", filenameCartaCircolazione);
					veicolo.setCarta_circolazione(filenameCartaCircolazione);
				}
				
				if(filenameImmagineVeicolo!=null && !filenameImmagineVeicolo.equals("")) {
					saveFile(fileImmagineVeicolo, veicolo.getId()+"\\ImmagineVeicolo\\", filenameImmagineVeicolo);
					veicolo.setImmagine_veicolo(filenameImmagineVeicolo);
				}
								
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Veicolo salvato con successo!");
				out.print(myObj);
				
			}
			
			
			else if(action.equals("elimina_veicolo")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				
				String id = request.getParameter("id_veicolo_elimina");

				PaaVeicoloDTO veicolo = GestioneParcoAutoBO.getVeicoloFromId(Integer.parseInt(id), session);
				veicolo.setDisabilitato(1);
				
				session.update(veicolo);
								
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Veicolo eliminato con successo!");
				out.print(myObj);
				
			}
			else if (action.equals("download_file")) {
				
				String id_veicolo = request.getParameter("id_veicolo");
				String tipo_file = request.getParameter("tipo_file");
				
				PaaVeicoloDTO veicolo = GestioneParcoAutoBO.getVeicoloFromId(Integer.parseInt(id_veicolo), session);
				
				response.setContentType("application/octet-stream");
				if(tipo_file.equals("carta_circolazione")) {
					response.setHeader("Content-Disposition","attachment;filename="+ veicolo.getCarta_circolazione().split("\\\\")[0]);
					downloadFile(Costanti.PATH_FOLDER+"\\ParcoAuto\\"+veicolo.getId()+"\\CartaCircolazione\\"+veicolo.getCarta_circolazione(), response.getOutputStream());
				}else {
					response.setHeader("Content-Disposition","attachment;filename="+ veicolo.getImmagine_veicolo().split("\\\\")[0]);
					downloadFile(Costanti.PATH_FOLDER+"\\ParcoAuto\\"+veicolo.getId()+"\\ImmagineVeicolo\\"+veicolo.getImmagine_veicolo(), response.getOutputStream());
				}
				
			}
			
			else if(action.equals("gestione_prenotazioni")) {
				
				
				ArrayList<PaaVeicoloDTO> lista_veicoli = GestioneParcoAutoBO.getListaVeicoli(session);
				ArrayList<DocumCommittenteDTO> lista_committenti = GestioneDocumentaleBO.getListaCommittenti(session);		
				ArrayList<UtenteDTO> lista_utenti = GestioneUtenteBO.getDipendenti(session);		
				
				String anno = request.getParameter("anno");
				String data_inizio = request.getParameter("data_inizio");
				String move = request.getParameter("move");			
				
									
				if(anno==null) {
					anno = ""+Calendar.getInstance().get(Calendar.YEAR);
				}

				LocalDate dataCorrente = null;
				 
				if(data_inizio == null && Integer.parseInt(anno) == LocalDate.now().getYear()) {
					dataCorrente = LocalDate.now();
				}
				else if(data_inizio == null && Integer.parseInt(anno) != LocalDate.now().getYear()) {
					dataCorrente = LocalDate.ofYearDay(Integer.parseInt(anno), 1);
				}
				else {						
					if(Integer.parseInt(data_inizio) == 366 && !LocalDate.ofYearDay(Integer.parseInt(anno), 1).isLeapYear()) {
						data_inizio = 365+"";
					}
			         dataCorrente = LocalDate.ofYearDay(Integer.parseInt(anno), Integer.parseInt(data_inizio));				       
				}				 							 
						 
				
				int meseCorrente = 0;
				int monthsToAdd = 3;
				
				if(move!=null && move.equals("back")) {
					if(dataCorrente.getMonthValue()==12) {
						meseCorrente = dataCorrente.getMonthValue()-1;
					}else {
						meseCorrente = dataCorrente.getMonthValue()-2;
					}
					
				}else if(move!=null && move.equals("forward")) {
					if(dataCorrente.getMonthValue()+1==12) {
						meseCorrente = dataCorrente.getMonthValue()+1;
						monthsToAdd = 2;
					}
					else if(dataCorrente.getMonthValue()+2==12) {
						meseCorrente = dataCorrente.getMonthValue()+2;
						monthsToAdd = 2;
						
					}
					else if(dataCorrente.getMonthValue()==1) {
						meseCorrente = dataCorrente.getMonthValue();
					}
					else {
						meseCorrente = dataCorrente.getMonthValue()+2;	
					}
									
				}else {
					meseCorrente = dataCorrente.getMonthValue();
				}
				
				
				int mesePrecedente = 0;
				if(meseCorrente>1) {
					mesePrecedente =  meseCorrente - 1;
				}else {
					if(meseCorrente==0) {
						meseCorrente = 12;
						mesePrecedente = 10;
						anno = ""+(Integer.parseInt(anno)-1);
					}else {
						mesePrecedente = meseCorrente;	
					}
					
				}
				
				
				
				LocalDate inizioBimestre = LocalDate.of(Integer.parseInt(anno), mesePrecedente, 1);
				LocalDate fineBimestre = inizioBimestre.plusMonths(monthsToAdd).minusDays(1);

				
		        
		        int start_date = 0; 
		        int end_date = 0; 
		        
				if(inizioBimestre.getYear() == fineBimestre.getYear()) {
					start_date = inizioBimestre.getDayOfYear();
			        end_date = fineBimestre.getDayOfYear();
				}else if(inizioBimestre.getYear() < fineBimestre.getYear()) {
					start_date = inizioBimestre.getDayOfYear();
					 if(LocalDate.ofYearDay(Integer.parseInt(anno), 1).isLeapYear()){
						 end_date = fineBimestre.getDayOfYear() +366;
					 }else {
						 end_date = fineBimestre.getDayOfYear() +365;
					 }
			        
				}
		        

				int daysNumber = end_date - start_date;
				
				
				ArrayList<LocalDate> festivitaItaliane = new ArrayList<>();
			    festivitaItaliane.add(LocalDate.of(Integer.parseInt(anno), 1, 1));
			    festivitaItaliane.add(LocalDate.of(Integer.parseInt(anno), 1, 6));

			 // Pasqua - data variabile (calcolata tramite algoritmo)
			   LocalDate pasqua = Utility.calculatePasqua(Integer.parseInt(anno));
			    festivitaItaliane.add(pasqua);
			 // Lunedì di Pasqua
			 festivitaItaliane.add(pasqua.plusDays(1));
			 // Festa della Liberazione - 25 aprile
			 festivitaItaliane.add(LocalDate.of(Integer.parseInt(anno), 4, 25));
			 // Festa dei Lavoratori - 1 maggio
			 festivitaItaliane.add(LocalDate.of(Integer.parseInt(anno), 5, 1));
			 // Festa della Repubblica - 2 giugno
			 festivitaItaliane.add(LocalDate.of(Integer.parseInt(anno), 6, 2));
			 // Ferragosto - 15 agosto
			 festivitaItaliane.add(LocalDate.of(Integer.parseInt(anno), 8, 15));
			 // Tutti i Santi - 1 novembre
			 festivitaItaliane.add(LocalDate.of(Integer.parseInt(anno), 11, 1));
			 // Immacolata Concezione - 8 dicembre
			 festivitaItaliane.add(LocalDate.of(Integer.parseInt(anno), 12, 8));
			 // Natale - 25 dicembre
			 festivitaItaliane.add(LocalDate.of(Integer.parseInt(anno), 12, 25));
			 // Santo Stefano - 26 dicembre
			 festivitaItaliane.add(LocalDate.of(Integer.parseInt(anno), 12, 26));
			
			 
			 long today = 0;
			 
			 if(Integer.parseInt(anno)==Integer.parseInt(LocalDate.now().getYear()+"")) {
				 today = ChronoUnit.DAYS.between(inizioBimestre, dataCorrente);
			 }
			 
			 ArrayList<PaaTipoSegnalazioneDTO> lista_tipi_segnalazione = GestioneParcoAutoBO.getListaTipiSegnalazione(session);
			 

				request.getSession().setAttribute("today", today);
				request.getSession().setAttribute("anno", Integer.parseInt(anno));
				request.getSession().setAttribute("daysNumber", daysNumber);
				request.getSession().setAttribute("festivitaItaliane", festivitaItaliane);
				request.getSession().setAttribute("start_date", start_date);
				request.getSession().setAttribute("end_date", end_date);
				request.getSession().setAttribute("filtro_tipo_pianificazioni", 0);
			
				request.getSession().setAttribute("lista_committenti", lista_committenti);
				request.getSession().setAttribute("lista_utenti", lista_utenti);
				request.getSession().setAttribute("lista_tipi_segnalazione", lista_tipi_segnalazione);
				
				request.getSession().setAttribute("lista_veicoli", lista_veicoli);				
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestionePrenotazioneVeicoli.jsp");
		     	dispatcher.forward(request,response);
				
			}
			
			else if(action.equals("nuova_prenotazione")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}
		        
		       
				FileItem fileItem = null;
				String filename= null;
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	                     fileItem = item;
	                     filename = item.getName();
	                     
	            	 }else
	            	 {
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	            	 }
	            	
	            }
				
				String id_utente = ret.get("utente");
				String data_inizio = ret.get("data_inizio");
				String data_fine = ret.get("data_fine");
		
				String note = ret.get("note");
				String day = ret.get("day");
				String id_veicolo = ret.get("id_veicolo");
				String id_prenotazione = ret.get("id_prenotazione");
				String ora_inizio = ret.get("ora_inizio");
				String ora_fine = ret.get("ora_fine");
				String stato = ret.get("stato");
				String rifornimento = ret.get("rifornimento");
				String check_giornaliero = ret.get("check_giornaliero");
				String luogo = ret.get("luogo");
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				DateFormat timeFormat = new SimpleDateFormat("HH:mm");
				
				Date data_start = df.parse(data_inizio);
				Date ora_start = timeFormat.parse(ora_inizio);
				
				Date data_end = df.parse(data_fine);
				Date ora_end = timeFormat.parse(ora_fine);
				
				long giorniDifferenza = 1;
				if(check_giornaliero != null && check_giornaliero.equals("SI")) {
			
					
					 LocalDate startDate = new java.sql.Date(data_start.getTime()).toLocalDate();
				        LocalDate endDate = new java.sql.Date(data_end.getTime()).toLocalDate();

				        // Calcolo della differenza in giorni
				        giorniDifferenza = ChronoUnit.DAYS.between(startDate, endDate) + 1;					        
				        
				        
				}
				
				
				for(int i = 0;i<giorniDifferenza;i++) {
					
				
					PaaPrenotazioneDTO prenotazione = null;
					if(id_prenotazione!=null && !id_prenotazione.equals("")) {
						prenotazione = GestioneParcoAutoBO.getPrenotazioneFromId(Integer.parseInt(id_prenotazione), session);					
					}else {
						prenotazione = new PaaPrenotazioneDTO();
						prenotazione.setStato_prenotazione(1);
					}
					
					if(stato!=null && !stato.equals("")) {
						prenotazione.setStato_prenotazione(Integer.parseInt(stato));
					}
					
					
					
					prenotazione.setVeicolo(GestioneParcoAutoBO.getVeicoloFromId(Integer.parseInt(id_veicolo), session));
					
					if(id_utente!=null && !id_utente.equals("")) {
						prenotazione.setUtente(GestioneUtenteBO.getUtenteById(id_utente, session));	
					}else {
						prenotazione.setManutenzione(1);
					}
					
					if(rifornimento!=null && rifornimento.equals("on")) {
						prenotazione.setRifornimento(1);
					}else {
						prenotazione.setRifornimento(0);
					}
					
					prenotazione.setLuogo(luogo);
					prenotazione.setNote(note);
					
					data_start.setHours(ora_start.getHours());
					data_start.setMinutes(ora_start.getMinutes());
					
				
					data_end.setHours(ora_end.getHours());
					data_end.setMinutes(ora_end.getMinutes());
					
					//prenotazione.setData_inizio_prenotazione(data_start);
					//prenotazione.setData_fine_prenotazione(data_end);
					
					Calendar c = Calendar.getInstance();
					c.setTime(data_start);
					c.add(Calendar.DAY_OF_YEAR, i);
					
					
					//c.setTime(df.parse(data_inizio));
					if(c.get(Calendar.DAY_OF_YEAR)!=Integer.parseInt(day)) {
						day = ""+c.get(Calendar.DAY_OF_YEAR);
					}
					
					LocalDateTime  start_date = LocalDateTime.ofInstant(c.toInstant(),ZoneId.systemDefault());
					

					LocalDateTime end_date = null;
					if(giorniDifferenza>1) {
						
						end_date = 	LocalDateTime.ofInstant(c.toInstant(),ZoneId.systemDefault());
						end_date = end_date.withHour(ora_end.getHours());
						end_date = end_date.withMinute(ora_end.getMinutes());
						prenotazione.setData_inizio_prenotazione(Date.from(start_date.atZone(ZoneId.systemDefault()).toInstant()));
						prenotazione.setData_fine_prenotazione(Date.from(end_date.atZone(ZoneId.systemDefault()).toInstant()));
					}else {
						
						end_date = LocalDateTime.ofInstant(data_end.toInstant(),ZoneId.systemDefault());
						prenotazione.setData_inizio_prenotazione(data_start);
						prenotazione.setData_fine_prenotazione(data_end);
					}
				
				//	prenotazione.setOra_inizio(ora_inizio);
				//	prenotazione.setOra_fine(ora_fine);
					
					DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
					
					int anno = (int) request.getSession().getAttribute("anno");
					
				//	LocalDate start_date = LocalDate.parse(data_inizio, formatter);
					//LocalDate end_date = LocalDate.parse(data_fine, formatter);
					
					 long diffInDays = ChronoUnit.DAYS.between(start_date, end_date);
					
					
					LocalDate localDate = null;
					if(Integer.parseInt(day)>366 && LocalDate.ofYearDay(anno, 1).isLeapYear()) {
						anno = anno+1;
						localDate = LocalDate.ofYearDay(anno, (Integer.parseInt(day)-366));
						prenotazione.setCella_inizio(Integer.parseInt(day)-366);
						prenotazione.setCella_fine(Integer.parseInt(day)-366 + (int) diffInDays);
						
					}else if(Integer.parseInt(day)>365 && !LocalDate.ofYearDay(anno, 1).isLeapYear()) {
						anno = anno+1;
						localDate = LocalDate.ofYearDay(anno, (Integer.parseInt(day)-365));					
						
						prenotazione.setCella_inizio(Integer.parseInt(day)-365);
						prenotazione.setCella_fine(Integer.parseInt(day)-365 + (int) diffInDays);
					}else {
						localDate = LocalDate.ofYearDay(anno, Integer.parseInt(day));					
						
						prenotazione.setCella_inizio(Integer.parseInt(day));
						prenotazione.setCella_fine(Integer.parseInt(day)+  (int) diffInDays);
					}
					
			        
			      //  LocalDateTime localDateTime = localDate.atStartOfDay();
			     //   Date date = Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant());
					
				//	prenotazione.setData(date);
					
				
					
					session.saveOrUpdate(prenotazione);
					
					
				
					
//					PaaPrenotazioneDTO prenotazione = null;
//					if(id_prenotazione!=null && !id_prenotazione.equals("")) {
//						prenotazione = GestioneParcoAutoBO.getPrenotazioneFromId(Integer.parseInt(id_prenotazione), session);					
//					}else {
//						prenotazione = new PaaPrenotazioneDTO();
//						prenotazione.setStato_prenotazione(1);
//					}
//					
//					if(stato!=null && !stato.equals("")) {
//						prenotazione.setStato_prenotazione(Integer.parseInt(stato));
//					}
//					
//					
//					
//					prenotazione.setVeicolo(GestioneParcoAutoBO.getVeicoloFromId(Integer.parseInt(id_veicolo), session));
//					
//					if(id_utente!=null && !id_utente.equals("")) {
//						prenotazione.setUtente(GestioneUtenteBO.getUtenteById(id_utente, session));	
//					}else {
//						prenotazione.setManutenzione(1);
//					}
//					
//					if(rifornimento!=null && rifornimento.equals("on")) {
//						prenotazione.setRifornimento(1);
//					}else {
//						prenotazione.setRifornimento(0);
//					}
//					
//					prenotazione.setLuogo(luogo);
//					prenotazione.setNote(note);
//					
//					data_start.setHours(ora_start.getHours());
//					data_start.setMinutes(ora_start.getMinutes());
//					
//				
//					data_end.setHours(ora_end.getHours());
//					data_end.setMinutes(ora_end.getMinutes());
//					
//					prenotazione.setData_inizio_prenotazione(data_start);
//					prenotazione.setData_fine_prenotazione(data_end);
//					
//					
//					c.setTime(df.parse(data_inizio));
//					if(c.get(Calendar.DAY_OF_YEAR)!=Integer.parseInt(day)) {
//						day = ""+c.get(Calendar.DAY_OF_YEAR);
//					}
//					
//				
//				//	prenotazione.setOra_inizio(ora_inizio);
//				//	prenotazione.setOra_fine(ora_fine);
//					
//					DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
//					
//					int anno = (int) request.getSession().getAttribute("anno");
//					
//					LocalDate start_date = LocalDate.parse(data_inizio, formatter);
//					LocalDate end_date = LocalDate.parse(data_fine, formatter);
//					
//					 long diffInDays = ChronoUnit.DAYS.between(start_date, end_date);
//					
//					
//					LocalDate localDate = null;
//					if(Integer.parseInt(day)>366 && LocalDate.ofYearDay(anno, 1).isLeapYear()) {
//						anno = anno+1;
//						localDate = LocalDate.ofYearDay(anno, (Integer.parseInt(day)-366));
//						prenotazione.setCella_inizio(Integer.parseInt(day)-366);
//						prenotazione.setCella_fine(Integer.parseInt(day)-366 + (int) diffInDays);
//						
//					}else if(Integer.parseInt(day)>365 && !LocalDate.ofYearDay(anno, 1).isLeapYear()) {
//						anno = anno+1;
//						localDate = LocalDate.ofYearDay(anno, (Integer.parseInt(day)-365));					
//						
//						prenotazione.setCella_inizio(Integer.parseInt(day)-365);
//						prenotazione.setCella_fine(Integer.parseInt(day)-365 + (int) diffInDays);
//					}else {
//						localDate = LocalDate.ofYearDay(anno, Integer.parseInt(day));					
//						
//						prenotazione.setCella_inizio(Integer.parseInt(day));
//						prenotazione.setCella_fine(Integer.parseInt(day)+  (int) diffInDays);
//					}
//					
//			        
//			      //  LocalDateTime localDateTime = localDate.atStartOfDay();
//			     //   Date date = Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant());
//					
//				//	prenotazione.setData(date);
//					
//				
//					
//					session.saveOrUpdate(prenotazione);
				}
				
				
				PrintWriter out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Prenotazione salvata con successo!");
	        	out.print(myObj);
				
				
			}
			
			else if(action.equals("dettaglio_prenotazione")) {
				
				ajax = true;
				
				String id = request.getParameter("id");
				
				PaaPrenotazioneDTO prenotazione = GestioneParcoAutoBO.getPrenotazioneFromId(Integer.parseInt(id), session);
				
				Gson g = new GsonBuilder().setDateFormat("dd/MM/yyyy HH:mm").create(); 		
					
				PrintWriter out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.add("prenotazione", g.toJsonTree(prenotazione));
	        	out.print(myObj);
				
			}
			
			else if(action.equals("elimina_prenotazione")) {
				
				ajax = true;
				
				String id = request.getParameter("id_prenotazione");
				
				PaaPrenotazioneDTO prenotazione = GestioneParcoAutoBO.getPrenotazioneFromId(Integer.parseInt(id), session);
				
				if(prenotazione.getId_richiesta()!=0) {
					PaaRichiestaDTO richiesta = GestioneParcoAutoBO.getRichiestaFromID(prenotazione.getId_richiesta(), session);
					richiesta.setStato(3);
					session.update(richiesta);
				}
				
				session.delete(prenotazione);
				
					
				PrintWriter out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Prenotazione eliminata con successo!");
	        	out.print(myObj);
			}
			
			else if(action.equals("gestione_richieste")) {
				
				ArrayList<PaaVeicoloDTO> lista_veicoli = GestioneParcoAutoBO.getListaVeicoli(session);
				ArrayList<PaaRichiestaDTO> lista_richieste = GestioneParcoAutoBO.getListaRichieste(session);
				
				Collections.sort(lista_veicoli, Comparator.comparing(PaaVeicoloDTO::getModello));
			
				request.getSession().setAttribute("lista_richieste", lista_richieste);
				request.getSession().setAttribute("lista_veicoli", lista_veicoli);
				
								
				request.getSession().setAttribute("userObj", utente);
				
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaRichiestePrenotazione.jsp");
		     	dispatcher.forward(request,response);
				
			}
			
			else if(action.equals("nuova_richiesta")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}
		        
		       
				FileItem fileItem = null;
				String filename= null;
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	                     fileItem = item;
	                     filename = item.getName();
	                     
	            	 }else
	            	 {
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	            	 }
	            	
	            }

				String id_utente = ret.get("utente");
				String data_inizio = ret.get("data_inizio");
				String data_fine = ret.get("data_fine");
		
		
				String ora_inizio = ret.get("ora_inizio");
				String ora_fine = ret.get("ora_fine");
				String note = ret.get("note");
				String luogo = ret.get("luogo");
				
				
				PaaRichiestaDTO richiesta = new PaaRichiestaDTO();				
				
				richiesta.setStato(1);
				
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				DateFormat timeFormat = new SimpleDateFormat("HH:mm");							
				
				richiesta.setUtente(utente);			
				richiesta.setLuogo(luogo);
	
				richiesta.setNote(note);
				Date data_start = df.parse(data_inizio);
				Date ora_start = timeFormat.parse(ora_inizio);
				data_start.setHours(ora_start.getHours());
				data_start.setMinutes(ora_start.getMinutes());
				
				Date data_end = df.parse(data_fine);
				Date ora_end = timeFormat.parse(ora_fine);
				data_end.setHours(ora_end.getHours());
				data_end.setMinutes(ora_end.getMinutes());
				
				richiesta.setData_inizio(data_start);
				richiesta.setData_fine(data_end);
				
				richiesta.setData_richiesta(new Date());

				session.save(richiesta);
				
				PrintWriter out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Salvato con successo!");
	        	out.print(myObj);
				
			}
			
			
			else if(action.equals("modifica_richiesta")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}
		        
		       
				FileItem fileItem = null;
				String filename= null;
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	                     fileItem = item;
	                     filename = item.getName();
	                     
	            	 }else
	            	 {
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	            	 }
	            	
	            }

				String id_richiesta = ret.get("id_richiesta");
				String data_inizio = ret.get("data_inizio_mod");
				String data_fine = ret.get("data_fine_mod");
				String stato = ret.get("stato");		
		
				String ora_inizio = ret.get("ora_inizio_mod");
				String ora_fine = ret.get("ora_fine_mod");
				String note = ret.get("note_mod");
				String veicolo = ret.get("veicoli");
				String check_giornaliero =  ret.get("check_giornaliero_mod");
				String luogo =  ret.get("luogo_mod");
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				DateFormat timeFormat = new SimpleDateFormat("HH:mm");
				
				
				PaaRichiestaDTO richiesta = GestioneParcoAutoBO.getRichiestaFromID(Integer.parseInt(id_richiesta), session);				
				
			//	richiesta.setStato(Integer.parseInt(stato));				

				richiesta.setNote(note);
				Date data_start = df.parse(data_inizio);
				Date ora_start = timeFormat.parse(ora_inizio);
				data_start.setHours(ora_start.getHours());
				data_start.setMinutes(ora_start.getMinutes());
				
				Date data_end = df.parse(data_fine);
				Date ora_end = timeFormat.parse(ora_fine);
				data_end.setHours(ora_end.getHours());
				data_end.setMinutes(ora_end.getMinutes());
				
				richiesta.setData_inizio(data_start);
				richiesta.setData_fine(data_end);
				
				richiesta.setLuogo(luogo);
				
				
				if(veicolo!=null && !veicolo.equals("")) {
					
					long giorniDifferenza = 1;
					if(check_giornaliero != null && check_giornaliero.equals("SI")) {
				
						
						 LocalDate startDate = new java.sql.Date(data_start.getTime()).toLocalDate();
					        LocalDate endDate = new java.sql.Date(data_end.getTime()).toLocalDate();

					        // Calcolo della differenza in giorni
					        giorniDifferenza = ChronoUnit.DAYS.between(startDate, endDate) + 1;					        
					        
					        
					}
					for (int i = 0; i < giorniDifferenza; i++) {
						
						PaaVeicoloDTO v = GestioneParcoAutoBO.getVeicoloFromId(Integer.parseInt(veicolo), session);
						
						PaaPrenotazioneDTO prenotazione = new PaaPrenotazioneDTO();
						prenotazione.setVeicolo(v);					
						
						prenotazione.setUtente(richiesta.getUtente());
						prenotazione.setStato_prenotazione(1);
						prenotazione.setNote(richiesta.getNote());
						prenotazione.setLuogo(luogo);
						prenotazione.setId_richiesta(richiesta.getId());
						Calendar c = Calendar.getInstance();
						c.setTime(data_start);
						c.add(Calendar.DAY_OF_YEAR, i);
						
						String day = ""+c.get(Calendar.DAY_OF_YEAR);
						
						
						DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
						
						int anno = c.get(Calendar.YEAR);
						
						//LocalDate start_date = LocalDate.parse(data_inizio, formatter);
						//LocalDate end_date = LocalDate.parse(data_fine, formatter);
						LocalDateTime  start_date = LocalDateTime.ofInstant(c.toInstant(),ZoneId.systemDefault());
				

						LocalDateTime end_date = null;
						if(giorniDifferenza>1) {
			
							end_date = 	LocalDateTime.ofInstant(c.toInstant(),ZoneId.systemDefault());
							end_date = end_date.withHour(ora_end.getHours());
							end_date = end_date.withMinute(ora_end.getMinutes());
							prenotazione.setData_inizio_prenotazione(Date.from(start_date.atZone(ZoneId.systemDefault()).toInstant()));
							prenotazione.setData_fine_prenotazione(Date.from(end_date.atZone(ZoneId.systemDefault()).toInstant()));
						}else {
							
							end_date = LocalDateTime.ofInstant(data_end.toInstant(),ZoneId.systemDefault());
							prenotazione.setData_inizio_prenotazione(data_start);
							prenotazione.setData_fine_prenotazione(data_end);
						}
						
						
						 long diffInDays = ChronoUnit.DAYS.between(start_date, end_date);
						
						
						LocalDate localDate = null;
						if(Integer.parseInt(day)>366 && LocalDate.ofYearDay(anno, 1).isLeapYear()) {
							anno = anno+1;
							localDate = LocalDate.ofYearDay(anno, (Integer.parseInt(day)-366));
							prenotazione.setCella_inizio(Integer.parseInt(day)-366);
							prenotazione.setCella_fine(Integer.parseInt(day)-366 + (int) diffInDays);
							
						}else if(Integer.parseInt(day)>365 && !LocalDate.ofYearDay(anno, 1).isLeapYear()) {
							anno = anno+1;
							localDate = LocalDate.ofYearDay(anno, (Integer.parseInt(day)-365));					
							
							prenotazione.setCella_inizio(Integer.parseInt(day)-365);
							prenotazione.setCella_fine(Integer.parseInt(day)-365 + (int) diffInDays);
						}else {
							localDate = LocalDate.ofYearDay(anno, Integer.parseInt(day));					
							
							prenotazione.setCella_inizio(Integer.parseInt(day));
							prenotazione.setCella_fine(Integer.parseInt(day)+  (int) diffInDays);
						}
						
						
						
						session.save(prenotazione);
						
					}
					
					richiesta.setStato(2);
					
				}
				
				
				session.update(richiesta);
				PrintWriter out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Salvato con successo!");
	        	out.print(myObj);
				
			}
			
			
			else if(action.equals("veicoli_disponibili")) {
				
				
				String data_inizio = request.getParameter("data_inizio");
				String data_fine = request.getParameter("data_fine");
				String ora_inizio = request.getParameter("ora_inizio");
				String ora_fine = request.getParameter("ora_fine");
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				DateFormat timeFormat = new SimpleDateFormat("HH:mm");	
				
				Date data_start = df.parse(data_inizio);
				Date ora_start = timeFormat.parse(ora_inizio);
				data_start.setHours(ora_start.getHours());
				data_start.setMinutes(ora_start.getMinutes());
				
				Date data_end = df.parse(data_fine);
				Date ora_end = timeFormat.parse(ora_fine);
				data_end.setHours(ora_end.getHours());
				data_end.setMinutes(ora_end.getMinutes());
				
				ArrayList<PaaVeicoloDTO> lista_veicoli_disponibili = GestioneParcoAutoBO.getListaVeicoliDisponibili(data_start, data_end, session);				
			
//				Collections.sort(lista_veicoli_disponibili, Comparator.comparing(PaaVeicoloDTO::getModello));
				
				Gson g = new GsonBuilder().setDateFormat("dd/MM/yyyy HH:mm").create(); 	
				PrintWriter out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.add("lista_veicoli", g.toJsonTree(lista_veicoli_disponibili));
	        	out.print(myObj);
				
			}
			
			else if(action.equals("elimina_richiesta")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				
				String id = request.getParameter("id_richiesta_elimina");

				PaaRichiestaDTO richiesta = GestioneParcoAutoBO.getRichiestaFromID(Integer.parseInt(id), session);
				richiesta.setDisabilitato(1);
				session.update(richiesta);
								
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Richiesta eliminata con successo!");
				out.print(myObj);
				
			}
			
			else if(action.equals("nuova_segnalazione")) {
				
				
				ajax = true;
				
				response.setContentType("application/json");
				List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}
		        
		       
				FileItem fileItem = null;
				String filename= null;
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	                     fileItem = item;
	                     filename = item.getName();
	                     
	            	 }else
	            	 {
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	            	 }
	            	
	            }

				String id_prenotazione = ret.get("id_prenotazione_segnalazione");
				
				String tipi_segnalazione = ret.get("tipo_segnalazione_str");
				String note = ret.get("note_segnalazione");
				String tipiDaRimuovere = ret.get("tipo_segnalazione_da_rimuovere");
				
				if (tipiDaRimuovere != null && !tipiDaRimuovere.isEmpty()) {
					  String[] idDaRimuovere = tipiDaRimuovere.split(",");
					    for (String idTipoStr : idDaRimuovere) {
					    	GestioneParcoAutoBO.deleteSegnalazioni(Integer.parseInt(id_prenotazione), Integer.parseInt(idTipoStr), session);
					    }
				}
				
				if (tipi_segnalazione != null && !tipi_segnalazione.isEmpty()) {
				    String[] ids = tipi_segnalazione.split(";");
				    for (String id : ids) {
				    	
				    	PaaSegnalazioneDTO segnalazione = GestioneParcoAutoBO.getSegnalazione(Integer.parseInt(id_prenotazione), Integer.parseInt(id), session);
				    	if(segnalazione == null) {
				    		segnalazione = new PaaSegnalazioneDTO();
					    	PaaPrenotazioneDTO prenotazione = (PaaPrenotazioneDTO) session.get(PaaPrenotazioneDTO.class, Integer.parseInt(id_prenotazione));
					    	segnalazione.setPrenotazione(prenotazione);
					    	PaaTipoSegnalazioneDTO tipo = (PaaTipoSegnalazioneDTO) session.get(PaaTipoSegnalazioneDTO.class, Integer.parseInt(id));
					    	segnalazione.setTipo(tipo);
					    	segnalazione.setNote(note);		
					       segnalazione.setData_segnalazione(new Date());

					       session.save(segnalazione);
				    	}
				    	 
				       
				    }
				}
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Segnalazione salvata con successo!");
				out.print(myObj);
			}
			
			else if(action.equals("lista_segnalazioni")) {
				
				ArrayList<PaaSegnalazioneDTO> lista_segnalazioni = GestioneParcoAutoBO.getListaSegnalazioni(0, null, session);
					
				request.getSession().setAttribute("lista_segnalazioni", lista_segnalazioni);
				
		
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaSegnalazioni.jsp");
		     	dispatcher.forward(request,response);
				
			}
			else if(action.equals("cambia_stato_segnalazione")) {
				
				ajax = true;
				
				String id_segnalazione = request.getParameter("id_segnalazione");
				
				PaaSegnalazioneDTO segnalazione = (PaaSegnalazioneDTO) session.get(PaaSegnalazioneDTO.class, Integer.parseInt(id_segnalazione));
				
				if(segnalazione.getStato() == 0) {
					segnalazione.setStato(1);
				}else {
					segnalazione.setStato(0);
				}
				session.update(segnalazione);
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Stato cambiato con successo!");
				out.print(myObj);
				
			}
			else if(action.equals("crea_rapporto_veicolo")) {
				
				String id_veicolo = request.getParameter("id_veicolo");
				
				ArrayList<PaaSegnalazioneDTO> lista_segnalazioni = GestioneParcoAutoBO.getListaSegnalazioni(Integer.parseInt(id_veicolo), null, session);
				
				
				
			}
			
			session.getTransaction().commit();
        	session.close();
		
		}catch(Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
        	session.close();
			if(ajax) {
				
				PrintWriter out = response.getWriter();
				
	        	
	        	request.getSession().setAttribute("exception", e);
	        	myObj = STIException.getException(e);
	        	out.print(myObj);
        	}else {
   			    			
    			e.printStackTrace();
    			request.setAttribute("error",STIException.callException(e));
    	  	     request.getSession().setAttribute("exception", e);
    			 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
    		     dispatcher.forward(request,response);	
        	}
			
		}

	}
	
	
	 private void saveFile(FileItem item, String path, String filename) {

		 	String path_folder = Costanti.PATH_FOLDER+"//ParcoAuto//"+path+"//";
			File folder=new File(path_folder);
			
			if(!folder.exists()) {
				folder.mkdirs();
			}
		
			
			while(true)
			{
				File file=null;
				
				
				file = new File(path_folder+filename);					
				
					try {
						item.write(file);
						break;

					} catch (Exception e) 
					{

						e.printStackTrace();
						break;
					}
			}
		
		}
	 
	 private void downloadFile(String path,  ServletOutputStream outp) throws Exception {
		 
		 File file = new File(path);
			
			FileInputStream fileIn = new FileInputStream(file);

	
			    byte[] outputByte = new byte[1];
			    
			    while(fileIn.read(outputByte, 0, 1) != -1)
			    {
			    	outp.write(outputByte, 0, 1);
			    }
			    				    
			 
			    fileIn.close();
			    outp.flush();
			    outp.close();
	 }
}