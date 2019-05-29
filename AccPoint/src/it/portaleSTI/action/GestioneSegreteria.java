package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
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
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.SegreteriaDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneSegreteriaBO;

/**
 * Servlet implementation class GestioneSegreteria
 */
@WebServlet("/gestioneSegreteria.do")
public class GestioneSegreteria extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneSegreteria() {
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
		
		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
		
		String action = request.getParameter("action");
		JsonObject myObj = new JsonObject();
		boolean ajax = false;
        response.setContentType("application/json");
        
		try {
			
			if(action==null) {
				
				List<ClienteDTO> listaClienti = (List<ClienteDTO>)request.getSession().getAttribute("lista_clienti");
				if(listaClienti==null) {
					listaClienti = GestioneAnagraficaRemotaBO.getListaClienti(String.valueOf(utente.getCompany().getId()));	
				}
				
			
				request.getSession().setAttribute("inserimento", false);
				request.getSession().setAttribute("lista_clienti", listaClienti);
				//session.close();
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneSegreteria.jsp");
		  	    dispatcher.forward(request,response);
				
			}
			
			else if(action.equals("lista")) {
				
				ArrayList<SegreteriaDTO> lista_segreteria = GestioneSegreteriaBO.getListaSegreteria(session);
				
				request.getSession().setAttribute("lista_segreteria", lista_segreteria);
				request.getSession().setAttribute("inserimento", true);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaSegreteria.jsp");
		  	    dispatcher.forward(request,response);
				
			}
			else if(action.equals("nuovo")) {
				
				List<FileItem> items = null;
	            if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

	            		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
	            	}
        		
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
								
				ajax = true;
				String azienda = ret.get("azienda");
				String localita = ret.get("localita");
				String telefono = ret.get("telefono");
				String referente = ret.get("referente");
				String mail = ret.get("mail");
				String offerta = ret.get("offerta");
				String note = ret.get("note");
				
				SegreteriaDTO item = new SegreteriaDTO();
				item.setAzienda(azienda);
				item.setLocalita(localita);
				item.setTelefono(telefono);
				item.setMail(mail);
				item.setReferente(referente);
				item.setOfferta(offerta);
				item.setNote(note);
				item.setUtente(utente);
				
				session.save(item);
				
				
				myObj.addProperty("success",true);
				PrintWriter out = response.getWriter();
				out.print(myObj);
				
			}
			else if(action.equals("modifica")) {
				
				List<FileItem> items = null;
	            if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

	            		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
	            	}
        		
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
								
				ajax = true;
				String id = ret.get("id_segreteria");
				String azienda = ret.get("azienda_mod");
				String localita = ret.get("localita_mod");
				String telefono = ret.get("telefono_mod");
				String referente = ret.get("referente_mod");
				String mail = ret.get("mail_mod");
				String offerta = ret.get("offerta_mod");
				String note = ret.get("note_mod");
				
				SegreteriaDTO item = GestioneSegreteriaBO.getItemSegreteriaFromId(Integer.parseInt(id), session);
				item.setAzienda(azienda);
				item.setLocalita(localita);
				item.setTelefono(telefono);
				item.setMail(mail);
				item.setReferente(referente);
				item.setOfferta(offerta);
				item.setNote(note);
				item.setUtente(utente);
				
				session.update(item);
				
				
				myObj.addProperty("success",true);
				PrintWriter out = response.getWriter();
				out.print(myObj);
				
			}
			else if(action.equals("elimina")) {
				ajax = true;
				String id = request.getParameter("id_item");
				
				SegreteriaDTO item = GestioneSegreteriaBO.getItemSegreteriaFromId(Integer.parseInt(id), session);
				
				session.delete(item);
				
				myObj.addProperty("success",true);
				myObj.addProperty("messaggio","Item eliminato con successo!");
				PrintWriter out = response.getWriter();
				out.print(myObj);
			}
			
			session.getTransaction().commit();
			session.close();
			
		} catch (Exception e) {
			
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


}
