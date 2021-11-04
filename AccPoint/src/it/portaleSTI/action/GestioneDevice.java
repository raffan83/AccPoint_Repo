package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
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
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.DevAllegatiDeviceDTO;
import it.portaleSTI.DTO.DevAllegatiSoftwareDTO;
import it.portaleSTI.DTO.DevDeviceDTO;
import it.portaleSTI.DTO.DevDeviceSoftwareDTO;
import it.portaleSTI.DTO.DevLabelConfigDTO;
import it.portaleSTI.DTO.DevLabelTipoInterventoDTO;
import it.portaleSTI.DTO.DevProceduraDTO;
import it.portaleSTI.DTO.DevProceduraDeviceDTO;
import it.portaleSTI.DTO.DevRegistroAttivitaDTO;
import it.portaleSTI.DTO.DevSoftwareDTO;
import it.portaleSTI.DTO.DevStatoValidazioneDTO;
import it.portaleSTI.DTO.DevTestoEmailDTO;
import it.portaleSTI.DTO.DevTipoDeviceDTO;
import it.portaleSTI.DTO.DevTipoEventoDTO;
import it.portaleSTI.DTO.DevTipoProceduraDTO;
import it.portaleSTI.DTO.DocumDipendenteFornDTO;
import it.portaleSTI.DTO.DocumFornitoreDTO;
import it.portaleSTI.DTO.DpiDTO;
import it.portaleSTI.DTO.TipoDpiDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerAllegatoStrumentoDTO;
import it.portaleSTI.DTO.VerStrumentoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneDeviceBO;
import it.portaleSTI.bo.GestioneDocumentaleBO;
import it.portaleSTI.bo.GestioneDpiBO;
import it.portaleSTI.bo.GestioneVerStrumentiBO;

/**
 * Servlet implementation class GestioneDevice
 */
@WebServlet("/gestioneDevice.do")
public class GestioneDevice extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneDevice() {
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
			
			if(action.equals("lista_tipi_device")) {
			
				ArrayList<DevTipoDeviceDTO> lista_tipi_device = GestioneDeviceBO.getListaTipiDevice(session);
				
				request.getSession().setAttribute("lista_tipi_device", lista_tipi_device);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaTipiDevice.jsp");
		     	dispatcher.forward(request,response);
			}
			else if(action.equals("nuovo_tipo_device")) {
				
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
		
				String descrizione = ret.get("descrizione");

				DevTipoDeviceDTO tipo_device = new 	DevTipoDeviceDTO();	
				tipo_device.setDescrizione(descrizione);
				
				session.save(tipo_device);				
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Tipo device salvato con successo!");
				out.print(myObj);
				
			}
			else if(action.equals("modifica_tipo_device")) {
				
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
		
		        String id_tipo_device = ret.get("id_tipo_device");
				String descrizione = ret.get("descrizione_mod");

				DevTipoDeviceDTO tipo_device = GestioneDeviceBO.getTipoDeviceFromID(Integer.parseInt(id_tipo_device), session);
				tipo_device.setDescrizione(descrizione);
				
				session.update(tipo_device);				
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Tipo device salvato con successo!");
				out.print(myObj);
				
			}
			
