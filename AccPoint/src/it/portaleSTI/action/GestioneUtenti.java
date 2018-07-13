package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Hashtable;
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
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.GestioneAccessoDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.RuoloDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneCompanyBO;
import it.portaleSTI.bo.GestioneRuoloBO;
import it.portaleSTI.bo.GestioneStrumentoBO;
import it.portaleSTI.bo.GestioneUtenteBO;

/**
 * Servlet implementation class GestioneUtenti
 */

@WebServlet(name = "gestioneUtenti", urlPatterns = { "/gestioneUtenti.do" })

public class GestioneUtenti extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneUtenti() {
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

	    	 			String nome = ret.get("nome");
	    	 			String cognome = ret.get("cognome");
	    	 			String user = ret.get("user");
	    	 			String passw = ret.get("passw");
	    	 			String indirizzo = ret.get("indirizzo");
	    	 			String comune = ret.get("comune");
	    	 			String cap = ret.get("cap");
	    	 			String email = ret.get("email");
	    	 			String telefono = ret.get("telefono");
	    	 			String companyId = ret.get("company");
	    	 			String idFirma = ret.get("idFirma");
 	    	 			String tipoutente = ret.get("tipoutente");
	    	 			String cliente = null;
	    	 			String sede = null;
	    	 			if(tipoutente.equals("2")) {
	    	 				  cliente = ret.get("cliente");
	    	 				  sede = ret.get("sede").split("_")[0];
	    	 			}
	    	 			String abilitato = ret.get("abilitato");
	    	 			CompanyDTO company = GestioneCompanyBO.getCompanyById(companyId, session);
	    	 				    	 			
	    	 			UtenteDTO utente = new UtenteDTO();
	    	 			
	    	 			utente.setNome(nome);
	    	 			utente.setCognome(cognome);
	    	 			utente.setUser(user);
	    	 			utente.setPassw(DirectMySqlDAO.getPassword(passw));
	    	 			utente.setIndirizzo(indirizzo);
	    	 			utente.setComune(comune);
	    	 			utente.setCap(cap);
	    	 			utente.setEMail(email);
	    	 			utente.setTelefono(telefono);
	    	 			utente.setCompany(company);
	    	 			utente.setIdFirma(idFirma);
	    	 			utente.setNominativo(nome+" "+cognome);
	    	 			if(cliente!=null) {
	    	 				utente.setIdCliente(Integer.parseInt(cliente));
	    	 			}else {
	    	 				utente.setIdCliente(0);
	    	 			}
	    	 			if(sede!=null) {
	    	 				utente.setIdSede(Integer.parseInt(sede));
	    	 			}else {
	    	 				utente.setIdSede(0);
	    	 			}
	    	 			utente.setTipoutente(tipoutente);
	    	 			utente.setCv(null);
	    	 			utente.setResetToken(null);
	    	 			
	    	 			if(abilitato != null && !abilitato.equals("") && abilitato.equals("1")){
		    	 			utente.setAbilitato(1);
	    	 			}else {
	    	 				utente.setAbilitato(0);
	    	 			}
	    	 			
