package it.portaleSTI.action;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.EnumMap;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.TimeUnit;
import java.util.regex.Pattern;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.imageio.ImageIO;
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
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonNull;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;
import com.itextpdf.text.Document;
import com.itextpdf.text.Image;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.pdf.PdfWriter;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.GestioneCommesseDAO;
import it.portaleSTI.DAO.GestioneFormazioneDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.AgendaMilestoneDTO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.ForConfInvioEmailDTO;
import it.portaleSTI.DTO.ForCorsoAllegatiDTO;
import it.portaleSTI.DTO.ForCorsoCatAllegatiDTO;
import it.portaleSTI.DTO.ForCorsoCatDTO;
import it.portaleSTI.DTO.ForCorsoDTO;
import it.portaleSTI.DTO.ForCorsoMoodleDTO;
import it.portaleSTI.DTO.ForDocenteDTO;
import it.portaleSTI.DTO.ForEmailDTO;
import it.portaleSTI.DTO.ForGruppoMoodleDTO;
import it.portaleSTI.DTO.ForMembriGruppoDTO;
import it.portaleSTI.DTO.ForPartecipanteDTO;
import it.portaleSTI.DTO.ForPartecipanteRuoloCorsoDTO;
import it.portaleSTI.DTO.ForPiaPianificazioneDTO;
import it.portaleSTI.DTO.ForPiaStatoDTO;
import it.portaleSTI.DTO.ForPiaTipoDTO;
import it.portaleSTI.DTO.ForQuestionarioDTO;
import it.portaleSTI.DTO.ForReferenteDTO;
import it.portaleSTI.DTO.ForRuoloDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneAssegnazioneAttivitaBO;
import it.portaleSTI.bo.GestioneFormazioneBO;
import it.portaleSTI.bo.SendEmailBO;

/**
 * Servlet implementation class GestioneFormazione
 */
