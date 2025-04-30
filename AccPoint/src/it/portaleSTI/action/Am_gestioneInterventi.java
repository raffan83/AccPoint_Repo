package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
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
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.AMCampioneDTO;
import it.portaleSTI.DTO.AMInterventoDTO;
import it.portaleSTI.DTO.AMOggettoProvaDTO;
import it.portaleSTI.DTO.AMOperatoreDTO;
import it.portaleSTI.DTO.AMProvaDTO;
import it.portaleSTI.DTO.AMTipoProvaDTO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.DocumFornitoreDTO;
import it.portaleSTI.DTO.ItServizioItDTO;
import it.portaleSTI.DTO.ItTipoRinnovoDTO;
import it.portaleSTI.DTO.ItTipoServizioDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerInterventoDTO;
import it.portaleSTI.DTO.VerInterventoStrumentiDTO;
import it.portaleSTI.DTO.VerMisuraDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAM_BO;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneCommesseBO;
import it.portaleSTI.bo.GestioneDocumentaleBO;
import it.portaleSTI.bo.GestioneScadenzarioItBO;
import it.portaleSTI.bo.GestioneVerInterventoBO;
import it.portaleSTI.bo.GestioneVerStrumentiBO;

/**
 * Servlet implementation class listaCampioni
 */
@WebServlet(name="amGestioneInterventi" , urlPatterns = { "/amGestioneInterventi.do" })

