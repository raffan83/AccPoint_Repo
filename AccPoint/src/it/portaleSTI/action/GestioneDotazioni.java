package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.List;
import java.util.Set;

import javax.persistence.Access;
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

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.AccessorioDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.DotazioneDTO;
import it.portaleSTI.DTO.LogMagazzinoDTO;
import it.portaleSTI.DTO.PermessoDTO;
import it.portaleSTI.DTO.RuoloDTO;
import it.portaleSTI.DTO.TipologiaAccessoriDTO;
import it.portaleSTI.DTO.TipologiaDotazioniDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAccessorioBO;
import it.portaleSTI.bo.GestioneDotazioneBO;
import it.portaleSTI.bo.GestioneMagazzinoBO;
import it.portaleSTI.bo.GestionePermessiBO;
import it.portaleSTI.bo.GestioneRuoloBO;
import it.portaleSTI.bo.GestioneUtenteBO;

/**
 * Servlet implementation class GestioneUtenti
 */
@WebServlet(name = "gestioneDotazioni", urlPatterns = { "/gestioneDotazioni.do" })
public class GestioneDotazioni extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneDotazioni() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if(Utility.validateSession(request,response,getServletContext()))return;
		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
	
   
        response.setContentType("application/json");
        try{
        	   
        	List<FileItem> items = null;
        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
        	}
        	String action =  request.getParameter("action");
       	 	
        	if(action !=null )
       	 	{
				
        		UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
        		
    	 		if(action.equals("nuovo"))
    	 		{
    	 			PrintWriter out = response.getWriter();
    	 			JsonObject myObj = new JsonObject();
    	 			
    				FileItem fileItem = null;
    				
    		        Hashtable<String,String> ret = new Hashtable<String,String>();
    		      
    		        for (FileItem item : items) {
    	            	 if (!item.isFormField()) {
    	            		
    	                     fileItem = item;
    	                     
    	            	 }else
    	            	 {
    	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));

    	            	 }
    	            	
    	            
    	            }
    			        
    	 			
    	 			
    	 			String marca = (String) ret.get("marca");
    	 			String modello = (String) ret.get("modello");
    	 			String tipologia_id = (String) ret.get("tipologia");
    	 			String targa = (String) ret.get("targa");
    	 			String matricola = (String) ret.get("matricola");
    	 			
    	 			TipologiaDotazioniDTO tipologia = new TipologiaDotazioniDTO();
    	 			tipologia.setId(Integer.parseInt(tipologia_id));
    	 			
    	 			DotazioneDTO dotazione = new DotazioneDTO();
    	 			dotazione.setMarca(marca);
    	 			dotazione.setModello(modello);
    	 			dotazione.setMatricola(matricola);
    	 			dotazione.setTarga(targa);
    	 			dotazione.setCompany(utente.getCompany());

    	 			dotazione.setTipologia(tipologia);
    	 			if(fileItem != null && fileItem.getName() != null && !fileItem.getName().equals("")){
    	 				dotazione.setSchedaTecnica(fileItem.getName());
    	 			}
    	 			GestioneDotazioneBO.saveDotazione(dotazione, action, session);
    	 			
    	 			if(fileItem.getName() != null && !fileItem.getName().equals("")) {
	    	 			File directory =new File(Costanti.PATH_FOLDER+"//Dotazioni//"+dotazione.getId());
	    	 			
	    	 			if(directory.exists()==false)
	    	 			{
	    	 				directory.mkdir();
	    	 			}
	    	 			
	    	 			if(fileItem.getName().substring(fileItem.getName().length()-3, fileItem.getName().length()).equalsIgnoreCase("pdf"))
	    	 			{
	    	 			
	    	 				File file =new File(directory.getPath()+"//"+fileItem.getName());
	    	 			
	    	 				fileItem.write(file);
	
	    	 	 		}
	    	 			else
	    	 			{
	    	 				session.getTransaction().rollback();
	    	 				session.close();
	    	 				myObj.addProperty("success", false);
	    					myObj.addProperty("messaggio","Errore Salvataggio File");
	    	 			}
    	 			
    	 			}
    	 			
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio","Salvato con Successo");
				session.getTransaction().commit();
				session.close();

				out.println(myObj.toString());	 	
    	 		}else if(action.equals("modifica")){
    	 			PrintWriter out = response.getWriter();
    	 			JsonObject myObj = new JsonObject();
    	 			
    				FileItem fileItem = null;
    				
    		        Hashtable<String,String> ret = new Hashtable<String,String>();
    		      
    		        for (FileItem item : items) {
    	            	 if (!item.isFormField()) {
    	            		
    	                     fileItem = item;
    	                     
    	            	 }else
    	            	 {
    	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));

    	            	 }
    	            	
    	            
    	            }
    	 			
    	 			String id = (String) ret.get("modid");

    	 			String marca = (String) ret.get("modmarca");
    	 			String modello = (String) ret.get("modmodello");
    	 			String tipologia_id = (String) ret.get("modtipologia");
    	 			String targa = (String) ret.get("modtarga");
    	 			String matricola = (String) ret.get("modmatricola");
    	 			
    	 			DotazioneDTO dotazione = GestioneDotazioneBO.getDotazioneById(id, session);

    	 			if(marca != null && !marca.equals("")){
    	 				dotazione.setMarca(marca);
    	 			}
    	 			if(modello != null && !modello.equals("")){
    	 				dotazione.setModello(modello);
    	 			}
    	 			if(targa != null && !targa.equals("")){
    	 				dotazione.setTarga(targa);
    	 			}
    	 			if(matricola != null && !matricola.equals("")){
    	 				dotazione.setMatricola(matricola);
    	 			}
    	 			if(tipologia_id != null && !tipologia_id.equals("")){
    	 				TipologiaDotazioniDTO tipologia = new TipologiaDotazioniDTO();
    	 				tipologia.setId(Integer.parseInt(tipologia_id));
    	 			}
    	 			if(fileItem != null && fileItem.getName() != null && !fileItem.getName().equals("")){
    	 				dotazione.setSchedaTecnica(fileItem.getName());

    	 			}
    	 			dotazione.setSchedaTecnica(fileItem.getName());
    	 			 GestioneDotazioneBO.saveDotazione(dotazione, action, session);
    	 			if(fileItem.getName() != null && !fileItem.getName().equals("")) {
	    	 			 
	    	 			  
	    	 			  File directory =new File(Costanti.PATH_FOLDER+"//Dotazioni//"+dotazione.getId());
	     	 			
	     	 			if(directory.exists()==false)
	     	 			{
	     	 				directory.mkdir();
	     	 			}
	     	 			
	     	 			if(fileItem.getName().substring(fileItem.getName().length()-3, fileItem.getName().length()).equalsIgnoreCase("pdf"))
	     	 			{
	     	 			
	     	 				File file =new File(directory.getPath()+"//"+fileItem.getName());
	     	 			
	     	 				fileItem.write(file);
	
	     	 	 		}
	     	 			else
	     	 			{
	     	 				session.getTransaction().rollback();
	     	 				session.close();
	     	 				myObj.addProperty("success", false);
	     					myObj.addProperty("messaggio","Errore Salvataggio File");
	     	 			}
    	 			}
    					myObj.addProperty("success", true);
    					myObj.addProperty("messaggio","Salvato con Successo");
    					session.getTransaction().commit();
    					session.close();
    				
    					out.println(myObj.toString()); 

    	 		}else if(action.equals("elimina")){
    	 			
    	 			PrintWriter out = response.getWriter();
    	 			JsonObject myObj = new JsonObject();
     	 			
     	 			String id = request.getParameter("id");

    	 				
    	 			
    	 			DotazioneDTO dotazione = GestioneDotazioneBO.getDotazioneById(id, session);
    	 			
    	 			GestioneDotazioneBO.deleteDotazione(dotazione, session);

    	 			File directory =new File(Costanti.PATH_FOLDER+"//Dotazioni//"+dotazione.getId());
    	 			
    	 			String[]entries = directory.list();
    	 			for(String s: entries){
    	 			    File currentFile = new File(directory.getPath(),s);
    	 			    currentFile.delete();
    	 			}
    	 			
    	 			directory.delete();
    	 			
    					myObj.addProperty("success", true);
    					myObj.addProperty("messaggio","Elimionato con Successo");
    					session.getTransaction().commit();
    					session.close();

    			
    	 			
    					out.println(myObj.toString());	
    	 		}else if(action.equals("scaricaSchedaTecnica")){
    	 			
   	 
    	 			String id = request.getParameter("idDotazione");
    	 			String nomeFile = request.getParameter("nomeFile");

    	 			String nomePack= request.getParameter("nomePack");
    			 	

    				 
   			     File d = new File(Costanti.PATH_FOLDER+"//Dotazioni//"+id+"//"+nomeFile);
   				 
   				 FileInputStream fileIn = new FileInputStream(d);
   				 
   				 response.setContentType("application/octet-stream");
   				 
   				 response.setHeader("Content-Disposition","attachment;filename="+nomeFile);
   				 
   				 ServletOutputStream outp = response.getOutputStream();
   				     
   				    byte[] outputByte = new byte[1];
   				    
   				    while(fileIn.read(outputByte, 0, 1) != -1)
   				    {
   				    	outp.write(outputByte, 0, 1);
   				     }
   				    
   				    
   				    fileIn.close();
   			
   				    outp.flush();
   				    outp.close();
   			 	 
   	 			
   	 				
   	 		}
    	 		
    	 	}else{
    	 		PrintWriter out = response.getWriter();
    			JsonObject myObj = new JsonObject();
    			myObj.addProperty("success", false);
    			myObj.addProperty("messaggio", "Nessuna action riconosciuta");  
    		}	
        


        }catch(Exception ex){
         	String action =  request.getParameter("action");
	        	if(action.equals("scaricaSchedaTecnica"))
		 		{
	        			 request.setAttribute("error",STIException.callException(ex));
	    				 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
	    			     dispatcher.forward(request,response);
		 		}else {
			        	PrintWriter out = response.getWriter();
			    		JsonObject myObj = new JsonObject();
			        	ex.printStackTrace();
			        	session.getTransaction().rollback();
			        	session.close();
			        	request.getSession().setAttribute("exception", ex);
			        	myObj.addProperty("success", false);
			        	myObj.addProperty("messaggio", STIException.callException(ex).toString());
			        	//out.println(myObj.toString());
		 		}
	        } 
	}

}