@WebServlet("/gestioneFormazione.do")
public class GestioneFormazione extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final Logger logger = Logger.getLogger(GestioneFormazione.class);
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneFormazione() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String action = request.getParameter("action");
		UtenteDTO utente =(UtenteDTO)request.getSession().getAttribute("userObj");
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		JsonObject myObj = new JsonObject();
		try {
		
		if(action!=null && action.equals("lista_pianificazioni")) {
	
			String anno = request.getParameter("anno");
			String filtro_tipo_pianificazioni = request.getParameter("filtro_tipo_pianificazioni");
			
			if(anno == null) {
				anno = ""+Calendar.getInstance().get(Calendar.YEAR);
			}
			Gson g = new GsonBuilder().setDateFormat("MM/dd/yyyy").create(); 	
			ArrayList<ForPiaPianificazioneDTO> lista_pianificazioni = GestioneFormazioneBO.getListaPianificazioni(anno, filtro_tipo_pianificazioni,session);
				
			Date today = new Date();
			if(today.after(new GregorianCalendar(Integer.parseInt(anno), Calendar.NOVEMBER, 01).getTime())){
				ArrayList<ForPiaPianificazioneDTO> lista_pianificazioni_anno_succ = GestioneFormazioneBO.getListaPianificazioni((Calendar.getInstance().get(Calendar.YEAR)+1)+"", filtro_tipo_pianificazioni,session);
				lista_pianificazioni.addAll(lista_pianificazioni_anno_succ);
			}
			
			if(today.before(new GregorianCalendar(Integer.parseInt(anno), Calendar.FEBRUARY, 01).getTime())) {
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				ArrayList<ForPiaPianificazioneDTO> lista_pianificazioni_anno_rec = GestioneFormazioneBO.getListaPianificazioniData((Calendar.getInstance().get(Calendar.YEAR)-1)+"-11-01", ""+(Calendar.getInstance().get(Calendar.YEAR)-1)+"-12-31", session);
				lista_pianificazioni.addAll(lista_pianificazioni_anno_rec);
			}
			
			
			PrintWriter out = response.getWriter();
			myObj.addProperty("success", true);
			myObj.add("lista_pianificazioni",g.toJsonTree(lista_pianificazioni));
			
			if(filtro_tipo_pianificazioni==null) {
				filtro_tipo_pianificazioni = "0";
			}
			request.getSession().setAttribute("filtro_tipo_pianificazioni", filtro_tipo_pianificazioni);
			
        	out.print(myObj);
        	session.getTransaction().commit();
        	session.close();
			
		}else {
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
			logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+utente.getNominativo());
			
			if(action.equals("lista_docenti")) {
				
				ArrayList<ForDocenteDTO> lista_docenti = GestioneFormazioneBO.getListaDocenti(session);
				
				request.getSession().setAttribute("lista_docenti", lista_docenti);
				
				session.getTransaction().commit();
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneForDocenti.jsp");
		     	dispatcher.forward(request,response);
			}
			else if(action.equals("nuovo_docente")) {
				
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
		
				String nome = ret.get("nome");
				String cognome = ret.get("cognome");
				String formatore = ret.get("formatore");
				String email = ret.get("email");
				String user_milestone = ret.get("user_milestone");

				ForDocenteDTO docente = new ForDocenteDTO();
				
				docente.setNome(nome);
				docente.setCognome(cognome);
				docente.setFormatore(Integer.parseInt(formatore));		
				docente.setEmail(email);
				docente.setUtenteMilestone(user_milestone);
				
				session.save(docente);
				
				if(fileItem!=null && !filename.equals("")) {

					//saveFile(fileItem, "Docenti//"+nome+"_"+cognome,filename);
					saveFile(fileItem, "Docenti//"+docente.getId(),filename);
					docente.setCv(filename);
					session.update(docente);
				}
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Docente salvato con successo!");
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
			}
			
			else if(action.equals("modifica_docente")) {
				
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
		
		        String id_docente = request.getParameter("id_docente");
				String nome = ret.get("nome_mod");
				String cognome = ret.get("cognome_mod");
				String formatore = ret.get("formatore_mod");
				String email = ret.get("email_mod");
				String user_milestone = ret.get("user_milestone_mod");

				ForDocenteDTO docente = GestioneFormazioneBO.getDocenteFromId(Integer.parseInt(id_docente),session);
				
				docente.setNome(nome);
				docente.setCognome(cognome);
				docente.setFormatore(Integer.parseInt(formatore));		
				docente.setEmail(email);
				docente.setUtenteMilestone(user_milestone);
				
				if(fileItem!=null && !filename.equals("")) {

					//saveFile(fileItem, "Docenti//"+nome+"_"+cognome,filename);
					saveFile(fileItem, "Docenti//"+id_docente,filename);
					docente.setCv(filename);
				}
				
				session.update(docente);
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Docente modificato con successo!");
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
			}
			else if (action.equals("download_curriculum")) {
				
				String id_docente = request.getParameter("id_docente");
				
				id_docente = Utility.decryptData(id_docente);
				
				ForDocenteDTO docente = GestioneFormazioneBO.getDocenteFromId(Integer.parseInt(id_docente), session);
				
				String path = Costanti.PATH_FOLDER+"//Formazione//Docenti//"+docente.getId()+"//"+docente.getCv();
				
				downloadFile(path, response.getOutputStream());
				
				response.setContentType("application/pdf");	
				
				session.close();
				
			}
			else if(action.equals("lista_cat_corsi")) {
				
				ArrayList<ForCorsoCatDTO> lista_corsi_cat = GestioneFormazioneBO.getListaCategorieCorsi(session);
				
				request.getSession().setAttribute("lista_corsi_cat", lista_corsi_cat);
				
				session.getTransaction().commit();
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneForCorsiCat.jsp");
		     	dispatcher.forward(request,response);
				
			}
			else if(action.equals("nuova_categoria")) {
				
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
		
				String codice = ret.get("codice");
				String descrizione = ret.get("descrizione");
				String frequenza = ret.get("frequenza");	

				ForCorsoCatDTO categoria = new ForCorsoCatDTO();		
				
				categoria.setCodice(codice);
				categoria.setDescrizione(descrizione);
				categoria.setFrequenza(Integer.parseInt(frequenza));
				
				session.save(categoria);
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Categoria corso salvata con successo!");
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
			}
			
			else if(action.equals("modifica_categoria")) {
				
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
		
		        String id_categoria = request.getParameter("id_categoria");
				String codice = ret.get("codice_mod");
				String descrizione = ret.get("descrizione_mod");
				String frequenza = ret.get("frequenza_mod");
				String mod_freq = request.getParameter("mod_freq");
				

				ForCorsoCatDTO categoria = GestioneFormazioneBO.getCategoriaCorsoFromId(Integer.parseInt(id_categoria),session);		
				
				categoria.setCodice(codice);
				categoria.setDescrizione(descrizione);
				categoria.setFrequenza(Integer.parseInt(frequenza));
								
				session.update(categoria);
				
				if(mod_freq.equals("1")) {
					
					ArrayList<ForCorsoDTO> lista_corsi = GestioneFormazioneBO.getListaCorsiCategoria(Integer.parseInt(id_categoria), session);
					
					for (ForCorsoDTO forCorsoDTO : lista_corsi) {
						
						Calendar calendar = Calendar.getInstance();
						calendar.setTime(forCorsoDTO.getData_corso());
						calendar.add(Calendar.MONTH, categoria.getFrequenza());
						
						Date data_scadenza = calendar.getTime();
						
						forCorsoDTO.setData_scadenza(data_scadenza);
					}
					
				}
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Categoria corso modificata con successo!");
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
			}
			else if(action.equals("lista_corsi")) {
				
				ArrayList<ForCorsoDTO> lista_corsi = null;
				
				if(utente.checkRuolo("F2")) {
					lista_corsi = GestioneFormazioneBO.getListaCorsiCliente(utente.getIdCliente(), utente.getIdSede(), session);
				}
				else if(utente.checkRuolo("F3")) {
					lista_corsi = GestioneFormazioneBO.getListaCorsiClienteSupervisore(utente.getIdCliente(),  session);	
				}
				else {
					
					String dateFrom = request.getParameter("dateFrom");
					String dateTo = request.getParameter("dateTo");
					
					if(dateFrom == null && dateTo == null) {
						DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
						
						Date today = new Date();
						
						Calendar cal = Calendar.getInstance();
						cal.setTime(today);
						
						dateTo = df.format(cal.getTime());
						
						cal.add(Calendar.DATE, -90);
						Date startDate = cal.getTime();
						
						
						dateFrom = df.format(startDate);
						
						
					}
					
					lista_corsi = GestioneFormazioneBO.getListaCorsiDate(dateFrom, dateTo, session);
				//	lista_corsi = GestioneFormazioneBO.getListaCorsi(session);
					
//					
//					for (ForCorsoDTO corso : lista_corsi) {
//						
//						ForDocenteDTO docente = corso.getDocente();
//						
//						if(docente!=null) {
//						corso.getListaDocenti().add(docente);
//						
//						session.update(corso);
//						}
//					}
					
					
					ArrayList<ForCorsoCatDTO> lista_corsi_cat = GestioneFormazioneBO.getListaCategorieCorsi(session);
					ArrayList<ForDocenteDTO> lista_docenti = GestioneFormazioneBO.getListaDocenti(session);			
					ArrayList<CommessaDTO> lista_commesse = GestioneCommesseDAO.getListaCommesseFormazione(company, "FES;FCS", utente, 0, false);
					
					request.getSession().setAttribute("lista_docenti", lista_docenti);
					request.getSession().setAttribute("lista_corsi_cat", lista_corsi_cat);
					request.getSession().setAttribute("lista_commesse", lista_commesse);
					request.getSession().setAttribute("dateTo", dateTo);
					request.getSession().setAttribute("dateFrom", dateFrom);
				}
			
				request.getSession().setAttribute("lista_corsi", lista_corsi);				
				
				session.getTransaction().commit();
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneForCorsi.jsp");
		     	dispatcher.forward(request,response);
				
			}
			
			
			
			
			
			else if(action.equals("nuovo_corso")) {
				
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
		        
		        		
				String categoria = ret.get("categoria");
				String id_docenti = ret.get("id_docenti");
				String data_corso = ret.get("data_corso");
				String data_scadenza = ret.get("data_scadenza");
				String descrizione = ret.get("descrizione");
				String tipologia = ret.get("tipologia");
				String commessa = ret.get("commessa");
				String e_learning = ret.get("e_learning");
				String durata = ret.get("durata");
				String efei = ret.get("efei");
				String frequenza_remind = ret.get("frequenza_remind");
				
				ForCorsoDTO corso = new ForCorsoDTO();		
				
				corso.setCorso_cat(new ForCorsoCatDTO(Integer.parseInt(categoria.split("_")[0])));
				if(id_docenti!=null && !id_docenti.equals("")) {
					for (String id : id_docenti.split(";")) {
						corso.getListaDocenti().add(new ForDocenteDTO(Integer.parseInt(id)));
						
					}
					
									
				}
				if(e_learning!=null && !e_learning.equals("")) {
					corso.setE_learning(Integer.parseInt(e_learning));
				}
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				corso.setData_corso(df.parse(data_corso));
				corso.setData_scadenza(df.parse(data_scadenza));
				corso.setDescrizione(descrizione);
				corso.setTipologia(tipologia);
				corso.setCommessa(commessa);
				corso.setDurata(Integer.parseInt(durata));
				corso.setEfei(Integer.parseInt(efei));
				
				
				if(filename!=null && !filename.equals("")) {
					corso.setDocumento_test(filename);
					//saveFile(fileItem, "DocumentiTest//"+lista_corsi, filename);
				}
				
				session.save(corso);
				
				if(filename!=null && !filename.equals("")) {
					
					saveFile(fileItem, "DocumentiTest//"+corso.getId(), filename);
				}
				
				if(frequenza_remind!=null && !frequenza_remind.equals("")) {
					corso.setfrequenza_remind(Integer.parseInt(frequenza_remind));
					Calendar c = Calendar.getInstance();
					c.setTime(corso.getData_corso());
					c.add(Calendar.DAY_OF_YEAR, Integer.parseInt(frequenza_remind));
					corso.setData_remind(c.getTime());
				}
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Corso salvato con successo!");
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
				
			
			}
			
			else if(action.equals("modifica_corso")) {
				
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
		
		        String id_corso = request.getParameter("id_corso");
		        String categoria = ret.get("categoria_mod");
				String id_docenti = ret.get("id_docenti_mod");
				String id_docenti_dissocia = ret.get("id_docenti_dissocia");
				String data_corso = ret.get("data_corso_mod");
				String data_scadenza = ret.get("data_scadenza_mod");
				String descrizione = ret.get("descrizione_mod");
				String tipologia = ret.get("tipologia_mod");
				String commessa = ret.get("commessa_mod");
				String e_learning = ret.get("e_learning_mod");
				String durata = ret.get("durata_mod");
				String efei = ret.get("efei_mod");
				String frequenza_remind = ret.get("frequenza_remind_mod");
				
				
				ForCorsoDTO corso = GestioneFormazioneBO.getCorsoFromId(Integer.parseInt(id_corso),session);		
				
				corso.setCorso_cat(new ForCorsoCatDTO(Integer.parseInt(categoria.split("_")[0])));
				
				if(id_docenti_dissocia!=null && !id_docenti_dissocia.equals("")) {
					for (String id : id_docenti_dissocia.split(";")) {
						
						corso.getListaDocenti().remove(GestioneFormazioneBO.getDocenteFromId(Integer.parseInt(id), session));
						
					}
					
									
				}
				
				if(id_docenti!=null && !id_docenti.equals("")) {
					for (String id : id_docenti.split(";")) {
						corso.getListaDocenti().add(new ForDocenteDTO(Integer.parseInt(id)));
						
					}
					
									
				}
				if(e_learning!=null && !e_learning.equals("")) {
					corso.setE_learning(Integer.parseInt(e_learning));
				}
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				corso.setData_corso(df.parse(data_corso));
				corso.setData_scadenza(df.parse(data_scadenza));
				corso.setDescrizione(descrizione);
				corso.setTipologia(tipologia);
				if(commessa!=null && !commessa.equals("")) {
					corso.setCommessa(commessa);
				}
				corso.setEfei(Integer.parseInt(efei));
				
				if(filename!=null && !filename.equals("")) {
					corso.setDocumento_test(filename);
					saveFile(fileItem, "DocumentiTest//"+corso.getId(), filename);
				}
				
				if(frequenza_remind!=null && !frequenza_remind.equals("")) {
					corso.setfrequenza_remind(Integer.parseInt(frequenza_remind));
					Calendar c = Calendar.getInstance();
					c.setTime(corso.getData_corso());
					c.add(Calendar.DAY_OF_YEAR, Integer.parseInt(frequenza_remind));
					corso.setData_remind(c.getTime());
				}
				
				corso.setDurata(Integer.parseInt(durata));
				
				session.update(corso);
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Corso modificato con successo!");
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
			}
			else if(action.equals("elimina_corso")) {
				
				ajax = true;
				
				String id_corso = request.getParameter("id_corso");
				
				ForCorsoDTO corso = GestioneFormazioneBO.getCorsoFromId(Integer.parseInt(id_corso), session);
				corso.setDisabilitato(1);
				
				session.update(corso);
				session.getTransaction().commit();
				session.close();
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Corso eliminato con successo!");
				out.print(myObj);
				
			}
			
			else if (action.equals("download_documento_test")) {
				
				String id_corso = request.getParameter("id_corso");
				
				id_corso = Utility.decryptData(id_corso);
				
				ForCorsoDTO corso = GestioneFormazioneBO.getCorsoFromId(Integer.parseInt(id_corso), session);
				
				String path = Costanti.PATH_FOLDER+"//Formazione//DocumentiTest//"+corso.getId()+"//"+corso.getDocumento_test();
				
				downloadFile(path, response.getOutputStream());
				
				response.setContentType("application/pdf");
	
								    				    
				session.close();
				
			}
			
			else if(action.equals("archivio")) {
				
				String id_corso = request.getParameter("id_corso");
				String id_categoria = request.getParameter("id_categoria");
				
				ArrayList<ForCorsoAllegatiDTO> lista_allegati_corso = null;
				ArrayList<ForCorsoCatAllegatiDTO> lista_allegati_categoria = null;
				
				if(!id_corso.equals("0")) {
					lista_allegati_corso = GestioneFormazioneBO.getAllegatiCorso(Integer.parseInt(id_corso), session);					
				}				
				
				if(!id_categoria.equals("0")) {
					lista_allegati_categoria = GestioneFormazioneBO.getAllegatiCategoria(Integer.parseInt(id_categoria), session);					
				}
				
				request.getSession().setAttribute("lista_allegati_corso", lista_allegati_corso);
				request.getSession().setAttribute("lista_allegati_categoria", lista_allegati_categoria);
				request.getSession().setAttribute("id_corso", id_corso);
				request.getSession().setAttribute("id_categoria", id_categoria);
				
				
				session.getTransaction().commit();
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaArchivioFormazione.jsp");
		     	dispatcher.forward(request,response);
			}
			else if(action.equals("archivio_upload")) {
				ajax = true;
				
				String id_corso = request.getParameter("id_corso");
				String id_categoria = request.getParameter("id_categoria");				
								
				ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
				PrintWriter out = response.getWriter();
				response.setContentType("application/json");						
					
					List<FileItem> items = uploadHandler.parseRequest(request);
					for (FileItem item : items) {
						if (!item.isFormField()) {
							if(id_corso!=null && !id_corso.equals("0")) {
								
								ForCorsoAllegatiDTO allegato_corso = new ForCorsoAllegatiDTO();
								ForCorsoDTO corso = GestioneFormazioneBO.getCorsoFromId(Integer.parseInt(id_corso), session);
								allegato_corso.setCorso(corso);
								allegato_corso.setNome_allegato(item.getName());
								saveFile(item, "Allegati//Corsi//"+id_corso,item.getName());	
								session.save(allegato_corso);
								
							}
							if(id_categoria!=null && !id_categoria.equals("0")) {
								
								ForCorsoCatAllegatiDTO allegato_categoria = new ForCorsoCatAllegatiDTO();
								ForCorsoCatDTO categoria = GestioneFormazioneBO.getCategoriaCorsoFromId(Integer.parseInt(id_categoria), session);
								allegato_categoria.setCorso(categoria);
								allegato_categoria.setNome_allegato(item.getName());
								saveFile(item, "Allegati//Categorie//"+id_categoria,item.getName());	
								session.save(allegato_categoria);
							}
							
						}
					}

					session.getTransaction().commit();
					session.close();	
					myObj.addProperty("success", true);
					myObj.addProperty("messaggio", "Upload effettuato con successo!");
					out.print(myObj);
			}
			else if (action.equals("archivio_download")) {

			
				String id_corso = request.getParameter("id_corso");
				String id_categoria = request.getParameter("id_categoria");
				String id_allegato = request.getParameter("id_allegato");
				
				String path = "";
				
				if(id_corso!=null && !id_corso.equals("0")) {
					
					ForCorsoAllegatiDTO allegato_corso = GestioneFormazioneBO.getAllegatoCorsoFormId(Integer.parseInt(id_allegato), session);
					
					path = Costanti.PATH_FOLDER+"//Formazione//Allegati//Corsi//"+id_corso+"//"+allegato_corso.getNome_allegato();
					response.setContentType("application/octet-stream");
					response.setHeader("Content-Disposition","attachment;filename="+ allegato_corso.getNome_allegato());
				}
				if(id_categoria!=null && !id_categoria.equals("0")) {
					
					ForCorsoCatAllegatiDTO allegato_categoria = GestioneFormazioneBO.getAllegatoCorsoCategoriaFormId(Integer.parseInt(id_allegato), session);
					
					path = Costanti.PATH_FOLDER+"//Formazione//Allegati//Categorie//"+id_categoria+"//"+allegato_categoria.getNome_allegato();
					response.setContentType("application/octet-stream");
					response.setHeader("Content-Disposition","attachment;filename="+ allegato_categoria.getNome_allegato());
				}
								
				downloadFile(path, response.getOutputStream());
				
				
				
				session.close();
				
			}
			
			
			else if(action.equals("elimina_allegato")) {
				
				ajax=true;
				
				String id_corso = request.getParameter("id_corso");
				String id_categoria = request.getParameter("id_categoria");
				String id_allegato = request.getParameter("id_allegato");
				
				if(id_corso!=null && !id_corso.equals("0")) {
					
					ForCorsoAllegatiDTO allegato_corso = GestioneFormazioneBO.getAllegatoCorsoFormId(Integer.parseInt(id_allegato), session);
					
					session.delete(allegato_corso);
				}
				if(id_categoria!=null && !id_categoria.equals("0")) {
					
					ForCorsoCatAllegatiDTO allegato_categoria = GestioneFormazioneBO.getAllegatoCorsoCategoriaFormId(Integer.parseInt(id_allegato), session);
					
					session.delete(allegato_categoria);
				}
				
				
				PrintWriter out = response.getWriter();
				session.getTransaction().commit();
				session.close();	
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Allegato eliminato con successo!");
				out.print(myObj);
				
				
			}
			
			else if(action.equals("dettaglio_corso")) {
				
				String id_corso = request.getParameter("id_corso");
				
				id_corso = Utility.decryptData(id_corso);
				
				ForCorsoDTO corso = GestioneFormazioneBO.getCorsoFromId(Integer.parseInt(id_corso), session);	
				ArrayList<ForPartecipanteDTO> lista_partecipanti = GestioneFormazioneBO.getListaPartecipanti(session);
				ArrayList<ForRuoloDTO> lista_ruoli = GestioneFormazioneBO.getListaRuoli(session);
				ArrayList<ForReferenteDTO> lista_referenti = GestioneFormazioneBO.getListaReferenti(session);
												
				
				request.getSession().setAttribute("corso", corso);
				request.getSession().setAttribute("lista_partecipanti", lista_partecipanti);
				request.getSession().setAttribute("lista_ruoli", lista_ruoli);
				request.getSession().setAttribute("lista_referenti", lista_referenti);
				
				session.getTransaction().commit();
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioForCorso.jsp");
		     	dispatcher.forward(request,response);
			}
			
			else if(action.equals("dettaglio_partecipanti_corso")) {
								
				ForCorsoDTO corso = (ForCorsoDTO) request.getSession().getAttribute("corso");
				
				ArrayList<ForPartecipanteRuoloCorsoDTO> listaPartecipanti = null;
				
				if(utente.checkRuolo("F2")) {
					listaPartecipanti = GestioneFormazioneBO.getListaPartecipantiCorsoCliente(corso.getId(),utente.getIdCliente(),utente.getIdSede(),session); 
				}
				else if(utente.checkRuolo("F3")) {
					listaPartecipanti = GestioneFormazioneBO.getListaPartecipantiCorsoClienteSupervisore(corso.getId(),utente.getIdCliente(),session);
				}
				else {
					listaPartecipanti = GestioneFormazioneBO.getListaPartecipantiCorso(corso.getId(),session); 
				}
				
				
				
				request.getSession().setAttribute("listaPartecipanti", listaPartecipanti);					
				
				session.getTransaction().commit();
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioForCorsoPartecipanti.jsp");
		     	dispatcher.forward(request,response);
			}
			else if(action.equals("lista_partecipanti")) {
			
				ArrayList<ForPartecipanteDTO> lista_partecipanti = null;
				
				if(utente.checkRuolo("F2")) {
					
					lista_partecipanti = GestioneFormazioneBO.getListaPartecipantiCliente(utente.getIdCliente(), utente.getIdSede(), session);
							
				}
				else if(utente.checkRuolo("F3")) {
					lista_partecipanti = GestioneFormazioneBO.getListaPartecipantiClienteSupervisore(utente.getIdCliente(),  session);
				}
				else {
					
					
					List<ClienteDTO> listaClienti = (List<ClienteDTO>)request.getSession().getAttribute("lista_clienti");
					if(listaClienti==null) {
						//listaClienti = GestioneAnagraficaRemotaBO.getListaClienti(String.valueOf(utente.getCompany().getId()));							
						listaClienti = GestioneAnagraficaRemotaBO.getListaClienti(""+1428);
					}
					
					List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
					if(listaSedi== null) {
						listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
					}
					
					String id_azienda = request.getParameter("id_azienda");
					
					if(id_azienda!=null && id_azienda.equals("0")) {
						lista_partecipanti = GestioneFormazioneBO.getListaPartecipanti(session);	
					}else if(id_azienda!=null){
						id_azienda = Utility.decryptData(id_azienda);
						lista_partecipanti = GestioneFormazioneBO.getListaPartecipantiClienteSupervisore(Integer.parseInt(id_azienda), session);
					}else {
						lista_partecipanti = new ArrayList<ForPartecipanteDTO>();
					}
					 
			
					ArrayList<String> listaAziendePartecipanti = GestioneFormazioneBO.getListaAziendeConPartecipanti(session);
					
					ArrayList<String> lista_cf = GestioneFormazioneDAO.getListaCodiciFiscali(session);
					
					Gson g = new Gson();
					JsonElement json_cf = g.toJsonTree(lista_cf);
					
					ArrayList<ForCorsoDTO> lista_corsi = DirectMySqlDAO.getListaCorsiDirect(session);
					ArrayList<ForRuoloDTO> lista_ruoli = GestioneFormazioneBO.getListaRuoli(session);
					
					request.getSession().setAttribute("lista_clienti", listaClienti);
					request.getSession().setAttribute("listaAziendePartecipanti", listaAziendePartecipanti);	
					request.getSession().setAttribute("lista_sedi", listaSedi);
					request.getSession().setAttribute("json_cf", json_cf);
					request.getSession().setAttribute("lista_corsi", lista_corsi);
					request.getSession().setAttribute("lista_ruoli", lista_ruoli);
					request.getSession().setAttribute("id_azienda", id_azienda);
					
				}
				
				
				request.getSession().setAttribute("lista_partecipanti", lista_partecipanti);
		
				
				session.getTransaction().commit();
				session.close();
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneForPartecipanti.jsp");
		     	dispatcher.forward(request,response);
				
			}
			
			
			
			else if(action.equals("nuovo_partecipante")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}
		        
		        List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				if(listaSedi== null) {
					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
				}
				FileItem fileItem = null;
				String filename= null;
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	                     fileItem = item;
	                     filename = item.getName();
	                     System.out.println(item.getSize());
	                     
	            	 }else
	            	 {
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	            	 }
	            	
	            }
		        
		        		
				String nome = ret.get("nome");
				String cognome = ret.get("cognome");
				String data_nascita = ret.get("data_nascita");
				String id_azienda = ret.get("azienda");	
				String sede = ret.get("sede");
				String cf = ret.get("cf");
				String luogo_nascita = ret.get("luogo_nascita");
				String email = ret.get("email");
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");

				ForPartecipanteDTO partecipante = new ForPartecipanteDTO();		
				partecipante.setCognome(cognome);
				partecipante.setNome(nome);
				partecipante.setId_azienda(Integer.parseInt(id_azienda));
				partecipante.setLuogo_nascita(luogo_nascita);
				partecipante.setCf(cf);
				partecipante.setEmail(email);
				
				ClienteDTO cl = GestioneAnagraficaRemotaBO.getClienteById(id_azienda);
				partecipante.setNome_azienda(cl.getNome());
				
				SedeDTO sd =null;
				if(!sede.equals("0")) {
					partecipante.setId_sede(Integer.parseInt(sede.split("_")[0]));
					sd = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, Integer.parseInt(sede.split("_")[0]), Integer.parseInt(id_azienda));
					partecipante.setNome_sede(sd.getDescrizione() + " - "+sd.getIndirizzo() +" - " + sd.getComune() + " - ("+ sd.getSiglaProvincia()+")");
				}else {
					partecipante.setNome_sede("Non associate");
				}

				partecipante.setData_nascita(df.parse(data_nascita));				
			
				session.save(partecipante);
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Partecipante salvato con successo!");
				out.print(myObj);
				
				session.getTransaction().commit();
				session.close();
				
			}
			
			else if(action.equals("modifica_partecipante")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}
		        
		        List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				if(listaSedi== null) {
					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
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
		        
		        String id = request.getParameter("id_partecipante");		
				String nome = ret.get("nome_mod");
				String cognome = ret.get("cognome_mod");
				String data_nascita = ret.get("data_nascita_mod");
				String id_azienda = ret.get("azienda_mod");	
				String sede = ret.get("sede_mod");
				String cf = ret.get("cf_mod");
				String luogo_nascita = ret.get("luogo_nascita_mod");
				String email = ret.get("email_mod");
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");

				ForPartecipanteDTO partecipante = GestioneFormazioneBO.getPartecipanteFromId(Integer.parseInt(id),session);	
				partecipante.setCognome(cognome);
				partecipante.setNome(nome);
				partecipante.setLuogo_nascita(luogo_nascita);
				partecipante.setCf(cf);
				partecipante.setEmail(email);
				partecipante.setId_azienda(Integer.parseInt(id_azienda));
				
				ClienteDTO cl = GestioneAnagraficaRemotaBO.getClienteById(id_azienda);
				partecipante.setNome_azienda(cl.getNome());
				
				SedeDTO sd =null;
				if(!sede.equals("0")) {
					partecipante.setId_sede(Integer.parseInt(sede.split("_")[0]));
					sd = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, Integer.parseInt(sede.split("_")[0]), Integer.parseInt(id_azienda));
					partecipante.setNome_sede(sd.getDescrizione() + " - "+sd.getIndirizzo()+" - "+sd.getCap()+" - "+sd.getComune()+" ("+sd.getSiglaProvincia()+")");
				}else {
					partecipante.setNome_sede("Non associate");
				}
				
