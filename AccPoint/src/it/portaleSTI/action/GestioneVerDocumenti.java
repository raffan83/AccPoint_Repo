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

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.VerAllegatoDocumentoDTO;
import it.portaleSTI.DTO.VerAllegatoLegalizzazioneBilanceDTO;
import it.portaleSTI.DTO.VerDocumentoDTO;
import it.portaleSTI.DTO.VerLegalizzazioneBilanceDTO;
import it.portaleSTI.DTO.VerStrumentoDTO;
import it.portaleSTI.DTO.VerTipoApprovazioneDTO;
import it.portaleSTI.DTO.VerTipoDocumentoDTO;
import it.portaleSTI.DTO.VerTipoProvvedimentoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneVerDocumentiBO;
import it.portaleSTI.bo.GestioneVerLegalizzazioneBilanceBO;
import it.portaleSTI.bo.GestioneVerStrumentiBO;

/**
 * Servlet implementation class GgestioneVerLegalizzazioneBilance
 */
@WebServlet(name = "GestioneVerDocumenti", urlPatterns = { "/gestioneVerDocumenti.do" })
public class GestioneVerDocumenti extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneVerDocumenti() {
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
		JsonObject myObj = new JsonObject();
		boolean ajax = false;
	   
		try {
			
			if(action.equals("lista")) {
				
				ArrayList<VerDocumentoDTO> lista_documenti = GestioneVerDocumentiBO.getListaDocumenti(session);
				ArrayList<VerTipoDocumentoDTO>  lista_tipo_documenti = GestioneVerDocumentiBO.getListaTipoDocumenti(session);
				
				
				request.getSession().setAttribute("lista_documenti", lista_documenti);
				request.getSession().setAttribute("lista_tipo_documenti", lista_tipo_documenti);

				
				session.getTransaction().commit();
				session.close();
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneDocumentiVerificazione.jsp");
		  	    dispatcher.forward(request,response);
		  	    
			}
			else if(action.equals("nuovo_documento")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}
		        
		       
				FileItem fileItem = null;
				String filename= null;
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		        ArrayList<FileItem> file_list = new ArrayList<FileItem>();
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	            		 file_list.add(item);
	                     
	            	 }else
	            	 {
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	            	 }
	            	
	            }
		
				
				String costruttore = ret.get("costruttore");
				String modello = ret.get("modello");
				String tipo_documento = ret.get("tipo_documento");
				
				VerDocumentoDTO documento = new VerDocumentoDTO();
				

				documento.setCostruttore(costruttore);
				documento.setModello(modello);
				documento.setData_caricamento(new Date());
				documento.setTipo_documento(new VerTipoDocumentoDTO(Integer.parseInt(tipo_documento),""));
		
				
				session.save(documento);
				
				for (FileItem item : file_list) {
					if(!item.getName().equals("")) {
						saveFile(item, documento.getId(),item.getName());		
						
						VerAllegatoDocumentoDTO allegato = new VerAllegatoDocumentoDTO();
						allegato.setNome_file(item.getName());
						allegato.setDocumento(documento);
								
						session.save(allegato);
					}
				}				
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Documento salvato con successo!");
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
				
			}
			else if(action.equals("modifica_documento")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}
		        
		       
				
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		        
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	                     
	                     
	            	 }else
	            	 {
                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	            	 }
	            	
	            }

				
		
				
				String id=ret.get("id_documento");
				String costruttore=ret.get("costruttore_mod");
				String modello=ret.get("modello_mod");
				String id_tipo_documento=ret.get("tipo_documento_mod");
				
				VerDocumentoDTO documento =GestioneVerDocumentiBO.getDocumentoFromId(Integer.parseInt(id), session);
				
				documento.setCostruttore(costruttore);
				documento.setModello(modello);
				documento.setTipo_documento(new VerTipoDocumentoDTO(Integer.parseInt(id_tipo_documento),""));
				documento.setData_caricamento(new Date());
				
				session.save(documento);
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Documento modificato con successo!");
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
			}

			else if(action.equals("lista_allegati")) {
			
				 String id = request.getParameter("id_documento");
					

				 ArrayList<VerAllegatoDocumentoDTO> lista_allegati = GestioneVerDocumentiBO.getListaAllegati(Integer.parseInt(id), session);
	
				    PrintWriter out = response.getWriter();
					
					 Gson gson = new Gson(); 
				        			        
				     			       		       
				        myObj.addProperty("success", true);
				  				        
				        myObj.add("lista_allegati", gson.toJsonTree(lista_allegati));
				        
				        out.print(myObj);
			
				        out.close();
				        
				     session.getTransaction().commit();
			       	session.close();
					
				
			}
			else if(action.equals("upload_allegato")) {
				
				 ajax = true;
				
				 String id = request.getParameter("id_documento");
					
				 VerDocumentoDTO documento = GestioneVerDocumentiBO.getDocumentoFromId(Integer.parseInt(id), session);
				
				
				 ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
					PrintWriter out = response.getWriter();
					response.setContentType("application/json");						
						
						List<FileItem> items = uploadHandler.parseRequest(request);
						for (FileItem item : items) {
							if (!item.isFormField()) {							
								saveFile(item, documento.getId(),item.getName());		
								
								VerAllegatoDocumentoDTO allegato = new VerAllegatoDocumentoDTO();
								allegato.setNome_file(item.getName());
								allegato.setDocumento(documento);
										
								session.save(allegato);
							}
						}

						session.getTransaction().commit();
						session.close();	
						myObj.addProperty("success", true);
						myObj.addProperty("messaggio", "Upload effettuato con successo!");
						out.print(myObj);
			}
			else if(action.equals("download_allegato")){
				
			
				String id_allegato = request.getParameter("id_allegato");			
			
				VerAllegatoDocumentoDTO allegato = GestioneVerDocumentiBO.getAllegatoFromId(Integer.parseInt(id_allegato), session); 
					
				
				String path = Costanti.PATH_FOLDER+"//Verificazione//Documenti//"+allegato.getDocumento().getId()+"//"+allegato.getNome_file();
				response.setContentType("application/octet-stream");
				response.setHeader("Content-Disposition","attachment;filename="+ allegato.getNome_file());
		
				ServletOutputStream outp = response.getOutputStream();
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
				
				session.close();
				
			}
			
			
			else if(action.equals("elimina_allegato")) {
				
				ajax=true;				

				String id_allegato = request.getParameter("id_allegato");			
				
				VerAllegatoDocumentoDTO allegato = GestioneVerDocumentiBO.getAllegatoFromId(Integer.parseInt(id_allegato), session);
					
				session.delete(allegato);	
				
				
				PrintWriter out = response.getWriter();
				session.getTransaction().commit();
				session.close();	
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Allegato eliminato con successo!");
				out.print(myObj);
				
				
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
	
	 private void saveFile(FileItem item, int id_provvedimento, String filename) {

		 	String path_folder = Costanti.PATH_FOLDER+"//Verificazione//Documenti//"+id_provvedimento+"//";
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