public class Am_gestioneInterventi extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final Logger logger = Logger.getLogger(AMInterventoDTO.class); 
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Am_gestioneInterventi() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
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

			logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+utente.getNominativo());

			if(action.equals("lista")) 
			{
			String dateFrom = request.getParameter("dateFrom");
			String dateTo = request.getParameter("dateTo");
			
			if(dateFrom == null && dateTo == null) {
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				
				Date today = new Date();				
				
				
				Calendar cal = Calendar.getInstance();
				
				cal.setTime(today);
				
				dateTo = df.format(cal.getTime());
				
				cal.add(Calendar.DATE, -60);
				Date startDate = cal.getTime();
				
				
				dateFrom = df.format(startDate);					
				
				
			}
		/*	
			if(request.getSession().getAttribute("listaClientiAll")==null) 
			{
				request.getSession().setAttribute("listaClientiAll",GestioneAnagraficaRemotaBO.getListaClientiAll());
			}	
			
			if(request.getSession().getAttribute("listaSediAll")==null) 
			{				
					request.getSession().setAttribute("listaSediAll",GestioneAnagraficaRemotaBO.getListaSediAll());				
			}			
	*/
			List<ClienteDTO> listaClienti = (List<ClienteDTO>)request.getSession().getAttribute("lista_clienti");

			
			if(listaClienti==null) {
				listaClienti = GestioneAnagraficaRemotaBO.getListaClienti(String.valueOf(utente.getCompany().getId()));							
			}
			
			List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
			if(listaSedi== null) {
				listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
			}
			
			
			ArrayList<AMInterventoDTO> lista_interventi = GestioneAM_BO.getListaInterventi(utente, dateFrom, dateTo, session);
			
			CompanyDTO c= new CompanyDTO();
			c.setId(52);
			
			utente.setTrasversale(0);
			
			ArrayList<CommessaDTO> lista_commesse= GestioneCommesseBO.getListaCommesse(c, "", utente, 0, false);			
			
			ArrayList<AMOperatoreDTO> listaOperatori = GestioneAM_BO.getListaOperatoriAll(session);
			
			request.getSession().setAttribute("lista_interventi", lista_interventi);
		//	request.getSession().setAttribute("lista_clienti", listaClienti);				
		//	request.getSession().setAttribute("lista_sedi", listaSedi);
			request.getSession().setAttribute("lista_commesse", lista_commesse);
			request.getSession().setAttribute("lista_operatori", listaOperatori);
			
			request.getSession().setAttribute("dateTo", dateTo);
			request.getSession().setAttribute("dateFrom", dateFrom);
			
			
			
			
			
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/am_listaInterventi.jsp");
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
		
				String nome_cliente = ret.get("nomeCliente");
				String nome_cliente_utilizzatore = ret.get("nomeClienteUtilizzatore");
				String nome_sede= ret.get("nomeSede");
				String nome_sede_utilizzatore = ret.get("nomeSedeUtilizzatore");
				String commessa = ret.get("comm");
				String operatore = ret.get("operatore");
				String data_intervento = ret.get("data_intervento");
				
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				 
				AMInterventoDTO intervento = new AMInterventoDTO();	
				
				intervento.setNomeCliente(nome_cliente);
				intervento.setNomeClienteUtilizzatore(nome_cliente_utilizzatore);
				intervento.setNomeSede(nome_sede);
				intervento.setNomeSedeUtilizzatore(nome_sede_utilizzatore);
				intervento.setOperatore(new AMOperatoreDTO(Integer.parseInt(operatore), "", ""));
				intervento.setDataIntervento(df.parse(data_intervento));
				
				
				
				session.save(intervento);				
							
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Intervento salvato con successo!");
				out.print(myObj);
				
				
			}else if(action.equals("modifica")) {
				
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
		
		        String id_intervento = ret.get("id_intervento");
				String nome_cliente = ret.get("nomeCliente_mod");
				String nome_cliente_utilizzatore = ret.get("nomeClienteUtilizzatore_mod");
				String nome_sede= ret.get("nomeSede_mod");
				String nome_sede_utilizzatore = ret.get("nomeSedeUtilizzatore_mod");
				String commessa = ret.get("comm_mod");
				String operatore = ret.get("operatore_mod");
				String data_intervento = ret.get("data_intervento_mod");
				
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				 
				AMInterventoDTO intervento = GestioneAM_BO.getInterventoFromID(Integer.parseInt(id_intervento), session);	
				
				intervento.setNomeCliente(nome_cliente);
				intervento.setNomeClienteUtilizzatore(nome_cliente_utilizzatore);
				intervento.setNomeSede(nome_sede);
				intervento.setNomeSedeUtilizzatore(nome_sede_utilizzatore);
				intervento.setOperatore(new AMOperatoreDTO(Integer.parseInt(operatore), "", ""));
				intervento.setDataIntervento(df.parse(data_intervento));
				
				
				
				session.update(intervento);				
							
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Intervento salvato con successo!");
				out.print(myObj);
			}
			else if(action.equals("dettaglio")) {
				
				
				String id_intervento = request.getParameter("id_intervento");
				
				id_intervento = Utility.decryptData(id_intervento);
				AMInterventoDTO intervento = GestioneAM_BO.getInterventoFromID(Integer.parseInt(id_intervento), session);
				
				ArrayList<AMProvaDTO> lista_prove = GestioneAM_BO.getListaProveIntervento(Integer.parseInt(id_intervento), session);
				ArrayList<AMOggettoProvaDTO> lista_strumenti = GestioneAM_BO.getListaStrumenti(session);
				ArrayList<AMCampioneDTO> lista_campioni = GestioneAM_BO.getListaCampioni(session);
				ArrayList<AMTipoProvaDTO> lista_tipi_prova = GestioneAM_BO.getListaTipiProva(session);
				ArrayList<AMOperatoreDTO> lista_operatori = GestioneAM_BO.getListaOperatoriAll(session);
				
				
				request.getSession().setAttribute("intervento", intervento);
				request.getSession().setAttribute("lista_prove", lista_prove);
				request.getSession().setAttribute("lista_strumenti", lista_strumenti);
				request.getSession().setAttribute("lista_campioni", lista_campioni);
				request.getSession().setAttribute("lista_tipi_prova", lista_tipi_prova);
				request.getSession().setAttribute("lista_operatori", lista_operatori);
				
				
			
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioAMIntervento.jsp");
		  	    dispatcher.forward(request,response);
				
			}
			else if(action.equals("nuova_prova")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}
		        
		       
				FileItem fileItem_excel = null;
				String filename_excel= null;
				FileItem fileItem_img = null;
				String filename_img= null;
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	            		 if(item.getFieldName().equals("fileupload_excel")) {
	            			 fileItem_excel = item;
	            			 filename_excel = item.getName();
	            			 
	            		 }else if(item.getFieldName().equals("fileupload_img")) {
	            			 fileItem_img = item;
	            			 filename_img = item.getName();
	            		 }
	                     	                     
	            	 }else
	            	 {
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	            	 }
	            	
	            }
		
				String id_strumento = ret.get("strumento");
				String id_campione = ret.get("campione");
				String esito= ret.get("esito");
				String data = ret.get("data_prova");							
				String id_intervento = ret.get("id_intervento");
				String id_operatore= ret.get("operatore");
				String id_tipo_prova = ret.get("tipo_prova");
				
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				 
				AMProvaDTO prova = new AMProvaDTO();	
				
				AMTipoProvaDTO tipo = GestioneAM_BO.getTipoProvaFromID(Integer.parseInt(id_tipo_prova), session);
				AMCampioneDTO campione = GestioneAM_BO.getCampioneFromID(Integer.parseInt(id_campione), session);
				AMOggettoProvaDTO strumento = GestioneAM_BO.getOggettoProvaFromID(Integer.parseInt(id_strumento), session);
				AMInterventoDTO intervento = GestioneAM_BO.getInterventoFromID(Integer.parseInt(id_intervento), session);
				AMOperatoreDTO operatore = GestioneAM_BO.getOperatoreFromID(Integer.parseInt(id_operatore), session);
				
				prova.setTipoProva(tipo);
				prova.setCampione(campione);
				prova.setStrumento(strumento);
				prova.setEsito(esito);
				prova.setData(df.parse(data));
				prova.setIntervento(intervento);
				
				prova.setOperatore(operatore);
				
				session.save(prova);			
				boolean esito_import = true;
				if(fileItem_excel!=null) {
					prova.setFilename_excel(filename_excel);
					Utility.saveFile(fileItem_excel, Costanti.PATH_FOLDER+"\\AM_interventi\\"+intervento.getId()+"\\"+prova.getId()+"\\excel", filename_excel);
					
					String matrix = GestioneAM_BO.getMatrix(Costanti.PATH_FOLDER+"\\AM_interventi\\"+intervento.getId()+"\\"+prova.getId()+"\\excel\\"+filename_excel);
					if(matrix.equals("[]")) {
						esito_import = false;
					}
					
					prova.setMatrixSpess(matrix);
				}
				
				if(filename_img!=null) {
					prova.setFilename_img(filename_img);
					Utility.saveFile(fileItem_img, Costanti.PATH_FOLDER+"\\AM_interventi\\"+intervento.getId()+"\\"+prova.getId()+"\\img", filename_img);
				}
							
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				if(esito_import) {
					session.update(prova);
					myObj.addProperty("success", true);
					myObj.addProperty("messaggio", "Prova salvata con successo!");
				}else {
					session.getTransaction().rollback();
					myObj.addProperty("success", false);
					myObj.addProperty("messaggio", "Formato matrice errato!");
				}
				
				out.print(myObj);
				
				
				
				
			}
			else if(action.equals("modifica_prova")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}
		        
		       
				FileItem fileItem_excel = null;
				String filename_excel= null;
				FileItem fileItem_img = null;
				String filename_img= null;
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	            		 if(item.getFieldName().equals("fileupload_excel_mod")) {
	            			 fileItem_excel = item;
	            			 filename_excel = item.getName();
	            			 
	            		 }else if(item.getFieldName().equals("fileupload_img_mod")) {
	            			 fileItem_img = item;
	            			 filename_img = item.getName();
	            		 }
	                     	                     
	            	 }else
	            	 {
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	            	 }
	            	
	            }
		
				String id_strumento = ret.get("strumento_mod");
				String id_campione = ret.get("campione_mod");
				String esito= ret.get("esito_mod");
				String data = ret.get("data_prova_mod");							
				String id_intervento = ret.get("id_intervento_mod");
				String id_operatore= ret.get("operatore_mod");
				String id_tipo_prova = ret.get("tipo_prova_mod");
				String id_prova = ret.get("id_prova");
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				 
				AMProvaDTO prova = GestioneAM_BO.getProvaFromID(Integer.parseInt(id_prova), session);	
				
				AMTipoProvaDTO tipo = GestioneAM_BO.getTipoProvaFromID(Integer.parseInt(id_tipo_prova), session);
				AMCampioneDTO campione = GestioneAM_BO.getCampioneFromID(Integer.parseInt(id_campione), session);
				AMOggettoProvaDTO strumento = GestioneAM_BO.getOggettoProvaFromID(Integer.parseInt(id_strumento), session);
				AMInterventoDTO intervento = GestioneAM_BO.getInterventoFromID(Integer.parseInt(id_intervento), session);
				AMOperatoreDTO operatore = GestioneAM_BO.getOperatoreFromID(Integer.parseInt(id_operatore), session);
				
				prova.setTipoProva(tipo);
				prova.setCampione(campione);
				prova.setStrumento(strumento);
				prova.setEsito(esito);
				prova.setData(df.parse(data));
				prova.setIntervento(intervento);
				
				prova.setOperatore(operatore);
		
				boolean esito_import = true;
				if(filename_excel!=null && !filename_excel.equals("")) {
					prova.setFilename_excel(filename_excel);
					Utility.saveFile(fileItem_excel, Costanti.PATH_FOLDER+"\\AM_interventi\\"+intervento.getId()+"\\"+prova.getId()+"\\excel", filename_excel);
					
					String matrix = GestioneAM_BO.getMatrix(Costanti.PATH_FOLDER+"\\AM_interventi\\"+intervento.getId()+"\\"+prova.getId()+"\\excel\\"+filename_excel);
					if(matrix.equals("[]")) {
						esito_import = false;
					}
					
					prova.setMatrixSpess(matrix);
				}
				
				if(filename_img!=null && !filename_img.equals("")) {
					prova.setFilename_img(filename_img);
					Utility.saveFile(fileItem_img, Costanti.PATH_FOLDER+"\\AM_interventi\\"+intervento.getId()+"\\"+prova.getId()+"\\img", filename_img);
				}
					
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				if(esito_import) {
					session.update(prova);
					myObj.addProperty("success", true);
					myObj.addProperty("messaggio", "Prova salvata con successo!");
				}else {
					
					myObj.addProperty("success", false);
					myObj.addProperty("messaggio", "Formato matrice errato!");
				}
				
				out.print(myObj);
				
				
				
			}
			
			session.getTransaction().commit();
			session.close();
			
		} 
		catch(Exception e)
    	{
			
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