//				if(azienda!=null && !azienda.equals("")) {
//					partecipante.setAzienda(new ForAziendaDTO(Integer.parseInt(azienda),""));	
//				}
				
				partecipante.setData_nascita(df.parse(data_nascita));				
			
				session.update(partecipante);
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Partecipante modificato con successo!");
				out.print(myObj);
				
				session.getTransaction().commit();
				session.close();
				
			}
			
			else if(action.equals("associa_partecipante_corso")) {
							
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
			    
			    String id_corso = request.getParameter("id_corso");		
				String id_partecipante = ret.get("partecipante");
				String id_ruolo = ret.get("ruolo");
				String ore_partecipate = ret.get("ore_partecipate");
				
				ForPartecipanteRuoloCorsoDTO part_ruolo_cor = new ForPartecipanteRuoloCorsoDTO();
								
				
				part_ruolo_cor.setCorso(new ForCorsoDTO(Integer.parseInt(id_corso)));
				part_ruolo_cor.setPartecipante(new ForPartecipanteDTO(Integer.parseInt(id_partecipante)));
				part_ruolo_cor.setRuolo(new ForRuoloDTO(Integer.parseInt(id_ruolo)));
				part_ruolo_cor.setOre_partecipate(Double.parseDouble(ore_partecipate));
			
				if(filename!=null && !filename.equals("")) {
					saveFile(fileItem, "Attestati//"+id_corso+"//"+id_partecipante, filename);
					part_ruolo_cor.setAttestato(filename);
				}
				session.save(part_ruolo_cor);
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Operazione completata con successo!");
				out.print(myObj);
				
				session.getTransaction().commit();
				session.close();
			}
			
			else if(action.equals("modifica_associazione_partecipante_corso")) {
				
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
			    
			    String id_corso = request.getParameter("id_corso");		
				String id_partecipante =request.getParameter("id_partecipante");	
				String id_ruolo = ret.get("ruolo_mod");				
				String ore_partecipate = ret.get("ore_partecipate_mod");
				
				ForPartecipanteRuoloCorsoDTO part_ruolo = GestioneFormazioneBO.getPartecipanteFromCorso(Integer.parseInt(id_corso), Integer.parseInt(id_partecipante), 0, session);				
				
				part_ruolo.setRuolo(new ForRuoloDTO(Integer.parseInt(id_ruolo)));
				part_ruolo.setOre_partecipate(Double.parseDouble(ore_partecipate));
			
				if(filename!=null && !filename.equals("")) {
					saveFile(fileItem, "Attestati//"+id_corso+"//"+id_partecipante, filename);
					part_ruolo.setAttestato(filename);
				}
				session.update(part_ruolo);
				
				session.getTransaction().commit();
				session.close();
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Operazione completata con successo!");
				out.print(myObj);
				
				
				
			}
			else if(action.equals("download_attestato")) {
				
				String id_corso = request.getParameter("id_corso");
				String id_partecipante = request.getParameter("id_partecipante");				
				String filename = request.getParameter("filename");
				String download_ajax = request.getParameter("ajax");
				
				if(download_ajax==null) {
					id_corso = Utility.decryptData(id_corso);
					id_partecipante = Utility.decryptData(id_partecipante);
				}
				
				if(filename==null) {
					ForPartecipanteRuoloCorsoDTO p = GestioneFormazioneBO.getPartecipanteFromCorso(Integer.parseInt(id_corso), Integer.parseInt(id_partecipante), 0, session);
					filename = p.getAttestato();
				}else {
					filename = Utility.decryptData(filename);
				}
				String path = Costanti.PATH_FOLDER+"//Formazione//Attestati//"+id_corso+"//"+id_partecipante+"//"+filename;
				//response.setHeader("Content-disposition", "attachment; filename=\""+filename+"\"");
				response.setContentType("application/pdf");	
				
				downloadFile(path, response.getOutputStream());
				
				
				session.close();	
			}
			else if(action.equals("download_attestato_all")) {
				String id_corso = request.getParameter("id_corso");
				
				ArrayList<ForPartecipanteRuoloCorsoDTO> lista_partecipanti_corso = null;
				
				if(utente.checkRuolo("F2")) {
					lista_partecipanti_corso = GestioneFormazioneBO.getListaPartecipantiCorsoCliente(Integer.parseInt(id_corso), utente.getIdCliente(), utente.getIdSede(), session);
				}
				else if(utente.checkRuolo("F3")) {
					lista_partecipanti_corso = GestioneFormazioneBO.getListaPartecipantiCorsoClienteSupervisore(Integer.parseInt(id_corso), utente.getIdCliente(),  session);
				}
				else {
					lista_partecipanti_corso = GestioneFormazioneBO.getListaPartecipantiCorso(Integer.parseInt(id_corso), session); 
				}
				
				
				 FileOutputStream fos = null;
			     ZipOutputStream zipOut = null;
			     FileInputStream fis = null;
			     
			     File zipFile = new File(Costanti.PATH_FOLDER+"//Formazione//Attestati//"+id_corso+"//"+"zipfile.zip");
			     if(zipFile.exists()) {
			    	 zipFile.delete();
			     }
			     
			     fos = new FileOutputStream(Costanti.PATH_FOLDER+"//Formazione//Attestati//"+id_corso+"//"+"zipfile.zip");
		         zipOut = new ZipOutputStream(new BufferedOutputStream(fos));
		            
		         ArrayList<String> filenames=new ArrayList<String>();
				
				for (ForPartecipanteRuoloCorsoDTO p : lista_partecipanti_corso) {
					File input = new File(Costanti.PATH_FOLDER+"//Formazione//Attestati//"+id_corso+"//"+p.getPartecipante().getId()+"//"+p.getAttestato());
					
					//String name=input.getName().replace(".pdf","").replace(".PDF", "");
					
					String name= p.getPartecipante().getNome()+"_"+p.getPartecipante().getCognome();
					name = name.replaceAll("'", "");
					
					  ZipEntry ze = null;
					  File input_renamed = null;
					if(!filenames.contains(name)) {
						input_renamed = new File(Costanti.PATH_FOLDER+"//Formazione//Attestati//"+id_corso+"//"+p.getPartecipante().getId()+"//"+name+".pdf");
//						input.renameTo(input_renamed);						
//						filenames.add(input.getName());
//						fis = new FileInputStream(input_renamed);
//		                 ze = new ZipEntry(input_renamed.getName());
//		                System.out.println("Zipping the file: "+input.getName());
					}else {
						 input_renamed = new File(Costanti.PATH_FOLDER+"//Formazione//Attestati//"+id_corso+"//"+p.getPartecipante().getId()+"//"+name+"_"+p.getPartecipante().getId()+".pdf");
					}				
					filenames.add(input_renamed.getName());
					input.renameTo(input_renamed);
					fis = new FileInputStream(input_renamed);
					ze = new ZipEntry(input_renamed.getName());
	                System.out.println("Zipping the file: "+input_renamed.getName());
	                p.setAttestato(input_renamed.getName());
	                session.update(p);
					
	                zipOut.putNextEntry(ze);
	                byte[] tmp = new byte[4*1024];
	                int size = 0;
	                while((size = fis.read(tmp)) != -1){
	                    zipOut.write(tmp, 0, size);
	                }
	                zipOut.flush();
	                fis.close();
	            }
	            zipOut.close();
	            System.out.println("Done... Zipped the files...");
	            
	            session.getTransaction().commit();
				session.close();
				
				downloadFile(Costanti.PATH_FOLDER+"//Formazione//Attestati//"+id_corso+"//"+"zipfile.zip", response.getOutputStream());
				
				response.setContentType("application/octet-stream");	
				
				
			}
			else if(action.equals("dissocia_partecipante_corso")) {
				
				ajax = true;
				
				String id_corso = request.getParameter("id_corso");
				String id_partecipante = request.getParameter("id_partecipante");
				String id_ruolo = request.getParameter("id_ruolo");	
				
				ForPartecipanteRuoloCorsoDTO part = GestioneFormazioneBO.getPartecipanteFromCorso(Integer.parseInt(id_corso), Integer.parseInt(id_partecipante), Integer.parseInt(id_ruolo), session);
								
				session.delete(part);
				
				session.getTransaction().commit();
				session.close();
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Operazione completata con successo!");
				out.print(myObj);
				
			}
			else if(action.equals("dettaglio_partecipante")) {
				
				String id_partecipante = request.getParameter("id_partecipante");
				
				id_partecipante = Utility.decryptData(id_partecipante);
				
				ForPartecipanteDTO partecipante = GestioneFormazioneBO.getPartecipanteFromId(Integer.parseInt(id_partecipante), session);
				ArrayList<ForPartecipanteRuoloCorsoDTO> lista_corsi = GestioneFormazioneBO.getListaCorsiFromPartecipante(Integer.parseInt(id_partecipante), session);
				
				request.getSession().setAttribute("partecipante", partecipante);
				request.getSession().setAttribute("lista_corsi_partecipante", lista_corsi);
				
				session.getTransaction().commit();
				session.close();
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioForPartecipante.jsp");
		     	dispatcher.forward(request,response);
							
			}
			else if(action.equals("scadenzario_partecipante")) {
				
				String id_partecipante = request.getParameter("id_partecipante");
				
				id_partecipante = Utility.decryptData(id_partecipante);
				
				ForPartecipanteDTO partecipante = GestioneFormazioneBO.getPartecipanteFromId(Integer.parseInt(id_partecipante), session);
				
				request.getSession().setAttribute("partecipante", partecipante);
				
				
				session.getTransaction().commit();
				session.close();
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/scadenzarioForPartecipante.jsp");
		     	dispatcher.forward(request,response);
				
			}			
			else if(action.equals("scadenzario_partecipante_create")) {
				
				ajax = true;
			
				ForPartecipanteDTO partecipante = (ForPartecipanteDTO) request.getSession().getAttribute("partecipante");
							
				HashMap<String,Integer> listaScadenze =  GestioneFormazioneBO.getListaScadenzeCorsi(partecipante.getId(),session);
				
				ArrayList<String> lista_scadenzario = new ArrayList<>();				
			
				Iterator scadenza = listaScadenze.entrySet().iterator();
			
				while (scadenza.hasNext()) {
					 Map.Entry pair = (Map.Entry)scadenza.next();
					 lista_scadenzario.add(pair.getKey() + ";" + pair.getValue());
					 scadenza.remove(); 
				}
				
				PrintWriter out = response.getWriter();
				
				Gson gson = new Gson(); 			        
		        
			    JsonElement obj_scadenzario = gson.toJsonTree(lista_scadenzario);
			       
			    myObj.addProperty("success", true);
			  
			    myObj.add("obj_scadenzario", obj_scadenzario);
						        
			    out.println(myObj.toString());

			    out.close();
			        
			    session.getTransaction().commit();
		        session.close();
				
			}	
			else if(action.equals("lista_corsi_scadenza")) {
				
				ForPartecipanteDTO partecipante = (ForPartecipanteDTO) request.getSession().getAttribute("partecipante");
				String data_scadenza = request.getParameter("data_scadenza");
				
				
				ArrayList<ForCorsoDTO> lista_corsi = GestioneFormazioneBO.getListaCorsiPartecipanteScadenza(partecipante.getId(), data_scadenza, session);
				
				request.getSession().setAttribute("lista_corsi", lista_corsi);
				
				session.getTransaction().commit();
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneForCorsi.jsp");
		     	dispatcher.forward(request,response);
			}
			else if(action.equals("scadenzario")) {		
				
				String dateFrom = request.getParameter("dateFrom");
				String dateTo = request.getParameter("dateTo");
				String tipo_data = request.getParameter("tipo_data");
				
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				
				if(tipo_data == null) {
					tipo_data = "data_scadenza";
					if(dateFrom == null) {
						dateFrom = "" +df.format(new Date());
						
					}
					if(dateTo ==null) {
						Calendar c = Calendar.getInstance();
						Date scadenza = new Date();
						c.add(Calendar.DAY_OF_MONTH, 60);
						dateTo ="" +df.format(c.getTime());
					}
				}
				
				
				
				ArrayList<ForPartecipanteRuoloCorsoDTO> lista_corsi = null;
				
				if(utente.checkRuolo("F2")) {
					lista_corsi = GestioneFormazioneBO.getListaPartecipantiRuoloCorsoCliente(dateFrom, dateTo, tipo_data, utente.getIdCliente(),utente.getIdSede(), session);
				}
				else if(utente.checkRuolo("F3")){
					lista_corsi = GestioneFormazioneBO.getListaPartecipantiRuoloCorsoClienteSupervisore(dateFrom, dateTo, tipo_data, utente.getIdCliente(), session);
				}
				else {
					lista_corsi = GestioneFormazioneBO.getListaPartecipantiRuoloCorso(dateFrom, dateTo, tipo_data, null, null, session);
					
					
				}				
				if(tipo_data !=null && tipo_data.equals("data_scadenza") &&dateTo!=null) {
					ArrayList<ForCorsoDTO> lista_corsi_successivi = GestioneFormazioneBO.getListaCorsiSuccessivi(dateFrom, session);
					
					Calendar c = Calendar.getInstance();
					Date scadenza = new Date();
					c.add(Calendar.DAY_OF_MONTH, 60);
					scadenza = c.getTime();
					
					
					for (ForCorsoDTO succ : lista_corsi_successivi) {
						for(ForPartecipanteRuoloCorsoDTO part : lista_corsi) {
							if(part.getCorso().getData_scadenza().before(scadenza) || part.getCorso().getData_scadenza().equals(scadenza)) {
								part.getCorso().setIn_scadenza(1);
							}
							
							
							if(part.getCorso().getId()!=succ.getId() && part.getCorso().getCorso_cat().getId() == succ.getCorso_cat().getId() && part.getCorso().getData_scadenza().before(succ.getData_scadenza())) {
								List<ForPartecipanteDTO> mainList = new ArrayList<ForPartecipanteDTO>();
								mainList.addAll(succ.getListaPartecipanti());
								
								if(mainList.contains(part.getPartecipante())) {
									part.setCorso_aggiornato(1);
								}
							}
							
						}
					}
					
				}
				
				request.getSession().setAttribute("lista_corsi", lista_corsi);
				request.getSession().setAttribute("dateFrom", dateFrom);
				request.getSession().setAttribute("dateTo", dateTo);
				request.getSession().setAttribute("tipo_data", tipo_data);
								
				session.getTransaction().commit();
				session.close();
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/scadenzarioFormazione.jsp");
		     	dispatcher.forward(request,response);
				
			}
			else if(action.equals("importa_excel")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}
		        
		        List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				if(listaSedi== null) {
					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
				}
				
				FileItem fileItem = null;
				String filename= null;
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	                     fileItem = item;
	                     filename = item.getName();
	                     System.out.println(item.getSize());
	            	 }else
	            	 {
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	            	 }
	            	
	            }		        
		        		
				String id_azienda = ret.get("azienda_import");	
				String sede = ret.get("sede_import");
				int id_sede = 0;
				
				ClienteDTO cl = GestioneAnagraficaRemotaBO.getClienteById(id_azienda);
				
				SedeDTO sd =null;
				String nome_sede = "Non associate";
				if(!sede.equals("0")) {
					id_sede = Integer.parseInt(sede.split("_")[0]);
					
					sd = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, Integer.parseInt(sede.split("_")[0]), Integer.parseInt(id_azienda));
					nome_sede = sd.getDescrizione() + " - "+sd.getIndirizzo() +" - " + sd.getComune() + " - ("+ sd.getSiglaProvincia()+")";
				}
				int esito = 0;
				if(!fileItem.getName().equals("")) {
					
					esito = GestioneFormazioneBO.importaDaExcel(fileItem, Integer.parseInt(id_azienda), cl.getNome(),id_sede,nome_sede, session);

				}
				
				session.getTransaction().commit();
				session.close();
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				if(esito == 0) {
					myObj.addProperty("success", true);
					myObj.addProperty("messaggio", "Partecipanti importati con successo!");
				}else {
					myObj.addProperty("success", false);
					myObj.addProperty("messaggio", "Formato file errato!");
				}
				out.print(myObj);

			}
			else if(action.equals("importa_pdf")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}
		        
		        List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				if(listaSedi== null) {
					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
				}
				
				FileItem fileItem = null;
				String filename= null;
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	                     fileItem = item;
	                     filename = item.getName();
	                     System.out.println(item.getSize());
	                     
	            	 }else
	            	 {
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	            	 }
	            	
	            }		        
		        		
				String id_azienda = ret.get("azienda_import");	
				String sede = ret.get("sede_import");
				int id_sede = 0;
				
				ClienteDTO cl = null;
				
				if(id_azienda!=null && !id_azienda.equals("")) {
					cl = GestioneAnagraficaRemotaBO.getClienteById(id_azienda);	
				}				
				
				SedeDTO sd =null;
				String nome_sede = "Non associate";
				if(sede!=null && !sede.equals("0")) {
					id_sede = Integer.parseInt(sede.split("_")[0]);
					
					sd = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, Integer.parseInt(sede.split("_")[0]), Integer.parseInt(id_azienda));
					
				}
				
				ArrayList<ForPartecipanteDTO> lista_partecipanti = null;
				
				myObj = new JsonObject();
				
				if(!fileItem.getName().equals("")) {
					
					myObj =  GestioneFormazioneBO.importaDaPDF(fileItem,cl, sd, session);

				}
				
				session.getTransaction().commit();
				session.close();
				
				
				PrintWriter  out = response.getWriter();
				request.getSession().setAttribute("fileItemAttestati", fileItem);
