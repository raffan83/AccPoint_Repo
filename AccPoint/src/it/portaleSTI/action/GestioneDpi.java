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
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.ConsegnaDpiDTO;
import it.portaleSTI.DTO.DocumCommittenteDTO;
import it.portaleSTI.DTO.DocumDipendenteFornDTO;
import it.portaleSTI.DTO.DocumFornitoreDTO;
import it.portaleSTI.DTO.DocumTLDocumentoDTO;
import it.portaleSTI.DTO.DpiDTO;
import it.portaleSTI.DTO.ForDocenteDTO;
import it.portaleSTI.DTO.TipoDpiDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.CreateSchedaDPI;
import it.portaleSTI.bo.GestioneDocumentaleBO;
import it.portaleSTI.bo.GestioneDpiBO;
import it.portaleSTI.bo.SendEmailBO;

/**
 * Servlet implementation class GestioneDpi
 */
@WebServlet("/gestioneDpi.do")
public class GestioneDpi extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneDpi() {
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
			
			if(action.equals("lista")) {
				
				ArrayList<TipoDpiDTO> lista_tipo_dpi = GestioneDpiBO.getListaTipoDPI(session);
				ArrayList<DpiDTO> lista_dpi = GestioneDpiBO.getListaDpi(session);
				ArrayList<DocumFornitoreDTO> lista_company = GestioneDocumentaleBO.getListaDocumFornitori(session);
				request.getSession().setAttribute("lista_tipo_dpi", lista_tipo_dpi);
				request.getSession().setAttribute("lista_dpi", lista_dpi);
				request.getSession().setAttribute("lista_company", lista_company);
				
				session.getTransaction().commit();
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaDPI.jsp");
		     	dispatcher.forward(request,response);
				
			}
			else if(action.equals("nuovo_dpi")) {
				
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
		
				String tipo_dpi = ret.get("tipo_dpi");
				String id_company = ret.get("company");
				String descrizione = ret.get("descrizione");
				String modello = ret.get("modello");
				String conformita = ret.get("conformita");
				String data_scadenza = ret.get("data_scadenza");
				String nuovo_tipo_dpi = ret.get("nuovo_tipo_dpi");
				String collettivo = ret.get("collettivo");

				DpiDTO dpi = new DpiDTO();				
				
				TipoDpiDTO tipo = null;
				
				if(tipo_dpi.equals("0")) {
					tipo = new TipoDpiDTO();
					tipo.setDescrizione(nuovo_tipo_dpi);
					if(collettivo == null) {
						collettivo = "0";
					}
					tipo.setCollettivo(Integer.parseInt(collettivo));
					session.save(tipo);
				}else {
					tipo = GestioneDpiBO.getTipoDPIFromId(Integer.parseInt(tipo_dpi), session); 
				}				
				
				DocumFornitoreDTO cmp = GestioneDocumentaleBO.getFornitoreFromId(Integer.parseInt(id_company), session);
				
				dpi.setCompany(cmp);
				dpi.setTipo(tipo);	
				dpi.setDescrizione(descrizione);
				dpi.setModello(modello);
				dpi.setConformita(conformita);
				
				if(collettivo == null) {
					collettivo = "0";
				}
				
				dpi.setCollettivo(Integer.parseInt(collettivo));
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				if(data_scadenza!=null && !data_scadenza.equals("")) {
					dpi.setData_scadenza(df.parse(data_scadenza));	
				}	
				
				session.save(dpi);				
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "DPI salvato con successo!");
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
			}
			else if(action.equals("modifica_dpi")) {
				
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
		
		        String id_dpi = ret.get("id_dpi");
				String tipo_dpi = ret.get("tipo_dpi_mod");
				String id_company = ret.get("company_mod");
				String descrizione = ret.get("descrizione_mod");
				String modello = ret.get("modello_mod");
				String conformita = ret.get("conformita_mod");
				String data_scadenza = ret.get("data_scadenza_mod");
				String nuovo_tipo_dpi = ret.get("nuovo_tipo_dpi_mod");
				String collettivo = ret.get("collettivo_mod");

				DpiDTO dpi = GestioneDpiBO.getDpiFormId(Integer.parseInt(id_dpi), session);				
				
				TipoDpiDTO tipo = null;
				
				if(collettivo == null) {
					collettivo = "0";
				}
				
				if(tipo_dpi.equals("0")) {
					tipo = new TipoDpiDTO();
					tipo.setDescrizione(nuovo_tipo_dpi);
					tipo.setCollettivo(Integer.parseInt(collettivo));
					session.save(tipo);
				}else {
					tipo = GestioneDpiBO.getTipoDPIFromId(Integer.parseInt(tipo_dpi), session); 
				}				
				
				DocumFornitoreDTO cmp = GestioneDocumentaleBO.getFornitoreFromId(Integer.parseInt(id_company), session);
				
				dpi.setCompany(cmp);
				dpi.setTipo(tipo);	
				dpi.setDescrizione(descrizione);
				dpi.setModello(modello);
				dpi.setConformita(conformita);
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				if(data_scadenza!=null && !data_scadenza.equals("")) {
					dpi.setData_scadenza(df.parse(data_scadenza));	
				}else {
					dpi.setData_scadenza(null);
				}

				dpi.setCollettivo(Integer.parseInt(collettivo));
				session.update(dpi);				
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "DPI salvato con successo!");
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
			}
			
			else if(action.equals("lista_schede_consegna")) {
				
				ArrayList<DpiDTO> lista_dpi = GestioneDpiBO.getListaDpi(session);
				ArrayList<ConsegnaDpiDTO> lista_consegne = GestioneDpiBO.getListaConsegneDpi(session);
				ArrayList<DocumDipendenteFornDTO> lista_dipendenti = GestioneDocumentaleBO.getListaDipendenti(0, 0, session);
				
				request.getSession().setAttribute("lista_dpi", lista_dpi);
				request.getSession().setAttribute("lista_consegne", lista_consegne);
				request.getSession().setAttribute("lista_dipendenti", lista_dipendenti);
				
				session.getTransaction().commit();
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaConsegneDPI.jsp");
		     	dispatcher.forward(request,response);
				
			}
			else if(action.equals("nuova_consegna")) {
				
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
		
				String id_dpi = ret.get("id_dpi");
				String id_lavoratore = ret.get("lavoratore");
				String commessa = ret.get("commessa");

				ConsegnaDpiDTO consegna = new ConsegnaDpiDTO();				
				
				DpiDTO dpi = GestioneDpiBO.getDpiFormId(Integer.parseInt(id_dpi), session);				
				
				consegna.setDpi(dpi);	
				DocumDipendenteFornDTO lavoratore = GestioneDocumentaleBO.getDipendenteFromId(Integer.parseInt(id_lavoratore), session);
				consegna.setLavoratore(lavoratore);
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				consegna.setData_consegna(new Date());
				consegna.setCommessa(commessa);
				
				dpi.setAssegnato(1);
				
				session.save(consegna);
				
				session.update(dpi);
				
				SendEmailBO.sendEmailAccettazioneConsegna(consegna, request.getServletContext());
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Consegna salvata con successo!");
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
			}
			
			else if(action.equals("modifica_consegna")) {
				
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
		
		        String id_consegna = ret.get("id_consegna");
				String id_dpi = ret.get("id_dpi_mod");
				String id_lavoratore = ret.get("lavoratore_mod");
				String commessa = ret.get("commessa_mod");
				
				ConsegnaDpiDTO consegna = GestioneDpiBO.getCosegnaFromID(Integer.parseInt(id_consegna),session);
				
				
				DpiDTO dpi = GestioneDpiBO.getDpiFormId(Integer.parseInt(id_dpi), session);	
				consegna.setDpi(dpi);	
				DocumDipendenteFornDTO lavoratore = GestioneDocumentaleBO.getDipendenteFromId(Integer.parseInt(id_lavoratore), session);
				consegna.setLavoratore(lavoratore);
		
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				consegna.setCommessa(commessa);
				//consegna.setData_consegna(new Date());
				
				session.update(consegna);
				
				
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Consegna salvata con successo!");
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
			}
			else if(action.equals("crea_restituzione")) {
				
				String id_consegna = request.getParameter("id_consegna");
				String motivazione = request.getParameter("motivazione");	
				String quantita = request.getParameter("quantita_rest");
				
				ConsegnaDpiDTO consegna = GestioneDpiBO.getCosegnaFromID(Integer.parseInt(id_consegna), session);
				
				ConsegnaDpiDTO restituzione = new ConsegnaDpiDTO();
				restituzione.setLavoratore(consegna.getLavoratore());				
				restituzione.setDpi(consegna.getDpi());
				restituzione.setIs_restituzione(1);
				restituzione.setData_consegna(new Date());
				restituzione.setMotivazione(motivazione);
				restituzione.setCommessa(consegna.getCommessa());
				
				session.save(restituzione);
				
				restituzione.getDpi().setAssegnato(0);
				session.update(restituzione.getDpi());
				
				consegna.setRestituzione(restituzione);
				session.update(consegna);
				
				SendEmailBO.sendEmailRiconsegnaDPI(consegna, request.getServletContext());
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Riconsegna salvata con successo!");
				out.print(myObj);
				session.getTransaction().commit();
				session.close();
				
				
			}
			else if(action.equals("nuova_scheda_dpi")) {				
				
				ajax = false;
				
//				response.setContentType("application/json");
//				 
//			  	List<FileItem> items = null;
//		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {
//
//		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
//		        	}
//		        
//		       
//				FileItem fileItem = null;
//				String filename= null;
//		        Hashtable<String,String> ret = new Hashtable<String,String>();
//		      
//		        for (FileItem item : items) {
//	            	 if (!item.isFormField()) {
//	            		
//	                     fileItem = item;
//	                     filename = item.getName();
//	                     
//	            	 }else
//	            	 {
//	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
//	            	 }
//	            	
//	            }
		
		        String tipo_scheda = request.getParameter("tipo_scheda");
				String id_lavoratore = request.getParameter("lavoratore_scheda");
				
				DocumDipendenteFornDTO lavoratore = null;
				
				if(id_lavoratore!=null && !id_lavoratore.equals("")) {
					lavoratore =  GestioneDocumentaleBO.getDipendenteFromId(Integer.parseInt(id_lavoratore), session);
				}				
				
				new CreateSchedaDPI(Integer.parseInt(tipo_scheda), lavoratore, session);
				
				
				String path = Costanti.PATH_FOLDER+"\\GestioneDPI\\";
				
				if(Integer.parseInt(tipo_scheda) == 0) {
					path = path + "SchedaConsegnaDPI.pdf"; 
				}else if(Integer.parseInt(tipo_scheda) == 1) {
					path = path + "SchedaRiconsegnaDPI.pdf";
				}else if(Integer.parseInt(tipo_scheda) ==2) {
					path = path + "SchedaDPICollettivi.pdf";
				}
				
				
				File file = new File(path);
				
				FileInputStream fileIn = new FileInputStream(file);
				 
				 response.setContentType("application/octet-stream");
				  
				 response.setHeader("Content-Disposition","attachment;filename="+ file.getName());
				 
				 ServletOutputStream outp = response.getOutputStream();
				     
				    byte[] outputByte = new byte[1];
				    
				    while(fileIn.read(outputByte, 0, 1) != -1)
				    {
				    	outp.write(outputByte, 0, 1);
				    }
				    session.close();
				    
				    fileIn.close();
				    outp.flush();
				    outp.close();
				
			}
			
			else if(action.equals("storico")) {
				
			String id_dpi = request.getParameter("id_dpi");
			
			ArrayList<ConsegnaDpiDTO> lista_eventi = GestioneDpiBO.getListaEventiFromDPI(Integer.parseInt(id_dpi), session);
			
			PrintWriter out = response.getWriter();
			response.setContentType("application/json");
			 Gson gson = new GsonBuilder().setDateFormat("dd/MM/yyyy").create(); 			        			        
		     			      		       
		        myObj.addProperty("success", true);
		
		        myObj.add("lista_eventi", gson.toJsonTree(lista_eventi));			      
		        
		        out.println(myObj.toString());
	
		        out.close();
		        
		     session.getTransaction().commit();
	       	session.close();
				
			}
			else if(action.equals("scadenzario")) {
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/scadenzarioDPI.jsp");
			    dispatcher.forward(request,response);
			    
			    session.close();
				
			}
			
			else if(action.equals("scadenzario_table")) {
				
				String dateFrom = request.getParameter("dateFrom");
				String dateTo = request.getParameter("dateTo");					
				
				ArrayList<DpiDTO> lista_dpi = GestioneDpiBO.getListaDpiScadenzario(dateFrom,dateTo, session);
				
				request.getSession().setAttribute("lista_dpi", lista_dpi);
				request.getSession().setAttribute("dateFrom", dateFrom);
				request.getSession().setAttribute("dateTo", dateTo);
								
				//session.getTransaction().commit();
				session.close();
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/scadenzarioDpiTable.jsp");
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

}
