package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

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
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.DocumCommittenteDTO;
import it.portaleSTI.DTO.DocumDipendenteFornDTO;
import it.portaleSTI.DTO.DocumFornitoreDTO;
import it.portaleSTI.DTO.DocumReferenteFornDTO;
import it.portaleSTI.DTO.DocumTLDocumentoDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneDocumentaleBO;

/**
 * Servlet implementation class GestioneDocumentale
 */
@WebServlet("/gestioneDocumentale.do")
public class GestioneDocumentale extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneDocumentale() {
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
			
			if(action.equals("lista_committenti")) {
				
				ArrayList<DocumCommittenteDTO> lista_committenti = GestioneDocumentaleBO.getListaCommittenti(session);
				
				List<ClienteDTO> listaClienti = (List<ClienteDTO>)request.getSession().getAttribute("lista_clienti");
				if(listaClienti==null) {
					listaClienti = GestioneAnagraficaRemotaBO.getListaClienti(String.valueOf(utente.getCompany().getId()));							
				}
				
				List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				if(listaSedi== null) {
					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
				}
				request.getSession().setAttribute("lista_committenti", lista_committenti);
				request.getSession().setAttribute("lista_clienti", listaClienti);
				request.getSession().setAttribute("lista_sedi", listaSedi);
				
				session.getTransaction().commit();
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneDocumCommittenti.jsp");
		     	dispatcher.forward(request,response);
			}
			
			else if(action.equals("nuovo_committente")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}
		        
		        List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				if(listaSedi== null) {
					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
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
		
		        String id_cliente = ret.get("cliente");
		        String id_sede = ret.get("sede");				
				String referente = ret.get("referente");

				DocumCommittenteDTO committente = new DocumCommittenteDTO();
				
				ClienteDTO cl = GestioneAnagraficaRemotaBO.getClienteById(id_cliente);
				committente.setId_cliente(Integer.parseInt(id_cliente));
				committente.setNome_cliente(cl.getNome());
				
				SedeDTO sd =null;
				if(!id_sede.equals("0")) {
					committente.setId_sede(Integer.parseInt(id_sede.split("_")[0]));
					sd = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, Integer.parseInt(id_sede.split("_")[0]), Integer.parseInt(id_cliente));
					committente.setIndirizzo_cliente(sd.getIndirizzo() +" - " + sd.getComune() + " - ("+ sd.getSiglaProvincia()+")");
				}else {
					committente.setId_sede(0);
					committente.setIndirizzo_cliente(cl.getIndirizzo() +" - " + cl.getCitta() + " - ("+ cl.getProvincia()+")");
				}
				
				committente.setNominativo_referente(referente);