			else if(action.equals("lista_device")) {
				
				String id_company = request.getParameter("id_company");
				
				if(id_company == null) {
					id_company = "0";
				}else {
					id_company = Utility.decryptData(id_company);	
				}				
				
				
				ArrayList<DevDeviceDTO> lista_device = GestioneDeviceBO.getListaDevice(Integer.parseInt(id_company),session);
				ArrayList<DevTipoDeviceDTO> lista_tipi_device = GestioneDeviceBO.getListaTipiDevice(session);
				ArrayList<DocumFornitoreDTO> lista_company = GestioneDocumentaleBO.getListaDocumFornitori(session);
				ArrayList<DocumDipendenteFornDTO> lista_dipendenti = GestioneDocumentaleBO.getListaDipendenti(0, 0, session);
				ArrayList<DevLabelConfigDTO> lista_configurazioni = GestioneDeviceBO.getListaLabelConfigurazioni(session);
				ArrayList<DevStatoValidazioneDTO> lista_stati_validazione = GestioneDeviceBO.getListaStatiValidazione(session);
				 
				
				Collections.sort(lista_dipendenti);
				
				request.getSession().setAttribute("lista_device", lista_device);
				request.getSession().setAttribute("lista_tipi_device", lista_tipi_device);
				request.getSession().setAttribute("lista_company", lista_company);
				request.getSession().setAttribute("lista_dipendenti", lista_dipendenti);
				request.getSession().setAttribute("lista_configurazioni", lista_configurazioni);
				request.getSession().setAttribute("lista_stati_validazione", lista_stati_validazione);
				request.getSession().setAttribute("id_company", id_company);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaDevice.jsp");
		     	dispatcher.forward(request,response);
			}
			else if(action.equals("nuovo_device")) {
				
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
		
				String codice_interno = ret.get("codice_interno");
				String id_company = ret.get("company");
				String id_tipo_device = ret.get("tipo_device");
				String denominazione = ret.get("denominazione");
				String costruttore = ret.get("costruttore");
				String modello = ret.get("modello");
				String distributore = ret.get("distributore");
				String data_acquisto = ret.get("data_acquisto");
				String data_creazione = ret.get("data_creazione");
				String ubicazione = ret.get("ubicazione");
				String configurazione = ret.get("configurazione");
				String id_dipendente = ret.get("dipendente");
				String nuova_label_configurazione = ret.get("nuova_label_configurazione");

				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				DevDeviceDTO device = new DevDeviceDTO();
				device.setCodice_interno(codice_interno);
				DocumFornitoreDTO company = GestioneDocumentaleBO.getFornitoreFromId(Integer.parseInt(id_company), session);
				device.setCompany(company);
				device.setTipo_device(new DevTipoDeviceDTO(Integer.parseInt(id_tipo_device), ""));
				
				device.setDenominazione(denominazione);
				device.setCostruttore(costruttore);
				device.setModello(modello);
				device.setDistributore(distributore);
				if(data_acquisto!=null && !data_acquisto.equals("")) {
					device.setData_acquisto(df.parse(data_acquisto));
				}
				if(data_creazione!=null && !data_creazione.equals("")) {
					device.setData_creazione(df.parse(data_creazione));
				}else {
					device.setData_creazione(new Date());
				}
				device.setUbicazione(ubicazione);
				device.setConfigurazione(configurazione);
				if(id_dipendente!=null && !id_dipendente.equals("")) {
					DocumDipendenteFornDTO dipendente = GestioneDocumentaleBO.getDipendenteFromId(Integer.parseInt(id_dipendente), session);
					device.setDipendente(dipendente);
				}
				device.setData_cambio_company(new Date());
				
				session.save(device);			
				
				if(nuova_label_configurazione!=null && !nuova_label_configurazione.equals("")) {
					for(int i = 0;i<nuova_label_configurazione.split(";").length;i++) {
						DevLabelConfigDTO label = new DevLabelConfigDTO();
						label.setDescrizione(nuova_label_configurazione.split(";")[i]);
						session.save(label);
					}
					
				}
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Device salvato con successo!");
				out.print(myObj);
				
			}
			else if(action.equals("modifica_device")) {
				
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
		
		        String id_device = ret.get("id_device");
				String codice_interno = ret.get("codice_interno_mod");
				String id_company = ret.get("company_mod");
				String id_tipo_device = ret.get("tipo_device_mod");
				String data_creazione = ret.get("data_creazione_mod");
				String denominazione = ret.get("denominazione_mod");
				String costruttore = ret.get("costruttore_mod");
				String modello = ret.get("modello_mod");
				String distributore = ret.get("distributore_mod");
				String data_acquisto = ret.get("data_acquisto_mod");
				String ubicazione = ret.get("ubicazione_mod");
				String configurazione = ret.get("configurazione_mod");
				String id_dipendente = ret.get("dipendente_mod");
				String nuova_label_configurazione = ret.get("nuova_label_configurazione_mod");

				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");				
				
				DevDeviceDTO device = GestioneDeviceBO.getDeviceFromID(Integer.parseInt(id_device), session);
				
				String stringaModifica=("Modifica attributi device|");
				
				DocumFornitoreDTO company = GestioneDocumentaleBO.getFornitoreFromId(Integer.parseInt(id_company), session);
				DevTipoDeviceDTO tipo = GestioneDeviceBO.getTipoDeviceFromID(Integer.parseInt(id_tipo_device), session);
				DocumDipendenteFornDTO dipendente = null;
				if(id_dipendente!=null && !id_dipendente.equals("")) {
					 dipendente = GestioneDocumentaleBO.getDipendenteFromId(Integer.parseInt(id_dipendente), session);	
				}
				
				
				if(device.getCompany()!=null && device.getCompany().getId() !=Integer.parseInt(id_company))
				{
					
					stringaModifica=stringaModifica+"Company("+device.getCompany().getRagione_sociale()+","+company.getRagione_sociale()+")|";	
					device.setData_cambio_company(new Date());					
				}
				
				if(device.getTipo_device()!=null && device.getTipo_device().getId() !=Integer.parseInt(id_tipo_device))
				{
					
					stringaModifica=stringaModifica+"Tipo Device("+device.getTipo_device().getDescrizione()+","+tipo.getDescrizione()+")|";	
										
				}
				
				if(device.getDipendente()!=null &&  dipendente!=null && device.getDipendente().getId() !=Integer.parseInt(id_dipendente))
				{
					
					stringaModifica=stringaModifica+"Dipendente("+device.getTipo_device().getDescrizione()+","+dipendente.getNome()+" "+dipendente.getCognome()+")|";	
										
				}else {
					if(device.getDipendente()== null && dipendente!=null) {
						stringaModifica=stringaModifica+"Dipendente([VUOTO],"+dipendente.getNome()+" "+dipendente.getCognome()+")|";
					}
				}
				
				
				if(device.getDenominazione()!=null && !device.getDenominazione().equals(denominazione))
				{
					if(device.getDenominazione().equals("")) {
						stringaModifica=stringaModifica+"Denominazione([VUOTO],"+denominazione+")|";
					}else {
						if(denominazione.equals("")) {
							denominazione = "[VUOTO]";
						}
						stringaModifica=stringaModifica+"Denominazione("+device.getDenominazione()+","+denominazione+")|";	
					}
					
				}
				
				if(device.getCostruttore()!=null && !device.getCostruttore().equals(costruttore))
				{
					if(device.getCostruttore().equals("")) {
						stringaModifica=stringaModifica+"Costruttore([VUOTO],"+costruttore+")|";
					}else {
						if(costruttore.equals("")) {
							costruttore = "[VUOTO]";
						}
						stringaModifica=stringaModifica+"Costruttore("+device.getCostruttore()+","+costruttore+")|";	
					}
					
				}
				
				if(device.getModello()!=null && !device.getModello().equals(modello))
				{
					if(device.getModello().equals("")) {
						stringaModifica=stringaModifica+"Modello([VUOTO],"+modello+")|";
					}else {
						if(modello.equals("")) {
							modello = "[VUOTO]";
						}
						stringaModifica=stringaModifica+"Modello("+device.getModello()+","+modello+")|";	
					}
					
				}
				
				if(device.getDistributore()!=null && !device.getDistributore().equals(distributore))
				{
					if(device.getDistributore().equals("")) {
						stringaModifica=stringaModifica+"Distributore([VUOTO],"+distributore+")|";
					}else {
						if(distributore.equals("")) {
							distributore = "[VUOTO]";
						}
						stringaModifica=stringaModifica+"Distributore("+device.getDistributore()+","+distributore+")|";	
					}
					
				}
				
				if(device.getData_acquisto()!=null && data_acquisto!=null && data_acquisto.equals("") && !device.getData_acquisto().equals(df.parse(data_acquisto)))
				{					
						
						stringaModifica=stringaModifica+"Data acquisto("+device.getData_acquisto()+","+df.parse(data_acquisto)+")|";	
										
				}else {
					if(device.getData_acquisto()==null && !data_acquisto.equals("")) {
						stringaModifica=stringaModifica+"Data acquisto([VUOTO],"+df.parse(data_acquisto)+")|";
					}else {
						if(data_acquisto==null || data_acquisto.equals("")) {
							data_acquisto = "[VUOTO]";
						}
						stringaModifica=stringaModifica+"Data acquisto("+df.format(device.getData_acquisto())+","+data_acquisto+")|";
					}
				}
				
				
				if(device.getData_creazione()!=null && data_creazione!=null && data_creazione.equals("") && !device.getData_creazione().equals(df.parse(data_creazione)))
				{					
						
						stringaModifica=stringaModifica+"Data creazione("+device.getData_acquisto()+","+df.parse(data_creazione)+")|";	
										
				}else {
					if(device.getData_creazione()==null && !data_creazione.equals("")) {
						stringaModifica=stringaModifica+"Data creazione([VUOTO],"+df.parse(data_creazione)+")|";
					}else {
						if(data_creazione==null || data_creazione.equals("")) {
							data_creazione = "[VUOTO]";
						}
						stringaModifica=stringaModifica+"Data creazione("+df.format(device.getData_creazione())+","+data_creazione+")|";
					}
				}
				
				if(device.getUbicazione()!=null && !device.getUbicazione().equals(ubicazione))
				{
					if(device.getUbicazione().equals("")) {
						stringaModifica=stringaModifica+"Ubicazione([VUOTO],"+ubicazione+")|";
					}else {
						if(ubicazione.equals("")) {
							ubicazione = "[VUOTO]";
						}
						stringaModifica=stringaModifica+"Ubicazione("+device.getUbicazione()+","+ubicazione+")|";	
					}
					
				}
				
				if(device.getConfigurazione()!=null && !device.getConfigurazione().equals(configurazione))
				{
					if(device.getConfigurazione().equals("")) {
						stringaModifica=stringaModifica+"Configurazione([VUOTO],"+denominazione+")|";
					}else {
						if(configurazione.equals("")) {
							configurazione = "[VUOTO]";
						}
						stringaModifica=stringaModifica+"Configurazione("+device.getConfigurazione()+","+configurazione+")|";	
					}
					
				}
				
						
				device.setCodice_interno(codice_interno);
				
				device.setCompany(company);
				device.setTipo_device(tipo);
				device.setData_creazione(new Date());
				device.setDenominazione(denominazione);
				device.setCostruttore(costruttore);
				device.setModello(modello);
				device.setDistributore(distributore);
				if(data_creazione!=null && !data_creazione.equals("")) {
					device.setData_creazione(df.parse(data_creazione));
				}
				if(data_acquisto!=null && !data_acquisto.equals("")) {
					device.setData_acquisto(df.parse(data_acquisto));
				}
				device.setUbicazione(ubicazione);
				device.setConfigurazione(configurazione);
				if(id_dipendente!=null && !id_dipendente.equals("")) {
					
					device.setDipendente(dipendente);
				}				
				
				session.update(device);				
				
				DevRegistroAttivitaDTO attivita = new DevRegistroAttivitaDTO();
				attivita.setDevice(device);
				attivita.setData_evento(new Date());
				attivita.setTipo_evento(new DevTipoEventoDTO(1, ""));
				attivita.setDescrizione(stringaModifica);
				attivita.setUtente(utente);
				
				
				session.save(attivita);
				
				if(nuova_label_configurazione!=null && !nuova_label_configurazione.equals("")) {
					for(int i = 0;i<nuova_label_configurazione.split(";").length;i++) {
						DevLabelConfigDTO label = new DevLabelConfigDTO();
						label.setDescrizione(nuova_label_configurazione.split(";")[i]);
						session.save(label);
					}
					
				}
				
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Device salvato con successo!");
				out.print(myObj);
				
			}
			else if(action.equals("lista_software")) {
				
				ArrayList<DevSoftwareDTO> lista_software = GestioneDeviceBO.getListaSoftware(session);
				ArrayList<DocumFornitoreDTO> lista_company = GestioneDocumentaleBO.getListaDocumFornitori(session);
				
				request.getSession().setAttribute("lista_software", lista_software);
				request.getSession().setAttribute("lista_company", lista_company);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaSoftware.jsp");
		     	dispatcher.forward(request,response);
			}
			else if(action.equals("dettaglio_device")) {
				
				ajax = true;
				
				String id_device = request.getParameter("id_device");
				DevDeviceDTO device = GestioneDeviceBO.getDeviceFromID(Integer.parseInt(id_device), session);
							
				Gson g = new GsonBuilder().setDateFormat("dd/MM/yyyy").create();
				
				
				
				myObj = new JsonObject();
				myObj.add("device", g.toJsonTree(device));
				
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				out.print(myObj);	
				
			}
			
