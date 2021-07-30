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

import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.ConsegnaDpiDTO;
import it.portaleSTI.DTO.DocumDipendenteFornDTO;
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
				ArrayList<ConsegnaDpiDTO> lista_consegne = GestioneDpiBO.getListaConsegneDpi(session);
				ArrayList<DocumDipendenteFornDTO> lista_dipendenti = GestioneDocumentaleBO.getListaDipendenti(0, 0, session);
				
				request.getSession().setAttribute("lista_tipo_dpi", lista_tipo_dpi);
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
		
				String tipo_dpi = ret.get("tipo_dpi");
				String id_lavoratore = ret.get("lavoratore");
				String quantita = ret.get("quantita");
				String modello = ret.get("modello");
				String conformita = ret.get("conformita");
				String data_scadenza = ret.get("data_scadenza");
				String nuovo_tipo_dpi = ret.get("nuovo_tipo_dpi");
				String collettivo = ret.get("collettivo");

				ConsegnaDpiDTO consegna = new ConsegnaDpiDTO();				
				
				TipoDpiDTO tipo = null;
				
				if(tipo_dpi.equals("0")) {
					tipo = new TipoDpiDTO();
					tipo.setDescrizione(nuovo_tipo_dpi);
					tipo.setCollettivo(Integer.parseInt(collettivo));
					session.save(tipo);
				}else {
					tipo = GestioneDpiBO.getTipoDPIFromId(Integer.parseInt(tipo_dpi), session); 
				}				
				
				consegna.setTipo(tipo);	
				DocumDipendenteFornDTO lavoratore = GestioneDocumentaleBO.getDipendenteFromId(Integer.parseInt(id_lavoratore), session);
				consegna.setLavoratore(lavoratore);
				consegna.setQuantita(Integer.parseInt(quantita));
				consegna.setModello(modello);
				consegna.setConformita(conformita);
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				consegna.setData_scadenza(df.parse(data_scadenza));
				consegna.setData_consegna(new Date());
				
				session.save(consegna);
				
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
				String tipo_dpi = ret.get("tipo_dpi_mod");
				String id_lavoratore = ret.get("lavoratore_mod");
				String quantita = ret.get("quantita_mod");
				String modello = ret.get("modello_mod");
				String conformita = ret.get("conformita_mod");
				String data_scadenza = ret.get("data_scadenza_mod");
				String nuovo_tipo_dpi = ret.get("nuovo_tipo_dpi_mod");
				String collettivo = ret.get("collettivo_mod");
				
				ConsegnaDpiDTO consegna = GestioneDpiBO.getCosegnaFromID(Integer.parseInt(id_consegna),session);
				
				
				TipoDpiDTO tipo = null;
				
				if(tipo_dpi.equals("0")) {
					tipo = new TipoDpiDTO();
					tipo.setDescrizione(nuovo_tipo_dpi);
					tipo.setCollettivo(Integer.parseInt(collettivo));
					session.save(tipo);
				}else {
					tipo = GestioneDpiBO.getTipoDPIFromId(Integer.parseInt(tipo_dpi), session); 
				}				
				
				consegna.setTipo(tipo);	
				DocumDipendenteFornDTO lavoratore = GestioneDocumentaleBO.getDipendenteFromId(Integer.parseInt(id_lavoratore), session);
				consegna.setLavoratore(lavoratore);
				consegna.setQuantita(Integer.parseInt(quantita));
				consegna.setModello(modello);
				consegna.setConformita(conformita);
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				consegna.setData_scadenza(df.parse(data_scadenza));
				
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
				restituzione.setConformita(consegna.getConformita());
				restituzione.setModello(consegna.getModello());
				restituzione.setLavoratore(consegna.getLavoratore());
				restituzione.setQuantita(Integer.parseInt(quantita));
				restituzione.setTipo(consegna.getTipo());
				restituzione.setIs_restituzione(1);
				restituzione.setData_consegna(new Date());
				restituzione.setMotivazione(motivazione);
				
				session.save(restituzione);
				
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
