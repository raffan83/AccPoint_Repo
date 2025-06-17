package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

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

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.ForCorsoDTO;
import it.portaleSTI.DTO.ForPartecipanteDTO;
import it.portaleSTI.DTO.ForPartecipanteRuoloCorsoDTO;
import it.portaleSTI.DTO.PRRequisitoDocumentaleDTO;
import it.portaleSTI.DTO.PRRequisitoRisorsaDTO;
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
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		String action = request.getParameter("action");
		UtenteDTO utente =(UtenteDTO)request.getSession().getAttribute("userObj");
		CompanyDTO company =(CompanyDTO)request.getSession().getAttribute("usrCompany");
		
		JsonObject myObj = new JsonObject();
		boolean ajax = false;
		
		try {
			
			if(action.equals("dettaglio_risorsa")) {
				
				String id = request.getParameter("id_risorsa");
				String id_partecipante = request.getParameter("id_partecipante");
				
				
				ArrayList<PRRequisitoRisorsaDTO> lista_requisiti_risorsa = null;
				PRRisorsaDTO risorsa = null; 
				if(id!=null && !id.equals("")) {
				risorsa = (PRRisorsaDTO) session.get(PRRisorsaDTO.class, Integer.parseInt(id));
				
				lista_requisiti_risorsa = GestioneRisorseBO.getListaRequisitiRisorsa(risorsa.getId(),session);				
				
				id_partecipante = ""+risorsa.getPartecipante().getId();
				}
				
				ArrayList<ForCorsoDTO> lista_corsi = null;
				if(id_partecipante!=null && !id_partecipante.equals("")) {
					 lista_corsi = GestioneFormazioneBO.getListaCorsiInCorsoPartecipante(Integer.parseInt(id_partecipante), session);
				}
				
						
			
				Gson g = new GsonBuilder().setDateFormat("dd/MM/yyyy").create();
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.add("lista_requisiti_risorsa", g.toJsonTree(lista_requisiti_risorsa));
				myObj.add("lista_corsi", g.toJsonTree(lista_corsi));
				myObj.add("risorsa", g.toJsonTree(risorsa));
				out.print(myObj);
				
			}
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
				ArrayList<UtenteDTO> lista_utenti_all = GestioneUtenteBO.getDipendenti(session);				
				ArrayList<ForPartecipanteDTO> lista_partecipanti_all = GestioneFormazioneBO.getListaPartecipantiCliente(4132, 0, session);
				ArrayList<PRRequisitoDocumentaleDTO> lista_requisiti_documentali = GestioneRisorseBO.getListaRequisitiDocumentali(session);
				ArrayList<PRRequisitoSanitarioDTO> lista_requisiti_sanitari = GestioneRisorseBO.getListaRequisitiSanitari(session);
				
		
				Set<Integer> idUtentiInRisorse = new HashSet<>();
				for (PRRisorsaDTO risorsa : lista_risorse) {
				    if (risorsa.getUtente() != null) {
				        idUtentiInRisorse.add(risorsa.getUtente().getId()); 
				    }
				}

				ArrayList<UtenteDTO> lista_utenti_filtrata = new ArrayList<>();
				for (UtenteDTO u : lista_utenti_all) {
				    if (!idUtentiInRisorse.contains(u.getId())) {
				        lista_utenti_filtrata.add(u);
				    }
				}
				
				Set<Integer> idPartecipantiInRisorse = new HashSet<>();
				for (PRRisorsaDTO risorsa : lista_risorse) {
				    if (risorsa.getPartecipante() != null) {
				        idPartecipantiInRisorse.add(risorsa.getPartecipante().getId());
				    }
				}

				ArrayList<ForPartecipanteDTO> lista_partecipanti_filtrata = new ArrayList<>();
				for (ForPartecipanteDTO partecipante : lista_partecipanti_all) {
				    if (!idPartecipantiInRisorse.contains(partecipante.getId())) {
				        lista_partecipanti_filtrata.add(partecipante);
				    }
				}
				
				request.getSession().setAttribute("lista_risorse", lista_risorse);
				request.getSession().setAttribute("lista_utenti", lista_utenti_filtrata);
				request.getSession().setAttribute("lista_partecipanti", lista_partecipanti_filtrata);
				request.getSession().setAttribute("lista_utenti_all", lista_utenti_all);
				request.getSession().setAttribute("lista_partecipanti_all", lista_partecipanti_all);
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
				String id_req_documentali = ret.get("id_req_documentali");
				String id_req_sanitari = ret.get("id_req_sanitari");
				
				PRRisorsaDTO risorsa = new PRRisorsaDTO();
				UtenteDTO user = (UtenteDTO) session.get(UtenteDTO.class, Integer.parseInt(id_utente));
				ForPartecipanteDTO partecipante = (ForPartecipanteDTO) session.get(ForPartecipanteDTO.class, Integer.parseInt(id_partecipante));
				
				risorsa.setUtente(user);
				risorsa.setPartecipante(partecipante);
				
				
				
				if(id_req_sanitari!=null) {
//					
//					if(id_req_documentali!=null && !id_req_documentali.equals("")) {
//						for (int i = 0; i < id_req_documentali.split(";").length;i++) {
//							
//							if(!id_req_documentali.split(";")[i].equals("")) {
//							PRRequisitoRisorsaDTO req_risorsa = new PRRequisitoRisorsaDTO();
//							req_risorsa.setRisorsa(risorsa.getId());
//							PRRequisitoDocumentaleDTO req_doc = (PRRequisitoDocumentaleDTO) session.get(PRRequisitoDocumentaleDTO.class, Integer.parseInt(id_req_documentali.split(";")[i]));
//							req_risorsa.setReq_documentale(req_doc);
//							//session.save(req_risorsa);
//							risorsa.getListaRequisiti().add(req_risorsa);
//							}
//						}
//						
//					}
					DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
					
					if(id_req_sanitari!=null && !id_req_sanitari.equals("")) {
						for (int i = 0; i < id_req_sanitari.split(";").length;i++) {
							PRRequisitoRisorsaDTO req_risorsa = new PRRequisitoRisorsaDTO();
							req_risorsa.setRisorsa(risorsa.getId());
							String[] str_sanitari = id_req_sanitari.split(";")[i].split(",");
							PRRequisitoSanitarioDTO req_san = (PRRequisitoSanitarioDTO) session.get(PRRequisitoSanitarioDTO.class, Integer.parseInt(str_sanitari[0]));
							String stato = str_sanitari[1];
							Date data_inizio = df.parse(str_sanitari[2]);
							Date data_fine = df.parse(str_sanitari[3]);
							
							req_risorsa.setReq_sanitario(req_san);
							req_risorsa.setReq_san_data_inizio(data_inizio);
							req_risorsa.setReq_san_data_fine(data_fine);
							req_risorsa.setStato(Integer.parseInt(stato));
							risorsa.getListaRequisiti().add(req_risorsa);
							}
						}
					
					
				}
				
				session.saveOrUpdate(risorsa);
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Salvato con successo!");
				out.print(myObj);
				
				
			}
			else if(action.equals("modifica_risorsa")) {
				
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
		
				String id_utente = ret.get("utente_mod");
				String id_partecipante = ret.get("partecipante_mod");
				String id_req_documentali = ret.get("id_req_documentali_mod");
				String id_req_sanitari = ret.get("id_req_sanitari_mod");
				String id_risorsa = ret.get("id_risorsa");
				
				PRRisorsaDTO risorsa = (PRRisorsaDTO) session.get(PRRisorsaDTO.class, Integer.parseInt(id_risorsa));
				UtenteDTO user = (UtenteDTO) session.get(UtenteDTO.class, Integer.parseInt(id_utente));
				ForPartecipanteDTO partecipante = (ForPartecipanteDTO) session.get(ForPartecipanteDTO.class, Integer.parseInt(id_partecipante));
				
				risorsa.setUtente(user);
				risorsa.setPartecipante(partecipante);
				
				//session.saveOrUpdate(risorsa);
				
				risorsa.getListaRequisiti().clear();
				
		
				session.update(risorsa);
				
				if(id_req_documentali!= null || id_req_sanitari!=null) {
					
					if(id_req_documentali!=null && !id_req_documentali.equals("")) {
						for (int i = 0; i < id_req_documentali.split(";").length;i++) {
							
							if(!id_req_documentali.split(";")[i].equals("")) {
							PRRequisitoRisorsaDTO req_risorsa = new PRRequisitoRisorsaDTO();
							req_risorsa.setRisorsa(risorsa.getId());
							PRRequisitoDocumentaleDTO req_doc = (PRRequisitoDocumentaleDTO) session.get(PRRequisitoDocumentaleDTO.class, Integer.parseInt(id_req_documentali.split(";")[i]));
							req_risorsa.setReq_documentale(req_doc);
							//session.save(req_risorsa);
							risorsa.getListaRequisiti().add(req_risorsa);
							}
						}
						
					}
					DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
					
					if(id_req_sanitari!=null && !id_req_sanitari.equals("")) {
						for (int i = 0; i < id_req_sanitari.split(";").length;i++) {
							PRRequisitoRisorsaDTO req_risorsa = new PRRequisitoRisorsaDTO();
							req_risorsa.setRisorsa(risorsa.getId());
							String[] str_sanitari = id_req_sanitari.split(";")[i].split(",");
							PRRequisitoSanitarioDTO req_san = (PRRequisitoSanitarioDTO) session.get(PRRequisitoSanitarioDTO.class, Integer.parseInt(str_sanitari[0]));
							String stato = str_sanitari[1];
							Date data_inizio = df.parse(str_sanitari[2]);
							Date data_fine = df.parse(str_sanitari[3]);
							
							req_risorsa.setReq_sanitario(req_san);
							req_risorsa.setReq_san_data_inizio(data_inizio);
							req_risorsa.setReq_san_data_fine(data_fine);
							req_risorsa.setStato(Integer.parseInt(stato));
							//session.save(req_risorsa);
							risorsa.getListaRequisiti().add(req_risorsa);
							}
						}
					
					
				}
				session.update(risorsa);
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Salvato con successo!");
				out.print(myObj);
				
			}
			else if(action.equals("elimina_risorsa")) {
				
				ajax = true;
				String id_risorsa = request.getParameter("id_risorsa");
				
				PRRisorsaDTO risorsa = (PRRisorsaDTO) session.get(PRRisorsaDTO.class, Integer.parseInt(id_risorsa));
				risorsa.setDisabilitato(1);
				
				session.update(risorsa);
				
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