			else if(action.equals("nuovo_software")) {
				
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
		
				String nome = ret.get("nome");
				String produttore = ret.get("produttore");
				String id_stato_validazione = ret.get("stato_validazione");
				String data_validazione = ret.get("data_validazione");
				String autorizzato = ret.get("autorizzato");
				String versione = ret.get("versione");

				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				DevSoftwareDTO software = new DevSoftwareDTO();
				software.setNome(nome);
				software.setProduttore(produttore);
				software.setVersione(versione);
				session.save(software);				
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Software salvato con successo!");
				out.print(myObj);
				
			}
			else if(action.equals("modifica_software")) {
				
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
		
		        String id_software = ret.get("id_software");
		        String nome = ret.get("nome_mod");
				String produttore = ret.get("produttore_mod");
				String autorizzato = ret.get("autorizzato_mod");
				String versione = ret.get("versione_mod");

				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				DevSoftwareDTO software = GestioneDeviceBO.getSoftwareFromID(Integer.parseInt(id_software), session);
				software.setNome(nome);
				software.setProduttore(produttore);
				
				software.setVersione(versione);
				
				
				session.update(software);	
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Software salvato con successo!");
				out.print(myObj);
				
			}
			
			else if(action.equals("registro_attivita")) {
				
				String id_device = request.getParameter("id_device");
				String id_company = request.getParameter("id_company");
				
				DevDeviceDTO device = GestioneDeviceBO.getDeviceFromID(Integer.parseInt(id_device), session);
				
				if(id_company == null || id_company.equals("")) {
					id_company = device.getCompany().getId()+"";
				}
				
				ArrayList<DevRegistroAttivitaDTO> registro_attivita = GestioneDeviceBO.getRegistroAttivitaFromDevice(device, Integer.parseInt(id_company), session);
				ArrayList<DevTipoEventoDTO> lista_tipi_evento = GestioneDeviceBO.geListaTipiEvento(session);
				ArrayList<DevLabelTipoInterventoDTO> lista_label_tipo_intervento = GestioneDeviceBO.geListaLabelTipoIntervento(session);
				
				request.getSession().setAttribute("registro_attivita", registro_attivita);
				request.getSession().setAttribute("lista_tipi_evento", lista_tipi_evento);
				request.getSession().setAttribute("lista_label_tipo_intervento", lista_label_tipo_intervento);
				request.getSession().setAttribute("id_device", id_device);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/devRegistroAttivita.jsp");
		     	dispatcher.forward(request,response);				
				
			}
			else if(action.equals("nuova_attivita")) {
				
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
		
		        String id_device = ret.get("id_device");
				String tipo_evento = ret.get("tipo_evento");
				String descrizione = ret.get("descrizione");
				String data = ret.get("data");
				String frequenza = ret.get("frequenza");
				String data_prossima = ret.get("data_prossima");
				String note_evento = ret.get("note_evento");
				String tipo_intervento = ret.get("tipo_intervento");
				String nuova_label_tipo = ret.get("nuova_label_tipo");

				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				
				DevDeviceDTO device = GestioneDeviceBO.getDeviceFromID(Integer.parseInt(id_device), session);
				DevRegistroAttivitaDTO attivita = new DevRegistroAttivitaDTO();
				attivita.setDevice(device);
				attivita.setTipo_evento(new DevTipoEventoDTO(Integer.parseInt(tipo_evento),""));
				attivita.setDescrizione(descrizione);
				attivita.setData_evento(df.parse(data));
				if(frequenza!=null && !frequenza.equals("")) {
					attivita.setFrequenza(Integer.parseInt(frequenza));
				}
				if(data_prossima!=null && !data_prossima.equals("")) {
					attivita.setData_prossima(df.parse(data_prossima));
				}
				attivita.setUtente(utente);
				attivita.setTipo_intervento(tipo_intervento);
				attivita.setNote_evento(note_evento);

				if(attivita.getTipo_evento().getId()==2) {
					attivita.setCompany(device.getCompany());
				}
				session.save(attivita);				
				
				if(nuova_label_tipo!=null && !nuova_label_tipo.equals("")) {
					DevLabelTipoInterventoDTO label = new DevLabelTipoInterventoDTO();
					label.setDescrizione(nuova_label_tipo);
					session.save(label);
				}
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Attività salvata con successo!");
				out.print(myObj);
			}
			else if(action.equals("modifica_attivita")) {
				
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
		
		        String id_attivita = ret.get("id_attivita");
		        String id_device = ret.get("id_device_mod");
				String tipo_evento = ret.get("tipo_evento_mod");
				String descrizione = ret.get("descrizione_mod");
				String data = ret.get("data_mod");
				String frequenza = ret.get("frequenza_mod");
				String data_prossima = ret.get("data_prossima_mod");
				String note_evento = ret.get("note_evento_mod");
				String tipo_intervento = ret.get("tipo_intervento_mod");
				String nuova_label_tipo = ret.get("nuova_label_tipo_mod");
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				
				DevDeviceDTO device = GestioneDeviceBO.getDeviceFromID(Integer.parseInt(id_device), session);
				DevRegistroAttivitaDTO attivita = GestioneDeviceBO.getRegistroAttivitaFromID(Integer.parseInt(id_attivita), session);
				attivita.setDevice(device);
				attivita.setTipo_evento(new DevTipoEventoDTO(Integer.parseInt(tipo_evento),""));
				attivita.setDescrizione(descrizione);
				attivita.setData_evento(df.parse(data));
				if(frequenza!=null && !frequenza.equals("")) {
					attivita.setFrequenza(Integer.parseInt(frequenza));
				}
				if(data_prossima!=null && !data_prossima.equals("")) {
					attivita.setData_prossima(df.parse(data_prossima));
				}
				attivita.setUtente(utente);
				attivita.setNote_evento(note_evento);
				attivita.setTipo_intervento(tipo_intervento);
				
				session.update(attivita);		
				
				if(nuova_label_tipo!=null && !nuova_label_tipo.equals("")) {
					DevLabelTipoInterventoDTO label = new DevLabelTipoInterventoDTO();
					label.setDescrizione(nuova_label_tipo);
					session.save(label);
				}
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Attività salvata con successo!");
				out.print(myObj);
			}
			else if(action.equals("software_associati")) {
				
				ajax = true;
				
				String id_device = request.getParameter("id_device");
				
				ArrayList<DevDeviceSoftwareDTO> lista_device_software = GestioneDeviceBO.getListaDeviceSoftware(Integer.parseInt(id_device), session);
				Gson g = new GsonBuilder().setDateFormat("dd/MM/yyyy").create();
				
				
				myObj = new JsonObject();
				myObj.add("lista_software_associati", g.toJsonTree(lista_device_software));
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				out.print(myObj);	
				
			}
			