//				if(lista_partecipanti != null) {
//					myObj.addProperty("success", true);
//					myObj.add("lista_partecipanti_import", g.toJsonTree(lista_partecipanti));
					
//				}else {
//					myObj.addProperty("success", false);
//					myObj.addProperty("messaggio", "Formato file errato!");
//				}
				out.print(myObj);
				
				
			}
			else if(action.equals("conferma_importazione")) {
				
				ajax = true;
				
				String[] data = request.getParameterValues("data");
				String dataOj = request.getParameter("data");
				String id_azienda_general = request.getParameter("id_azienda_general");
				String id_sede_general = request.getParameter("id_sede_general");
				
				List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				if(listaSedi== null) {
					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
				}
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				JsonElement jelement = new JsonParser().parse(dataOj);
				JsonArray json_array = jelement.getAsJsonArray();
				ArrayList<ForPartecipanteRuoloCorsoDTO> lista_partecipanti = new ArrayList<ForPartecipanteRuoloCorsoDTO>(); 
				ArrayList<String> lista_cf = GestioneFormazioneDAO.getListaCodiciFiscali(session);
				
				ClienteDTO cl = null; 
						
				if(id_azienda_general!=null && !id_azienda_general.equals("")) {
					cl = GestioneAnagraficaRemotaBO.getClienteById(""+id_azienda_general);	
				}					
				
				SedeDTO sd =null;
				String nome_sede = "Non associate";
				
			
				if(id_sede_general!=null && !id_sede_general.equals("0") && !id_azienda_general.equals("")) {
					sd = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, Integer.parseInt(id_sede_general.split("_")[0]), Integer.parseInt(id_azienda_general));
					nome_sede = sd.getDescrizione() + " - "+sd.getIndirizzo() +" - " + sd.getComune() + " - ("+ sd.getSiglaProvincia()+")";
				}		
				
				for (JsonElement json : json_array) {
					JsonObject json_obj = json.getAsJsonObject();
					
					String nome = json_obj.get("nome").getAsString();
					String cognome = json_obj.get("cognome").getAsString();
					String cf = json_obj.get("cf").getAsString();
					String luogo_nascita = json_obj.get("luogo_nascita").getAsString();
					String data_nascita = json_obj.get("data_nascita").getAsString();
					int id_azienda = 0;
					String id_sede = "";
					ClienteDTO cliente = null;
					if(json_obj.get("azienda")!=null && !json_obj.get("azienda").getAsString().equals("")) {
					    id_azienda = json_obj.get("azienda").getAsInt();
					    cliente  = GestioneAnagraficaRemotaBO.getClienteById(""+id_azienda);	
					}else {
						id_azienda = Integer.parseInt(id_azienda_general);						
						cliente = cl;
					}
					
					if(json_obj.get("sede")!=null &&json_obj.get("sede")!= JsonNull.INSTANCE && !json_obj.get("sede").getAsString().equals("")) {
						
						if(json_obj.get("sede").getAsString().equals("0")) {
							id_sede = "0";
							
							nome_sede = "Non Associate";
						}else {
							id_sede = json_obj.get("sede").getAsString();
							sd = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, Integer.parseInt(id_sede.split("_")[0]), id_azienda);
							nome_sede = sd.getDescrizione() + " - "+sd.getIndirizzo() +" - " + sd.getComune() + " - ("+ sd.getSiglaProvincia()+")";	
						}
						
					}else {
						id_sede = id_sede_general;
					}
					
					int id_corso = 0;
					int id_ruolo = 0;
					Double ore = 0.0;
					int firma_responsabile = 0;
					int firma_legale_rappresentante = 0;
					int firma_centro_formazione = 0;
					if(json_obj.get("id_corso")!=null && !json_obj.get("id_corso").getAsString().equals("") ) {
						id_corso = json_obj.get("id_corso").getAsInt();
					}
					if(json_obj.get("id_ruolo")!=null && !json_obj.get("id_ruolo").getAsString().equals("") ) {					
						id_ruolo = json_obj.get("id_ruolo").getAsInt();
					}
					if(json_obj.get("ore")!=null && !json_obj.get("ore").getAsString().equals("") ) {	
						ore = json_obj.get("ore").getAsDouble();
					}					
					if(json_obj.get("firma_responsabile")!=null && !json_obj.get("firma_responsabile").getAsString().equals("") ) {	
						firma_responsabile = json_obj.get("firma_responsabile").getAsInt();
					}					
					if(json_obj.get("firma_legale_rappresentante")!=null && !json_obj.get("firma_legale_rappresentante").getAsString().equals("") ) {	
						firma_legale_rappresentante = json_obj.get("firma_legale_rappresentante").getAsInt();
					}
					if(json_obj.get("firma_centro_formazione")!=null && !json_obj.get("firma_centro_formazione").getAsString().equals("") ) {	
						firma_centro_formazione = json_obj.get("firma_centro_formazione").getAsInt();
					}
				
					ForPartecipanteDTO partecipante = null;
					if(!lista_cf.contains(cf)) {
						partecipante =  new ForPartecipanteDTO();
					}else {
						partecipante = GestioneFormazioneBO.getPartecipanteFromCf(cf,session);
					}
					
						partecipante.setNome(nome);
						partecipante.setCognome(cognome);
						partecipante.setCf(cf);
						partecipante.setLuogo_nascita(luogo_nascita);
						partecipante.setData_nascita(df.parse(data_nascita));
						partecipante.setId_azienda(id_azienda);
						if(id_sede!=null && !id_sede.equals("0")) {
							partecipante.setId_sede(Integer.parseInt(id_sede.split("_")[0]));	
						}else {
							partecipante.setId_sede(0);
						}
						
						partecipante.setNome_azienda(cliente.getNome());
						partecipante.setNome_sede(nome_sede);
						session.saveOrUpdate(partecipante);
					
					
					if(partecipante !=null && id_corso!=0) {						
						
						ForPartecipanteRuoloCorsoDTO p = null;
						ForCorsoDTO corso = GestioneFormazioneBO.getCorsoFromId(id_corso, session);
						
						if(!corso.getListaPartecipanti().contains(partecipante)){
							
							p = new ForPartecipanteRuoloCorsoDTO();
							p.setCorso(corso);
							
							
							p.setOre_partecipate(ore);
							if(id_ruolo!=0) {
								p.setRuolo(new ForRuoloDTO(id_ruolo));	
							}
							
													
							p.setPartecipante(partecipante);
							session.save(p);	
						}else {
							ForRuoloDTO ruolo = GestioneFormazioneBO.getRuoloFromId(id_ruolo, session);
							if(partecipante.getListaRuoli().contains(ruolo)) {
								p = GestioneFormazioneBO.getPartecipanteFromCorso(corso.getId(), partecipante.getId(), id_ruolo, session);
								
								if(p == null) {
									p = GestioneFormazioneBO.getPartecipanteFromCorso(corso.getId(), partecipante.getId(), 0, session);
									p.setCorso(corso);
									
									
									p.setOre_partecipate(ore);
									if(id_ruolo!=0) {
										p.setRuolo(ruolo);	
									}
									
															
									p.setPartecipante(partecipante);
									session.saveOrUpdate(p);
								}
								
							}else {
								p = new ForPartecipanteRuoloCorsoDTO();
								p.setCorso(corso);
								
								
								p.setOre_partecipate(ore);
								if(id_ruolo!=0) {
									p.setRuolo(new ForRuoloDTO(id_ruolo));	
								}
								
														
								p.setPartecipante(partecipante);
								session.saveOrUpdate(p);	
							}
							
						}
						
						p.setFirma_legale_rappresentante(firma_legale_rappresentante);
						p.setFirma_responsabile(firma_responsabile);
						p.setFirma_centro_formazione(firma_centro_formazione);
						
						lista_partecipanti.add(p);
						
					}
				}
				
				if(lista_partecipanti.size()>0) {
					FileItem fileItem = (FileItem) request.getSession().getAttribute("fileItemAttestati");
					GestioneFormazioneBO.splitPdf(fileItem,lista_partecipanti, session);
				}				
				
				
				
				session.getTransaction().commit();
				session.close();

				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();

				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Partecipanti importati con successo");

				out.print(myObj);
				
				
			}
			else if(action.equals("download_template")) {
				
				String path = Costanti.PATH_FOLDER+"Formazione//template_importazione.xlsx";
				response.setContentType("application/octet-stream");
				response.setHeader("Content-Disposition","attachment;filename=template_importazione.xlsx");
				
				downloadFile(path, response.getOutputStream());
			
				
				session.close();
				
			}
			else if(action.equals("consuntivo")) {
								
				session.getTransaction().commit();
				session.close();
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/consuntivoFormazione.jsp");
		     	dispatcher.forward(request,response);
				
			}
			else if(action.equals("consuntivo_table")) {
								
				String dateFrom = request.getParameter("dateFrom");
				String dateTo = request.getParameter("dateTo");				
				
				ArrayList<ForPartecipanteRuoloCorsoDTO> lista_corsi = null;
				if(utente.checkRuolo("F2")) {
					lista_corsi = GestioneFormazioneBO.getListaCorsiConsuntivo(dateFrom, dateTo, utente.getIdCliente(), utente.getIdSede(), session);
					
					
					for (ForPartecipanteRuoloCorsoDTO c : lista_corsi) {
						List<ForPartecipanteDTO> lista_partecipanti = new ArrayList<ForPartecipanteDTO>();
						for (ForPartecipanteDTO p : c.getCorso().getListaPartecipanti()) {							
							if(p.getId_azienda() == utente.getIdCliente() && p.getId_sede() == utente.getIdSede()) {
								lista_partecipanti.add(p);
							}
						}
						c.getCorso().setListaPartecipanti(new HashSet<ForPartecipanteDTO>(lista_partecipanti));
					}
					
				}
				else if(utente.checkRuolo("F3")){
					
					lista_corsi = GestioneFormazioneBO.getListaCorsiConsuntivo(dateFrom, dateTo, utente.getIdCliente(), utente.getIdSede(), session);
					
					
					for (ForPartecipanteRuoloCorsoDTO c : lista_corsi) {
						List<ForPartecipanteDTO> lista_partecipanti = new ArrayList<ForPartecipanteDTO>();
						for (ForPartecipanteDTO p : c.getCorso().getListaPartecipanti()) {							
							if(p.getId_azienda() == utente.getIdCliente()) {
								lista_partecipanti.add(p);
							}
						}
						c.getCorso().setListaPartecipanti(new HashSet<ForPartecipanteDTO>(lista_partecipanti));
					}
					
				}
				
				else {
					lista_corsi = GestioneFormazioneBO.getListaCorsiConsuntivo(dateFrom, dateTo, 0, 0, session);	
				}
				request.getSession().setAttribute("lista_corsi", lista_corsi);
				request.getSession().setAttribute("dateFrom", dateFrom);
				request.getSession().setAttribute("dateTo", dateTo);
			
								
				//session.getTransaction().commit();
				session.close();
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/consuntivoFormazioneTable.jsp");
		     	dispatcher.forward(request,response);
				
			}
			else if(action.equals("questionario")) {
				
				String id_corso = request.getParameter("id_corso");

				id_corso = Utility.decryptData(id_corso);
				
				ForCorsoDTO corso = GestioneFormazioneBO.getCorsoFromId(Integer.parseInt(id_corso), session);
				
				ForQuestionarioDTO questionario = null;
				
				if(corso.getQuestionario() == null) {
				
					questionario = new ForQuestionarioDTO();
					
					session.save(questionario);
					
					corso.setQuestionario(questionario);
					
					session.update(corso);					
					
				}else {
				
					questionario = corso.getQuestionario();
				}
				
				
				ArrayList<ForPartecipanteRuoloCorsoDTO> listaPartecipanti = (ArrayList<ForPartecipanteRuoloCorsoDTO>) request.getSession().getAttribute("listaPartecipanti");	
				request.getSession().setAttribute("numero_partecipanti", listaPartecipanti.size());	
				
				request.getSession().setAttribute("questionario", questionario);
				request.getSession().setAttribute("corso", corso);
				
				session.getTransaction().commit();
				session.close();
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/questionarioFormazione.jsp");
		     	dispatcher.forward(request,response);
			}
			else if(action.equals("consuntivo_questionari")) {
				
				
				ArrayList<CommessaDTO> lista_commesse = GestioneCommesseDAO.getListaCommesseFormazione(company, "FES;FCS", utente, 0, false);
				
				request.getSession().setAttribute("lista_commesse", lista_commesse);
				session.getTransaction().commit();
				session.close();
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/consuntivoQuestionariFormazione.jsp");
		     	dispatcher.forward(request,response);
				
			}
			
			else if(action.equals("consuntivo_questionari_table")) {
				
				String dateFrom = request.getParameter("dateFrom");
				String dateTo = request.getParameter("dateTo");
				String commessa = request.getParameter("commessa");
				
//				if(dateFrom == null && dateTo == null) {
//					DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
//					
//					Date today = new Date();
//					
//					Calendar cal = Calendar.getInstance();
//					cal.setTime(today);
//					
//					dateTo = df.format(cal.getTime());
//					
//					cal.add(Calendar.DATE, -90);
//					Date startDate = cal.getTime();
//					
//					
//					dateFrom = df.format(startDate);
//					
//					
//				}
				ArrayList<ForCorsoDTO>lista_corsi = null;
				if(commessa!=null) {
					lista_corsi= GestioneFormazioneBO.getlistaCorsiCommessa(commessa, session);
				}else {
					lista_corsi= GestioneFormazioneBO.getListaCorsiDate(dateFrom, dateTo, session);	
				}
				
				 
				ArrayList<Integer>lista_n_partecipanti = new ArrayList<Integer>();
				ArrayList<Integer>lista_questionari_compilati = new ArrayList<Integer>();				
				int numero_partecipanti = 0;
				
				List<String[]> parsedQuestionari = new ArrayList<>();
				int maxDomande = 0;
				for (ForCorsoDTO corso : lista_corsi) {
					
					if(corso.getQuestionario()!=null) {
						
						ForQuestionarioDTO questionario = corso.getQuestionario();
						if(Pattern.compile("\\d").matcher(questionario.getSeq_risposte()).find()) {
							lista_questionari_compilati.add(1);
							
						}else {
							lista_questionari_compilati.add(0);
						}
						
						
						String[] risposte = questionario.getSeq_risposte().split(";");
						
						parsedQuestionari.add(risposte);
						maxDomande = Math.max(maxDomande, risposte.length);
						
						
					}else {
						lista_questionari_compilati.add(0);
					}
					
					lista_n_partecipanti.add(GestioneFormazioneBO.getListaPartecipantiCorso(corso.getId(), session).size());
					//numero_partecipanti += GestioneFormazioneBO.getListaPartecipantiCorso(corso.getId(), session).size();
				}
				
//				int[][] sommaRisposte = new int[maxDomande][2];
//				
//				
//				 for (String[] risposte : parsedQuestionari) {
//			            for (int i = 0; i < risposte.length; i++) {
//			                String risposta = risposte[i].trim();
//			                if (risposta.isEmpty() || risposta.equals(",,") || risposta.equals(",")) {
//			                    continue; // Saltiamo domande senza risposta
//			                }
//
//			                String[] valori = risposta.split(",");
//			                int poco = 0, molto = 0;
//
//			                if (valori.length == 2) { 
//			                    // Caso classico: "X,Y,"
//			                    poco = valori[0].isEmpty() ? 0 : Integer.parseInt(valori[0]);
//			                    molto = valori[1].isEmpty() ? 0 : Integer.parseInt(valori[1]);
//			                } else if (valori.length == 1) {
//			                	if (risposta.startsWith(",")) {
//			                        molto = Integer.parseInt(valori[0]);
//			                    } 
//			                    // Caso speciale: "X,," → poco=X, molto=0
//			                    else {
//			                        poco = Integer.parseInt(valori[0]);
//			                    }
//			                }
//			                else if (valori.length == 3) {
//			                    // Caso speciale: ",,Y" → poco=0, molto=Y
//			                    if (valori[0].isEmpty() && valori[1].isEmpty()) {
//			                        molto = Integer.parseInt(valori[2]);
//			                    }
//			                }
//			                // Sommiamo i valori
//			                sommaRisposte[i][0] += poco;
//			                sommaRisposte[i][1] += molto;
//			            }
//			        }
//				
//				
//				StringBuilder risultato = new StringBuilder();
//		        for (int i = 0; i < maxDomande; i++) {
//		            if (sommaRisposte[i][0] == 0 && sommaRisposte[i][1] == 0) {
//		                risultato.append(",,;");
//		            } else {
//		                risultato.append(sommaRisposte[i][0]).append(",").append(sommaRisposte[i][1]).append(";");
//		            }
//		        }
				
				int[][] sommaRisposte = new int[maxDomande][3]; // Aggiunto terzo valore per "non risposte"

				for (String[] risposte : parsedQuestionari) {
				    for (int i = 0; i < risposte.length; i++) {
				        String risposta = risposte[i].trim();
				        if (risposta.isEmpty() || risposta.equals(",,") || risposta.equals(",")) {
				            continue; // Saltiamo domande senza risposta
				        }

				        String[] valori = risposta.split(",");
				        int poco = 0, molto = 0, nonRisposte = 0;

				        if (valori.length == 3) {
				            // Caso ",X,Y;" → poco=0, molto=X, nonRisposte=Y
				            poco = 0;
				            molto = valori[1].isEmpty() ? 0 : Integer.parseInt(valori[1]);
				            nonRisposte = valori[2].isEmpty() ? 0 : Integer.parseInt(valori[2]);
				        } else if (valori.length == 2) {
				            // Caso "X,Y;" → poco=X, molto=Y
				            poco = valori[0].isEmpty() ? 0 : Integer.parseInt(valori[0]);
				            molto = valori[1].isEmpty() ? 0 : Integer.parseInt(valori[1]);
				        } else if (valori.length == 1) {
				            // Caso speciale ",Y;" → poco=0, molto=Y
				            if (risposta.startsWith(",")) {
				                molto = Integer.parseInt(valori[0]);
				            } else {
				                poco = Integer.parseInt(valori[0]);
				            }
				        }

				        // Sommare i valori nell'array
				        sommaRisposte[i][0] += poco;
				        sommaRisposte[i][1] += molto;
				        sommaRisposte[i][2] += nonRisposte; // Nuova colonna per non risposte
				    }
				}

				// Costruzione della stringa risultato
				StringBuilder risultato = new StringBuilder();
				for (int i = 0; i < maxDomande; i++) {
				    if (sommaRisposte[i][0] == 0 && sommaRisposte[i][1] == 0 && sommaRisposte[i][2] == 0) {
				        risultato.append(",,;"); // Nessuna risposta registrata
				    } else {
				        risultato.append(sommaRisposte[i][0])
				                .append(",")
				                .append(sommaRisposte[i][1])
				                .append(",")
				                .append(sommaRisposte[i][2])
				                .append(";");
				    }
				}

				ForQuestionarioDTO questionario_result = new ForQuestionarioDTO();
				questionario_result.setSeq_risposte(risultato.toString());
						
				 
				//request.getSession().setAttribute("numero_partecipanti", numero_partecipanti);	
				request.getSession().setAttribute("lista_corsi", lista_corsi);
				request.getSession().setAttribute("lista_n_partecipanti", lista_n_partecipanti);
				request.getSession().setAttribute("lista_questionari_compilati", lista_questionari_compilati);				
				
				request.getSession().setAttribute("questionario", questionario_result);
				request.getSession().setAttribute("commessa", commessa);
				
				session.getTransaction().commit();
				session.close();
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/consuntivoQuestionariFormazioneTable.jsp");
		     	dispatcher.forward(request,response);
			}
			
			else if(action.equals("compila_questionario")) {
				
				ajax = true;
				
			
				String risposte = request.getParameter("risposte");
				
				ForQuestionarioDTO questionario = (ForQuestionarioDTO) request.getSession().getAttribute("questionario");				
				
				questionario.setSeq_risposte(risposte);
				
				session.update(questionario);				
				
				
				request.getSession().setAttribute("questionario", questionario);
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				
				myObj.addProperty("success", true);				
				
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
			}
			else if(action.equals("salva_compilazione_questionario")) {
				
				ajax = true;
								
				
				ForQuestionarioDTO questionario = (ForQuestionarioDTO) request.getSession().getAttribute("questionario");				
				
				questionario.setSalvato(1);
				
				session.update(questionario);				
				
				
				request.getSession().setAttribute("questionario", questionario);
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Questionario salvato con successo!");
				
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
			}
			else if(action.equals("visibilita")) {
				
				ajax = true;
								
				String id_corso = request.getParameter("id_corso");
				String visibile = request.getParameter("visibile");
				
				ForCorsoDTO corso = GestioneFormazioneBO.getCorsoFromId(Integer.parseInt(id_corso), session);
				corso.setVisibile(Integer.parseInt(visibile));				
				
				session.update(corso);				

				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				
				myObj.addProperty("success", true);
				
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
			}
			else if(action.equals("corsi_partecipante")) {
			
				String id_partecipante = request.getParameter("id_partecipante");
								
				ArrayList<ForPartecipanteRuoloCorsoDTO> lista_corsi = GestioneFormazioneBO.getListaCorsiFromPartecipante(Integer.parseInt(id_partecipante), session);
								
				request.getSession().setAttribute("lista_corsi_partecipante", lista_corsi);				
				
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				
				String corsi = "";
				if(lista_corsi.size()>0) {
					for (ForPartecipanteRuoloCorsoDTO cor : lista_corsi) {
						
						corsi = corsi +"- " +cor.getCorso().getId()+"<br>";
					}
					
					corsi = corsi +"Per procedere con l'eliminazione, dissociare prima il partecipante dai corsi.";
				}
				
				myObj.addProperty("success", true);
				  
				myObj.addProperty("corsi", corsi);
							        
				out.println(myObj.toString());

				out.close();
				
				session.getTransaction().commit();
				session.close();
			}

			else if(action.equals("elimina_partecipante")) {
				
				String id_partecipante = request.getParameter("id_partecipante");
				
				ForPartecipanteDTO partecipante = GestioneFormazioneBO.getPartecipanteFromId(Integer.parseInt(id_partecipante), session);
				
				session.delete(partecipante);

				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
							        
				out.println(myObj.toString());

				out.close();
				
				session.getTransaction().commit();
				session.close();
				
				
			}
			else if(action.equals("report_partecipanti")) {
				
				String id_azienda = request.getParameter("id_azienda");
				String id_sede = request.getParameter("id_sede");
				
				if(id_sede!=null && !id_sede.equals("0")) {
					id_sede= id_sede.split("_")[0];
				}
				
				ArrayList<ForPartecipanteRuoloCorsoDTO> lista = GestioneFormazioneBO.getListaPartecipantiRuoloCorso(null, null, null, id_azienda, id_sede, session);
				
				GestioneFormazioneBO.createReportPartecipanti(lista);
				
				String path = Costanti.PATH_FOLDER + "\\Formazione\\ReportPartecipanti\\REPORT_PARTECIPANTI.xlsx";
				 File file = new File(path);
					
					FileInputStream fileIn = new FileInputStream(file);

					ServletOutputStream outp = response.getOutputStream();
					response.setContentType("application/octet-stream");
					response.setHeader("Content-Disposition","attachment;filename=REPORT_PARTECIPANTI.xlsx");
			
					    byte[] outputByte = new byte[1];
					    
					    while(fileIn.read(outputByte, 0, 1) != -1)
					    {
					    	outp.write(outputByte, 0, 1);
					    }
					    				    
					 
					    fileIn.close();
					    outp.flush();
					    outp.close();
				
				session.close();
			}
			
			else if(action.equals("lista_referenti")) {
				
				
				
				
				
				List<ClienteDTO> listaClienti = (List<ClienteDTO>)request.getSession().getAttribute("lista_clienti");
				if(listaClienti==null) {
					listaClienti = GestioneAnagraficaRemotaBO.getListaClienti(String.valueOf(utente.getCompany().getId()));							
				}
				
				List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				if(listaSedi== null) {
					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
				}
				
				
				ArrayList<ForReferenteDTO> lista_referenti = GestioneFormazioneBO.getListaReferenti(session);
				
				request.getSession().setAttribute("lista_referenti", lista_referenti);
				request.getSession().setAttribute("lista_clienti", listaClienti);				
				request.getSession().setAttribute("lista_sedi", listaSedi);
				session.getTransaction().commit();
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneForReferentiCorso.jsp");
		     	dispatcher.forward(request,response);
			}
			else if (action.equals("nuovo_referente")) {
				
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
		
				String nome = ret.get("nome");
				String cognome = ret.get("cognome");
				String email = ret.get("email");
				String id_azienda = ret.get("azienda");
				String id_sede = ret.get("sede");

				ForReferenteDTO referente = new ForReferenteDTO();
				
				referente.setNome(nome);
				referente.setCognome(cognome);
				referente.setEmail(email);
				referente.setId_azienda(Integer.parseInt(id_azienda));
				
				ClienteDTO cl = GestioneAnagraficaRemotaBO.getClienteById(id_azienda);
				referente.setNome_azienda(cl.getNome());
				
				List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				if(listaSedi== null) {
					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
				}
				
				SedeDTO sd =null;
				if(!id_sede.equals("0")) {
					referente.setId_sede(Integer.parseInt(id_sede.split("_")[0]));
					sd = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, Integer.parseInt(id_sede.split("_")[0]), Integer.parseInt(id_azienda));
					referente.setNome_sede(sd.getDescrizione() + " - "+sd.getIndirizzo() +" - " + sd.getComune() + " - ("+ sd.getSiglaProvincia()+")");
				}else {
					referente.setNome_sede("Non associate");
				}
				
				session.save(referente);				

				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Referente salvato con successo!");
				out.print(myObj);
				session.getTransaction().commit();
				session.close();	
				
				
			}
			
			else if (action.equals("modifica_referente")) {
				
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
		
				String nome = ret.get("nome_mod");
				String cognome = ret.get("cognome_mod");
				String email = ret.get("email_mod");
				String id_azienda = ret.get("azienda_mod");
				String id_sede = ret.get("sede_mod");
				String id_referente = ret.get("id_referente");

				ForReferenteDTO referente = GestioneFormazioneBO.getReferenteFromID(Integer.parseInt(id_referente),session);
				
				referente.setNome(nome);
				referente.setCognome(cognome);
				referente.setEmail(email);
				referente.setId_azienda(Integer.parseInt(id_azienda));
				
				ClienteDTO cl = GestioneAnagraficaRemotaBO.getClienteById(id_azienda);
				referente.setNome_azienda(cl.getNome());
				
				List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				if(listaSedi== null) {
					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
				}
				
				SedeDTO sd =null;
				if(!id_sede.equals("0")) {
					referente.setId_sede(Integer.parseInt(id_sede.split("_")[0]));
					sd = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, Integer.parseInt(id_sede.split("_")[0]), Integer.parseInt(id_azienda));
					referente.setNome_sede(sd.getDescrizione() + " - "+sd.getIndirizzo() +" - " + sd.getComune() + " - ("+ sd.getSiglaProvincia()+")");
				}else {
					referente.setNome_sede("Non associate");
				}
				
				session.update(referente);				

				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Referente salvato con successo!");
				out.print(myObj);
				session.getTransaction().commit();
				session.close();	
				
				
			}
			
			else if(action.equals("referenti_corso")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				String id_corso = request.getParameter("id_corso");
				ForCorsoDTO corso = GestioneFormazioneBO.getCorsoFromId(Integer.parseInt(id_corso), session);
				
				Gson g = new Gson();
				
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.add("lista_referenti_corso",  g.toJsonTree(corso.getListaReferenti()));
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
				
			}
			
			else if(action.equals("associa_dissocia_referente")) {
				
				ajax = true;
				
				String id_referente = request.getParameter("id_referente");
				String id_corso = request.getParameter("id_corso");
				String azione = request.getParameter("azione");
				
				ForReferenteDTO referente = GestioneFormazioneBO.getReferenteFromID(Integer.parseInt(id_referente), session);
				ForCorsoDTO corso = GestioneFormazioneBO.getCorsoFromId(Integer.parseInt(id_corso), session);
				
				if(azione.equals("associa")) {
					corso.getListaReferenti().add(referente);
				}else {
					corso.getListaReferenti().remove(referente);
				}
				
				session.update(corso);
				
				request.getSession().setAttribute("corso", corso);
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				out.print(myObj);
				session.getTransaction().commit();
				session.close();	
				
			}
			
			else if(action.equals("invia_comunicazione")) {				
				
				ajax = true;
				
				String id_corso = request.getParameter("id_corso");
				String indirizzi = request.getParameter("indirizzi");
				
				ForCorsoDTO corso = GestioneFormazioneBO.getCorsoFromId(Integer.parseInt(id_corso), session);
				
				 String dest_rendicontazione = "segreteria@crescosrl.net";
		    	  
		    	 SendEmailBO.sendEmailFormazione(corso, dest_rendicontazione, request.getServletContext());
		    	  
				String[] destinatari = indirizzi.split(";"); 
			      
			      for (String dest : destinatari) {
				
			    	  SendEmailBO.sendEmailFormazione(corso, dest.replaceAll(" ", ""), request.getServletContext());
			    	  ForEmailDTO email = new ForEmailDTO();
			    	  email.setCorso(corso);
			    	  email.setUtente(utente);
			    	  email.setData(new Timestamp(System.currentTimeMillis()));
			    	  email.setDestinatario(dest);
			    	  
			    	  session.save(email);
			    	  corso.setScheda_consegna_inviata(1);
			    	  session.update(corso);
			    /*	  
			    	  String dest_rendicontazione = "segreteria@crescosrl.net";
			    	  
			    	  SendEmailBO.sendEmailFormazione(corso, dest_rendicontazione, request.getServletContext());
			    	  ForEmailDTO email_conf = new ForEmailDTO();
			    	  email_conf.setCorso(corso);
			    	  email_conf.setUtente(utente);
			    	  email_conf.setData(new Timestamp(System.currentTimeMillis()));
			    	  email_conf.setDestinatario(dest_rendicontazione);
			    	  */
			      }
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Scheda di consegna inviata con successo!");
				out.print(myObj);
				session.getTransaction().commit();
				session.close();	
				
			}
			else if(action.equals("storico_email")) {
				String id_corso = request.getParameter("id_corso");
				String attestato = request.getParameter("attestato");
				
				
				ArrayList<ForEmailDTO> lista_email = GestioneFormazioneBO.getStoricoEmail(Integer.parseInt(id_corso),Integer.parseInt(attestato),session);
				
				
				request.getSession().setAttribute("lista_email", lista_email);
				
				session.getTransaction().commit();
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaForEmailCorso.jsp");
		     	dispatcher.forward(request,response);
			}
			else if(action.equals("update_nota_partecipante")) {
				
				String id_partecipante = request.getParameter("id_partecipante");
				String nota = request.getParameter("nota");
				
				ForPartecipanteDTO partecipante = (ForPartecipanteDTO) request.getSession().getAttribute("partecipante");
				if(partecipante == null) {
					partecipante = GestioneFormazioneBO.getPartecipanteFromId(Integer.parseInt(id_partecipante), session);
				}
				partecipante.setNote(nota);
				
				session.update(partecipante);
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Nota inserita con successo!");
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
				
			}
			else if(action.equals("consuntivo_docente")) {
				
				String dateFrom = request.getParameter("dateFrom");
				String dateTo = request.getParameter("dateTo");	
				String id_docente = request.getParameter("docente");
				String pianificazione = request.getParameter("pianificazione");	
				
				
				RequestDispatcher dispatcher = null;
				
				if(pianificazione!=null && pianificazione.equals("1")) {
					
					ArrayList<ForPiaPianificazioneDTO> lista_pianificazioni = GestioneFormazioneBO.getListaPianificazioniDocente(dateFrom, dateTo, Integer.parseInt(id_docente), session);
					request.getSession().setAttribute("lista_pianificazioni", lista_pianificazioni);
					dispatcher = getServletContext().getRequestDispatcher("/site/consuntivoDocentePianificazione.jsp");
					
				}else {
					ArrayList<ForCorsoDTO> lista_corsi_docente =  GestioneFormazioneBO.getListaCorsiDocente(dateFrom, dateTo, Integer.parseInt(id_docente), session);
					request.getSession().setAttribute("lista_corsi", lista_corsi_docente);
					dispatcher = getServletContext().getRequestDispatcher("/site/consuntivoDocenteFormazione.jsp");
				}
				
				
				
				
				request.getSession().setAttribute("dateFrom", dateFrom);
				request.getSession().setAttribute("dateTo", dateTo);
			
								
				session.getTransaction().commit();
				session.close();
				
				
		     	dispatcher.forward(request,response);
				
			}
			else if(action.equals("download_template_questionari")) {
				
			
				String path = Costanti.PATH_FOLDER+"//Formazione//Questionari//template_questionari_regionali.xlsx";
				response.setContentType("application/octet-stream");	
				response.setHeader("Content-Disposition","attachment;filename=template_questionari_regionali.xlsx");
				downloadFile(path, response.getOutputStream());
				
				
				session.getTransaction().commit();
				session.close();
			}
			
			else if(action.equals("carica_file_questionari")) {
				
				
				ajax=true;
			
				ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
				String filename="";
				response.setContentType("application/json");
				PrintWriter writer = response.getWriter();
				List<FileItem> items = uploadHandler.parseRequest(request);
				for (FileItem item : items) {
					if (!item.isFormField()) {

						saveFile(item, "temp//",item.getName());
						filename=item.getName();					
						
					}
			
				}
				myObj = GestioneFormazioneBO.compilaExcelQuestionario(filename);
			
				PrintWriter  out = response.getWriter();
			
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
			}
			
			else if(action.equals("gestione_questionari")) {			
				
				
				session.getTransaction().commit();
				session.close();
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneQuestionari.jsp");
		     	dispatcher.forward(request,response);
				
			}
			else if(action.equals("upload_consuntivo_questionari")) {
				
				ajax=true;
				
				ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());

				response.setContentType("application/json");
				PrintWriter writer = response.getWriter();
				List<FileItem> items = uploadHandler.parseRequest(request);
				
				
				
				for (FileItem item : items) {
					if (!item.isFormField()) {

						saveFile(item, "Questionari//","template_questionari_regionali.xlsx");
							
						
					}
								
				}
							
				PrintWriter  out = response.getWriter();
			
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "File caricato con successo!");
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
				
				
			}
			
				else if(action.equals("gestione_pianificazione")) 
				{
					
					
//					ArrayList<ForPiaPianificazioneDTO> pia = GestioneFormazioneBO.getListaPianificazioni(2023+"",null, session);
//					for (ForPiaPianificazioneDTO forPiaPianificazioneDTO : pia) {
//						forPiaPianificazioneDTO.setDescrizione(forPiaPianificazioneDTO.getNote());
//						session.update(forPiaPianificazioneDTO);
//					}
					
					String anno = request.getParameter("anno");
					String commesse = request.getParameter("commesse");
					String data_inizio = request.getParameter("data_inizio");
					String move = request.getParameter("move");
				
					String cellCopy = request.getParameter("cellCopy");
										
					if(anno==null) {
						anno = ""+Calendar.getInstance().get(Calendar.YEAR);
					}
						
					boolean soloAperte = true;
					if(commesse!=null && !commesse.equals("0")) {
						soloAperte = false;
					}
					ArrayList<CommessaDTO> lista_commesse = GestioneCommesseDAO.getListaCommesseFormazione(company, "FES;FCS", utente, 0, soloAperte);
					if(commesse!=null && commesse.equals("1")) {
						ArrayList<CommessaDTO> lista_commesse_chiuse = new ArrayList<CommessaDTO>();
						for (CommessaDTO commessaDTO : lista_commesse) {
							if(commessaDTO.getSYS_STATO().equals("1CHIUSA")) {
								lista_commesse_chiuse.add(commessaDTO);
							}
						}
						lista_commesse = lista_commesse_chiuse;
					}
					
					ArrayList<ForDocenteDTO> lista_docenti = GestioneFormazioneBO.getListaDocenti(session);
					ArrayList<ForPiaStatoDTO> lista_stati = GestioneFormazioneBO.getListaStati(session);
					ArrayList<ForPiaTipoDTO> lista_tipi = GestioneFormazioneBO.getListaTipi(session);
					ArrayList<ForCorsoDTO> lista_corsi = GestioneFormazioneBO.getListaCorsi(session);
					
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
						if(meseCorrente == 0) {
							meseCorrente = 1;
						}
						mesePrecedente = meseCorrente;
					}
					
					
					LocalDate inizioBimestre = LocalDate.of(dataCorrente.getYear(), mesePrecedente, 1);
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
			        
			        
//					int daysNumber = 365;
//					if(LocalDate.ofYearDay(Integer.parseInt(anno), 1).isLeapYear()) {
//						daysNumber = 366;
//					}
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
				 
				 
					request.getSession().setAttribute("lista_commesse", lista_commesse);			
					request.getSession().setAttribute("lista_docenti", lista_docenti);
					request.getSession().setAttribute("lista_tipi", lista_tipi);
					request.getSession().setAttribute("lista_stati", lista_stati);
					//request.getSession().setAttribute("today", LocalDate.now().getDayOfYear());
					request.getSession().setAttribute("today", today);
					request.getSession().setAttribute("anno", Integer.parseInt(anno));
					request.getSession().setAttribute("daysNumber", daysNumber);
					request.getSession().setAttribute("festivitaItaliane", festivitaItaliane);
					request.getSession().setAttribute("commesse", commesse);
					request.getSession().setAttribute("start_date", start_date);
					request.getSession().setAttribute("end_date", end_date);
					request.getSession().setAttribute("filtro_tipo_pianificazioni", 0);
					request.getSession().setAttribute("cellCopy", cellCopy);
					request.getSession().setAttribute("lista_corsi", lista_corsi);
					
					session.getTransaction().commit();
					session.close();
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestionePianificazione.jsp");
			     	dispatcher.forward(request,response);
			     	
						
				}
			
				else if(action.equals("nuova_pianificazione")) {
					
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
					
					String id_docenti = ret.get("id_docenti");
					String id_docenti_dissocia = ret.get("id_docenti_dissocia");
					String stato = ret.get("stato");
					String tipo = ret.get("tipo");
					String nota = ret.get("nota");
					String day = ret.get("day");
					String id_commessa = ret.get("commessa");
					String id_pianificazione = ret.get("id_pianificazione");
					String ora_inizio = ret.get("ora_inizio");
					String ora_fine = ret.get("ora_fine");
					String n_utenti = ret.get("n_utenti");
					String check_mail = ret.get("check_mail");
					String check_agenda = ret.get("check_agenda");
					String check_pausa_pranzo = ret.get("check_pausa_pranzo");
					String descrizione = ret.get("descrizione");
					String durata_pausa_pranzo = ret.get("durata_pausa_pranzo");
					String anno_data = ret.get("anno_data");
					String check_nuovo_corso = ret.get("check_nuovo_corso");
					String check_corso_esistente = ret.get("check_corso_esistente");
					String id_corso_esistente = ret.get("id_corso_esistente");
					
					ForPiaPianificazioneDTO pianificazione = null;
					if(id_pianificazione!=null && !id_pianificazione.equals("")) {
						pianificazione = GestioneFormazioneBO.getPianificazioneFromId(Integer.parseInt(id_pianificazione), session);
						if(pianificazione.getStato().getId()!=Integer.parseInt(stato) || pianificazione.getData_cambio_stato()==null) {
							pianificazione.setData_cambio_stato(new Date());
						}
					}else {
						pianificazione = new ForPiaPianificazioneDTO();
						pianificazione.setData_cambio_stato(new Date());
					}
					
					
					pianificazione.setStato(new ForPiaStatoDTO(Integer.parseInt(stato), ""));
					
					pianificazione.setTipo(new ForPiaTipoDTO(Integer.parseInt(tipo), ""));
					pianificazione.setNote(nota);
					pianificazione.setDescrizione(descrizione);
					pianificazione.setId_commessa(id_commessa);
				
					pianificazione.setOra_inizio(ora_inizio);
					pianificazione.setOra_fine(ora_fine);
					pianificazione.setPausa_pranzo(check_pausa_pranzo);
					pianificazione.setDurata_pausa_pranzo(durata_pausa_pranzo);
					if(n_utenti!=null && !n_utenti.equals("")) {
						pianificazione.setnUtenti(Integer.parseInt(n_utenti));
					}
					int anno = 0;
					if(anno_data!=null && !anno_data.equals("")) {
						anno = Integer.parseInt(anno_data);
					}else {
						anno = (int) request.getSession().getAttribute("anno");
					}
					
					LocalDate localDate = null;
					if(Integer.parseInt(day)>366 && LocalDate.ofYearDay(anno, 1).isLeapYear()) {
						anno = anno+1;
						localDate = LocalDate.ofYearDay(anno, (Integer.parseInt(day)-366));
						pianificazione.setnCella(Integer.parseInt(day)-366);
						
					}else if(Integer.parseInt(day)>365 && !LocalDate.ofYearDay(anno, 1).isLeapYear()) {
						anno = anno+1;
						localDate = LocalDate.ofYearDay(anno, (Integer.parseInt(day)-365));
						pianificazione.setnCella(Integer.parseInt(day)-365);
					}else {
						localDate = LocalDate.ofYearDay(anno, Integer.parseInt(day));
						pianificazione.setnCella(Integer.parseInt(day));
					}
					
			        
			        LocalDateTime localDateTime = localDate.atStartOfDay();
			        Date date = Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant());
					
					pianificazione.setData(date);
					
