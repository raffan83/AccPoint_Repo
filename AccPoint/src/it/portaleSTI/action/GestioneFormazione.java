package it.portaleSTI.action;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

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
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.GestioneCommesseDAO;
import it.portaleSTI.DAO.GestioneFormazioneDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.ForCorsoAllegatiDTO;
import it.portaleSTI.DTO.ForCorsoCatAllegatiDTO;
import it.portaleSTI.DTO.ForCorsoCatDTO;
import it.portaleSTI.DTO.ForCorsoDTO;
import it.portaleSTI.DTO.ForDocenteDTO;
import it.portaleSTI.DTO.ForPartecipanteDTO;
import it.portaleSTI.DTO.ForPartecipanteRuoloCorsoDTO;
import it.portaleSTI.DTO.ForQuestionarioDTO;
import it.portaleSTI.DTO.ForRuoloDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneFormazioneBO;

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
		
		doPost(request, response);
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

				ForDocenteDTO docente = new ForDocenteDTO();
				
				docente.setNome(nome);
				docente.setCognome(cognome);
				docente.setFormatore(Integer.parseInt(formatore));				
				
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

				ForDocenteDTO docente = GestioneFormazioneBO.getDocenteFromId(Integer.parseInt(id_docente),session);
				
				docente.setNome(nome);
				docente.setCognome(cognome);
				docente.setFormatore(Integer.parseInt(formatore));				
				
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
				String durata = ret.get("durata");

				ForCorsoCatDTO categoria = new ForCorsoCatDTO();		
				
				categoria.setCodice(codice);
				categoria.setDescrizione(descrizione);
				categoria.setFrequenza(Integer.parseInt(frequenza));
				categoria.setDurata(Integer.parseInt(durata));
				
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
				String durata = ret.get("durata_mod");

				ForCorsoCatDTO categoria = GestioneFormazioneBO.getCategoriaCorsoFromId(Integer.parseInt(id_categoria),session);		
				
				categoria.setCodice(codice);
				categoria.setDescrizione(descrizione);
				categoria.setFrequenza(Integer.parseInt(frequenza));
				categoria.setDurata(Integer.parseInt(durata));
				
				session.update(categoria);
				
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
				}else {
					lista_corsi = GestioneFormazioneBO.getListaCorsi(session);
					ArrayList<ForCorsoCatDTO> lista_corsi_cat = GestioneFormazioneBO.getListaCategorieCorsi(session);
					ArrayList<ForDocenteDTO> lista_docenti = GestioneFormazioneBO.getListaDocenti(session);			
					ArrayList<CommessaDTO> lista_commesse = GestioneCommesseDAO.getListaCommesseFormazione(company, "FES;FCS", utente, 0, false);
					
					request.getSession().setAttribute("lista_docenti", lista_docenti);
					request.getSession().setAttribute("lista_corsi_cat", lista_corsi_cat);
					request.getSession().setAttribute("lista_commesse", lista_commesse);
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
				String docente = ret.get("docente");
				String data_corso = ret.get("data_corso");
				String data_scadenza = ret.get("data_scadenza");
				String descrizione = ret.get("descrizione");
				String edizione = ret.get("edizione");
				String commessa = ret.get("commessa");
				String e_learning = ret.get("e_learning");

				ForCorsoDTO corso = new ForCorsoDTO();		
				
				corso.setCorso_cat(new ForCorsoCatDTO(Integer.parseInt(categoria.split("_")[0])));
				if(docente!=null && !docente.equals("")) {
					corso.setDocente(new ForDocenteDTO(Integer.parseInt(docente)));					
				}
				if(e_learning!=null && !e_learning.equals("")) {
					corso.setE_learning(Integer.parseInt(e_learning));
				}
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				corso.setData_corso(df.parse(data_corso));
				corso.setData_scadenza(df.parse(data_scadenza));
				corso.setDescrizione(descrizione);
				corso.setEdizione(edizione);
				corso.setCommessa(commessa);
				
				if(filename!=null && !filename.equals("")) {
					corso.setDocumento_test(filename);
					//saveFile(fileItem, "DocumentiTest//"+lista_corsi, filename);
				}
				
				session.save(corso);
				
				if(filename!=null && !filename.equals("")) {
					
					saveFile(fileItem, "DocumentiTest//"+corso.getId(), filename);
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
				String docente = ret.get("docente_mod");
				String data_corso = ret.get("data_corso_mod");
				String data_scadenza = ret.get("data_scadenza_mod");
				String descrizione = ret.get("descrizione_mod");
				String edizione = ret.get("edizione_mod");
				String commessa = ret.get("commessa_mod");
				String e_learning = ret.get("e_learning_mod");
				
				ForCorsoDTO corso = GestioneFormazioneBO.getCorsoFromId(Integer.parseInt(id_corso),session);		
				
				corso.setCorso_cat(new ForCorsoCatDTO(Integer.parseInt(categoria.split("_")[0])));
				if(docente!=null && !docente.equals("")) {
					corso.setDocente(new ForDocenteDTO(Integer.parseInt(docente)));					
				}else {
					corso.setDocente(null);
				}
				if(e_learning!=null && !e_learning.equals("")) {
					corso.setE_learning(Integer.parseInt(e_learning));
				}
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				corso.setData_corso(df.parse(data_corso));
				corso.setData_scadenza(df.parse(data_scadenza));
				corso.setDescrizione(descrizione);
				corso.setEdizione(edizione);
				if(commessa!=null && !commessa.equals("")) {
					corso.setCommessa(commessa);
				}
				
				if(filename!=null && !filename.equals("")) {
					corso.setDocumento_test(filename);
					saveFile(fileItem, "DocumentiTest//"+corso.getId(), filename);
				}
				
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
												
				
				request.getSession().setAttribute("corso", corso);
				request.getSession().setAttribute("lista_partecipanti", lista_partecipanti);
				request.getSession().setAttribute("lista_ruoli", lista_ruoli);
				
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
				}else {
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
							
				}else {
					
					lista_partecipanti = GestioneFormazioneBO.getListaPartecipanti(session); 
					List<ClienteDTO> listaClienti = (List<ClienteDTO>)request.getSession().getAttribute("lista_clienti");
					if(listaClienti==null) {
						listaClienti = GestioneAnagraficaRemotaBO.getListaClienti(String.valueOf(utente.getCompany().getId()));							
					}
					
					List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
					if(listaSedi== null) {
						listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
					}
					
					ArrayList<String> listaAziendePartecipanti = GestioneFormazioneBO.getListaAziendeConPartecipanti(session);
					
					ArrayList<String> lista_cf = GestioneFormazioneDAO.getListaCodiciFiscali(session);
					
					Gson g = new Gson();
					JsonElement json_cf = g.toJsonTree(lista_cf);
					
					request.getSession().setAttribute("lista_clienti", listaClienti);
					request.getSession().setAttribute("listaAziendePartecipanti", listaAziendePartecipanti);	
					request.getSession().setAttribute("lista_sedi", listaSedi);
					request.getSession().setAttribute("json_cf", json_cf);
					
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
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");

				ForPartecipanteDTO partecipante = new ForPartecipanteDTO();		
				partecipante.setCognome(cognome);
				partecipante.setNome(nome);
				partecipante.setId_azienda(Integer.parseInt(id_azienda));
				partecipante.setLuogo_nascita(luogo_nascita);
				partecipante.setCf(cf);
				
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
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");

				ForPartecipanteDTO partecipante = GestioneFormazioneBO.getPartecipanteFromId(Integer.parseInt(id),session);	
				partecipante.setCognome(cognome);
				partecipante.setNome(nome);
				partecipante.setLuogo_nascita(luogo_nascita);
				partecipante.setCf(cf);
				
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
				
				id_corso = Utility.decryptData(id_corso);
				id_partecipante = Utility.decryptData(id_partecipante);
				filename = Utility.decryptData(filename);
								
				String path = Costanti.PATH_FOLDER+"//Formazione//Attestati//"+id_corso+"//"+id_partecipante+"//"+filename;
				
				downloadFile(path, response.getOutputStream());
				
				response.setContentType("application/pdf");	
				
				session.close();	
			}
			else if(action.equals("download_attestato_all")) {
				String id_corso = request.getParameter("id_corso");
				
				ArrayList<ForPartecipanteRuoloCorsoDTO> lista_partecipanti_corso = null;
				
				if(utente.checkRuolo("F2")) {
					lista_partecipanti_corso = GestioneFormazioneBO.getListaPartecipantiCorsoCliente(Integer.parseInt(id_corso), utente.getIdCliente(), utente.getIdSede(), session);
				}else {
					lista_partecipanti_corso = GestioneFormazioneBO.getListaPartecipantiCorso(Integer.parseInt(id_corso), session); 
				}
				
				
				 FileOutputStream fos = null;
			     ZipOutputStream zipOut = null;
			     FileInputStream fis = null;
			     fos = new FileOutputStream(Costanti.PATH_FOLDER+"//Formazione//Attestati//"+id_corso+"//"+"zipfile.zip");
		         zipOut = new ZipOutputStream(new BufferedOutputStream(fos));
		            
		         ArrayList<String> filenames=new ArrayList<String>();
				
				for (ForPartecipanteRuoloCorsoDTO p : lista_partecipanti_corso) {
					File input = new File(Costanti.PATH_FOLDER+"//Formazione//Attestati//"+id_corso+"//"+p.getPartecipante().getId()+"//"+p.getAttestato());
					
					String name=input.getName().replace(".pdf","").replace(".PDF", "");
					  ZipEntry ze = null;
					if(!filenames.contains(input.getName())) {
						filenames.add(input.getName());
						fis = new FileInputStream(input);
		                 ze = new ZipEntry(input.getName());
		                System.out.println("Zipping the file: "+input.getName());
					}else {
						File input_renamed = new File(Costanti.PATH_FOLDER+"//Formazione//Attestati//"+id_corso+"//"+p.getPartecipante().getId()+"//"+name+"_"+p.getPartecipante().getId()+".pdf");
						input.renameTo(input_renamed);
						
						fis = new FileInputStream(input_renamed);
						ze = new ZipEntry(input_renamed.getName());
		                System.out.println("Zipping the file: "+input_renamed.getName());
		                p.setAttestato(input_renamed.getName());
		                session.update(p);
					}									

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
				
				downloadFile(Costanti.PATH_FOLDER+"//Formazione//Attestati//"+id_corso+"//"+"zipfile.zip", response.getOutputStream());
				
				response.setContentType("application/octet-stream");	
				
				session.getTransaction().commit();
				session.close();
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
				
				ArrayList<ForPartecipanteRuoloCorsoDTO> lista_corsi = null;
				
				if(utente.checkRuolo("F2")) {
					lista_corsi = GestioneFormazioneBO.getListaPartecipantiRuoloCorsoCliente(dateFrom, dateTo, tipo_data, utente.getIdCliente(),utente.getIdSede(), session);
				}else {
					lista_corsi = GestioneFormazioneBO.getListaPartecipantiRuoloCorso(dateFrom, dateTo, tipo_data, null, null, session);
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
					
				}else {
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
			
		}catch(Exception e) {
			
			session.getTransaction().rollback();
        	session.close();
			if(ajax) {
				
				PrintWriter out = response.getWriter();
				e.printStackTrace();
	        	
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

}