			else if(action.equals("associa_software")) {
				
				ajax = true;
				
				String id_device = request.getParameter("id_device");
				
				ArrayList<DevSoftwareDTO> lista_software = GestioneDeviceBO.getListaSoftware(session);
				ArrayList<DevDeviceSoftwareDTO> lista_device_software = GestioneDeviceBO.getListaDeviceSoftware(Integer.parseInt(id_device), session);
				
				Gson g = new GsonBuilder().setDateFormat("dd/MM/yyyy").create();
				
				
				myObj = new JsonObject();
				myObj.add("lista_software_associati", g.toJsonTree(lista_device_software));
				myObj.add("lista_software", g.toJsonTree(lista_software));
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				out.print(myObj);	
				
				
			}
			else if(action.equals("salva_associazione")) {
				
				ajax = true;
				
				String id_device = request.getParameter("id_device");
				String selezionati = request.getParameter("selezionati");
				String stati_validazioni = request.getParameter("stati_validazioni");
				String date_validazioni = request.getParameter("date_validazioni");
				String product_key = request.getParameter("product_key");
				String autorizzazioni = request.getParameter("autorizzazioni");
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				DevDeviceDTO device = GestioneDeviceBO.getDeviceFromID(Integer.parseInt(id_device), session);
				
				//device.getListaSoftware().clear();				
			
				GestioneDeviceBO.dissociaSoftware(device.getId(), session);
				if(selezionati!=null && !selezionati.equals("")) {
					for(int i = 0; i<selezionati.split(";;").length;i++) {
						
						DevSoftwareDTO software = GestioneDeviceBO.getSoftwareFromID(Integer.parseInt(selezionati.split(";;")[i]), session);
											
						DevDeviceSoftwareDTO devSw = new DevDeviceSoftwareDTO();					
						devSw.setDevice(device);
						devSw.setSoftware(software);
						if(product_key.split(";;", -1)!=null && product_key.split(";;", -1)!=null) {
							devSw.setProduct_key(product_key.split(";;", -1)[i]);	
						}
						if(stati_validazioni.split(";;", -1)!=null && stati_validazioni.split(";;", -1)[i]!=null && !stati_validazioni.split(";;", -1)[i].equals("")) {
							devSw.setStato_validazione(new DevStatoValidazioneDTO(Integer.parseInt(stati_validazioni.split(";;", -1)[i]), ""));	
						}
						if(date_validazioni.split(";;", -1)!=null && date_validazioni.split(";;", -1)[i]!=null && !date_validazioni.split(";;", -1)[i].equals("")) {
							devSw.setData_validazione(df.parse(date_validazioni.split(";;", -1)[i]));	
						}		
						if(autorizzazioni.split(";;", -1)!=null && autorizzazioni.split(";;", -1)[i]!=null && !autorizzazioni.split(";;", -1)[i].equals("")) {
							devSw.setAutorizzato(autorizzazioni.split(";;", -1)[i]);	
						}
					
						session.save(devSw);
						
					}
				}
				
				
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Operazione completata con successo!");
				out.print(myObj);	
				
			}
			else if(action.equals("elimina_device")) {
				ajax = true;
				
				String id_device = request.getParameter("id_device");				
				
				DevDeviceDTO device = GestioneDeviceBO.getDeviceFromID(Integer.parseInt(id_device), session);
				
				device.setDisabilitato(1);
								
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Device eliminato con successo!");
				out.print(myObj);	
				
			}
			else if(action.equals("elimina_software")) {
				ajax = true;
				
				String id_software = request.getParameter("id_software");				
				
				DevSoftwareDTO software = GestioneDeviceBO.getSoftwareFromID(Integer.parseInt(id_software), session);
				
				software.setDisabilitato(1);
								
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Software eliminato con successo!");
				out.print(myObj);	
				
			}
			else if(action.equals("lista_procedure")) {
				
				String id_device = request.getParameter("id_device");
				
				ArrayList<DevProceduraDTO> lista_procedure = GestioneDeviceBO.getListaProcedure( session);
				ArrayList<DevTipoProceduraDTO> lista_tipi_procedure = GestioneDeviceBO.getListaTipiProcedure(session);
				
				request.getSession().setAttribute("lista_tipi_procedure", lista_tipi_procedure);
				request.getSession().setAttribute("lista_procedure", lista_procedure);
				request.getSession().setAttribute("id_device", id_device);

				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaDevProcedure.jsp");
		     	dispatcher.forward(request,response);		
				
			}
			