//					if(stato.equals("4")) {
//						
//						localDateTime = localDate.plusWeeks(1).atStartOfDay();
//						pianificazione.setData_reminder(Date.from(localDateTime.atZone(ZoneId.systemDefault()).toInstant()));
//					}else {
//						pianificazione.setData_reminder(null);
//					}
				
					if(id_docenti!=null && !id_docenti.equals("")) {
			
						for (String id : id_docenti.split(";")) {
							ForDocenteDTO docente = GestioneFormazioneBO.getDocenteFromId(Integer.parseInt(id), session);
							docente.setFase(ret.get("select_fasi_"+id));
							pianificazione.getListaDocenti().add(docente);							
							
							
						}
						
										
					}
					
					if(id_docenti_dissocia!=null && !id_docenti_dissocia.equals("")) {
						for (String id : id_docenti_dissocia.split(";")) {
							
							pianificazione.getListaDocenti().remove(GestioneFormazioneBO.getDocenteFromId(Integer.parseInt(id), session));
							
						}
						
										
					}
					
					
					
					CommessaDTO commessa = GestioneCommesseDAO.getCommessaById(id_commessa);
					
					if(check_mail!=null && check_mail.equals("1")) {
						SendEmailBO.sendEmailPianificazione(pianificazione, commessa, request.getServletContext());
						pianificazione.setEmail_inviata(1);
					}
					
					if(check_agenda!=null && check_agenda.equals("1")) {
						for (ForDocenteDTO docente : pianificazione.getListaDocenti()) {
							if(docente.getUtenteMilestone()!=null && !docente.getUtenteMilestone().equals("")) {
								AgendaMilestoneDTO agenda = new AgendaMilestoneDTO();
								agenda.setUSERNAME(docente.getUtenteMilestone());
								agenda.setSTATO(1);
								agenda.setSOGGETTO("Commessa: "+commessa.getID_COMMESSA()+" Cliente: "+commessa.getID_ANAGEN_NOME());
								//agenda.setNOTA(pianificazione.getDescrizione() +" - "+ nota +" - Commessa: "+commessa.getID_COMMESSA()+" Cliente: "+commessa.getID_ANAGEN_NOME());
								agenda.setNOTA(nota);
								agenda.setDESCRIZIONE(pianificazione.getDescrizione());
								agenda.setLABEL(3);
								Calendar calendar = Calendar.getInstance();
								if(ora_inizio!=null && !ora_inizio.equals("")) {
									calendar.set(localDate.getYear(), localDate.getMonthValue()-1,localDate.getDayOfMonth(), Integer.parseInt(ora_inizio.split(":")[0]), Integer.parseInt(ora_inizio.split(":")[1]));
								}else {
									calendar.set(localDate.getYear(), localDate.getMonthValue()-1,localDate.getDayOfMonth());
								}
								
								agenda.setSTARTDATE(calendar.getTime());
								//calendar.set(2023, Calendar.JUNE, 28, 13, 0, 0);
								if(ora_fine!=null && !ora_fine.equals("")) {
									calendar.set(localDate.getYear(), localDate.getMonthValue()-1,localDate.getDayOfMonth(), Integer.parseInt(ora_fine.split(":")[0]), Integer.parseInt(ora_fine.split(":")[1]));
								}else {
									calendar.set(localDate.getYear(), localDate.getMonthValue()-1,localDate.getDayOfMonth());
								}
								agenda.setENDTDATE(calendar.getTime());
								
								
								agenda.setFASE("BWT_COMMESSA_FASI~|~AM_TSC_0118/25~|~"+docente.getFase());
							//	CommessaDTO commessa_fissa = GestioneCommesseDAO.getCommessaById(id_commessa);
								agenda.setID_ANAGEN(1428); //N.C.S
								agenda.setID_COMMESSA("AM_TSC_0118/25");
								int idAgendaMilestone =GestioneAssegnazioneAttivitaBO.inserisciAppuntamento(agenda);
								pianificazione.setIdAgendaMilestone(idAgendaMilestone);
							}
						}
						
						pianificazione.setAggiunto_agenda(1);
					}
					
					
					if(check_nuovo_corso!=null && check_nuovo_corso.equals("1")) {
						
						ForCorsoDTO corso = new ForCorsoDTO();
						
						corso.setCommessa(pianificazione.getId_commessa());
						corso.setDescrizione(pianificazione.getDescrizione());
						Set<ForDocenteDTO> docenti = new HashSet<ForDocenteDTO>();
						docenti.addAll(pianificazione.getListaDocenti());
						corso.setListaDocenti(docenti);
						corso.setData_corso(pianificazione.getData());
						if(pianificazione.getTipo().getId()==3) {
							corso.setE_learning(1);
						}
					
						session.save(corso);
						pianificazione.setId_corso(corso.getId());
						
						Gson g = new Gson();
						myObj.add("corso_aggiunto", g.toJsonTree(corso));
						 
					}
					if(check_corso_esistente!=null && check_corso_esistente.equals("1")) {
						
						pianificazione.setId_corso(Integer.parseInt(id_corso_esistente));
						
					}
					
					
					session.saveOrUpdate(pianificazione);
					session.getTransaction().commit();
					session.close();
					
					PrintWriter out = response.getWriter();
					myObj.addProperty("success", true);
					
					myObj.addProperty("messaggio", "Pianificazione salvata con successo!");
		        	out.print(myObj);
				}
				else if(action.equals("dettaglio_pianificazione")) {
					
					ajax = true;
					String id = request.getParameter("id");
			
					ForPiaPianificazioneDTO pianificazione = GestioneFormazioneBO.getPianificazioneFromId(Integer.parseInt(id), session);
					
					
					Gson g = new Gson();
					session.getTransaction().commit();
					session.close();
					
					PrintWriter out = response.getWriter();
					myObj.addProperty("success", true);
					myObj.add("pianificazione", g.toJsonTree(pianificazione));
		        	out.print(myObj);
					
				}
				else if(action.equals("elimina_pianificazione")) {
				
					ajax = true;
					String id_pianificazione = request.getParameter("id_pianificazione");
					String check_email_eliminazione = request.getParameter("check_email_eliminazione");
				
					
					ForPiaPianificazioneDTO pianificazione =  GestioneFormazioneBO.getPianificazioneFromId(Integer.parseInt(id_pianificazione), session);
					
					if(pianificazione.getIdAgendaMilestone()!=0) 
					{
						GestioneAssegnazioneAttivitaBO.eliminaAppuntamento(pianificazione.getIdAgendaMilestone());
					}
					
					if(check_email_eliminazione!=null && check_email_eliminazione.equals("1")) {
						SendEmailBO.sendEmailEliminaPianificazione(pianificazione, request.getServletContext());	
					}
					
					
					session.delete(pianificazione);

					session.getTransaction().commit();
					session.close();
					PrintWriter out = response.getWriter();
					myObj.addProperty("success", true);
					myObj.addProperty("messaggio", "Pianificazione eliminata con successo!");
		        	out.print(myObj);
		        	
				}
			
				else if(action.equals("lista_pianificazioni")) {
					
					
					String dateFrom = request.getParameter("dateFrom");
					String dateTo = request.getParameter("dateTo");
					
					if(dateFrom == null && dateTo == null) {
						DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
						
						Date today = new Date();
						
						Calendar cal = Calendar.getInstance();
						cal.setTime(today);
						
						cal.add(Calendar.DATE, -30);
						Date startDate = cal.getTime();
						
						
						dateFrom = df.format(startDate);
						
						cal.add(Calendar.DATE, 60);
						
						dateTo = df.format(cal.getTime());
						
						
					}
					
					ArrayList<ForPiaPianificazioneDTO> lista_pianificazioni = GestioneFormazioneBO.getListaPianificazioniData(dateFrom, dateTo, session);
					
					for (ForPiaPianificazioneDTO pianificazione : lista_pianificazioni) {
						
						if(pianificazione.getStato().getId() == 5) {
							pianificazione.setAttestati_presenti(0);
							if(pianificazione.getId_corso()!=null) {
								ForCorsoDTO corso = GestioneFormazioneBO.getCorsoFromId(pianificazione.getId_corso(), session);
								ArrayList<ForPartecipanteRuoloCorsoDTO> lista_partecipanti = GestioneFormazioneBO.getListaPartecipantiCorso(corso.getId(), session);
								for (ForPartecipanteRuoloCorsoDTO p : lista_partecipanti) {
									if(p.getAttestato()!=null && !p.getAttestato().equals("")) {
										pianificazione.setAttestati_presenti(1);
										break;
									}
								}
							}
						}
					}
					
					
					request.getSession().setAttribute("lista_pianificazioni", lista_pianificazioni);
					
					request.getSession().setAttribute("dateTo", dateTo);
					request.getSession().setAttribute("dateFrom", dateFrom);
					
					session.getTransaction().commit();
					session.close();
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaPianificazioni.jsp");
			     	dispatcher.forward(request,response);
			     	
					
				}
			
			
				else if(action.equals("cambia_stato_pianificazione")) {
			
					ajax = true;
					
					String id = request.getParameter("id");
					String stato = request.getParameter("stato");
					
					ForPiaPianificazioneDTO pianificazione = GestioneFormazioneBO.getPianificazioneFromId(Integer.parseInt(id), session);
					
					String descrizione = "NON CONFERMATO"; 
					if(stato.equals("2")) {
						descrizione = "CONFERMATO";
					}else if(stato.equals("3")) {
						descrizione = "EROGATO";
					}else if(stato.equals("4")) {
						descrizione = "FATTURATO SENZA ATTESTATI";
					}else if(stato.equals("5")) {
						descrizione = "COMPLETATO";
					}else if(stato.equals("6")) {
						descrizione = "ATTESTATI SENZA FATTURA";
					}
					
					
					pianificazione.setAttestati_presenti(0);
					if(Integer.parseInt(stato) == 5) {
						if(pianificazione.getId_corso()!=null) {
							ForCorsoDTO corso = GestioneFormazioneBO.getCorsoFromId(pianificazione.getId_corso(), session);
							ArrayList<ForPartecipanteRuoloCorsoDTO> lista_partecipanti = GestioneFormazioneBO.getListaPartecipantiCorso(corso.getId(), session);
							for (ForPartecipanteRuoloCorsoDTO p : lista_partecipanti) {
								if(p.getAttestato()!=null && !p.getAttestato().equals("")) {
									pianificazione.setAttestati_presenti(1);
									break;
								}
							}
						}
					}
					
					
					PrintWriter out = response.getWriter();
//					if(Integer.parseInt(stato) == 5 && !attestati_presenti) {
//						
//						
//						myObj.addProperty("success", false);
//						myObj.addProperty("messaggio", "Attenzione! Sul corso associato alla pianificazione non risultano attestati presenti!");
//			        	
//					}else {
						pianificazione.setStato(new ForPiaStatoDTO(Integer.parseInt(stato),descrizione));
						
						session.update(pianificazione);
						
						
						
						
						Gson g = new Gson();
						
						myObj.addProperty("success", true);
						myObj.add("pianificazione", g.toJsonTree(pianificazione));
			        	
//					}
					
					
					out.print(myObj);
					
		        	session.getTransaction().commit();
					session.close();
				}
			
				else if(action.equals("gestione_conf_email")) {
					
					ajax = false;
					
					ArrayList<ForConfInvioEmailDTO> lista_configurazioni = GestioneFormazioneBO.getListaConfigurazioniInvioEmail(session);
					ArrayList<ForCorsoMoodleDTO> lista_corsi_moodle = GestioneFormazioneBO.getListaCorsiInvioEmail();
									
					
					
					request.getSession().setAttribute("lista_configurazioni", lista_configurazioni);
					request.getSession().setAttribute("lista_corsi_moodle", lista_corsi_moodle);
					
					session.getTransaction().commit();
					session.close();
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaConfigurazioniInvioEmail.jsp");
			     	dispatcher.forward(request,response);
					
				}
				else if(action.equals("gruppi_corso")) {
					
					
					ajax = true;
					
					String id_corso = request.getParameter("corso");
					
					ArrayList<ForGruppoMoodleDTO> lista_gruppi = GestioneFormazioneBO.getGruppiFromCorso(Integer.parseInt(id_corso));
					
					Gson g = new Gson();
					
				
					PrintWriter out = response.getWriter();
					
				
					
					myObj.addProperty("success", true);
					myObj.add("gruppi", g.toJsonTree(lista_gruppi));
					request.getSession().setAttribute("lista_gruppi_moodle", lista_gruppi);
		        	out.print(myObj);
		        	session.getTransaction().commit();
					session.close();
					
				}
			
			
				else if(action.equals("membri_gruppo")) {
					
					
					ajax = true;
					
					String id_gruppo = request.getParameter("gruppo");
					String id_corso = request.getParameter("corso");
					
					ArrayList<ForMembriGruppoDTO> lista_membri_gruppo = GestioneFormazioneBO.getMembriGruppo(Integer.parseInt(id_gruppo), Integer.parseInt(id_corso));
					ArrayList<ForMembriGruppoDTO> lista_membri_nc = GestioneFormazioneDAO.getListaUtentiNonCompleti(Integer.parseInt(id_corso), Integer.parseInt(id_gruppo));
					
					Gson g = new Gson();
					
				
					PrintWriter out = response.getWriter();
					
				
					
					myObj.addProperty("success", true);
					myObj.add("membri", g.toJsonTree(lista_membri_gruppo));
					myObj.add("membri_nc", g.toJsonTree(lista_membri_nc));
		        	out.print(myObj);
		        	session.getTransaction().commit();
					session.close();
					
				}
			
				else if(action.equals("nuova_configurazione_invio")) {
					
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
					
					String id_corso = ret.get("corsi");
					String id_gruppo = ret.get("gruppi");
					String frequenza = ret.get("frequenza");
					String data_inizio_invio = ret.get("data_inizio_invio");
					String data_prossimo_invio = ret.get("data_prossimo_invio");
					String data_scadenza = ret.get("data_scadenza");
					String oggetto_email = ret.get("oggetto_email");
					String testo_email = ret.get("testo_email");
					String report_vittoria=ret.get("report_vittoria");
					
				
					
					ArrayList<ForCorsoMoodleDTO> lista_corsi_moodle = (ArrayList<ForCorsoMoodleDTO>) request.getSession().getAttribute("lista_corsi_moodle");
					ArrayList<ForGruppoMoodleDTO> lista_gruppi_moodle = (ArrayList<ForGruppoMoodleDTO>) request.getSession().getAttribute("lista_gruppi_moodle");
					ForConfInvioEmailDTO configurazione = new ForConfInvioEmailDTO();
					configurazione.setId_corso(Integer.parseInt(id_corso));
					
					
					for (ForCorsoMoodleDTO corso : lista_corsi_moodle) {
					    if (corso.getId() == Integer.parseInt(id_corso)) {
					        configurazione.setDescrizione_corso(corso.getDescrizione());
					    }
					}		
					
					if(id_gruppo!=null && !id_gruppo.equals("") && !id_gruppo.equals("0")) {
						configurazione.setId_gruppo(Integer.parseInt(id_gruppo));
						for (ForGruppoMoodleDTO gruppo : lista_gruppi_moodle) {
						    if (gruppo.getId() == Integer.parseInt(id_gruppo)) {
						        configurazione.setDescrizione_gruppo(gruppo.getDescrizione());
						    }
						}
					}else {
						configurazione.setId_gruppo(0);
						configurazione.setDescrizione_gruppo("Nessun gruppo specificato");
					}
					
					configurazione.setOggetto_email(oggetto_email);
					configurazione.setTesto_email(testo_email);
					DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
					
					configurazione.setFrequenza_invio(Integer.parseInt(frequenza));
					configurazione.setData_inizio_invio(df.parse(data_inizio_invio));
					if(df.parse(data_prossimo_invio).equals(new Date()) || df.parse(data_prossimo_invio).before(new Date())) {
						Calendar calendar = Calendar.getInstance();
						calendar.add(Calendar.DAY_OF_YEAR, 1);

								
						configurazione.setData_prossimo_invio(calendar.getTime());
					}else {
						configurazione.setData_prossimo_invio(df.parse(data_prossimo_invio));
					}
					
					
					if(data_scadenza!=null && !data_scadenza.equals("")) {
						configurazione.setData_scadenza(df.parse(data_scadenza));
					}
					
					if(report_vittoria!=null) 
					{
						configurazione.setReport_vittoria(1);
					}
					else 
					{
						configurazione.setReport_vittoria(0);
					}
					
					session.save(configurazione);
					session.getTransaction().commit();
					session.close();
					
					PrintWriter out = response.getWriter();
					
					myObj.addProperty("success", true);
					myObj.addProperty("messaggio", "Configurazione salvata con successo!");
					
		        	out.print(myObj);
		        
					
				}
			
				else if(action.equals("modifica_configurazione_invio")) {
					
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
					
			        String id_configurazione = ret.get("id_configurazione");
					String id_corso = ret.get("corsi_mod");
					String id_gruppo = ret.get("gruppi_mod");
					String frequenza = ret.get("frequenza_mod");
					String data_inizio_invio = ret.get("data_inizio_invio_mod");
					String data_prossimo_invio = ret.get("data_prossimo_invio_mod");
					String data_scadenza = ret.get("data_scadenza_mod");
					String oggetto_email = ret.get("oggetto_email_mod");
					String testo_email = ret.get("testo_email_mod");
					String report_vittoria=ret.get("report_vittoria_mod");
				
					ArrayList<ForCorsoMoodleDTO> lista_corsi_moodle = (ArrayList<ForCorsoMoodleDTO>) request.getSession().getAttribute("lista_corsi_moodle");
					ArrayList<ForGruppoMoodleDTO> lista_gruppi_moodle = (ArrayList<ForGruppoMoodleDTO>) request.getSession().getAttribute("lista_gruppi_moodle");
					ForConfInvioEmailDTO configurazione = GestioneFormazioneBO.getConfigurazioneInvioEmail(Integer.parseInt(id_configurazione),session);
					configurazione.setId_corso(Integer.parseInt(id_corso));
					
					for (ForCorsoMoodleDTO corso : lista_corsi_moodle) {
					    if (corso.getId() == Integer.parseInt(id_corso)) {
					        configurazione.setDescrizione_corso(corso.getDescrizione());
					    }
					}		
					
					
					
					if(id_gruppo!=null && !id_gruppo.equals("") && !id_gruppo.equals("0")) {
						configurazione.setId_gruppo(Integer.parseInt(id_gruppo));
						for (ForGruppoMoodleDTO gruppo : lista_gruppi_moodle) {
						    if (gruppo.getId() == Integer.parseInt(id_gruppo)) {
						        configurazione.setDescrizione_gruppo(gruppo.getDescrizione());
						    }
						}
					}else {
						configurazione.setId_gruppo(0);
						configurazione.setDescrizione_gruppo("Nessun gruppo specificato");
					}
					
					DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
					
					configurazione.setOggetto_email(oggetto_email);
					configurazione.setTesto_email(testo_email);
					configurazione.setFrequenza_invio(Integer.parseInt(frequenza));
					configurazione.setData_inizio_invio(df.parse(data_inizio_invio));
					configurazione.setReport_vittoria(Integer.parseInt(report_vittoria));
					
					if(df.parse(data_prossimo_invio).equals(new Date()) || df.parse(data_prossimo_invio).before(new Date())) {
						Calendar calendar = Calendar.getInstance();
						calendar.add(Calendar.DAY_OF_YEAR, 1);

								
						configurazione.setData_prossimo_invio(calendar.getTime());
					}else {
						configurazione.setData_prossimo_invio(df.parse(data_prossimo_invio));
					}
					if(data_scadenza!=null && !data_scadenza.equals("")) {
						configurazione.setData_scadenza(df.parse(data_scadenza));
						if(df.parse(data_scadenza).after(new Date())) {
							configurazione.setStato_invio(0);
						}
					}else {
						configurazione.setData_scadenza(null);
					}
					session.update(configurazione);
					session.getTransaction().commit();
					session.close();
					
					PrintWriter out = response.getWriter();
					
					
					myObj.addProperty("success", true);
					myObj.addProperty("messaggio", "Configurazione salvata con successo!");
					
		        	out.print(myObj);
		        
					
				}else if(action.equals("elimina_configurazione")) {
					
					ajax = true;
					
					String id = request.getParameter("id_configurazione_elimina");
					
					ForConfInvioEmailDTO configuraizone = GestioneFormazioneBO.getConfigurazioneInvioEmail(Integer.parseInt(id), session);
					configuraizone.setDisabilitato(1);
					
					session.update(configuraizone);
					session.getTransaction().commit();
					session.close();
					
					PrintWriter out = response.getWriter();
					
					
					myObj.addProperty("success", true);
					myObj.addProperty("messaggio", "Configurazione eliminata con successo!");
					
		        	out.print(myObj);
					
				}
				else if(action.equals("lista_fasi")) {
					
					ajax = true;
					
					String id_docenti = request.getParameter("id_docenti");
					
					String docenti = "";
					if(id_docenti!=null && !id_docenti.equals("")) {
						for (String id : id_docenti.split(";")) {
							ForDocenteDTO docente = GestioneFormazioneBO.getDocenteFromId(Integer.parseInt(id), session);
							docenti += docente.getUtenteMilestone()+";";							
						}						
										
					}
					
					
					HashMap<String,ArrayList<String>> lista_fasi = GestioneAssegnazioneAttivitaBO.getListaFasiCommessa(docenti,id_docenti);
					
					
					Gson g = new Gson();
					
					
					session.getTransaction().commit();
					session.close();
					
					PrintWriter out = response.getWriter();
					
					
					myObj.addProperty("success", true);
					myObj.add("lista_fasi", g.toJsonTree(lista_fasi));
					
		        	out.print(myObj);
					
				}
			
				else if(action.equals("ore_fatturate")) {
					
					ajax = true;
									
					String id_pianificazione = request.getParameter("id_pianificazione");
					String value = request.getParameter("value");
					
					ForPiaPianificazioneDTO pianificazione = GestioneFormazioneBO.getPianificazioneFromId(Integer.parseInt(id_pianificazione), session);
					pianificazione.setOre_fatturate(Integer.parseInt(value));			
					session.update(pianificazione);

					myObj = new JsonObject();
					PrintWriter  out = response.getWriter();
					
					myObj.addProperty("success", true);
					
					out.print(myObj);
					session.getTransaction().commit();
					session.close();
				}		
				else if(action.equals("associaEmail")) 
				{ 
					
					
					// Costruisci JSON
					    response.setContentType("application/json");
					    response.setCharacterEncoding("UTF-8");

					    Map<String, String> dati = new HashMap<>();
					    
					    String idCorso = request.getParameter("id_corso");
					
					    ArrayList<ForPartecipanteRuoloCorsoDTO> listaPartecipanti =GestioneFormazioneBO.getListaPartecipantiCorso(Integer.parseInt(idCorso), session);
					    
					    
					    HashMap<String, String> listaEmailPartecipanti= GestioneFormazioneBO.listaCompletaEmailMoodle();
					    
					    
					    for (ForPartecipanteRuoloCorsoDTO partecipanteCorso : listaPartecipanti) {
							
					    	ForPartecipanteDTO partecipante=partecipanteCorso.getPartecipante();
					    	
					    	if(partecipante.getEmail()==null) 
					    	{
					    		String email= listaEmailPartecipanti.get(partecipante.getCf());
					    		
					    		if(email!=null) 
					    		{
					    			partecipante.setEmail(email);
					    			session.update(partecipante);
					    		}
					    	}
						}
					    
					    
					    Gson g = new GsonBuilder().setDateFormat("dd/MM/yyyy").create();
						
					     myObj = new JsonObject();
					     myObj.add("dati_indice", g.toJsonTree(dati));
						
						PrintWriter  out = response.getWriter();
						myObj.addProperty("success", true);
						
						session.getTransaction().commit();
						session.close();
						
						
						out.print(myObj); 
						out.flush();

				}		
				
					else if(action.equals("inviaEmail")) 
				{ 
					
						// Costruisci JSON
					    response.setContentType("application/json");
					    response.setCharacterEncoding("UTF-8");

					    Map<String, String> dati = new HashMap<>();
					    
					    String idCorso = request.getParameter("id_corso");
					    String id_partecipanti = request.getParameter("id_partecipanti");
					    
					    String errore = "";
					    String[] id = id_partecipanti.split(";");
					    ArrayList<String> inviati = new ArrayList<String>();
					    
					    for (int i = 0; i < id.length; i++) {
							if(!id[i].equals("")) {
					    	ForPartecipanteRuoloCorsoDTO p = GestioneFormazioneBO.getPartecipanteFromCorso(Integer.parseInt(idCorso), Integer.parseInt(id[i]), 0, session);
					    	
					    	 String result = SendEmailBO.sendEmailConsegnaAttestati(p);
					    	 if(!result.equals("")) {
					    		result+="<br>";
					    		errore +=result;
					    	 }else {
					    		 ForEmailDTO email = new ForEmailDTO();
						    	  email.setCorso(p.getCorso());
						    	  email.setUtente(utente);
						    	  email.setData(new Timestamp(System.currentTimeMillis()));
						    	  email.setDestinatario(p.getPartecipante().getEmail());
						    	  email.setAttestato(1);
						    	  session.save(email);
						    	  inviati.add(p.getPartecipante().getNome()+" "+p.getPartecipante().getCognome());
					    	 }
					    	 
					    						    	
					    	TimeUnit.SECONDS.sleep(2);
							}
						}
					
					    Gson g = new GsonBuilder().setDateFormat("dd/MM/yyyy").create();
						
					     myObj = new JsonObject();
					     myObj.add("dati_indice", g.toJsonTree(dati));
						
						PrintWriter  out = response.getWriter();
						
						
						if(errore.equals("")) {
							myObj.addProperty("success", true);
							myObj.addProperty("messaggio", "Email inviate con successo!");
						}else {
							myObj.addProperty("success", true);
							myObj.addProperty("errore", true);
							String messaggio = "";
							
							for (String string : inviati) {
								messaggio +="Email inviata correttamente per "+ string+"<br>";
							}
							
							myObj.addProperty("messaggio",messaggio+errore);	
						}
						
						
						session.getTransaction().commit();
						session.close();
						
						
						out.print(myObj); 
						out.flush();

				}
					else if(action.equals("aggiornaEmail")) 
					{ 
						
							// Costruisci JSON
						    response.setContentType("application/json");
						    response.setCharacterEncoding("UTF-8");

						    Map<String, String> dati = new HashMap<>();
						    
						    String idPartecipante = request.getParameter("id_partecipante");
						    String email=request.getParameter("email");
						    
						    ForPartecipanteDTO partecipante=GestioneFormazioneBO.getPartecipanteFromId(Integer.parseInt(idPartecipante), session);
						    
						    partecipante.setEmail(email);
						    session.update(partecipante);
						    
						    Gson g = new GsonBuilder().setDateFormat("dd/MM/yyyy").create();
							
						     myObj = new JsonObject();
						     myObj.add("dati_indice", g.toJsonTree(dati));
							
							PrintWriter  out = response.getWriter();
							myObj.addProperty("success", true);
							
							session.getTransaction().commit();
							session.close();
							
							
							out.print(myObj); 
							out.flush();

					}
					else if(action.equals("crea_qr")) {
						
						String id_corso = request.getParameter("id_corso");
						
						id_corso = Utility.decryptData(id_corso);
						
						createQRtoPDF(id_corso);
						
						downloadFile(Costanti.PATH_FOLDER+"\\Formazione\\QR\\"+id_corso+"\\qr.pdf", response.getOutputStream());
						
						response.setContentType("application/pdf");	
						
						session.close();
						
					}
					
			
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

		 	String path_folder = Costanti.PATH_FOLDER+"//Formazione//"+path+"//";
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
	 
