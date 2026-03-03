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
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

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
import org.hibernate.HibernateException;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CampionePrenotazioneDTO;
import it.portaleSTI.DTO.DocumCommittenteDTO;
import it.portaleSTI.DTO.PaaPrenotazioneDTO;
import it.portaleSTI.DTO.PaaRichiestaDTO;
import it.portaleSTI.DTO.PaaTipoSegnalazioneDTO;
import it.portaleSTI.DTO.PaaVeicoloDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneDocumentaleBO;
import it.portaleSTI.bo.GestioneParcoAutoBO;
import it.portaleSTI.bo.GestionePrenotazioneCampioneBO;
import it.portaleSTI.bo.GestioneUtenteBO;


/**
 * Servlet implementation class GestioneParcoAuto
 */
@WebServlet(name = "gestionePrenotazioneCampione.do", urlPatterns = { "/gestionePrenotazioneCampione.do" })
public class GestionePrenotazioneCampione extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	static final Logger logger = Logger.getLogger(GestionePrenotazioneCampione.class);
       
    /**
     */
    public GestionePrenotazioneCampione() {
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
		//	ArrayList<CampioneDTO> lista_campioni = GestionePrenotazioneCampioneBO.getListaCampioniDisponibiliDate(startDate, endDate, session);
			
			ArrayList<CampionePrenotazioneDTO> lista_prenotazioni = GestionePrenotazioneCampioneBO.getListaPrenotazioniDate(startDate, endDate, session);
				
			Collections.sort(lista_prenotazioni, new Comparator<CampionePrenotazioneDTO>() {
			    @Override
			    public int compare(CampionePrenotazioneDTO p1, CampionePrenotazioneDTO p2) {
			        return Integer.compare(p1.getId(), p2.getId());
			    }
			});
			
		
			
			PrintWriter out = response.getWriter();
			myObj.addProperty("success", true);
			
			
			myObj.add("lista_prenotazioni",g.toJsonTree(lista_prenotazioni));
			

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
		
		JsonObject myObj = new JsonObject();
		boolean ajax = false;
		
		try {
			
			if(action.equals("gestione_prenotazioni")) {
				
				
				ArrayList<PaaVeicoloDTO> lista_veicoli = GestioneParcoAutoBO.getListaVeicoli(session);
				ArrayList<DocumCommittenteDTO> lista_committenti = GestioneDocumentaleBO.getListaCommittenti(session);		
				ArrayList<UtenteDTO> lista_utentiAll = GestioneUtenteBO.getAllUtenti(session);		
				ArrayList<UtenteDTO> lista_utenti=filtraUtentiPerId(lista_utentiAll);
				
				
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

				LocalDate fineAnno = LocalDate.of(Integer.parseInt(anno), 12, 31);
				
				if (fineBimestre.isAfter(fineAnno)) {
				    fineBimestre = fineAnno;
				}
				
		        
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
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestionePrenotazioneCampione.jsp");
		     	dispatcher.forward(request,response);
				
			}
			else if(action!=null && action.equals("lista_campioni_disponibili")) {

			    response.setContentType("application/json; charset=UTF-8");
			    PrintWriter out = response.getWriter();

			     myObj = new JsonObject();

			    try {
			    	ajax = true;
					
			        Hashtable<String,List<String>> ret = Utility.getFormByResponse(request);

			        String dataInizio = Utility.getSingleValueFromResponse(ret,"data_inizio");
			        String oraInizio  = Utility.getSingleValueFromResponse(ret,"ora_inizio");
			        String dataFine   = Utility.getSingleValueFromResponse(ret,"data_fine");
			        String oraFine    = Utility.getSingleValueFromResponse(ret,"ora_fine");

			        if(dataInizio == null || oraInizio == null || dataFine == null || oraFine == null ||
			           dataInizio.trim().isEmpty() || oraInizio.trim().isEmpty() || dataFine.trim().isEmpty() || oraFine.trim().isEmpty()) {
			            myObj.addProperty("success", false);
			            myObj.addProperty("messaggio", "Compilare data/ora di inizio e fine.");
			            out.print(myObj.toString());
			            out.flush();
			            return;
			        }

			        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd/MM/yyyy H:mm");
			        LocalDateTime startDateTime = LocalDateTime.parse(dataInizio + " " + oraInizio, fmt);
			        LocalDateTime endDateTime   = LocalDateTime.parse(dataFine   + " " + oraFine,   fmt);

			        ArrayList<CampioneDTO> lista = GestionePrenotazioneCampioneBO
			                .getListaCampioniDisponibiliDate(startDateTime, endDateTime, session);

			        Gson g = new GsonBuilder().setDateFormat("dd/MM/yyyy HH:mm").create();

			        myObj.addProperty("success", true);
			        myObj.add("campioni", g.toJsonTree(lista));

			        out.print(myObj.toString());
			        out.flush();

			      

			    } catch(Exception ex) {			 
			        myObj = new JsonObject();
			        myObj.addProperty("success", false);
			        myObj.addProperty("messaggio", ex.getMessage());
			        out.print(myObj.toString());
			        out.flush();
			    } 
			}
			
			else if(action.equals("nuova_prenotazione")) {
				
			
				PrintWriter out = response.getWriter();
				
				try 
				{
					
				response.setContentType("application/json");
				
				Hashtable<String, List<String>> ret =Utility.getFormByResponse(request);
				
		        String id_utente = Utility.getSingleValueFromResponse(ret,"id_utente");
		        String data_inizio = Utility.getSingleValueFromResponse(ret,"data_inizio");
		        String data_fine = Utility.getSingleValueFromResponse(ret,"data_fine");
		        String ora_inizio = Utility.getSingleValueFromResponse(ret,"ora_inizio");
		        String ora_fine = Utility.getSingleValueFromResponse(ret,"ora_fine");
		        String note = Utility.getSingleValueFromResponse(ret,"note");
		        String luogo = Utility.getSingleValueFromResponse(ret,"luogo");
								
		        Set<CampioneDTO> campioni = new HashSet<CampioneDTO>();
		        List<String> idCampioni = ret.get("campioni");

				if (idCampioni != null) {
				    for (String idStr : idCampioni) {
				        int idCampione = Integer.parseInt(idStr);
				        
				        CampioneDTO campioneRef = (CampioneDTO) session.get(CampioneDTO.class, idCampione);
				        campioni.add(campioneRef);
				            
				    }
				}
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				DateFormat timeFormat = new SimpleDateFormat("HH:mm");
				
				Date data_start = mergeDateAndTime(df.parse(data_inizio), timeFormat.parse(ora_inizio));
				Date data_end   = mergeDateAndTime(df.parse(data_fine),   timeFormat.parse(ora_fine));
				
				int cella_inizio=Utility.getDayFromDate(data_start);
				int cella_fine=Utility.getDayFromDate(data_end);
				
			
				CampionePrenotazioneDTO prenotazione = new CampionePrenotazioneDTO();
				
				UtenteDTO utRef = GestioneUtenteBO.getUtenteById(id_utente, session);
				prenotazione.setUtente(utRef);
				
				prenotazione.setData_inizio_prenotazione(data_start);
				prenotazione.setData_fine_prenotazione(data_end);
				prenotazione.setNote(note);
				prenotazione.setStato_prenotazione(0);
				prenotazione.setData_conferma(new Date());
				prenotazione.setCella_inizio(cella_inizio);
				prenotazione.setCella_fine(cella_fine);
				prenotazione.setLuogo(luogo);
				prenotazione.setListaCampioni(campioni);
			
					
					session.save(prenotazione);
					
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Prenotazione salvata con successo!");
	        	out.print(myObj);
				
				 } 
				catch(Exception ex) {
					
					ex.printStackTrace();
					
				        myObj = new JsonObject();
				        myObj.addProperty("success", false);
				        myObj.addProperty("messaggio", ex.getMessage());
				        out.print(myObj.toString());
				        out.flush();
				    } 
				
				
			}
			
			else if(action.equals("dettaglio_prenotazione")) {
				
				response.setContentType("application/json; charset=UTF-8");
				response.setCharacterEncoding("UTF-8");
				
				ajax = true;
				
				String id = request.getParameter("id");
				
				CampionePrenotazioneDTO prenotazione = GestionePrenotazioneCampioneBO.getPrenotazioneFromId(Integer.parseInt(id), session);
				
				Gson g = new GsonBuilder().setDateFormat("dd/MM/yyyy HH:mm").create(); 		
					
				PrintWriter out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.add("prenotazione", g.toJsonTree(prenotazione));
	        	out.print(myObj);
				
			}
			
			else if(action.equals("elimina_prenotazione")) {
				
				ajax = true;
				
				String id = request.getParameter("id_prenotazione");
				
				CampionePrenotazioneDTO prenotazione = GestionePrenotazioneCampioneBO.getPrenotazioneFromId(Integer.parseInt(id), session);
				
				prenotazione.setAbilitato(1);
				session.update(prenotazione);
				
					
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

			session.getTransaction().commit();
        	session.close();
		
		}catch(Exception e) {
			e.printStackTrace();
			
			if(session!=null && session.isOpen()) 
			{
				session.getTransaction().rollback();
				session.close();
			}
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
	 
	 private static Date mergeDateAndTime(Date datePart, Date timePart) {
		    if (datePart == null || timePart == null) return null;

		    Calendar d = Calendar.getInstance();
		    d.setTime(datePart);

		    Calendar t = Calendar.getInstance();
		    t.setTime(timePart);

		    d.set(Calendar.HOUR_OF_DAY, t.get(Calendar.HOUR_OF_DAY));
		    d.set(Calendar.MINUTE,      t.get(Calendar.MINUTE));
		    d.set(Calendar.SECOND,      0);
		    d.set(Calendar.MILLISECOND, 0);

		    return d.getTime();
		}

		private static int getHour(Date timePart) {
		    Calendar c = Calendar.getInstance();
		    c.setTime(timePart);
		    return c.get(Calendar.HOUR_OF_DAY);
		}

		private static int getMinute(Date timePart) {
		    Calendar c = Calendar.getInstance();
		    c.setTime(timePart);
		    return c.get(Calendar.MINUTE);
		}
		public static void main(String[] args) throws HibernateException, Exception {
			new ContextListener().configCostantApplication();
			Session session =SessionFacotryDAO.get().openSession();
			session.beginTransaction();
			
			CampionePrenotazioneDTO link =
				    (CampionePrenotazioneDTO) session.get(
				    		CampionePrenotazioneDTO.class, 1);

			System.out.println("finito"+link.hashCode());
 
	    }
		
		public static ArrayList<UtenteDTO> filtraUtentiPerId(List<UtenteDTO> listaUtenti) {
		    
		    
			Set<Integer> idSelezionati = new LinkedHashSet<>(Arrays.asList(
				    5, 7, 8, 9, 10, 14, 15, 19, 23, 33,
				    51, 86, 187, 236, 264, 387, 388, 445
				));

		    ArrayList<UtenteDTO> risultato = new ArrayList<>();

		    for (UtenteDTO u : listaUtenti) {
		        if (idSelezionati.contains(u.getId())) {
		            risultato.add(u);
		        }
		    }

		    return risultato;
		}
}