			else if(action.equals("lista_procedure_device")) {
				
				String id_device = request.getParameter("id_device");
				
				ArrayList<DevProceduraDTO> lista_procedure = GestioneDeviceBO.getListaProcedure( session);
				ArrayList<DevProceduraDeviceDTO> lista_procedure_associate = GestioneDeviceBO.getListaProcedureDevice(Integer.parseInt(id_device), session);
				ArrayList<Integer> id_associati = new ArrayList<Integer>();
				for (DevProceduraDeviceDTO devProceduraDeviceDTO : lista_procedure_associate) {
					id_associati.add(devProceduraDeviceDTO.getProcedura().getId());
				}
			
				Gson g = new Gson();
				
				request.getSession().setAttribute("id_associati", g.toJsonTree(id_associati));
				request.getSession().setAttribute("lista_procedure", lista_procedure);
				request.getSession().setAttribute("id_device", id_device);

				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/devListaProcedure.jsp");
		     	dispatcher.forward(request,response);		
				
			}
			
			else if(action.equals("associa_procedura")) {
				
				ajax = true;
				
				String id_device = request.getParameter("id_device");
				String selezionati = request.getParameter("selezionati");
				
				DevDeviceDTO device = GestioneDeviceBO.getDeviceFromID(Integer.parseInt(id_device), session);
				
					
			
				GestioneDeviceBO.dissociaProcedura(device.getId(), session);
				if(selezionati!=null && !selezionati.equals("")) {
					for(int i = 0; i<selezionati.split(";;").length;i++) {
						
						DevProceduraDTO procedura = GestioneDeviceBO.getProceduraFromID(Integer.parseInt(selezionati.split(";;")[i]), session);
											
						DevProceduraDeviceDTO prDv = new DevProceduraDeviceDTO();
						
						prDv.setDevice(device);
						prDv.setProcedura(procedura);
						
						session.save(prDv);
						
					}
				}
				
				
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Operazione completata con successo!");
				out.print(myObj);	
				
			}
			
			
			else if(action.equals("nuova_procedura")) {
				
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
		
		        String id_device = ret.get("id_device");
				String tipo_procedura = ret.get("tipo_procedura");
				String descrizione = ret.get("descrizione_procedura");			
				String frequenza = ret.get("frequenza_procedura");
				
				DevProceduraDTO procedura = new DevProceduraDTO();
				procedura.setDescrizione(descrizione);
				procedura.setFrequenza(frequenza);
				//procedura.setId_device(Integer.parseInt(id_device));
				procedura.setTipo_procedura(new DevTipoProceduraDTO(Integer.parseInt(tipo_procedura), ""));			
				
				session.save(procedura);				
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Procedura salvata con successo!");
				out.print(myObj);
			}
			else if(action.equals("modifica_procedura")) {
				
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
		
		        String id_procedura = ret.get("id_procedura");
				String tipo_procedura = ret.get("tipo_procedura_mod");
				String descrizione = ret.get("descrizione_procedura_mod");			
				String frequenza = ret.get("frequenza_procedura_mod");
				
				DevProceduraDTO procedura = GestioneDeviceBO.getProceduraFromID(Integer.parseInt(id_procedura), session);
				procedura.setDescrizione(descrizione);
				procedura.setFrequenza(frequenza);
				procedura.setTipo_procedura(new DevTipoProceduraDTO(Integer.parseInt(tipo_procedura), ""));			
				
				session.save(procedura);				
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Procedura salvata con successo!");
				out.print(myObj);
			}
			