//	 public static void createQR(String id_corso) throws Exception
//		{
//			byte[] bytesEncoded = Base64.encodeBase64((""+id_corso).getBytes());
//			System.out.println("encoded value is " + new String(bytesEncoded));
//
//			String myCodeText = "http://localhost:8080/AccPoint/downloadAttestatiFormazione.do?id_corso="+Utility.encryptData(id_corso);
//
//			String filePath =Costanti.PATH_FOLDER+"\\Formazione\\QR\\"+id_corso+"\\";
//			             
//			
//			int size=80;
//			
//
//			String fileType = "png";
//			File dir = new File(filePath);
//			if(!dir.exists()) {
//				dir.mkdirs();
//			}
//			File myFile = new File(filePath+"qr.png");
//			
//			try {
//
//				Map<EncodeHintType, Object> hintMap = new EnumMap<EncodeHintType, Object>(EncodeHintType.class);
//				hintMap.put(EncodeHintType.CHARACTER_SET, "UTF-8");
//
//				// Now with zxing version 3.2.1 you could change border size (white border size to just 1)
//				hintMap.put(EncodeHintType.MARGIN, 0); /* default = 4 */
//				hintMap.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.L);
//
//				QRCodeWriter qrCodeWriter = new QRCodeWriter();
//				BitMatrix byteMatrix = qrCodeWriter.encode(myCodeText, BarcodeFormat.QR_CODE, size,
//						size, hintMap);
//				int CrunchifyWidth = byteMatrix.getWidth();
//				BufferedImage image = new BufferedImage(CrunchifyWidth, CrunchifyWidth,
//						BufferedImage.TYPE_INT_RGB);
//				image.createGraphics();
//
//				Graphics2D graphics = (Graphics2D) image.getGraphics();
//				graphics.setColor(Color.WHITE);
//				graphics.fillRect(0, 0, CrunchifyWidth, CrunchifyWidth);
//				graphics.setColor(Color.BLACK);
//
//				for (int i = 0; i < CrunchifyWidth; i++) {
//					for (int j = 0; j < CrunchifyWidth; j++) {
//						if (byteMatrix.get(i, j)) {
//							graphics.fillRect(i, j, 1, 1);
//						}
//					}
//				}
//				ImageIO.write(image, fileType, myFile);
//			} catch (WriterException e) {
//				e.printStackTrace();
//			} catch (IOException e) {
//				e.printStackTrace();
//			}
//		}
	 
	 
	 

	    public static void createQRtoPDF(String id_corso) throws Exception {

	        // 1. Creo il contenuto del QR
	        String myCodeText = "http://localhost:8080/AccPoint/downloadAttestatiFormazione.do?id_corso="
	                + Utility.encryptData(id_corso);

	        // Percorsi
	        String filePath = Costanti.PATH_FOLDER + "\\Formazione\\QR\\" + id_corso + "\\";
	        String qrFile = filePath + "qr.png";
	        String pdfFile = filePath + "qr.pdf";

	        int size = 150;
	        String fileType = "png";
	        File dir = new File(filePath);
	        if (!dir.exists()) {
	            dir.mkdirs();
	        }

	        // 2. Genero QR code manualmente (senza MatrixToImageWriter)
	        Map<EncodeHintType, Object> hintMap = new EnumMap<>(EncodeHintType.class);
	        hintMap.put(EncodeHintType.CHARACTER_SET, "UTF-8");
	        hintMap.put(EncodeHintType.MARGIN, 1);
	        hintMap.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.L);

	        QRCodeWriter qrCodeWriter = new QRCodeWriter();
	        BitMatrix bitMatrix = qrCodeWriter.encode(myCodeText, BarcodeFormat.QR_CODE, size, size, hintMap);

	        int width = bitMatrix.getWidth();
	        BufferedImage image = new BufferedImage(width, width, BufferedImage.TYPE_INT_RGB);
	        Graphics2D graphics = image.createGraphics();
	        graphics.setColor(Color.WHITE);
	        graphics.fillRect(0, 0, width, width);
	        graphics.setColor(Color.BLACK);

	        for (int i = 0; i < width; i++) {
	            for (int j = 0; j < width; j++) {
	                if (bitMatrix.get(i, j)) {
	                    graphics.fillRect(i, j, 1, 1);
	                }
	            }
	        }
	        ImageIO.write(image, fileType, new File(qrFile));

	        // 3. Inserisco QR in un PDF con iText
	        Document document = new Document(PageSize.A4);
	        PdfWriter.getInstance(document, new FileOutputStream(pdfFile));
	        document.open();

	        Image qrImg = Image.getInstance(qrFile);
	        qrImg.scaleAbsolute(150, 150);  // grandezza nel PDF
	        qrImg.setAbsolutePosition(200, 600); // posizione nel foglio

	        document.add(qrImg);
	        document.close();

	        System.out.println("PDF generato: " + pdfFile);
	    }
	

}
