package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.FirmaClienteDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneFirmaClienteBO;

/**
 * Servlet implementation class GestioneFirmaCliente
 */
@WebServlet("/gestioneFirmaCliente.do")
public class GestioneFirmaCliente extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneFirmaCliente() {
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
				
				ArrayList<FirmaClienteDTO> lista_firme = GestioneFirmaClienteBO.getListaFirme(0,0,session);
				List<ClienteDTO> listaClienti = (List<ClienteDTO>)request.getSession().getAttribute("lista_clienti");
				if(listaClienti==null) {
					listaClienti = GestioneAnagraficaRemotaBO.getListaClienti(String.valueOf(utente.getCompany().getId()));							
				}
				
				List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				if(listaSedi== null) {
					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
				}
				
				request.getSession().setAttribute("lista_firme", lista_firme);
				request.getSession().setAttribute("lista_clienti", listaClienti);
				request.getSession().setAttribute("lista_sedi", listaSedi);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaFirmeCliente.jsp");
		     	dispatcher.forward(request,response);
			}
			else if(action.equals("nuovo")) {				
				
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
		
				String cliente = ret.get("cliente");
				String sede = ret.get("sede");
				String nominativo = ret.get("nominativo_firma");
				
				ClienteDTO cl = GestioneAnagraficaRemotaBO.getClienteById(cliente);
				 List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
					if(listaSedi== null) {
						listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
					}
				
				FirmaClienteDTO firma = new FirmaClienteDTO();	
				firma.setId_cliente(cl.get__id());
				firma.setNome_cliente(cl.getNome());
				
				SedeDTO sd =null;
				if(!sede.equals("0")) {
					firma.setId_sede(Integer.parseInt(sede.split("_")[0]));
					sd = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, Integer.parseInt(sede.split("_")[0]), cl.get__id());
					firma.setNome_sede(sd.getDescrizione() + " - "+sd.getIndirizzo() +" - " + sd.getComune() + " - ("+ sd.getSiglaProvincia()+")");
				}else {
					firma.setNome_sede("Non associate");
				}
				
				firma.setNominativo_firma(nominativo);
				
				
				saveFile(fileItem, firma.getId_cliente(), firma.getId_sede(), filename);
				
				firma.setNome_file(filename);
				session.save(firma);				
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Firma cliente salvata con successo!");
				out.print(myObj);
			}
			
			else if(action.equals("modifica")) {				
				
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
		
		        String id_firma = ret.get("id_firma");
				String cliente = ret.get("cliente_mod");
				String sede = ret.get("sede_mod");
				String nominativo = ret.get("nominativo_firma_mod");
				
				ClienteDTO cl = GestioneAnagraficaRemotaBO.getClienteById(cliente);
				 List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
					if(listaSedi== null) {
						listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
					}
				
				FirmaClienteDTO firma = GestioneFirmaClienteBO.getFirmaCliente(Integer.parseInt(id_firma), session);	
				firma.setId_cliente(cl.get__id());
				firma.setNome_cliente(cl.getNome());
				
				SedeDTO sd =null;
				if(!sede.equals("0")) {
					firma.setId_sede(Integer.parseInt(sede.split("_")[0]));
					sd = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, Integer.parseInt(sede.split("_")[0]), cl.get__id());
					firma.setNome_sede(sd.getDescrizione() + " - "+sd.getIndirizzo() +" - " + sd.getComune() + " - ("+ sd.getSiglaProvincia()+")");
				}else {
					firma.setNome_sede("Non associate");
				}
				
				firma.setNominativo_firma(nominativo);
				
				if(filename!=null && !filename.equals("")) {
					saveFile(fileItem, firma.getId_cliente(), firma.getId_sede(), filename);
					
					firma.setNome_file(filename);
				}
				
				session.update(firma);				
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Firma cliente salvata con successo!");
				out.print(myObj);
			}
			
			else if(action.equals("download_firma")) {
				
				String id_firma = request.getParameter("id_firma");
				
				FirmaClienteDTO firma = GestioneFirmaClienteBO.getFirmaCliente(Integer.parseInt(id_firma), session);
				
				response.setContentType("application/octet-stream");
				  
				 response.setHeader("Content-Disposition","attachment;filename="+ firma.getNome_file());
				
				downloadFile(Costanti.PATH_FOLDER+"\\FirmeCliente\\"+firma.getId_cliente()+"\\"+firma.getId_sede()+"\\"+firma.getNome_file(), response.getOutputStream());
 				
				
			}
			else if(action.equals("elimina_firma")) {
				
				ajax = true;
				
				String id_firma = request.getParameter("id_firma");
				
				FirmaClienteDTO firma = GestioneFirmaClienteBO.getFirmaCliente(Integer.parseInt(id_firma), session);
				firma.setDisabilitato(1);
				
				session.update(firma);
				
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Firma cliente salvata con successo!");
				out.print(myObj);
				
			}
			else if(action.equals("lista_firme_cliente")) {
				
				ajax = true;
				
				String id_cliente = request.getParameter("id_cliente");
				String id_sede = request.getParameter("id_sede");
				
				ArrayList<FirmaClienteDTO> lista_firme = GestioneFirmaClienteBO.getListaFirme(Integer.parseInt(id_cliente), Integer.parseInt(id_sede),session);
				response.setContentType("application/json");
				Gson g = new Gson();
				
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.add("lista_firme", g.toJsonTree(lista_firme));
				out.print(myObj);
				out.close();		
				
			}
			
			session.getTransaction().commit();
			session.close();
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
	
	
	
	
	private void saveFile(FileItem item,int id_cliente, int id_sede,  String filename) {

	 	String path_folder = Costanti.PATH_FOLDER+"\\FirmeCliente\\"+id_cliente+"\\"+id_sede+"\\";
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