			else if(action.equals("elimina_procedura")) {
				
				ajax = true;
						
				String id_procedura = request.getParameter("id");
				DevProceduraDTO procedura = GestioneDeviceBO.getProceduraFromID(Integer.parseInt(id_procedura), session);
				procedura.setDisabilitato(1);
				session.update(procedura);				
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Procedura eliminata con successo!");
				out.print(myObj);
				
			}
			
			else if(action.equals("lista_allegati_device")) {
				
				String id_device = request.getParameter("id_device");	
				
				ArrayList<DevAllegatiDeviceDTO> lista_allegati = GestioneDeviceBO.getListaAllegatiDevice(Integer.parseInt(id_device), session);
				
				request.getSession().setAttribute("lista_allegati", lista_allegati);
				request.getSession().setAttribute("allegati_device", 1);
				request.getSession().setAttribute("allegati_software", 0);
				request.getSession().setAttribute("id_device", id_device);
				request.getSession().setAttribute("id_software", null);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaAllegatiDevice.jsp");
		     	dispatcher.forward(request,response);	
						
				
			}
			
			else if(action.equals("lista_allegati_software")) {
				
				String id_software = request.getParameter("id_software");	
				
				ArrayList<DevAllegatiSoftwareDTO> lista_allegati = GestioneDeviceBO.getListaAllegatiSoftware(Integer.parseInt(id_software), session);
				
				request.getSession().setAttribute("lista_allegati", lista_allegati);
				request.getSession().setAttribute("allegati_software", 1);
				request.getSession().setAttribute("allegati_device", 0);
				request.getSession().setAttribute("id_software", id_software);
				request.getSession().setAttribute("id_device", null);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaAllegatiDevice.jsp");
		     	dispatcher.forward(request,response);	
						
				
			}
			