				session.save(committente);

				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Committente salvato con successo!");
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
			}
			
			else if(action.equals("modifica_committente")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}
		        
		        List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				if(listaSedi== null) {
					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
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
		
		        String id_committente = request.getParameter("id_committente");
		        String id_cliente = ret.get("cliente_mod");
		        String id_sede = ret.get("sede_mod");				
				String referente = ret.get("referente_mod");

				DocumCommittenteDTO committente = GestioneDocumentaleBO.getCommittenteFromID(Integer.parseInt(id_committente), session);
				
				ClienteDTO cl = GestioneAnagraficaRemotaBO.getClienteById(id_cliente);
				committente.setId_cliente(Integer.parseInt(id_cliente));
				committente.setNome_cliente(cl.getNome());
				
				SedeDTO sd =null;
				if(!id_sede.equals("0")) {
					committente.setId_sede(Integer.parseInt(id_sede.split("_")[0]));
					sd = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, Integer.parseInt(id_sede.split("_")[0]), Integer.parseInt(id_cliente));
					committente.setIndirizzo_cliente(sd.getIndirizzo() +" - " + sd.getComune() + " - ("+ sd.getSiglaProvincia()+")");
				}else {
					committente.setId_sede(0);
					committente.setIndirizzo_cliente(cl.getIndirizzo() +" - " + cl.getCitta() + " - ("+ cl.getProvincia()+")");
				}
				
				committente.setNominativo_referente(referente);
				
				session.update(committente);
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Committente modificato con successo!");
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
			}
			if(action.equals("lista_fornitori")) {
				
				ArrayList<DocumCommittenteDTO> lista_committenti = GestioneDocumentaleBO.getListaCommittenti(session);
				ArrayList<DocumFornitoreDTO> lista_fornitori = GestioneDocumentaleBO.getListaDocumFornitori(session);
				
				
				request.getSession().setAttribute("lista_committenti", lista_committenti);
				request.getSession().setAttribute("lista_fornitori", lista_fornitori);
					
				session.getTransaction().commit();
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneDocumFornitori.jsp");
		     	dispatcher.forward(request,response);
			}
			
			else if(action.equals("nuovo_fornitore")) {
				
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
		
		        String id_committente = ret.get("committente");
		        String ragione_sociale = ret.get("ragione_sociale");				
				String p_iva = ret.get("p_iva");
				String cf = ret.get("cf");
				String indirizzo = ret.get("indirizzo");
				String cap = ret.get("cap");
				String comune = ret.get("comune");
				String provincia = ret.get("provincia");
				String email = ret.get("email");

				DocumFornitoreDTO fornitore = new DocumFornitoreDTO();
				
				fornitore.setCommittente(new DocumCommittenteDTO(Integer.parseInt(id_committente)));
				fornitore.setRagione_sociale(ragione_sociale);
				fornitore.setP_iva(p_iva);
				fornitore.setCf(cf);
				fornitore.setIndirizzo(indirizzo);
				fornitore.setCap(cap);
				fornitore.setComune(comune);
				fornitore.setProvincia(provincia);
				fornitore.setEmail(email);
				fornitore.setAbilitato("S");

				session.save(fornitore);

				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Fornitore salvato con successo!");
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
			}
			
			else if(action.equals("modifica_fornitore")) {
				
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
		        String id_fornitore = request.getParameter("id_fornitore");
		        String id_committente = ret.get("committente_mod");
		        String ragione_sociale = ret.get("ragione_sociale_mod");				
				String p_iva = ret.get("p_iva_mod");
				String cf = ret.get("cf_mod");
				String indirizzo = ret.get("indirizzo_mod");
				String cap = ret.get("cap_mod");
				String comune = ret.get("comune_mod");
				String provincia = ret.get("provincia_mod");
				String email = ret.get("email_mod");

				DocumFornitoreDTO fornitore = GestioneDocumentaleBO.getFornitoreFromId(Integer.parseInt(id_fornitore), session);
				
				fornitore.setCommittente(new DocumCommittenteDTO(Integer.parseInt(id_committente)));
				fornitore.setRagione_sociale(ragione_sociale);
				fornitore.setP_iva(p_iva);
				fornitore.setCf(cf);
				fornitore.setIndirizzo(indirizzo);
				fornitore.setCap(cap);
				fornitore.setComune(comune);
				fornitore.setProvincia(provincia);
				fornitore.setEmail(email);
				

				session.update(fornitore);

				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Fornitore salvato con successo!");
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
			}
			else if(action.equals("dettaglio_fornitore")) {
				
				String id_fornitore = request.getParameter("id_fornitore");
				
				id_fornitore = Utility.decryptData(id_fornitore);
				
				DocumFornitoreDTO fornitore = GestioneDocumentaleBO.getFornitoreFromId(Integer.parseInt(id_fornitore), session);
				
				request.getSession().setAttribute("fornitore", fornitore);
				session.getTransaction().commit();
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioFornitore.jsp");
		     	dispatcher.forward(request,response);
			}
			
			if(action.equals("lista_referenti")) {
				
				ArrayList<DocumReferenteFornDTO> lista_referenti = GestioneDocumentaleBO.getListaReferenti(session);
				ArrayList<DocumFornitoreDTO> lista_fornitori = GestioneDocumentaleBO.getListaDocumFornitori(session);
				
				
				request.getSession().setAttribute("lista_referenti", lista_referenti);
				request.getSession().setAttribute("lista_fornitori", lista_fornitori);
					
				session.getTransaction().commit();
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneDocumReferenti.jsp");
		     	dispatcher.forward(request,response);
			}
			
			else if(action.equals("nuovo_referente")) {
				
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
		
		        String id_fornitore = ret.get("fornitore");
		        String id_fornitore_ref = ret.get("fornitore_ref");
		      
		        String nome = ret.get("nome");				
				String cognome = ret.get("cognome");
				String qualifica = ret.get("qualifica");
				String mansione = ret.get("mansione");
				String note = ret.get("note");


				DocumReferenteFornDTO referente = new DocumReferenteFornDTO();
				
				if(id_fornitore_ref!=null) {
					id_fornitore = id_fornitore_ref;
				}
				
	
				DocumFornitoreDTO fornitore = GestioneDocumentaleBO.getFornitoreFromId(Integer.parseInt(id_fornitore), session);
				
				referente.setId_fornitore(fornitore.getId());
				referente.setNome_fornitore(fornitore.getRagione_sociale());
				referente.setNome(nome);
				referente.setCognome(cognome);
				referente.setQualifica(qualifica);
				referente.setMansione(mansione);
				referente.setNote(note);
								
				session.save(referente);
				
				
				fornitore.getListaReferenti().add(referente);
				session.update(fornitore);
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Referente salvato con successo!");
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
			}
			
			
			else if(action.equals("modifica_referente")) {
				
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
		        
		        
		        String id_referente = request.getParameter("id_referente");
		        String id_fornitore = ret.get("fornitore_mod");
		        String id_fornitore_ref = ret.get("fornitore_ref_mod");
		        
		        String nome = ret.get("nome_mod");				
				String cognome = ret.get("cognome_mod");
				String qualifica = ret.get("qualifica_mod");
				String mansione = ret.get("mansione_mod");
				String note = ret.get("note_mod");


				if(id_fornitore_ref!=null) {
					id_fornitore = id_fornitore_ref;
				}
				
				DocumReferenteFornDTO referente = GestioneDocumentaleBO.getReferenteFromId(Integer.parseInt(id_referente), session);
				
				DocumFornitoreDTO fornitore = GestioneDocumentaleBO.getFornitoreFromId(Integer.parseInt(id_fornitore), session);
				
				fornitore.getListaReferenti().remove(referente);
				
				referente.setId_fornitore(fornitore.getId());
				referente.setNome_fornitore(fornitore.getRagione_sociale());
				referente.setNome(nome);
				referente.setCognome(cognome);
				referente.setQualifica(qualifica);
				referente.setMansione(mansione);
				referente.setNote(note);
								
				session.update(referente);
				
				fornitore.getListaReferenti().add(referente);
				
				session.update(fornitore);
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Referente modificato con successo!");
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
			}
			
			
			
			if(action.equals("lista_dipendenti")) {
				
				ArrayList<DocumDipendenteFornDTO> lista_dipendenti = GestioneDocumentaleBO.getListaDipendenti(session);
				ArrayList<DocumFornitoreDTO> lista_fornitori = GestioneDocumentaleBO.getListaDocumFornitori(session);
				
				
				request.getSession().setAttribute("lista_dipendenti", lista_dipendenti);
				request.getSession().setAttribute("lista_fornitori", lista_fornitori);
					
				session.getTransaction().commit();
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneDocumDipendenti.jsp");
		     	dispatcher.forward(request,response);
			}
			
			else if(action.equals("nuovo_dipendente")) {
				
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
		
		        String id_fornitore = ret.get("fornitore");
		        String id_fornitore_dip = ret.get("fornitore_dip");
		        String nome = ret.get("nome");				
				String cognome = ret.get("cognome");
				String qualifica = ret.get("qualifica");				
				String note = ret.get("note");


				DocumDipendenteFornDTO dipendente = new DocumDipendenteFornDTO();
				
				if(id_fornitore_dip!=null) {
					id_fornitore = id_fornitore_dip;
				}
				
				DocumFornitoreDTO fornitore = GestioneDocumentaleBO.getFornitoreFromId(Integer.parseInt(id_fornitore), session);
				
				dipendente.setId_fornitore(fornitore.getId());
				dipendente.setNome_fornitore(fornitore.getRagione_sociale());
				dipendente.setNome(nome);
				dipendente.setCognome(cognome);
				dipendente.setQualifica(qualifica);
			
				dipendente.setNote(note);
								
				session.save(dipendente);
				
				
				fornitore.getListaDipendenti().add(dipendente);
				session.update(fornitore);
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Dipendente salvato con successo!");
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
			}
			
			
			else if(action.equals("modifica_dipendente")) {
				
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
		        
		        
		        String id_dipendente = request.getParameter("id_dipendente");
		        String id_fornitore = ret.get("fornitore_mod");
		        String id_fornitore_dip = ret.get("fornitore_dip_mod");
		        String nome = ret.get("nome_mod");				
				String cognome = ret.get("cognome_mod");
				String qualifica = ret.get("qualifica_mod");
				
				String note = ret.get("note_mod");


				DocumDipendenteFornDTO dipendente = GestioneDocumentaleBO.getDipendenteFromId(Integer.parseInt(id_dipendente), session);
				
				if(id_fornitore_dip!=null) {
					id_fornitore = id_fornitore_dip;
				}
								
				DocumFornitoreDTO fornitore = GestioneDocumentaleBO.getFornitoreFromId(Integer.parseInt(id_fornitore), session);
				
				fornitore.getListaDipendenti().remove(dipendente);
				
				dipendente.setId_fornitore(fornitore.getId());
				dipendente.setNome_fornitore(fornitore.getRagione_sociale());
				dipendente.setNome(nome);
				dipendente.setCognome(cognome);
				dipendente.setQualifica(qualifica);
				
				dipendente.setNote(note);
								
				session.update(dipendente);
				
				fornitore.getListaDipendenti().add(dipendente);
				
				session.update(fornitore);
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Dipendente modificato con successo!");
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
			}
			if(action.equals("lista_documenti")) {
				
				ArrayList<DocumTLDocumentoDTO> lista_documenti = GestioneDocumentaleBO.getListaDocumenti(null, 0, session);
				ArrayList<DocumFornitoreDTO> lista_fornitori = GestioneDocumentaleBO.getListaDocumFornitori(session);
				
				
				request.getSession().setAttribute("lista_documenti", lista_documenti);
				request.getSession().setAttribute("lista_fornitori", lista_fornitori);
				request.getSession().setAttribute("data_scadenza", null);
					
				session.getTransaction().commit();
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneDocumDocumenti.jsp");
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
		      
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	                     fileItem = item;
	                     filename = item.getName();
	                     
	            	 }else
	            	 {
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	            	 }
	            	
	            }
		
		        String id_fornitore = ret.get("fornitore");
		        String nome_documento = ret.get("nome_documento");				
				String data_caricamento = ret.get("data_caricamento");
				String frequenza = ret.get("frequenza");				
				String data_scadenza = ret.get("data_scadenza");
				String rilasciato = ret.get("rilasciato");

				DocumTLDocumentoDTO documento = new DocumTLDocumentoDTO();
				
				DocumFornitoreDTO fornitore = GestioneDocumentaleBO.getFornitoreFromId(Integer.parseInt(id_fornitore), session);
				
				documento.setId_fornitore(fornitore.getId());
				documento.setNome_fornitore(fornitore.getRagione_sociale());
				documento.setNome_documento(nome_documento);
				SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
				documento.setData_caricamento(sdf.parse(data_caricamento));
				documento.setFrequenza_rinnovo_mesi(Integer.parseInt(frequenza));
				documento.setData_scadenza(sdf.parse(data_scadenza));
				documento.setNome_file(filename);
				documento.setRilasciato(rilasciato);
				
				saveFile(fileItem, fornitore.getId(), filename);
								
				session.save(documento);
				
				fornitore.getListaDocumenti().add(documento);
				session.update(fornitore);
				
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
		        
		        
		        String id_documento = request.getParameter("id_documento");
		        String id_fornitore = ret.get("fornitore_mod");
		        String nome_documento = ret.get("nome_documento_mod");				
				String data_caricamento = ret.get("data_caricamento_mod");
				String frequenza = ret.get("frequenza_mod");				
				String data_scadenza = ret.get("data_scadenza_mod");
				String rilasciato = ret.get("rilasciato_mod");
				

				DocumTLDocumentoDTO documento = GestioneDocumentaleBO.getDocumentoFromId(Integer.parseInt(id_documento), session);
				
				DocumFornitoreDTO fornitore = GestioneDocumentaleBO.getFornitoreFromId(Integer.parseInt(id_fornitore), session);
				
				documento.setId_fornitore(fornitore.getId());
				documento.setNome_fornitore(fornitore.getRagione_sociale());
				documento.setNome_documento(nome_documento);
				SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
				documento.setData_caricamento(sdf.parse(data_caricamento));
				documento.setFrequenza_rinnovo_mesi(Integer.parseInt(frequenza));
				documento.setData_scadenza(sdf.parse(data_scadenza));
				documento.setRilasciato(rilasciato);
				
				if(filename!=null && !filename.equals(""))
				{
					saveFile(fileItem, fornitore.getId(), filename);
					documento.setNome_file(filename);
				}
								
								
				session.save(documento);
				
				fornitore.getListaDocumenti().add(documento);
				session.update(fornitore);
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Documento modificato con successo!");
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
			}
			else if (action.equals("download_documento")) {
				
				String id_documento = request.getParameter("id_documento");
				
				id_documento = Utility.decryptData(id_documento);
				
				DocumTLDocumentoDTO documento = GestioneDocumentaleBO.getDocumentoFromId(Integer.parseInt(id_documento), session);
				
				response.setContentType("application/octet-stream");
				response.setHeader("Content-Disposition","attachment;filename="+ documento.getNome_file());
				downloadFile(documento.getId_fornitore(), documento.getNome_file(), response.getOutputStream());
				
				session.close();
				
			}
			else if(action.equals("elimina_documento")) {
				
				String id_documento = request.getParameter("id_documento");
				
				DocumTLDocumentoDTO documento = GestioneDocumentaleBO.getDocumentoFromId(Integer.parseInt(id_documento), session);
				
				DocumFornitoreDTO fornitore = GestioneDocumentaleBO.getFornitoreFromId(documento.getId_fornitore(), session);
				fornitore.getListaDocumenti().remove(documento);
				
				documento.setDisabilitato(1);
				
				session.update(documento);
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Documento eliminato con successo!");
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
			}
			
			else if(action.equals("scadenzario")) {				
				
				String id_fornitore = request.getParameter("id_fornitore");
				String nome_fornitore = request.getParameter("nome_fornitore");
				
				if(id_fornitore!=null) {
					id_fornitore = Utility.decryptData(id_fornitore);
				}
				request.getSession().setAttribute("id_fornitore", id_fornitore);
				request.getSession().setAttribute("nome_fornitore", nome_fornitore);
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/scadenzarioDocumentale.jsp");
			    dispatcher.forward(request,response);
			    
			    session.close();
			}
			
			else if(action.equals("create_scadenzario")) {				
				
				String id_fornitore = request.getParameter("id_fornitore");
				
			
				
				if(id_fornitore == null) {
					id_fornitore = "0";
				} 
				else if(id_fornitore.equals("0")){
					
				}
				else {
					id_fornitore= Utility.decryptData(id_fornitore);
				}
				
				HashMap<String,Integer> listaScadenze = GestioneDocumentaleBO.getDocumentiScadenza(Integer.parseInt(id_fornitore), session);
				
				ArrayList<String> lista_documenti_scadenza = new ArrayList<>();				
				
				 Iterator scadenza = listaScadenze.entrySet().iterator();
		
				    while (scadenza.hasNext()) {
				        Map.Entry pair = (Map.Entry)scadenza.next();
				        lista_documenti_scadenza.add(pair.getKey() + ";" + pair.getValue());
				        scadenza.remove(); 
				    }
		
				PrintWriter out = response.getWriter();
				
				 Gson gson = new Gson(); 
			        
			        
			        JsonElement obj_scadenze = gson.toJsonTree(lista_documenti_scadenza);
			       		       
			        myObj.addProperty("success", true);
			  
			        myObj.add("obj_scadenze", obj_scadenze);
			        
			        out.println(myObj.toString());
		
			        out.close();
			        
			     session.getTransaction().commit();
		       	session.close();
			
			}
			
			else if(action.equals("documenti_scadenza")) {
				
				String data_scadenza = request.getParameter("data_scadenza");
				String id_fornitore = request.getParameter("id_fornitore");
				
				ArrayList<DocumTLDocumentoDTO> lista_documenti = GestioneDocumentaleBO.getListaDocumenti(data_scadenza, Integer.parseInt(id_fornitore), session);
			
				ArrayList<DocumFornitoreDTO> lista_fornitori = GestioneDocumentaleBO.getListaDocumFornitori(session);
								
				request.getSession().setAttribute("lista_documenti", lista_documenti);
				request.getSession().setAttribute("lista_fornitori", lista_fornitori);
				
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				request.getSession().setAttribute("data_scadenza", df.parseObject(data_scadenza));
					
				session.getTransaction().commit();
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneDocumDocumenti.jsp");
		     	dispatcher.forward(request,response);
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

	
	
	
	
	 private void saveFile(FileItem item, int id_fornitore, String filename) {

		 	String path_folder = Costanti.PATH_FOLDER+"//Documentale//"+id_fornitore+"//";
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
	 
	 private void downloadFile(int id_fornitore, String filename, ServletOutputStream outp) throws Exception {
		 
		 String path = Costanti.PATH_FOLDER+"//Documentale//"+id_fornitore+"//"+filename;
		 
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