	    	 			int success = GestioneUtenteBO.saveUtente(utente, action, session);
	    				myObj = GestioneUtenteBO.sendEmailNuovoUtente(user, passw, session);
	    	 			if(success==0)
	    				{
	    	 				
	    	 				if(fileItem != null && fileItem.getName() != null && !fileItem.getName().equals("")) {
		    	    	 			File directory =new File(Costanti.PATH_FOLDER+"//Curriculum");
		    	    	 			
		    	    	 			if(directory.exists()==false)
		    	    	 			{
		    	    	 				directory.mkdir();
		    	    	 			}
		    	    	 			
		    	    	 			if(fileItem.getName().substring(fileItem.getName().length()-3, fileItem.getName().length()).equalsIgnoreCase("pdf"))
		    	    	 			{
		    	    	 			
		    	    	 				utente.setCv("cv_"+utente.getId()+".pdf");
		    	    	 				File file =new File(directory.getPath()+"//cv_"+utente.getId()+".pdf");	    	    	 			
		    	    	 				fileItem.write(file);
		    	    	 				int success2 = GestioneUtenteBO.saveUtente(utente, action, session);
		    	    	 				if(success==0)
		    		    				{
		    	    	 					myObj.addProperty("success", true);
		    		    					myObj.addProperty("messaggio","Utente salvato con successo");
		    		    					session.getTransaction().commit();
		    		    					session.close();
		    		    				
		    		    				}
		    		    				if(success==1)
		    		    				{
		    		    					file.delete();
		    		    					
		    		    					myObj.addProperty("success", false);
		    		    					myObj.addProperty("messaggio","Errore Salvataggio");		    		    					
		    		    					session.getTransaction().rollback();
		    		    			 		session.close();
		    		    			 		
		    		    				} 
		    	
		    	    	 	 		}
		    	    	 			else
		    	    	 			{
		    	    	 				session.getTransaction().rollback();
		    	    	 				session.close();
		    	    	 				myObj.addProperty("success", false);
		    	    					myObj.addProperty("messaggio","Errore Salvataggio File");
		    	    	 			}
	        	 			
	        	 			}else {
	        	 				myObj.addProperty("success", true);
		    					myObj.addProperty("messaggio","Utente salvato con successo");
		    					session.getTransaction().commit();
		    					session.close();
	        	 			}
	    	 				
	    				
	    				
	    				}
	    				if(success==1)
	    				{
	    					
	    					myObj.addProperty("success", false);
	    					myObj.addProperty("messaggio","Errore Salvataggio");
	    					
	    					session.getTransaction().rollback();
	    			 		session.close();
	    			 		
	    				} 
	    				out.println(myObj.toString());
		 			 	
	    	 		}
	    	 	
	    	 	if(action.equals("modifica")){
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
	    	 		
	    	 		
	    	 			String id = ret.get("modid");

	    	 			String nome = ret.get("modnome");
	    	 			String cognome = ret.get("modcognome");
	    	 			String user = ret.get("moduser");
	    	 			String passw = ret.get("modpassw");
	    	 			String indirizzo = ret.get("modindirizzo");
	    	 			String comune = ret.get("modcomune");
	    	 			String cap = ret.get("modcap");
	    	 			String EMail = ret.get("modemail");
	    	 			String telefono = ret.get("modtelefono");
	    	 			String companyId = ret.get("modcompany");
	    	 			String tipoutente = ret.get("modtipoutente");
	    	 			String abilitato = ret.get("modabilitato");
	    	 			String idFirma = ret.get("modidFirma");
	    	 			String cliente = null;
	    	 			String sede = null;
	    	 			if(tipoutente != null && tipoutente.equals("2")) {
	    	 				  cliente = ret.get("modcliente");
	    	 				  sede = ret.get("modsede").split("_")[0];
	    	 			}
	    	 			
	    	 			UtenteDTO utente = GestioneUtenteBO.getUtenteById(id, session);
	    	 			
	    	 			
	    	 			if(nome != null && !nome.equals("")){
	    	 				utente.setNome(nome);
	    	 			}
	    	 			if(cognome != null && !cognome.equals("")){
		    	 			utente.setCognome(cognome);
	    	 			}
	    	 			if(user != null && !user.equals("")){
		    	 			utente.setUser(user);
	    	 			}
	    	 			if(passw != null && !passw.equals("")){
		    	 			utente.setPassw(DirectMySqlDAO.getPassword(passw));
	    	 			}
	    	 			if(indirizzo != null && !indirizzo.equals("")){
		    	 			utente.setIndirizzo(indirizzo);
	    	 			}
	    	 			if(comune != null && !comune.equals("")){
		    	 			utente.setComune(comune);
	    	 			}
	    	 			if(cap != null && !cap.equals("")){
		    	 			utente.setCap(cap);
	    	 			}
	    	 			if(EMail != null && !EMail.equals("")){
		    	 			utente.setEMail(EMail);
	    	 			}
	    	 			if(telefono != null && !telefono.equals("")){
		    	 			utente.setTelefono(telefono);
	    	 			}
	    	 			if(cliente != null && !cliente.equals("")){
		    	 			utente.setIdCliente(Integer.parseInt(cliente));
	    	 			}
	    	 			if(sede != null && !sede.equals("")){
		    	 			utente.setIdSede(Integer.parseInt(sede));
	    	 			}
	    	 			if(tipoutente != null && !tipoutente.equals("")){
		    	 			utente.setTipoutente(tipoutente);
	    	 			}
	    	 			if(abilitato != null && !abilitato.equals("") && abilitato.equals("1")){
		    	 			utente.setAbilitato(1);
	    	 			}else {
	    	 				utente.setAbilitato(0);
	    	 			}
	    	 			if(idFirma != null){
		    	 			utente.setIdFirma(idFirma);
	    	 			}
	    	 			utente.setNominativo(utente.getNome()+" "+utente.getCognome());
	    	 			
	    	 			if(companyId != null && !companyId.equals("")){
		    	 			CompanyDTO company = GestioneCompanyBO.getCompanyById(companyId, session);
	    	 				utente.setCompany(company);
	    	 			}
	    	 			
	    	 			
    	 				if(fileItem != null && fileItem.getName() != null && !fileItem.getName().equals("")) {
	    	    	 			File directory =new File(Costanti.PATH_FOLDER+"//Curriculum");
	    	    	 			
	    	    	 			if(directory.exists()==false)
	    	    	 			{
	    	    	 				directory.mkdir();
	    	    	 			}
	    	    	 			
	    	    	 			if(fileItem.getName().substring(fileItem.getName().length()-3, fileItem.getName().length()).equalsIgnoreCase("pdf"))
	    	    	 			{
	    	    	 				utente.setCv("cv_"+utente.getId()+".pdf");
	    	    	 				File file =new File(directory.getPath()+"//cv_"+utente.getId()+".pdf");	    	    	 			
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


	    	 			int success = GestioneUtenteBO.saveUtente(utente, action, session);
	    	 			
	    	 			if(success==0)
	    				{

	    					myObj.addProperty("success", true);
	    					myObj.addProperty("messaggio","Salvato con Successo");
	    					session.getTransaction().commit();
	    					session.close();
	    				
	    				}
	    				if(success==1)
	    				{
	    					
	    					myObj.addProperty("success", false);
	    					myObj.addProperty("messaggio","Errore Salvataggio");
	    					
	    					session.getTransaction().rollback();
	    			 		session.close();
	    			 		
	    				} 
	    				out.println(myObj.toString());
	    	 		}
	    	 	
	    	 	if(action.equals("clientisedi")){
	    	 		
	    	 		PrintWriter out = response.getWriter();
	        		JsonObject myObj = new JsonObject();
	        		
	    	 		Gson gson = new Gson();
	    	 		String companyID = request.getParameter("company");
	    	 		String tipo = request.getParameter("tipo");
	    	 		UtenteDTO utente = null;
	    	 		if(tipo.equals("mod")) {
	    	 			String utenteId = request.getParameter("utente");
	    	 			utente = GestioneUtenteBO.getUtenteById(utenteId, session);
	    	 			JsonElement utenteJson = gson.toJsonTree(utente);
	    	 			myObj.addProperty("utente", utenteJson.toString());
	    	 		}
	    	 		ArrayList<ClienteDTO> clienti  = (ArrayList<ClienteDTO>) GestioneAnagraficaRemotaBO.getListaClienti(companyID);
	    	 		ArrayList<SedeDTO> sedi  = (ArrayList<SedeDTO>) GestioneAnagraficaRemotaBO.getListaSedi();

	    	 		
	    	 		JsonElement clientiJson = gson.toJsonTree(clienti);
	    	 		JsonElement sediJson = gson.toJsonTree(sedi);
	    	 		
	    	 		
	    	 		myObj.addProperty("success", true);
				myObj.addProperty("clienti",clientiJson.toString());
				myObj.addProperty("sedi",sediJson.toString());
				out.println(myObj.toString());
	    	 		
	    	 	}
	    	 	if(action.equals("inviaEmailAttivazione")){
	    	 		
	    	 		PrintWriter out = response.getWriter();
	        		JsonObject myObj = new JsonObject();
	        		
 	    	 		String idUser = request.getParameter("idUser");
 	    	 		UtenteDTO utente = GestioneUtenteBO.getUtenteById(idUser, session);
 	    	 		myObj = GestioneUtenteBO.sendEmailConfermaAttivazione(utente, session);

 				out.println(myObj.toString());
	    	 		
	    	 	}
	    	 	if(action.equals("scaricacv"))
    	 		{
	    	 		String utenteId = request.getParameter("id");
	    	 		UtenteDTO utente = GestioneUtenteBO.getUtenteById(utenteId, session);

   				 
	   			     File d = new File(Costanti.PATH_FOLDER+"//Curriculum//"+utente.getCv());
	   				 
	   				 FileInputStream fileIn = new FileInputStream(d);
	   				 
	   				 response.setContentType("application/octet-stream");
	   				 
	   				 response.setHeader("Content-Disposition","attachment;filename="+utente.getCv());
	   				 
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
	   
	       	

        }catch(Exception ex){
         	String action =  request.getParameter("action");
        		if(action.equals("scaricacv"))
	 		{
        			 request.setAttribute("error",STIException.callException(ex));
        			 request.getSession().setAttribute("exception", ex);
    				 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
    			     dispatcher.forward(request,response);
	 		}else {
	 			PrintWriter out = response.getWriter();
	 			JsonObject myObj = new JsonObject();   
		        	ex.printStackTrace();
		        	session.getTransaction().rollback();
		        	session.close();
		        	request.getSession().setAttribute("exception", ex);
		        	//myObj.addProperty("success", false);
		        	//myObj.addProperty("messaggio", STIException.callException(ex).toString());
		        	
		        	myObj = STIException.getException(ex);
		        	out.println(myObj.toString());
	 		}
        } 
	}

}
