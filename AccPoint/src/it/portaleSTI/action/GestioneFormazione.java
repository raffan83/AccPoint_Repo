package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import org.hibernate.Session;

import com.google.gson.JsonObject;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.ForCorsoCatDTO;
import it.portaleSTI.DTO.ForDocenteDTO;
import it.portaleSTI.DTO.RegistroEventiDTO;
import it.portaleSTI.DTO.TipoEventoRegistroDTO;
import it.portaleSTI.DTO.TipoManutenzioneDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneFormazioneBO;
import it.portaleSTI.bo.GestioneUtenteBO;

/**
 * Servlet implementation class GestioneFormazione
 */
@WebServlet("/gestioneFormazione.do")
public class GestioneFormazione extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
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
			
			if(action.equals("lista_docenti")) {
				
				ArrayList<ForDocenteDTO> lista_docenti = GestioneFormazioneBO.getListaDocenti(session);
				
				request.getSession().setAttribute("lista_docenti", lista_docenti);
				
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
				String titolo = ret.get("titolo");

				ForDocenteDTO docente = new ForDocenteDTO();
				
				docente.setNome(nome);
				docente.setCognome(cognome);
				docente.setTitolo(titolo);				
				
				if(fileItem!=null && !filename.equals("")) {

					saveFile(fileItem, cognome,nome,filename);
					docente.setCv(filename);
				}
				
				session.save(docente);
				
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
				String titolo = ret.get("titolo_mod");

				ForDocenteDTO docente = GestioneFormazioneBO.getDocenteFromId(Integer.parseInt(id_docente),session);
				
				docente.setNome(nome);
				docente.setCognome(cognome);
				docente.setTitolo(titolo);				
				
				if(fileItem!=null && !filename.equals("")) {

					saveFile(fileItem, cognome,nome,filename);
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
				
				String path = Costanti.PATH_FOLDER+"//DocentiFormazione//"+docente.getCognome()+"_"+docente.getNome()+"//"+docente.getCv();
				File file = new File(path);
				
				FileInputStream fileIn = new FileInputStream(file);
				 
				response.setContentType("application/pdf");
				  
				 //response.setHeader("Content-Disposition","attachment;filename="+ file.getName());
				 
				 ServletOutputStream outp = response.getOutputStream();
				     
				    byte[] outputByte = new byte[1];
				    
				    while(fileIn.read(outputByte, 0, 1) != -1)
				    {
				    	outp.write(outputByte, 0, 1);
				    }
				    				    
				    session.close();

				    fileIn.close();
				    outp.flush();
				    outp.close();
				
			}
			else if(action.equals("lista_cat_corsi")) {
				
				ArrayList<ForCorsoCatDTO> lista_corsi_cat = GestioneFormazioneBO.getListaCategorieCorsi(session);
				
				request.getSession().setAttribute("lista_corsi_cat", lista_corsi_cat);
				
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
	
	
	
	 private void saveFile(FileItem item, String cognome,String nome, String filename) {

		 	String path_folder = Costanti.PATH_FOLDER+"//DocentiFormazione//"+cognome+"_"+nome+"//";
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

}