			else if(action.equals("upload_allegati")){
				
				ajax = true;
				
				String id_device = request.getParameter("id_device");
				String id_software = request.getParameter("id_software");	
								
				ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
				PrintWriter out = response.getWriter();
				response.setContentType("application/json");						
					
					List<FileItem> items = uploadHandler.parseRequest(request);
					for (FileItem item : items) {
						if (!item.isFormField()) {							
								
							if(id_device!=null) {
								
								DevAllegatiDeviceDTO allegato = new DevAllegatiDeviceDTO();
								allegato.setId_device(Integer.parseInt(id_device));
								allegato.setNome_file(item.getName().replaceAll("'", "_"));
								saveFile(item, id_device,"Device", item.getName());	
								session.save(allegato);
								
							}else {
								
								DevAllegatiSoftwareDTO allegato = new DevAllegatiSoftwareDTO();
								allegato.setId_software(Integer.parseInt(id_software));
								allegato.setNome_file(item.getName().replaceAll("'", "_"));
								saveFile(item, id_software,"Software", item.getName());	
								session.save(allegato);
								
							}
													
						}
					}

					
					myObj.addProperty("success", true);
					myObj.addProperty("messaggio", "Upload effettuato con successo!");
					out.print(myObj);
			}
			else if(action.equals("download_allegato")){
				
				String id_device = request.getParameter("id_device");
				String id_software = request.getParameter("id_software");
				String id_allegato = request.getParameter("id_allegato");	
				
				String path = "";
				
				if(id_device!=null && !id_device.equals("")) {
					
					DevAllegatiDeviceDTO allegato = GestioneDeviceBO.getAllegatoDeviceFromID(Integer.parseInt(id_allegato), session);
					path = Costanti.PATH_FOLDER+"\\GestioneDevice\\Allegati\\Device\\"+id_device+"\\"+allegato.getNome_file();
					response.setHeader("Content-Disposition","attachment;filename="+ allegato.getNome_file());
					
				}else {
					
					DevAllegatiSoftwareDTO allegato = GestioneDeviceBO.getAllegatoSoftwareFromID(Integer.parseInt(id_allegato), session);
					path = Costanti.PATH_FOLDER+"\\GestioneDevice\\Allegati\\Software\\"+id_software+"\\"+allegato.getNome_file();
					response.setHeader("Content-Disposition","attachment;filename="+ allegato.getNome_file());
				}
								
				response.setContentType("application/octet-stream");
				
		
				ServletOutputStream outp = response.getOutputStream();
				
				downloadFile(path, outp);
				
			}
			
			
			else if(action.equals("elimina_allegato")) {
				
				ajax=true;				

				String id_device = request.getParameter("id_device");
				String id_software = request.getParameter("id_software");
				String id_allegato = request.getParameter("id_allegato");	
				
				
				if(id_device!=null && !id_device.equals("")) {
					
					DevAllegatiDeviceDTO allegato = GestioneDeviceBO.getAllegatoDeviceFromID(Integer.parseInt(id_allegato), session);
					allegato.setDisabilitato(1);
					session.update(allegato);
					
				}else {
					
					DevAllegatiSoftwareDTO allegato = GestioneDeviceBO.getAllegatoSoftwareFromID(Integer.parseInt(id_allegato), session);
					allegato.setDisabilitato(1);
					session.update(allegato);
				}				
				
				PrintWriter out = response.getWriter();
				
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Allegato eliminato con successo!");
				out.print(myObj);
				
				
			}
			else if(action.equals("scadenzario")) {
				
				DevTestoEmailDTO testo_email = GestioneDeviceBO.getTestoEmail(session);
				
				request.getSession().setAttribute("testo_email", testo_email);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/scadenzarioDevice.jsp");
			    dispatcher.forward(request,response);
			    
		
				
			}
			
