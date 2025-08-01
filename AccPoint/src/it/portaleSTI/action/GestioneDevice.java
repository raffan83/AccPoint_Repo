package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Calendar;
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

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.GestioneDeviceDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.DevAllegatiDeviceDTO;
import it.portaleSTI.DTO.DevAllegatiSoftwareDTO;
import it.portaleSTI.DTO.DevContrattoDTO;
import it.portaleSTI.DTO.DevDeviceDTO;
import it.portaleSTI.DTO.DevDeviceMonitorDTO;
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
import it.portaleSTI.DTO.DevTipoLicenzaDTO;
import it.portaleSTI.DTO.DevTipoProceduraDTO;
import it.portaleSTI.DTO.DocumCommittenteDTO;
import it.portaleSTI.DTO.DocumDipendenteFornDTO;
import it.portaleSTI.DTO.DocumFornitoreDTO;
import it.portaleSTI.DTO.DocumTLDocumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneDeviceBO;
import it.portaleSTI.bo.GestioneDocumentaleBO;

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
				
//				for (DevDeviceDTO device : lista_device) {
//					ArrayList<DevRegistroAttivitaDTO> lista_manutenzioni = GestioneDeviceBO.getRegistroAttivitaFromDevice(device, 0, 2, session);
//					
//					int idMassimo = lista_manutenzioni.stream()
//					        .mapToInt(DevRegistroAttivitaDTO::getId) // Estrai gli ID
//					        .max() // Trova il massimo
//					        .orElse(-1); // Valore di default (-1) se la lista è vuota
//					
//					for (DevRegistroAttivitaDTO a : lista_manutenzioni) {
//						if(a.getId()!=idMassimo) {
//							a.setObsoleta("S");
//						}else {
//							a.setObsoleta("N");
//							Date data_prossima = a.getData_prossima();
//							if(data_prossima!=null) {
//								Calendar c = Calendar.getInstance(); // Ottieni un'istanza di Calendar
//							    c.setTime(data_prossima); // Imposta la data di riferimento
//							    c.add(Calendar.DATE, -15); // Aggiungi 15 giorni
//							    a.setData_invio_email(c.getTime()); 
//							}
//						}
//					}
//					 
//					    if (idMassimo != -1) {
//					        System.out.println("ID massimo per il dispositivo " + device.getId() + ": " + idMassimo);
//					    } else {
//					        System.out.println("Nessuna manutenzione trovata per il dispositivo " + device.getId());
//					    }
//				}
				
				
				ArrayList<DevTipoDeviceDTO> lista_tipi_device = GestioneDeviceBO.getListaTipiDevice(session);
				ArrayList<DocumFornitoreDTO> lista_company = GestioneDocumentaleBO.getListaDocumFornitori(session);
				ArrayList<DocumDipendenteFornDTO> lista_dipendenti = GestioneDocumentaleBO.getListaDipendenti(0, 0, session);
				ArrayList<DevLabelConfigDTO> lista_configurazioni = GestioneDeviceBO.getListaLabelConfigurazioni(session);
				ArrayList<DevStatoValidazioneDTO> lista_stati_validazione = GestioneDeviceBO.getListaStatiValidazione(session);
				
				ArrayList<DevDeviceDTO> lista_device_no_man = GestioneDeviceBO.getListaDeviceNoMan(Integer.parseInt(id_company),session);
				
				ArrayList<DevDeviceDTO> lista_device_man_scad = GestioneDeviceBO.getListaDeviceManScad(Integer.parseInt(id_company),session);
				 
				
				Collections.sort(lista_dipendenti);
				
				request.getSession().setAttribute("lista_device", lista_device);
				request.getSession().setAttribute("lista_tipi_device", lista_tipi_device);
				request.getSession().setAttribute("lista_company", lista_company);
				request.getSession().setAttribute("lista_dipendenti", lista_dipendenti);
				request.getSession().setAttribute("lista_configurazioni", lista_configurazioni);
				request.getSession().setAttribute("lista_stati_validazione", lista_stati_validazione);
				request.getSession().setAttribute("id_company", id_company);
				request.getSession().setAttribute("lista_device_no_man", lista_device_no_man);
				request.getSession().setAttribute("lista_device_man_scad", lista_device_man_scad);
				
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
				String id_company_proprietaria = ret.get("company_proprietaria");
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
				String rif_fattura = ret.get("rif_fattura");
				String ram = ret.get("ram");
				String hard_disk = ret.get("hard_disk");
				String cpu = ret.get("cpu");
				String scheda_video = ret.get("scheda_video");
				
				if(id_dipendente.equals("0")) {
					id_dipendente=null;
				}

				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				DevDeviceDTO device = new DevDeviceDTO();
				device.setCodice_interno(codice_interno);
				if(id_company!=null && !id_company.equals("")) {
					DocumFornitoreDTO company = GestioneDocumentaleBO.getFornitoreFromId(Integer.parseInt(id_company), session);
					device.setCompany_util(company);
				}
				DocumFornitoreDTO company_proprietaria = GestioneDocumentaleBO.getFornitoreFromId(Integer.parseInt(id_company_proprietaria), session);
				device.setCompany_proprietaria(company_proprietaria);
				
				device.setTipo_device(new DevTipoDeviceDTO(Integer.parseInt(id_tipo_device), ""));
				
				device.setDenominazione(denominazione);
				device.setCostruttore(costruttore);
				device.setModello(modello);
				device.setDistributore(distributore);
				device.setRif_fattura(rif_fattura);
				device.setRam(ram);
				device.setCpu(cpu);
				device.setHard_disk(hard_disk);
				device.setScheda_video(scheda_video);
				
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
					DocumDipendenteFornDTO dipendente = GestioneDocumentaleBO.getDipendenteFromId(Integer.parseInt(id_dipendente.split("_")[0]), session);
					device.setDipendente(dipendente);
				}else {
					device.setDipendente(null);
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
				String id_company_proprietaria = ret.get("company_proprietaria_mod");
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
				String rif_fattura = ret.get("rif_fattura_mod");
				String ram = ret.get("ram_mod");
				String hard_disk = ret.get("hard_disk_mod");
				String cpu = ret.get("cpu_mod");
				String scheda_video = ret.get("scheda_video_mod");
				
				if(id_dipendente!=null && id_dipendente.equals("0")) {
					id_dipendente=null;
				}

			//	id_company=null;
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");				
				
				DevDeviceDTO device = GestioneDeviceBO.getDeviceFromID(Integer.parseInt(id_device), session);
				
				String stringaModifica=("Modifica attributi device|");
				boolean modifica_effettuata = false;
				
				DocumFornitoreDTO company = GestioneDocumentaleBO.getFornitoreFromId(Integer.parseInt(id_company), session);
				DocumFornitoreDTO company_proprietaria = GestioneDocumentaleBO.getFornitoreFromId(Integer.parseInt(id_company_proprietaria), session);
		
				DevTipoDeviceDTO tipo = GestioneDeviceBO.getTipoDeviceFromID(Integer.parseInt(id_tipo_device), session);
				DocumDipendenteFornDTO dipendente = null;
				if(id_dipendente!=null && !id_dipendente.equals("")) {
					 dipendente = GestioneDocumentaleBO.getDipendenteFromId(Integer.parseInt(id_dipendente.split("_")[0]), session);	
				}
				
				
				if(device.getCompany_util()!=null && device.getCompany_util().getId() !=Integer.parseInt(id_company))
				{
					if(company==null) {
						stringaModifica=stringaModifica+"Company("+device.getCompany_util().getRagione_sociale()+", Nessuna Company)|";
					}else {
						stringaModifica=stringaModifica+"Company("+device.getCompany_util().getRagione_sociale()+","+company.getRagione_sociale()+")|";
					}
					device.setData_cambio_company(new Date());					
					modifica_effettuata = true;
				}
				
				if(device.getCompany_proprietaria()!=null && device.getCompany_proprietaria().getId() !=Integer.parseInt(id_company_proprietaria))
				{
					if(company_proprietaria==null) {
						stringaModifica=stringaModifica+"Company("+device.getCompany_proprietaria().getRagione_sociale()+", Nessuna Company)|";
					}else {
						stringaModifica=stringaModifica+"Company("+device.getCompany_proprietaria().getRagione_sociale()+","+company_proprietaria.getRagione_sociale()+")|";
					}
					//device.setData_cambio_company(new Date());					
					modifica_effettuata = true;
				}
				
				if(device.getTipo_device()!=null && device.getTipo_device().getId() !=Integer.parseInt(id_tipo_device))
				{
					
					stringaModifica=stringaModifica+"Tipo Device("+device.getTipo_device().getDescrizione()+","+tipo.getDescrizione()+")|";
					modifica_effettuata = true;
										
				}
				
				if(device.getDipendente()!=null &&  dipendente!=null && device.getDipendente().getId() !=Integer.parseInt(id_dipendente.split("_")[0]))
				{
					
					stringaModifica=stringaModifica+"Dipendente("+device.getTipo_device().getDescrizione()+","+dipendente.getNome()+" "+dipendente.getCognome()+")|";	
					modifica_effettuata = true;				
				}else {
					if(device.getDipendente()== null && dipendente!=null) {
						stringaModifica=stringaModifica+"Dipendente([VUOTO],"+dipendente.getNome()+" "+dipendente.getCognome()+")|";
						modifica_effettuata = true;
					}
					
				}
				
				
				if(device.getDenominazione()!=null && !device.getDenominazione().equals(denominazione))
				{
					if(device.getDenominazione().equals("")) {
						stringaModifica=stringaModifica+"Denominazione([VUOTO],"+denominazione+")|";
					}else {
						if(denominazione.equals("")) {
							stringaModifica=stringaModifica+"Denominazione("+device.getDenominazione()+",[VUOTO])|";	
						}else {
							stringaModifica=stringaModifica+"Denominazione("+device.getDenominazione()+","+denominazione+")|";	
						}
							
					}
					modifica_effettuata = true;
				}
				
				if(device.getCostruttore()!=null && !device.getCostruttore().equals(costruttore))
				{
					if(device.getCostruttore().equals("")) {
						stringaModifica=stringaModifica+"Costruttore([VUOTO],"+costruttore+")|";
					}else {
						if(costruttore.equals("")) {
							stringaModifica=stringaModifica+"Costruttore("+device.getCostruttore()+",[VUOTO])|";
						}else {
							stringaModifica=stringaModifica+"Costruttore("+device.getCostruttore()+","+costruttore+")|";	
						}
							
					}
					modifica_effettuata = true;
				}
				
				if(device.getModello()!=null && !device.getModello().equals(modello))
				{
					if(device.getModello().equals("")) {
						stringaModifica=stringaModifica+"Modello([VUOTO],"+modello+")|";
					}else {
						if(modello.equals("")) {
							
							stringaModifica=stringaModifica+"Modello("+device.getModello()+",[VUOTO])|";
						}else {
							stringaModifica=stringaModifica+"Modello("+device.getModello()+","+modello+")|";	
						}
							
					}
					modifica_effettuata = true;
				}
			
				if(device.getRam()!=null && !device.getRam().equals(ram))
				{
					if(device.getRam().equals("")) {
						stringaModifica=stringaModifica+"Ram([VUOTO],"+ram+")|";
					}else {
						if(ram.equals("")) {
							
							stringaModifica=stringaModifica+"Ram("+device.getRam()+",[VUOTO])|";
						}else {
							stringaModifica=stringaModifica+"Ram("+device.getRam()+","+ram+")|";	
						}
							
					}
					modifica_effettuata = true;
				}
				
				if(device.getCpu()!=null && !device.getCpu().equals(cpu))
				{
					if(device.getCpu().equals("")) {
						stringaModifica=stringaModifica+"Cpu([VUOTO],"+cpu+")|";
					}else {
						if(cpu.equals("")) {
							
							stringaModifica=stringaModifica+"Cpu("+device.getCpu()+",[VUOTO])|";
						}else {
							stringaModifica=stringaModifica+"Cpu("+device.getCpu()+","+cpu+")|";	
						}
							
					}
					modifica_effettuata = true;
				}
				
				if(device.getHard_disk()!=null && !device.getHard_disk().equals(hard_disk))
				{
					if(device.getHard_disk().equals("")) {
						stringaModifica=stringaModifica+"Hard Disk([VUOTO],"+modello+")|";
					}else {
						if(hard_disk.equals("")) {
							
							stringaModifica=stringaModifica+"Hard Disk("+device.getHard_disk()+",[VUOTO])|";
						}else {
							stringaModifica=stringaModifica+"Hard Disk("+device.getHard_disk()+","+hard_disk+")|";	
						}
							
					}
					modifica_effettuata = true;
				}
				
				if(device.getScheda_video()!=null && !device.getScheda_video().equals(scheda_video))
				{
					if(device.getScheda_video().equals("")) {
						stringaModifica=stringaModifica+"Modello([VUOTO],"+scheda_video+")|";
					}else {
						if(scheda_video.equals("")) {
							
							stringaModifica=stringaModifica+"Modello("+device.getScheda_video()+",[VUOTO])|";
						}else {
							stringaModifica=stringaModifica+"Modello("+device.getScheda_video()+","+modello+")|";	
						}
							
					}
					modifica_effettuata = true;
				}
				
		
				
				if(device.getDistributore()!=null && !device.getDistributore().equals(distributore))
				{
					if(device.getDistributore().equals("")) {
						stringaModifica=stringaModifica+"Distributore([VUOTO],"+distributore+")|";
					}else {
						if(distributore.equals("")) {
							stringaModifica=stringaModifica+"Distributore("+device.getDistributore()+",[VUOTO])|";	
						}else {
							stringaModifica=stringaModifica+"Distributore("+device.getDistributore()+","+distributore+")|";	
						}
							
					}
					modifica_effettuata = true;
				}
				
				if(device.getData_acquisto()!=null && data_acquisto!=null && !data_acquisto.equals("") && !device.getData_acquisto().equals(df.parse(data_acquisto)))
				{					
						
						stringaModifica=stringaModifica+"Data acquisto("+device.getData_acquisto()+","+df.parse(data_acquisto)+")|";	
						modifica_effettuata = true;		
				}else {
					if(device.getData_acquisto()==null && !data_acquisto.equals("")) {
						stringaModifica=stringaModifica+"Data acquisto([VUOTO],"+df.parse(data_acquisto)+")|";
						modifica_effettuata = true;
					}
					else if(device.getData_acquisto()==null && data_acquisto.equals("")) {
						
					}
					else {
						if(data_acquisto==null || data_acquisto.equals("")) {
							stringaModifica=stringaModifica+"Data acquisto("+df.format(device.getData_acquisto())+",[VUOTO])|";
							modifica_effettuata = true;
						}
						//stringaModifica=stringaModifica+"Data acquisto("+df.format(device.getData_acquisto())+","+data_acquisto+")|";
					}
				}
				
				
				if(device.getData_creazione()!=null && data_creazione!=null && !data_creazione.equals("") && !device.getData_creazione().equals(df.parse(data_creazione)))
				{					
						
						stringaModifica=stringaModifica+"Data creazione("+device.getData_acquisto()+","+df.parse(data_creazione)+")|";	
						modifica_effettuata = true;				
				}else {
					if(device.getData_creazione()==null && !data_creazione.equals("")) {
						stringaModifica=stringaModifica+"Data creazione([VUOTO],"+df.parse(data_creazione)+")|";
						modifica_effettuata = true;
					}
					else if(device.getData_creazione()==null && data_creazione.equals("")) {
						
					}
					else {
						if(data_creazione==null || data_creazione.equals("")) {
							stringaModifica=stringaModifica+"Data creazione("+df.format(device.getData_creazione())+",[VUOTO])|";
							modifica_effettuata = true;
						}
						//stringaModifica=stringaModifica+"Data creazione("+df.format(device.getData_creazione())+","+data_creazione+")|";
					}
				}
				
				if(device.getUbicazione()!=null && !device.getUbicazione().equals(ubicazione))
				{
					if(device.getUbicazione().equals("")) {
						stringaModifica=stringaModifica+"Ubicazione([VUOTO],"+ubicazione+")|";
					}else {
						if(ubicazione.equals("")) {
							stringaModifica=stringaModifica+"Ubicazione("+device.getUbicazione()+",[VUOTO])|";	
						}else {
							stringaModifica=stringaModifica+"Ubicazione("+device.getUbicazione()+","+ubicazione+")|";		
						}
						
					}
					modifica_effettuata = true;
				}
				
				if(device.getConfigurazione()!=null && !device.getConfigurazione().equals(configurazione))
				{
					if(device.getConfigurazione().equals("")) {
						stringaModifica=stringaModifica+"Configurazione([VUOTO],"+denominazione+")|";
					}else {
						if(configurazione.equals("")) {
							stringaModifica=stringaModifica+"Configurazione("+device.getConfigurazione()+",[VUOTO])|";	
						}else {
							stringaModifica=stringaModifica+"Configurazione("+device.getConfigurazione()+","+configurazione+")|";	
						}
							
					}
					modifica_effettuata = true;
				}
				
				if(device.getRif_fattura()!=null && !device.getRif_fattura().equals(rif_fattura))
				{
					if(device.getRif_fattura().equals("")) {
						stringaModifica=stringaModifica+"Rif. fattura([VUOTO],"+rif_fattura+")|";
					}else {
						if(denominazione.equals("")) {
							stringaModifica=stringaModifica+"Rif. fattura("+device.getRif_fattura()+",[VUOTO])|";	
						}else {
							stringaModifica=stringaModifica+"Rif. fattura("+device.getRif_fattura()+","+rif_fattura+")|";	
						}
							
					}
					modifica_effettuata = true;
				}
				
						
				device.setCodice_interno(codice_interno);
				
				device.setCompany_util(company);
				device.setCompany_proprietaria(company_proprietaria);
				device.setTipo_device(tipo);
				device.setData_creazione(new Date());
				device.setDenominazione(denominazione);
				device.setCostruttore(costruttore);
				device.setModello(modello);
				device.setDistributore(distributore);
				device.setRam(ram);
				device.setCodice_interno(codice_interno);
				device.setCpu(cpu);
				device.setHard_disk(hard_disk);
				device.setScheda_video(scheda_video);
				
				device.setRif_fattura(rif_fattura);
				if(data_creazione!=null && !data_creazione.equals("") ) {
					device.setData_creazione(df.parse(data_creazione));
				}else {
					device.setData_creazione(null);
				}
				if(data_acquisto!=null && !data_acquisto.equals("") ) {
					device.setData_acquisto(df.parse(data_acquisto));
				}else {
					device.setData_acquisto(null);
				}
				device.setUbicazione(ubicazione);
				device.setConfigurazione(configurazione);
			
				device.setDipendente(dipendente);
				
				
				
				
				
				session.update(device);				
				
				
				if(modifica_effettuata) {
					DevRegistroAttivitaDTO attivita = new DevRegistroAttivitaDTO();
					attivita.setDevice(device);
					attivita.setData_evento(new Date());
					attivita.setTipo_evento(new DevTipoEventoDTO(1, ""));
					attivita.setDescrizione(stringaModifica);
					attivita.setUtente(utente);
					
					
					session.save(attivita);
				}
				
				
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
				ArrayList<DevTipoLicenzaDTO> lista_tipi_licenze = GestioneDeviceBO.getListaTipiLicenze(session);
				
				request.getSession().setAttribute("lista_software", lista_software);
				request.getSession().setAttribute("lista_company", lista_company);
				request.getSession().setAttribute("lista_tipi_licenze", lista_tipi_licenze);
				
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
				String data_acquisto = ret.get("data_acquisto");
				String data_scadenza = ret.get("data_scadenza");
				String tipo_licenza = ret.get("tipo_licenza");
				String email_responsabile = ret.get("email_referenti");

				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				DevSoftwareDTO software = new DevSoftwareDTO();
				software.setNome(nome);
				software.setProduttore(produttore);
				software.setVersione(versione);
				
				if(data_acquisto!=null && !data_acquisto.equals("")) {
					software.setData_acquisto(df.parse(data_acquisto));
				}
				if(data_scadenza!=null && !data_scadenza.equals("")) {
					Date dataScadenza = df.parse(data_scadenza);
					software.setData_scadenza(dataScadenza);
					Calendar c = Calendar.getInstance();
					c.setTime(dataScadenza);
					c.add(Calendar.DAY_OF_YEAR, -60);
					if(c.getTime().before(new Date())) {
						c.setTime(dataScadenza);
						c.add(Calendar.DAY_OF_YEAR, -30);
					}
					if(c.getTime().before(new Date())) {
						c.setTime(dataScadenza);
						c.add(Calendar.DAY_OF_YEAR, -15);
					}
					if(c.getTime().before(new Date())) {
						c.setTime(dataScadenza);
						c.add(Calendar.DAY_OF_YEAR, -7);
					}
					if(c.getTime().before(new Date())) {
						c.setTime(dataScadenza);
						
					}	
					
					software.setData_invio_remind(c.getTime());					
				}
				if(tipo_licenza!=null) {
					software.setTipo_licenza(new DevTipoLicenzaDTO(Integer.parseInt(tipo_licenza),""));
				}
				if(email_responsabile!=null) {
					software.setEmail_responsabile(email_responsabile.trim());	
				}
								
				
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
				String data_acquisto = ret.get("data_acquisto_mod");
				String data_scadenza = ret.get("data_scadenza_mod");
				String tipo_licenza = ret.get("tipo_licenza_mod");
				String email_responsabile = ret.get("email_referenti_mod");

				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				DevSoftwareDTO software = GestioneDeviceBO.getSoftwareFromID(Integer.parseInt(id_software), session);
				software.setNome(nome);
				software.setProduttore(produttore);
				
				software.setVersione(versione);
				if(data_acquisto!=null && !data_acquisto.equals("")) {
					software.setData_acquisto(df.parse(data_acquisto));
				}
				if(data_scadenza!=null && !data_scadenza.equals("")) {
					Date dataScadenza = df.parse(data_scadenza);
					software.setData_scadenza(dataScadenza);
					Calendar c = Calendar.getInstance();
					c.setTime(dataScadenza);
					c.add(Calendar.DAY_OF_YEAR, -60);
					if(c.getTime().before(new Date())) {
						c.setTime(dataScadenza);
						c.add(Calendar.DAY_OF_YEAR, -30);
					}
					if(c.getTime().before(new Date())) {
						c.setTime(dataScadenza);
						c.add(Calendar.DAY_OF_YEAR, -15);
					}
					if(c.getTime().before(new Date())) {
						c.setTime(dataScadenza);
						c.add(Calendar.DAY_OF_YEAR, -7);
					}
					if(c.getTime().before(new Date())) {
						c.setTime(dataScadenza);						
					}
					software.setData_invio_remind(c.getTime());
					
				}
				if(tipo_licenza!=null && !tipo_licenza.equals("")) {
					software.setTipo_licenza(new DevTipoLicenzaDTO(Integer.parseInt(tipo_licenza),""));
				}
				if(email_responsabile!=null) {
					software.setEmail_responsabile(email_responsabile.trim());	
				}
				
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
					id_company = device.getCompany_util().getId()+"";
				}
				
				ArrayList<DevRegistroAttivitaDTO> registro_attivita = GestioneDeviceBO.getRegistroAttivitaFromDevice(device, Integer.parseInt(id_company),0, session);
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
				String tipo_manutenzione_straordinaria = ret.get("tipo_manutenzione_straordinaria");
				
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				
				DevDeviceDTO device = GestioneDeviceBO.getDeviceFromID(Integer.parseInt(id_device), session);
				DevRegistroAttivitaDTO attivita = new DevRegistroAttivitaDTO();
				attivita.setDevice(device);
				attivita.setTipo_evento(new DevTipoEventoDTO(Integer.parseInt(tipo_evento),""));
			
				attivita.setDescrizione(descrizione);
				attivita.setData_evento(df.parse(data));
				if(tipo_manutenzione_straordinaria!=null && !tipo_manutenzione_straordinaria.equals("")) {
					attivita.setTipo_manutenzione_straordinaria(Integer.parseInt(tipo_manutenzione_straordinaria));
				}else {
					attivita.setTipo_manutenzione_straordinaria(null);
				}
				if(frequenza!=null && !frequenza.equals("")) {
					attivita.setFrequenza(Integer.parseInt(frequenza));
				}
				
				Date data_invio_email = null;
				if(data_prossima!=null && !data_prossima.equals("")) {
					attivita.setData_prossima(df.parse(data_prossima));
					
					Calendar c = Calendar.getInstance();
					c.setTime(attivita.getData_prossima());
					c.add(Calendar.DATE, -15);
					data_invio_email = c.getTime();
				}
				
				if(tipo_evento.equals("2") || tipo_evento.equals("3")) {
					if(data_prossima!=null && !data_prossima.equals("")) {
						ArrayList<DevRegistroAttivitaDTO> lista_attivita_precedenti = GestioneDeviceBO.getRegistroAttivitaFromDevice(device, 0, 2,session);
						for (DevRegistroAttivitaDTO a : lista_attivita_precedenti) {
							a.setObsoleta("S");
						}
						attivita.setObsoleta("N");
						attivita.setData_invio_email(data_invio_email);
					}
				}
				
				
				attivita.setUtente(utente);
				attivita.setTipo_intervento(tipo_intervento);
				attivita.setNote_evento(note_evento);

				//if(attivita.getTipo_evento().getId()==2) {
				attivita.setCompany(device.getCompany_util());
				//}
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
				String tipo_manutenzione_straordinaria = ret.get("tipo_manutenzione_straordinaria_mod");
				
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
				}else {
					attivita.setData_prossima(null);
				}
				attivita.setUtente(utente);
				attivita.setNote_evento(note_evento);
				attivita.setTipo_intervento(tipo_intervento);
				if(tipo_manutenzione_straordinaria!=null && !tipo_manutenzione_straordinaria.equals("")) {
					attivita.setTipo_manutenzione_straordinaria(Integer.parseInt(tipo_manutenzione_straordinaria));
				}else {
					attivita.setTipo_manutenzione_straordinaria(null);
				}
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
				String id_contratto = request.getParameter("id_contratto");
				
				Gson g = new GsonBuilder().setDateFormat("dd/MM/yyyy").create();
				
				
				myObj = new JsonObject();
				
			
				if(id_device!=null) {
					ArrayList<DevDeviceSoftwareDTO>lista_device_software = GestioneDeviceBO.getListaDeviceSoftware(Integer.parseInt(id_device), session);	
					myObj.add("lista_software_associati", g.toJsonTree(lista_device_software));
				}else {
					ArrayList<DevSoftwareDTO>lista_software_associati = GestioneDeviceBO.getListaContrattoSoftware(Integer.parseInt(id_contratto), session);
					
					myObj.add("lista_software_associati", g.toJsonTree(lista_software_associati));
				}
				
				
				
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				out.print(myObj);	
				
			}
			
			else if(action.equals("associa_software")) {
				
				ajax = true;
				
				String id_device = request.getParameter("id_device");
				String id_contratto = request.getParameter("id_contratto");
				
				ArrayList<DevSoftwareDTO> lista_software = GestioneDeviceDAO.getListaSoftwareCount(session);
				ArrayList<DevDeviceSoftwareDTO> lista_device_software = null;
				if(id_device!=null) {
					lista_device_software = GestioneDeviceBO.getListaDeviceSoftware(Integer.parseInt(id_device), session);	
					
				}
				ArrayList<DevSoftwareDTO> lista_software_contratto = null;
				if(id_contratto!=null){
					lista_software_contratto =  GestioneDeviceBO.getListaContrattoSoftware(Integer.parseInt(id_contratto), session);
					
				}
				
				Gson g = new GsonBuilder().setDateFormat("dd/MM/yyyy").create();
				
				
				myObj = new JsonObject();
				if(id_contratto!=null) {
					myObj.add("lista_software_associati", g.toJsonTree(lista_software_contratto));
				}else {
					myObj.add("lista_software_associati", g.toJsonTree(lista_device_software));	
				}
				
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
				myObj = new JsonObject();
				String id_device = request.getParameter("id_device");		
				String stato = request.getParameter("stato");
				
				DevDeviceDTO device = GestioneDeviceBO.getDeviceFromID(Integer.parseInt(id_device), session);
				
				if(stato!=null && stato.equals("0")) {
					device.setDisabilitato(0);
					myObj.addProperty("messaggio", "Completato con successo!");
				}else {
					device.setDisabilitato(1);	
					myObj.addProperty("messaggio", "Device eliminato con successo!");
				}
				
				session.update(device);
								
				
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				
				out.print(myObj);	
				
			}
			else if(action.equals("elimina_software")) {
				ajax = true;
				
				String id_software = request.getParameter("id_software");
				String stato = request.getParameter("stato");		
				myObj = new JsonObject();
				
				DevSoftwareDTO software = GestioneDeviceBO.getSoftwareFromID(Integer.parseInt(id_software), session);
				
				if(stato!=null && stato.equals("0")) {
					software.setDisabilitato(0);
					myObj.addProperty("messaggio", "Completato con successo!");
				}else {
					software.setDisabilitato(1);	
					myObj.addProperty("messaggio", "Software eliminato con successo!");
				}
				
											
				
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				
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
		
		        
				String tipo_procedura = ret.get("tipo_procedura");
				String descrizione = ret.get("descrizione_procedura");			
				String frequenza = ret.get("frequenza_procedura");
				String scadenza_contratto = ret.get("scadenza_contratto");
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				DevProceduraDTO procedura = new DevProceduraDTO();
				procedura.setDescrizione(descrizione);
				procedura.setFrequenza(frequenza);
				//procedura.setId_device(Integer.parseInt(id_device));
				procedura.setTipo_procedura(new DevTipoProceduraDTO(Integer.parseInt(tipo_procedura), ""));		
				if(scadenza_contratto!=null && !scadenza_contratto.equals("")) {
					procedura.setScadenza_contratto(df.parse(scadenza_contratto));
				}
				
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
				String scadenza_contratto = ret.get("scadenza_contratto_mod");
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				DevProceduraDTO procedura = GestioneDeviceBO.getProceduraFromID(Integer.parseInt(id_procedura), session);
				procedura.setDescrizione(descrizione);
				procedura.setFrequenza(frequenza);
				procedura.setTipo_procedura(new DevTipoProceduraDTO(Integer.parseInt(tipo_procedura), ""));			
				if(scadenza_contratto!=null && !scadenza_contratto.equals("")) {
					procedura.setScadenza_contratto(df.parse(scadenza_contratto));
				}
				
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
				
				ArrayList<DocumFornitoreDTO> lista_company = GestioneDocumentaleBO.getListaDocumFornitori(session);				 
				
				request.getSession().setAttribute("lista_company", lista_company);
				
				request.getSession().setAttribute("testo_email", testo_email);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/scadenzarioDevice.jsp");
			    dispatcher.forward(request,response);
			    
		
				
			}
			
			else if(action.equals("scadenzario_table")) {
				
				String dateFrom = request.getParameter("dateFrom");
				String dateTo = request.getParameter("dateTo");	
				String company = request.getParameter("company");	
				
				ArrayList<DevRegistroAttivitaDTO> lista_scadenze = GestioneDeviceBO.getListaScadenze(dateFrom,dateTo,Integer.parseInt(company), session);
				ArrayList<DevDeviceDTO> lista_device_man_scad = GestioneDeviceBO.getListaDeviceManScad(Integer.parseInt(company), session);
				
				request.getSession().setAttribute("lista_scadenze", lista_scadenze);
				request.getSession().setAttribute("lista_device_man_scad", lista_device_man_scad);
				request.getSession().setAttribute("dateFrom", dateFrom);
				request.getSession().setAttribute("dateTo", dateTo);				
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/scadenzarioDeviceTable.jsp");
		     	dispatcher.forward(request,response);
				
			}
			
			else if(action.equals("salva_testo_email")) {
				
				ajax = true;
				
				String testo = request.getParameter("testo");
				String referenti = request.getParameter("referenti");
				String sollecito = request.getParameter("sollecito");
				
				DevTestoEmailDTO testo_email = (DevTestoEmailDTO) request.getSession().getAttribute("testo_email");
					
				if(testo_email == null) {
					testo_email = GestioneDeviceBO.getTestoEmail(session);
				}
				
				testo_email.setDescrizione(testo.replaceAll("\n", "<br>"));
				testo_email.setReferenti(referenti);
				testo_email.setSollecito(sollecito.replaceAll("\n", "<br>"));
				session.saveOrUpdate(testo_email);
				
				
				request.getSession().setAttribute("testo_email", testo_email);
				PrintWriter out = response.getWriter();
				
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Salvato con successo!");
				out.print(myObj);
				
			}
			
			else if(action.equals("lista_archiviati")) {
				
				String id_company = request.getParameter("id_company");
				
				if(id_company == null) {
					id_company = "0";
				}else {
					id_company = Utility.decryptData(id_company);	
				}				
				
				
				ArrayList<DevDeviceDTO> lista_device = GestioneDeviceBO.getListaDeviceArchiviati(Integer.parseInt(id_company),session);
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
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaDeviceArchiviati.jsp");
		     	dispatcher.forward(request,response);
			}
			
			else if(action.equals("esporta_lista_sw")) {
				
				String id_company = request.getParameter("id_company");
														
				
				ArrayList<DevSoftwareDTO> lista_software = GestioneDeviceBO.getListaSoftwareCompany(Integer.parseInt(id_company),session);
				DocumFornitoreDTO company = GestioneDocumentaleBO.getFornitoreFromId(Integer.parseInt(id_company), session);
 				SimpleDateFormat sdf = new SimpleDateFormat("ddMMyyyy");
				 
				GestioneDeviceBO.esportaListaSoftware(lista_software, company.getRagione_sociale());
				String path =  Costanti.PATH_FOLDER+"\\Device\\ListaSoftware"+ sdf.format(new Date())+".xlsx";									     
				
								
				 File file = new File(path);
					
					FileInputStream fileIn = new FileInputStream(file);

					ServletOutputStream outp = response.getOutputStream();
					
					response.setContentType("application/octet-stream");
					
					response.setHeader("Content-Disposition","attachment;filename=ListaSoftware"+ sdf.format(new Date())+".xlsx");
				
					
			
					    byte[] outputByte = new byte[1];
					    
					    while(fileIn.read(outputByte, 0, 1) != -1)
					    {
					    	outp.write(outputByte, 0, 1);
					    }
					    				    
					 
					    fileIn.close();
					    outp.flush();
					    outp.close();
		
								
			}
			
			else if(action.equals("lista_monitor")) {
				
				ajax = true;
				
				String id_device = request.getParameter("id_device");
				
				ArrayList<DevDeviceDTO> lista_monitor = GestioneDeviceBO.getListaMonitor(session);
				ArrayList<DevDeviceMonitorDTO> lista_monitor_device = null;
				
				if(id_device!=null) {
					int id = Integer.parseInt(id_device);
					lista_monitor_device = GestioneDeviceBO.getListaMonitorDevice(id,session);
					
				
				}
				
				Gson g = new GsonBuilder().setDateFormat("dd/MM/yyyy").create();
				
			
				PrintWriter out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.add("lista_monitor", g.toJsonTree(lista_monitor));
				myObj.add("lista_monitor_device", g.toJsonTree(lista_monitor_device));
				out.print(myObj);
			}
			else if(action.equals("associa_monitor")) {
				
				ajax = true;
				
				String id_device = request.getParameter("id_device");

				String selezionati = request.getParameter("selezionati");
				
				DevDeviceDTO device = GestioneDeviceBO.getDeviceFromID(Integer.parseInt(id_device), session);
				
				
				GestioneDeviceBO.dissociaMonitor(device.getId(), session);
				if(selezionati!=null && !selezionati.equals("")) {
					for(int i = 0; i<selezionati.split(";;").length;i++) {
						
						DevDeviceDTO monitor = GestioneDeviceBO.getDeviceFromID(Integer.parseInt(selezionati.split(";;")[i]), session);
						monitor.setDipendente(device.getDipendente());
						DevDeviceMonitorDTO devmon = new DevDeviceMonitorDTO();					
						
						devmon.setDevice(device);
						devmon.setMonitor(monitor);
						
						session.update(monitor);
						session.save(devmon);
						
					}
				}
				
				
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Operazione completata con successo!");
				out.print(myObj);	
			}
			
			
			
			else if(action.equals("ricerca_software")) {
				
				
				ArrayList<DocumFornitoreDTO> lista_company = GestioneDocumentaleBO.getListaDocumFornitori(session);
				ArrayList<DocumDipendenteFornDTO> lista_dipendenti = GestioneDocumentaleBO.getListaDipendenti(0, 0, session);
				request.getSession().setAttribute("lista_company", lista_company);
				request.getSession().setAttribute("lista_dipendenti", lista_dipendenti);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/ricercaSoftware.jsp");
		     	dispatcher.forward(request,response);
				
				
				
			}
			else if(action.equals("ricerca_software_filtro")) {
				
				String tipo_ricerca = request.getParameter("tipo_ricerca");
				String dipendente = request.getParameter("utente");
				String id_company = request.getParameter("company");
				

				
				ArrayList<DevSoftwareDTO> lista_software = GestioneDeviceBO.getListaSoftwareFiltro(Integer.parseInt(id_company));
				
				
				request.getSession().setAttribute("lista_software", lista_software);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/ricercaSoftwareTabella.jsp");
		     	dispatcher.forward(request,response);
				
			}
			else if(action.equals("lista_contratti")) {
				
				ArrayList<DevContrattoDTO> lista_contratto = GestioneDeviceBO.getListaContratto(session);
				ArrayList<DevSoftwareDTO> lista_software = GestioneDeviceBO.getListaSoftware(session);
				ArrayList<DocumFornitoreDTO> lista_company = GestioneDocumentaleBO.getListaDocumFornitori(session);
				ArrayList<DevTipoLicenzaDTO> lista_tipi_licenze = GestioneDeviceBO.getListaTipiLicenze(session);
				
				request.getSession().setAttribute("lista_contratto", lista_contratto);
				request.getSession().setAttribute("lista_software", lista_software);
				request.getSession().setAttribute("lista_company", lista_company);
				request.getSession().setAttribute("lista_tipi_licenze", lista_tipi_licenze);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaContrattiSoftware.jsp");
		     	dispatcher.forward(request,response);
				
			}
			else if(action.equals("nuovo_contratto")) {
				
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
	            	
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	            	
	            }
		
		        
				String fornitore = ret.get("fornitore");
				String data_inizio = ret.get("data_inizio");			
				String data_scadenza = ret.get("data_scadenza");
				String permanente = ret.get("permanente");
				String id_software_associazione = ret.get("id_software_associazione");
				String n_licenze = ret.get("n_licenze");
				String email_referenti = ret.get("email_referenti");
				String subscription = ret.get("subscription");
				String descrizione = ret.get("descrizione");
				String id_company = ret.get("company");
				
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				DevContrattoDTO contratto = new DevContrattoDTO();
				
				contratto.setFornitore(fornitore);
				contratto.setData_inizio(df.parse(data_inizio));
				if(email_referenti!=null) {
					contratto.setEmail_referenti(email_referenti.trim());	
				}
				
				contratto.setSubscription(subscription);
				contratto.setDescrizione(descrizione);
				if(data_scadenza!=null && !data_scadenza.equals("")) {
					Date dataScadenza = df.parse(data_scadenza);
					contratto.setData_scadenza(dataScadenza);	
					
					Calendar c = Calendar.getInstance();
					c.setTime(dataScadenza);
					
					if(c.getTime().before(new Date())) {
						contratto.setStato("S");
					}else {
						contratto.setStato("C");
					}
					c.add(Calendar.DAY_OF_YEAR, -30);
					if(c.getTime().before(new Date())) {
						c.setTime(dataScadenza);
						c.add(Calendar.DAY_OF_YEAR, -15);
					}
					if(c.getTime().before(new Date())) {
						c.setTime(dataScadenza);
						c.add(Calendar.DAY_OF_YEAR, -7);
					}
					if(c.getTime().before(new Date())) {
						c.setTime(dataScadenza);
						
					}					
					contratto.setData_invio_remind(c.getTime());
					
										
				}else {
					contratto.setData_scadenza(null);
				}
				
				contratto.setPermanente(permanente);
				
				if(id_company!=null && !id_company.equals("")&& !id_company.equals("0")) {
				
					DocumFornitoreDTO cmp = GestioneDocumentaleBO.getFornitoreFromId(Integer.parseInt(id_company), session);
					contratto.setCompany(cmp);
				}else {
					contratto.setCompany(null);
				}
				
				if(n_licenze!=null&& !n_licenze.equals("")) {
					contratto.setN_licenze(Integer.parseInt(n_licenze));
				}
				
				session.save(contratto);
				
				if(id_software_associazione!=null && !id_software_associazione.equals("")) {
				for (int i = 0; i < id_software_associazione.split(";").length; i++) {
					DevSoftwareDTO s = GestioneDeviceBO.getSoftwareFromID(Integer.parseInt(id_software_associazione.split(";")[i]), session);
					if(s.getContratto()!=null) {
						DevSoftwareDTO new_software = new DevSoftwareDTO();
						new_software.setCompany(s.getCompany());
						new_software.setContratto(contratto);
						new_software.setData_acquisto(s.getData_acquisto());
						new_software.setData_scadenza(contratto.getData_scadenza());
						if(contratto.getData_scadenza()!=null && contratto.getData_invio_remind()!=null) {
							new_software.setData_invio_remind(null);
						}
						new_software.setEmail_responsabile(s.getEmail_responsabile());
						new_software.setNome(s.getNome());
						new_software.setProduttore(s.getProduttore());
						new_software.setTipo_licenza(s.getTipo_licenza());
						new_software.setVersione(s.getVersione());
												
						session.save(new_software);
						

						
					}else {
						if(contratto.getData_scadenza()!=null) {
							s.setData_scadenza(contratto.getData_scadenza());
						}
						s.setContratto(contratto);
							
						session.update(s);
					}
					
				}
				
				}
								
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Contratto salvato con successo!");
				out.print(myObj);
				
				
			}
			
			else if(action.equals("modifica_contratto")) {
				
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
	            	
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	            	
	            }
		
		        String id_contratto = ret.get("id_contratto");
				String fornitore = ret.get("fornitore_mod");
				String data_inizio = ret.get("data_inizio_mod");			
				String data_scadenza = ret.get("data_scadenza_mod");
				String permanente = ret.get("permanente_mod");
				String id_software_associazione = ret.get("id_software_associazione_mod");
				String n_licenze = ret.get("n_licenze_mod");
				String email_referenti = ret.get("email_referenti_mod");
				String subscription = ret.get("subscription_mod");
				String descrizione = ret.get("descrizione_mod");
				String id_company = ret.get("company_mod");
				String is_rinnova = ret.get("is_rinnova");
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				DevContrattoDTO contratto = null;
				DevContrattoDTO contrattoOld = null;
				if(is_rinnova!=null && is_rinnova.equals("1")) {
					contratto = new DevContrattoDTO();
					contrattoOld = GestioneDeviceBO.getContrattoFromID(Integer.parseInt(id_contratto),session);
					contrattoOld.setDisabilitato(1);
					session.update(contrattoOld);
					contratto.setId_contratto_precedente(contrattoOld.getId());
				}else {
					contratto = GestioneDeviceBO.getContrattoFromID(Integer.parseInt(id_contratto),session);
				}
				 
				
				contratto.setFornitore(fornitore);
				contratto.setData_inizio(df.parse(data_inizio));
				contratto.setSubscription(subscription);
				contratto.setDescrizione(descrizione);
				contratto.setPermanente(permanente);
				if(email_referenti!=null) {
					contratto.setEmail_referenti(email_referenti.trim());	
				}
				if(n_licenze!=null&& !n_licenze.equals("")) {
					contratto.setN_licenze(Integer.parseInt(n_licenze));
				}
				
				if(data_scadenza!=null && !data_scadenza.equals("")) {
					Date dataScadenza = df.parse(data_scadenza);
					contratto.setData_scadenza(dataScadenza);	
					Calendar c = Calendar.getInstance();
					c.setTime(dataScadenza);
					if(c.getTime().before(new Date())) {
						contratto.setStato("S");
					}else {
						contratto.setStato("C");
					}
					
					c.add(Calendar.DAY_OF_YEAR, -30);
					if(c.getTime().before(new Date())) {
						c.setTime(dataScadenza);
						c.add(Calendar.DAY_OF_YEAR, -15);
					}
					if(c.getTime().before(new Date())) {
						c.setTime(dataScadenza);
						c.add(Calendar.DAY_OF_YEAR, -7);
					}
					if(c.getTime().before(new Date())) {
						c.setTime(dataScadenza);
						
					}	
					contratto.setData_invio_remind(c.getTime());					
				}else {
					contratto.setData_scadenza(null);
				}
				
				if(id_company!=null && !id_company.equals("")&& !id_company.equals("0")) {
					
					DocumFornitoreDTO cmp = GestioneDocumentaleBO.getFornitoreFromId(Integer.parseInt(id_company), session);
					contratto.setCompany(cmp);
				}else {
					contratto.setCompany(null);
				}
				
				session.saveOrUpdate(contratto);
				
				
				
				if(is_rinnova!=null && is_rinnova.equals("1")) {
					ArrayList<DevSoftwareDTO> lista_softwareAssociati = GestioneDeviceBO.getListaContrattoSoftware(contrattoOld.getId(), session);
					
					for (DevSoftwareDTO devSoftwareDTO : lista_softwareAssociati) {
						devSoftwareDTO.setContratto(contratto);
						devSoftwareDTO.setData_scadenza(contratto.getData_scadenza());
						if(contratto.getData_scadenza()!=null && contratto.getData_invio_remind()!=null) {
							devSoftwareDTO.setData_invio_remind(null);
						}
						session.update(devSoftwareDTO);
						
					
					}
				}else {
					
					ArrayList<Integer>lista_id_associati = new ArrayList<Integer>();
					ArrayList<DevSoftwareDTO> lista_softwareAssociati = GestioneDeviceBO.getListaContrattoSoftware(contratto.getId(), session);
					for (DevSoftwareDTO devSoftwareDTO : lista_softwareAssociati) {
						lista_id_associati.add(devSoftwareDTO.getId());
					}
					
					ArrayList<Integer> lista_id_da_associare = new ArrayList<Integer>();
					if(id_software_associazione!=null && !id_software_associazione.equals("")) {
					for (int i = 0; i < id_software_associazione.split(";").length; i++) {
						DevSoftwareDTO s = GestioneDeviceBO.getSoftwareFromID(Integer.parseInt(id_software_associazione.split(";")[i]), session);
						lista_id_da_associare.add(Integer.parseInt(id_software_associazione.split(";")[i]));
						if(s.getContratto()!=null && s.getContratto().getId()!=contratto.getId()) {
							DevSoftwareDTO new_software = new DevSoftwareDTO();
							new_software.setCompany(s.getCompany());
							new_software.setContratto(contratto);
							new_software.setData_acquisto(s.getData_acquisto());
							new_software.setData_scadenza(contratto.getData_scadenza());
							if(contratto.getData_scadenza()!=null && contratto.getData_invio_remind()!=null) {
								new_software.setData_invio_remind(null);
							}
							new_software.setEmail_responsabile(s.getEmail_responsabile());
							new_software.setNome(s.getNome());
							new_software.setProduttore(s.getProduttore());
							new_software.setTipo_licenza(s.getTipo_licenza());
							new_software.setVersione(s.getVersione());
													
							session.save(new_software);
							

						}else {
							if(contratto.getData_scadenza()!=null) {
								s.setData_scadenza(contratto.getData_scadenza());
							}
							s.setContratto(contratto);
							session.update(s);
						}
					}
					}
					
					for (int i = 0; i < lista_id_associati.size(); i++) {
						if(!lista_id_da_associare.contains(lista_id_associati.get(i))) {
							DevSoftwareDTO s = GestioneDeviceBO.getSoftwareFromID(lista_id_associati.get(i), session);
							s.setContratto(null);
							session.update(s);
						}
					}
				}
				
								
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Contratto salvato con successo!");
				out.print(myObj);
				
				
			}
			
			
			else if(action.equals("lista_sw_archiviati")) {
				
				ArrayList<DevSoftwareDTO> lista_software = GestioneDeviceBO.getListaSoftwareArchiviati(session);
				ArrayList<DocumFornitoreDTO> lista_company = GestioneDocumentaleBO.getListaDocumFornitori(session);
				ArrayList<DevTipoLicenzaDTO> lista_tipi_licenze = GestioneDeviceBO.getListaTipiLicenze(session);
				
				request.getSession().setAttribute("lista_software", lista_software);
				request.getSession().setAttribute("lista_company", lista_company);
				request.getSession().setAttribute("lista_tipi_licenze", lista_tipi_licenze);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaSoftwareArchiviati.jsp");
		     	dispatcher.forward(request,response);
			}
			
			else if(action.equals("rendi_obsoleto")) {
				ajax = true;
				
				String id_contratto = request.getParameter("id_contratto");
				
				DevContrattoDTO contratto = GestioneDeviceBO.getContrattoFromID(Integer.parseInt(id_contratto), session);
				
				contratto.setDisabilitato(1);
				session.update(contratto);
				
				ArrayList<DevSoftwareDTO> lista_software_contratto = GestioneDeviceDAO.getListaContrattoSoftware(contratto.getId(), session);
				for (DevSoftwareDTO s : lista_software_contratto) {
					s.setDisabilitato(1);
					session.update(s);
				}
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Salvato con successo!");
				out.print(myObj);
			}
			else if (action.equals("storico_contratto")) {
				
				ajax=true;
				
				String id_contratto = request.getParameter("id_contratto");
				
				ArrayList<DevContrattoDTO> lista_contratti = new ArrayList<DevContrattoDTO>();
				
				DevContrattoDTO contratto= GestioneDeviceBO.getContrattoFromID(Integer.parseInt(id_contratto), session);
								
				lista_contratti.add(contratto);
				
				if(contratto.getId_contratto_precedente()!=null ) {
					while(contratto.getId_contratto_precedente()!=null) {
						DevContrattoDTO contrattoOld =  GestioneDeviceBO.getContrattoFromID(contratto.getId_contratto_precedente(), session);
						lista_contratti.add(contrattoOld);
						
						contratto = contrattoOld;
					}
				}
			
				PrintWriter out = response.getWriter();
				response.setContentType("application/json");
				 Gson gson = new GsonBuilder().setDateFormat("dd/MM/yyyy").create(); 			        			        
			     			      		       
			        myObj.addProperty("success", true);
			
			        myObj.add("lista_contratti", gson.toJsonTree(lista_contratti));			      
			        
			        out.println(myObj.toString());
		
			        out.close();
			        
			     
			}
			else if(action.equals("lista_contratti_obsoleti")) {
				
				ArrayList<DevContrattoDTO> lista_contratto = GestioneDeviceBO.getListaContrattiObsoleti(session);
				ArrayList<DevSoftwareDTO> lista_software = GestioneDeviceBO.getListaSoftware(session);
				ArrayList<DocumFornitoreDTO> lista_company = GestioneDocumentaleBO.getListaDocumFornitori(session);
				ArrayList<DevTipoLicenzaDTO> lista_tipi_licenze = GestioneDeviceBO.getListaTipiLicenze(session);
				
				request.getSession().setAttribute("lista_contratto", lista_contratto);
				request.getSession().setAttribute("lista_software", lista_software);
				request.getSession().setAttribute("lista_company", lista_company);
				request.getSession().setAttribute("lista_tipi_licenze", lista_tipi_licenze);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaContrattiSoftwareObsoleti.jsp");
		     	dispatcher.forward(request,response);
				
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

