package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
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
import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.DocumCommittenteDTO;
import it.portaleSTI.DTO.LibreriaElettriciDTO;
import it.portaleSTI.DTO.PaaVeicoloDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneLibrerieElettriciBO;
import it.portaleSTI.bo.GestioneParcoAutoBO;

/**
 * Servlet implementation class GestioneLibrerieElettrici
 */
@WebServlet("/gestioneLibrerieElettrici.do")
public class GestioneLibrerieElettrici extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	static final Logger logger = Logger.getLogger(GestioneLibrerieElettrici.class);
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneLibrerieElettrici() {
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

		
		JsonObject myObj = new JsonObject();
		boolean ajax = false;
		
		try {
			
			if(action.equals("lista")) {
				
				ArrayList<LibreriaElettriciDTO> lista_librerie = GestioneLibrerieElettriciBO.getListaLibrerieElettrici(session);
		
				request.getSession().setAttribute("lista_librerie", lista_librerie);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaLibrerieElettrici.jsp");
		     	dispatcher.forward(request,response);
				
			}
			
			else if(action.equals("nuova_libreria")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}		        
		       
				FileItem fileConfig = null;
				String filenamefileConfig = null;
				
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	            		 if(item.getFieldName().equals("fileupload_config")) {
	            			 fileConfig = item;
	            			 filenamefileConfig = item.getName();
	            		 }
	            		
	                    
	                     
	            	 }else
	            	 {
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	            	 }
	            	
	            }
		
				String marca = ret.get("marca");
				String modello = ret.get("modello");
				String campione_riferimento = ret.get("campione_riferimento");
				String note = ret.get("note");
			
				LibreriaElettriciDTO libreria = new LibreriaElettriciDTO();
				
				libreria.setMarca_strumento(marca);
				libreria.setModello_strumento(modello);
				libreria.setCampione_riferimento(campione_riferimento);
				libreria.setNote(note);
								
				
				session.save(libreria);
				
				if(filenamefileConfig!=null && !filenamefileConfig.equals("")) {
					saveFile(fileConfig, libreria.getId()+"", filenamefileConfig);
					libreria.setFilename_config(filenamefileConfig);
					session.update(libreria);
				}
				
								
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Salvato con successo!");
				out.print(myObj);
			}
			
			
			else if(action.equals("modifica_libreria")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}		        
		       
				FileItem fileConfig = null;
				String filenamefileConfig = null;
				
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	            		 if(item.getFieldName().equals("fileupload_config_mod")) {
	            			 fileConfig = item;
	            			 filenamefileConfig = item.getName();
	            		 }
	            		
	                    
	                     
	            	 }else
	            	 {
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	            	 }
	            	
	            }
		
		        String id_libreria = ret.get("id_libreria");
				String marca = ret.get("marca_mod");
				String modello = ret.get("modello_mod");
				String campione_riferimento = ret.get("campione_riferimento_mod");
				String note = ret.get("note_mod");
			
				LibreriaElettriciDTO libreria = GestioneLibrerieElettriciBO.getLibreriaElettriciFromID(Integer.parseInt(id_libreria), session);
				
				libreria.setMarca_strumento(marca);
				libreria.setModello_strumento(modello);
				libreria.setCampione_riferimento(campione_riferimento);
				libreria.setNote(note);
								
				
				if(filenamefileConfig!=null && !filenamefileConfig.equals("")) {
					saveFile(fileConfig, libreria.getId()+"", filenamefileConfig);
					libreria.setFilename_config(filenamefileConfig);
					
				}
				
				
				session.update(libreria);			
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Salvato con successo!");
				out.print(myObj);
			}
			
			else if (action.equals("download_file")) {
				
				String id_libreria = request.getParameter("id_libreria");
				
				LibreriaElettriciDTO libreria = GestioneLibrerieElettriciBO.getLibreriaElettriciFromID(Integer.parseInt(id_libreria), session);
				
				response.setContentType("application/octet-stream");
				
				response.setHeader("Content-Disposition","attachment;filename="+ libreria.getFilename_config().split("\\\\")[0]);
				downloadFile(Costanti.PATH_FOLDER+"\\LibrerieElettrici\\"+libreria.getId()+"\\"+libreria.getFilename_config(), response.getOutputStream());
				
				
			}
			else if(action.equals("elimina_libreria")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				
				String id = request.getParameter("id_libreria_elimina");

				LibreriaElettriciDTO libreria = GestioneLibrerieElettriciBO.getLibreriaElettriciFromID(Integer.parseInt(id), session);
				libreria.setDisabilitato(1);
								
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Eliminato con successo!");
				out.print(myObj);
				
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

		 	String path_folder = Costanti.PATH_FOLDER+"//LibrerieElettrici//"+path+"//";
			File folder=new File(path_folder);
			
			if(!folder.exists()) {
				folder.mkdirs();
			}
			
		    String baseName;
		    String extension = "";

		    // Dividi il filename in base al punto per ottenere nome ed estensione
		    int dotIndex = filename.lastIndexOf('.');
		    if (dotIndex != -1) {
		        baseName = filename.substring(0, dotIndex);
		        extension = filename.substring(dotIndex);
		    } else {
		        baseName = filename;
		    }
		
			int index = 1;
			
			File file = new File(path_folder + filename);

		    while (file.exists()) {
		       
		        file = new File(path_folder + baseName + "_" + index + extension);
		        index++;
		    }

		    try {
		        item.write(file);
		    } catch (Exception e) {
		        e.printStackTrace();
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
