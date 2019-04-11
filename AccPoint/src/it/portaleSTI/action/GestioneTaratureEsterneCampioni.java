package it.portaleSTI.action;

import java.io.File;
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
import it.portaleSTI.DTO.AcAttivitaCampioneDTO;
import it.portaleSTI.DTO.AcTipoAttivitaCampioniDTO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.TaraturaEsternaCampioneDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAttivitaCampioneBO;
import it.portaleSTI.bo.GestioneCertificatoBO;
import it.portaleSTI.bo.GestioneCommesseBO;
import it.portaleSTI.bo.GestioneUtenteBO;

/**
 * Servlet implementation class gestioneTaratureEsterneCampioni
 */
@WebServlet(name = "GestioneTaratureEsterneCampioni", urlPatterns = { "/gestioneTaratureEsterneCampioni.do" })
public class GestioneTaratureEsterneCampioni extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneTaratureEsterneCampioni() {
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
        	if(action.equals("lista")) {
        		String idC = request.getParameter("idCamp");
        		
        		CampioneDTO campione = GestioneCampioneDAO.getCampioneFromId(idC);
        		
        		ArrayList<TaraturaEsternaCampioneDTO> lista_tarature_esterne = GestioneAttivitaCampioneBO.getListaTaratureEsterneCampione(Integer.parseInt(idC),session);
        		ArrayList<UtenteDTO> lista_utenti = GestioneUtenteBO.getUtentiFromCompany(campione.getCompany().getId(), session);
        		ArrayList<CommessaDTO> lista_commesse = GestioneCommesseBO.getListaCommesse(campione.getCompany(), "", utente, 0, false);
        		
        		request.getSession().setAttribute("lista_tarature_esterne", lista_tarature_esterne);			
        		request.getSession().setAttribute("lista_utenti", lista_utenti);
        		request.getSession().setAttribute("lista_commesse", lista_commesse);
				
				session.close();
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaTaratureEsterneCampione.jsp");
				dispatcher.forward(request,response);
        		
	        }
	        else if(action.equals("nuovo")) {
	        	
	        	response.setContentType("application/json");
				 
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
			
			String idC = request.getParameter("idCamp");				
			String rif_verifica = ret.get("rif_verifica");
			String data = ret.get("data");
			String committente = ret.get("committente");
			String oggetto = ret.get("oggetto");
			String stato = ret.get("stato");
			String controllo = ret.get("controllo");
			String commessa = ret.get("commessa");
			String operatore = ret.get("operatore");	
			String note = ret.get("note");
			
			CampioneDTO campione = GestioneCampioneDAO.getCampioneFromId(idC);				
			
			TaraturaEsternaCampioneDTO taratura = new TaraturaEsternaCampioneDTO();
			taratura.setCampione(campione);
			taratura.setCommessa(commessa);
			taratura.setCommittente(committente);
			taratura.setControllo(controllo);
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Date date = format.parse(data);
			taratura.setData(date);
			taratura.setOggetto(oggetto);
			taratura.setStato(Integer.parseInt(stato));
			AcAttivitaCampioneDTO verifica_intermedia = GestioneAttivitaCampioneBO.getAttivitaFromId(Integer.parseInt(rif_verifica), session);
			taratura.setVerifica_intermedia(verifica_intermedia);
			
			UtenteDTO op = GestioneUtenteBO.getUtenteById(operatore, session);
			taratura.setOperatore(op);;
			taratura.setNote(note);
			
			session.save(taratura);
			session.getTransaction().commit();
			session.close();
			
			PrintWriter out = response.getWriter();
			myObj.addProperty("success", true);
			myObj.addProperty("messaggio", "Taratura esterma salvata con successo!");
			out.print(myObj);
			
	        }
        	
	        else if(action.equals("modifica")) {
	        	
	        	response.setContentType("application/json");
				 
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
			
		//	String idC = request.getParameter("idCamp");				
			String rif_verifica = ret.get("rif_verifica_mod");
			String data = ret.get("data_mod");
			String committente = ret.get("committente_mod");
			String oggetto = ret.get("oggetto_mod");
			String stato = ret.get("stato_mod");
			String controllo = ret.get("controllo_mod");
			String commessa = ret.get("commessa_mod");
			String operatore = ret.get("operatore_mod");	
			String id_taratura = ret.get("id_taratura");	
			String note = ret.get("note_mod");
			
			//CampioneDTO campione = GestioneCampioneDAO.getCampioneFromId(idC);				
			
			TaraturaEsternaCampioneDTO taratura = GestioneAttivitaCampioneBO.getTaraturaEsternaById(Integer.parseInt(id_taratura),session);
		//	taratura.setCampione(campione);
			taratura.setCommessa(commessa);
			taratura.setCommittente(committente);
			taratura.setControllo(controllo);
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Date date = format.parse(data);
			taratura.setData(date);
			taratura.setOggetto(oggetto);
			taratura.setStato(Integer.parseInt(stato));
			AcAttivitaCampioneDTO verifica_intermedia = GestioneAttivitaCampioneBO.getAttivitaFromId(Integer.parseInt(rif_verifica), session);
			taratura.setVerifica_intermedia(verifica_intermedia);
			
			UtenteDTO op = GestioneUtenteBO.getUtenteById(operatore, session);
			taratura.setOperatore(op);;
			taratura.setNote(note);
			
			session.update(taratura);
			session.getTransaction().commit();
			session.close();
			
			PrintWriter out = response.getWriter();
			myObj.addProperty("success", true);
			myObj.addProperty("messaggio", "Taratura esterna modificata con successo!");
			out.print(myObj);
	        	
	        }
        	
        	
        	
        }
	     catch(Exception e) {
	    	 
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
