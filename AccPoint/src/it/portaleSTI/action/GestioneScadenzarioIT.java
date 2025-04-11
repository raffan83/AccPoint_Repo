package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
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

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CoAttrezzaturaDTO;
import it.portaleSTI.DTO.CoTipoAttrezzaturaDTO;
import it.portaleSTI.DTO.CoTipoControlloDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.DocumFornitoreDTO;
import it.portaleSTI.DTO.ItServizioItDTO;
import it.portaleSTI.DTO.ItTipoRinnovoDTO;
import it.portaleSTI.DTO.ItTipoServizioDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneControlliOperativiBO;
import it.portaleSTI.bo.GestioneDocumentaleBO;
import it.portaleSTI.bo.GestioneScadenzarioItBO;

/**
 * Servlet implementation class GestioneScadenzarioIT
 */
@WebServlet("/gestioneScadenzarioIT.do")
public class GestioneScadenzarioIT extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneScadenzarioIT() {
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
			if(action!=null && action.equals("lista")) {
				
				ArrayList<ItServizioItDTO> lista_servizi = GestioneScadenzarioItBO.getListaServizi(session);
				ArrayList<ItTipoRinnovoDTO> lista_tipi_rinnovo = GestioneScadenzarioItBO.getListaTipiRinnovo(session);
				ArrayList<ItTipoServizioDTO> lista_tipi_servizi = GestioneScadenzarioItBO.getListaTipiServizi(session);
				
				ArrayList<DocumFornitoreDTO> lista_company = GestioneDocumentaleBO.getListaDocumFornitori(session);				 
				
				request.getSession().setAttribute("lista_company", lista_company);				
				request.getSession().setAttribute("lista_servizi", lista_servizi);
				request.getSession().setAttribute("lista_tipi_rinnovo", lista_tipi_rinnovo);
				request.getSession().setAttribute("lista_tipi_servizi", lista_tipi_servizi);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/scadenzarioIT.jsp");
   		     dispatcher.forward(request,response);	
			}
			else if(action.equals("nuovo_servizio")) {
				
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
		
				String id_tipo_servizio = ret.get("tipo_servizio");
				String id_tipo_rinnovo = ret.get("tipo_rinnovo");
				String descrizione = ret.get("descrizione");
				String fornitore = ret.get("fornitore");
				String email_referenti = ret.get("email_referenti");
				String nuovo_tipo_servizio = ret.get("nuovo_tipo_servizio");
				String nuovo_tipo_rinnovo = ret.get("nuovo_tipo_rinnovo");
				String data_scadenza = ret.get("data_scadenza");
				String data_acquisto = ret.get("data_acquisto");
				String modalita_pagamento = ret.get("modalita_pagamento");
				String company = ret.get("company");
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				ItServizioItDTO servizio = new ItServizioItDTO();	
				
				ItTipoServizioDTO tipo_servizio = null;
				ItTipoRinnovoDTO tipo_rinnovo = null;
				
				if(nuovo_tipo_servizio!=null && !nuovo_tipo_servizio.equals("")) {
					tipo_servizio = new ItTipoServizioDTO();
					tipo_servizio.setDescrizione(nuovo_tipo_servizio);
					session.save(tipo_servizio);
				}else {
					tipo_servizio = GestioneScadenzarioItBO.getElement(new ItTipoServizioDTO(),Integer.parseInt(id_tipo_servizio), session);
				}
				if(nuovo_tipo_rinnovo!=null && !nuovo_tipo_rinnovo.equals("")) {
					
						tipo_rinnovo = new ItTipoRinnovoDTO();
						tipo_rinnovo.setDescrizione(nuovo_tipo_rinnovo);
						
						session.save(tipo_rinnovo);
				}else {
					tipo_rinnovo = GestioneScadenzarioItBO.getElement(new ItTipoRinnovoDTO(),Integer.parseInt(id_tipo_rinnovo), session);
				}
			
				servizio.setTipo_servizio(tipo_servizio);
				servizio.setTipo_rinnovo(tipo_rinnovo);
				servizio.setDescrizione(descrizione);
				servizio.setFornitore(fornitore);
				servizio.setEmail_referenti(email_referenti);
				servizio.setModalita_pagamento(modalita_pagamento);
				
				if(company!=null && !company.equals("")&& !company.equals("0")) {
					DocumFornitoreDTO cmp = GestioneDocumentaleBO.getFornitoreFromId(Integer.parseInt(company), session);
					servizio.setId_company(cmp);
				}else {
					servizio.setId_company(null);
				}
				if(data_acquisto!=null && !data_acquisto.equals("")) {
					servizio.setData_acquisto(df.parse(data_acquisto));
				}
				
			
				if(data_scadenza!=null && !data_scadenza.equals("")) {
					
					servizio.setData_scadenza(df.parse(data_scadenza));
					
					Calendar c = Calendar.getInstance();
					
					if(df.parse(data_scadenza).before(new Date())) {
						servizio.setStato(2);
						c.setTime(new Date());
						c.add(Calendar.DAY_OF_YEAR, 1);
						servizio.setData_remind(c.getTime());
					}else {
						servizio.setStato(1);
						c.setTime(df.parse(data_scadenza));
						c.add(Calendar.DAY_OF_YEAR, -30);
						if(c.getTime().before(new Date())) {
							c.setTime(df.parse(data_scadenza));
							c.add(Calendar.DAY_OF_YEAR, -15);
							
							if(c.getTime().before(new Date())) {
								servizio.setData_remind(servizio.getData_scadenza());
							}else {
								servizio.setData_remind(c.getTime());
							}
							
						}else {
							servizio.setData_remind(c.getTime());
						}
						
					}
					
					
											
				}
				
				session.save(servizio);				
							
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Servizio salvato con successo!");
				out.print(myObj);
				
			}
			else if(action.equals("modifica_servizio")) {
				
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
		
		        String id_servizio = ret.get("id_servizio");
				String id_tipo_servizio = ret.get("tipo_servizio_mod");
				String id_tipo_rinnovo = ret.get("tipo_rinnovo_mod");
				String descrizione = ret.get("descrizione_mod");
				String fornitore = ret.get("fornitore_mod");
				String email_referenti = ret.get("email_referenti_mod");
				String nuovo_tipo_servizio = ret.get("nuovo_tipo_servizio_mod");
				String nuovo_tipo_rinnovo = ret.get("nuovo_tipo_rinnovo_mod");
				String data_scadenza = ret.get("data_scadenza_mod");
				String data_acquisto = ret.get("data_acquisto_mod");
				String modalita_pagamento = ret.get("modalita_pagamento_mod");
				String company = ret.get("company_mod");
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				ItServizioItDTO servizio = GestioneScadenzarioItBO.getElement(new ItServizioItDTO(),Integer.parseInt(id_servizio), session);	
				
				ItTipoServizioDTO tipo_servizio = null;
				ItTipoRinnovoDTO tipo_rinnovo = null;
				
				if(nuovo_tipo_servizio!=null && !nuovo_tipo_servizio.equals("")) {
					tipo_servizio = new ItTipoServizioDTO();
					tipo_servizio.setDescrizione(nuovo_tipo_servizio);
					session.save(tipo_servizio);
				}else {
					tipo_servizio = GestioneScadenzarioItBO.getElement(new ItTipoServizioDTO(),Integer.parseInt(id_tipo_servizio), session);
				}
				if(nuovo_tipo_rinnovo!=null && !nuovo_tipo_rinnovo.equals("")) {
					
						tipo_rinnovo = new ItTipoRinnovoDTO();
						tipo_rinnovo.setDescrizione(nuovo_tipo_rinnovo);
						
						session.save(tipo_rinnovo);
				}else {
					tipo_rinnovo = GestioneScadenzarioItBO.getElement(new ItTipoRinnovoDTO(),Integer.parseInt(id_tipo_rinnovo), session);
				}
			
				if(company!=null && !company.equals("")&& !company.equals("0")) {
					DocumFornitoreDTO cmp = GestioneDocumentaleBO.getFornitoreFromId(Integer.parseInt(company), session);
					servizio.setId_company(cmp);
				}else {
					servizio.setId_company(null);
				}
				servizio.setTipo_servizio(tipo_servizio);
				servizio.setTipo_rinnovo(tipo_rinnovo);
				servizio.setDescrizione(descrizione);
				servizio.setFornitore(fornitore);
				servizio.setEmail_referenti(email_referenti);
				servizio.setModalita_pagamento(modalita_pagamento);
			
				
				if(data_scadenza!=null && !data_scadenza.equals("")) {
					
					servizio.setData_scadenza(df.parse(data_scadenza));
					
					Calendar c = Calendar.getInstance();
					
					if(df.parse(data_scadenza).before(new Date())) {
						servizio.setStato(2);
						c.setTime(new Date());
						c.add(Calendar.DAY_OF_YEAR, 1);
						servizio.setData_remind(c.getTime());
					}else {
						servizio.setStato(1);
						c.setTime(df.parse(data_scadenza));
						c.add(Calendar.DAY_OF_YEAR, -60);
						if(c.getTime().before(new Date())) {
							c.setTime(df.parse(data_scadenza));
							c.add(Calendar.DAY_OF_YEAR, -30);
							
							if(c.getTime().before(new Date())) {
								servizio.setData_remind(servizio.getData_scadenza());
							}else {
								servizio.setData_remind(c.getTime());
							}
							
						}else {
							servizio.setData_remind(c.getTime());
						}
						
					}
					
					
											
				}
				
				if(data_acquisto!=null && !data_acquisto.equals("")) {
					servizio.setData_acquisto(df.parse(data_acquisto));
				}
				
				session.save(servizio);				
							
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Servizio salvato con successo!");
				out.print(myObj);
				
			}
			else if(action.equals("elimina_servizio")) {
				
				ajax = true;
				String id = request.getParameter("id_servizio_elimina");
				
				ItServizioItDTO servizio = GestioneScadenzarioItBO.getElement(new ItServizioItDTO(),Integer.parseInt(id), session);
				servizio.setDisabilitato(1);
				
				session.update(servizio);
				
				
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Servizio eliminato con successo!");
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