			else if(action.equals("scadenzario_table")) {
				
				String dateFrom = request.getParameter("dateFrom");
				String dateTo = request.getParameter("dateTo");					
				
				ArrayList<DevRegistroAttivitaDTO> lista_scadenze = GestioneDeviceBO.getListaScadenze(dateFrom,dateTo, session);
				
				request.getSession().setAttribute("lista_scadenze", lista_scadenze);
				request.getSession().setAttribute("dateFrom", dateFrom);
				request.getSession().setAttribute("dateTo", dateTo);				
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/scadenzarioDeviceTable.jsp");
		     	dispatcher.forward(request,response);
				
			}
			
			else if(action.equals("salva_testo_email")) {
				
				ajax = true;
				
				String testo = request.getParameter("testo");
				String referenti = request.getParameter("referenti");
				
				DevTestoEmailDTO testo_email = (DevTestoEmailDTO) request.getSession().getAttribute("testo_email");
					
				if(testo_email == null) {
					testo_email = GestioneDeviceBO.getTestoEmail(session);
				}
				
				testo_email.setDescrizione(testo.replaceAll("\n", "<br>"));
				testo_email.setReferenti(referenti);
				session.saveOrUpdate(testo_email);
				
				
				request.getSession().setAttribute("testo_email", testo_email);
				PrintWriter out = response.getWriter();
				
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Salvato con successo!");
				out.print(myObj);
				
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

	private void saveFile(FileItem item, String id, String dev_sw, String filename) {

	 	String path_folder = Costanti.PATH_FOLDER+"//GestioneDevice//Allegati//"+dev_sw+"//"+id+"//";
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
