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
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.ForPartecipanteDTO;
import it.portaleSTI.DTO.PRRequisitoDocumentaleDTO;
import it.portaleSTI.DTO.PRRequisitoSanitarioDTO;
import it.portaleSTI.DTO.PRRisorsaDTO;
import it.portaleSTI.DTO.PaaRichiestaDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneFormazioneBO;
import it.portaleSTI.bo.GestioneRisorseBO;
import it.portaleSTI.bo.GestioneUtenteBO;

/**
 * Servlet implementation class GestioneRisorse
 */
@WebServlet("/gestioneRisorse.do")
public class GestioneRisorse extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneRisorse() {
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
			
			if(action.equals("lista_risorse")) {
				
				ArrayList<PRRisorsaDTO> lista_risorse = GestioneRisorseBO.getListaRisorse(session);
				ArrayList<UtenteDTO> lista_utenti = GestioneUtenteBO.getDipendenti(session);
				ArrayList<ForPartecipanteDTO> lista_partecipanti = GestioneFormazioneBO.getListaPartecipantiCliente(4132, 0, session);
				ArrayList<PRRequisitoDocumentaleDTO> lista_requisiti_documentali = GestioneRisorseBO.getListaRequisitiDocumentali(session);
				ArrayList<PRRequisitoSanitarioDTO> lista_requisiti_sanitari = GestioneRisorseBO.getListaRequisitiSanitari(session);
				
				request.getSession().setAttribute("lista_risorse", lista_risorse);
				request.getSession().setAttribute("lista_utenti", lista_utenti);
				request.getSession().setAttribute("lista_partecipanti", lista_partecipanti);
				request.getSession().setAttribute("lista_requisiti_documentali", lista_requisiti_documentali);
				request.getSession().setAttribute("lista_requisiti_sanitari", lista_requisiti_sanitari);
				
				 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/pr_lista_risorse.jsp");
			     dispatcher.forward(request,response);	
				
			}
			else if(action.equals("nuova_risorsa")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}		        
		       
	
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
	            	
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	      
	            	
	            }
		
				String id_utente = ret.get("utente");
				String id_partecipante = ret.get("partecipante");
				
				PRRisorsaDTO risorsa = new PRRisorsaDTO();
				UtenteDTO user = (UtenteDTO) session.get(UtenteDTO.class, Integer.parseInt(id_utente));
				ForPartecipanteDTO partecipante = (ForPartecipanteDTO) session.get(ForPartecipanteDTO.class, Integer.parseInt(id_partecipante));
				
				risorsa.setUtente(user);
				risorsa.setPartecipante(partecipante);
				
				session.save(risorsa);
				
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Salvato con successo!");
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

}
