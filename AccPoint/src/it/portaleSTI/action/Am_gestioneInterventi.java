package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.AMCampioneDTO;
import it.portaleSTI.DTO.AMImmagineCampioneDTO;
import it.portaleSTI.DTO.AMInterventoDTO;
import it.portaleSTI.DTO.AMOggettoProvaDTO;
import it.portaleSTI.DTO.AMOggettoProvaZonaRifDTO;
import it.portaleSTI.DTO.AMOperatoreDTO;
import it.portaleSTI.DTO.AMProvaDTO;
import it.portaleSTI.DTO.AMRapportoDTO;
import it.portaleSTI.DTO.AMTipoProvaDTO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.DocumFornitoreDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.ItServizioItDTO;
import it.portaleSTI.DTO.ItTipoRinnovoDTO;
import it.portaleSTI.DTO.ItTipoServizioDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.StatoCertificatoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerInterventoDTO;
import it.portaleSTI.DTO.VerInterventoStrumentiDTO;
import it.portaleSTI.DTO.VerMisuraDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.CreateCertificatoAM;
import it.portaleSTI.bo.GestioneAM_BO;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneCommesseBO;
import it.portaleSTI.bo.GestioneDocumentaleBO;
import it.portaleSTI.bo.GestioneInterventoBO;
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
			request.getSession().setAttribute("lista_clienti", listaClienti);				
			request.getSession().setAttribute("lista_sedi", listaSedi);
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
		
		        String id_cliente = ret.get("cliente");
		        String id_sede = ret.get("sede");
		        String id_cliente_utilizzatore = ret.get("cliente_utilizzatore");
		        String id_sede_utilizzatore = ret.get("sede_utilizzatore");
				String nome_cliente = ret.get("nomeCliente");
				String nome_cliente_utilizzatore = ret.get("nomeClienteUtilizzatore");
				String nome_sede= ret.get("nomeSede");
				String nome_sede_utilizzatore = ret.get("nomeSedeUtilizzatore");
				String commessa = ret.get("comm");
				String operatore = ret.get("operatore");
				String data_intervento = ret.get("data_intervento");
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				if(listaSedi== null) {
					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
				}
				
				 
				AMInterventoDTO intervento = new AMInterventoDTO();	
				
				intervento.setId_cliente(Integer.parseInt(id_cliente));
				intervento.setId_sede(Integer.parseInt(id_sede.split("_")[0]));
				intervento.setId_cliente_utilizzatore(Integer.parseInt(id_cliente_utilizzatore));
				intervento.setId_sede_utilizzatore(Integer.parseInt(id_sede_utilizzatore.split("_")[0]));
				
				ClienteDTO cl = GestioneAnagraficaRemotaBO.getClienteById(id_cliente);
				
				intervento.setNomeCliente(cl.getNome());
				SedeDTO sd =null;
				if(!id_sede.equals("0")) {
					sd = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, Integer.parseInt(id_sede.split("_")[0]), Integer.parseInt(id_cliente));
					intervento.setNomeSede(sd.getDescrizione() + " - "+sd.getIndirizzo());
				}else {
					intervento.setNomeSede("Non associate");
				}
				
				cl = GestioneAnagraficaRemotaBO.getClienteById(id_cliente_utilizzatore);
				
				intervento.setNomeClienteUtilizzatore(cl.getNome());
				sd =null;
				
				if(!id_sede_utilizzatore.equals("0")) {
					sd = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, Integer.parseInt(id_sede_utilizzatore.split("_")[0]), Integer.parseInt(id_cliente_utilizzatore));
					intervento.setNomeSedeUtilizzatore(sd.getDescrizione() + " - "+sd.getIndirizzo());
				}else {
					intervento.setNomeSedeUtilizzatore(cl.getNome() +" - "+cl.getIndirizzo()+" - "+cl.getCap()+"- "+cl.getCitta()+" ("+cl.getProvincia()+")");
				}
				intervento.setOperatore(new AMOperatoreDTO(Integer.parseInt(operatore), "", ""));
				intervento.setDataIntervento(df.parse(data_intervento));
				intervento.setIdCommessa(commessa.split("@")[0]);
				
				
				
				session.save(intervento);				
							
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Intervento salvato con successo!");
				out.print(myObj);
				
				
			} else if( action.equals("nuova_sede")) 
			{
				
					PrintWriter  out = response.getWriter();
					String id_intervento = request.getParameter("id_intervento");
					
					String pivot = request.getParameter("pivot");
					
					AMInterventoDTO intervento = GestioneAM_BO.getInterventoFromID(Integer.parseInt(id_intervento), session);
					
					if(pivot.equals("1")) 
					{
						String nome_sede = request.getParameter("nome_sede");
						intervento.setNomeSede(nome_sede);
						
					}
					else 
					{
						String nome_sede_util = request.getParameter("nome_sede");
						intervento.setNomeSedeUtilizzatore(nome_sede_util);	
					}
			
					
					Gson gson = new Gson();
					String jsonInString = gson.toJson(intervento);
					
					
					myObj.addProperty("success", true);
					myObj.addProperty("intervento", jsonInString);
					myObj.addProperty("messaggio", "Sede aggiornata con successo!");
				
					out.print(myObj);
					
				
			}
			
			
			else if(action.equals("modifica")) {
				
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
		
		        String id_cliente = ret.get("cliente_mod");
		        String id_sede = ret.get("sede_mod");
		        String id_cliente_utilizzatore = ret.get("cliente_utilizzatore_mod");
		        String id_sede_utilizzatore = ret.get("sede_utilizzatore_mod");
		        String id_intervento = ret.get("id_intervento");
				String nome_cliente = ret.get("nomeCliente_mod");
				String nome_cliente_utilizzatore = ret.get("nomeClienteUtilizzatore_mod");
				String nome_sede= ret.get("nomeSede_mod");
				String nome_sede_utilizzatore = ret.get("nomeSedeUtilizzatore_mod");
				String commessa = ret.get("comm_mod");
				String operatore = ret.get("operatore_mod");
				String data_intervento = ret.get("data_intervento_mod");
				
				List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				if(listaSedi== null) {
					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
				}
				
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				
				AMInterventoDTO intervento = GestioneAM_BO.getInterventoFromID(Integer.parseInt(id_intervento), session);	
				
				intervento.setId_cliente(Integer.parseInt(id_cliente));
				intervento.setId_sede(Integer.parseInt(id_sede.split("_")[0]));
				intervento.setId_cliente_utilizzatore(Integer.parseInt(id_cliente_utilizzatore));
				intervento.setId_sede_utilizzatore(Integer.parseInt(id_sede_utilizzatore.split("_")[0]));
				
				ClienteDTO cl = GestioneAnagraficaRemotaBO.getClienteById(id_cliente);
				
				intervento.setNomeCliente(cl.getNome());
				SedeDTO sd =null;
				if(!id_sede.equals("0")) {
					sd = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, Integer.parseInt(id_sede.split("_")[0]), Integer.parseInt(id_cliente));
					intervento.setNomeSede(sd.getDescrizione() + " - "+sd.getIndirizzo());
				}else {
					intervento.setNomeSede("Non associate");
				}
				
				
				cl = GestioneAnagraficaRemotaBO.getClienteById(id_cliente_utilizzatore);
				
				intervento.setNomeClienteUtilizzatore(cl.getNome());
				sd =null;
				
				if(!id_sede_utilizzatore.equals("0")) {
					sd = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, Integer.parseInt(id_sede_utilizzatore.split("_")[0]), Integer.parseInt(id_cliente_utilizzatore));
					intervento.setNomeSedeUtilizzatore(sd.getDescrizione() + " - "+sd.getIndirizzo());
				}else {
					intervento.setNomeSedeUtilizzatore(cl.getNome() +" - "+cl.getIndirizzo()+" - "+cl.getCap()+" - "+cl.getCitta()+" ("+cl.getProvincia()+")");
				}
			
				intervento.setOperatore(new AMOperatoreDTO(Integer.parseInt(operatore), "", ""));
				intervento.setDataIntervento(df.parse(data_intervento));
				intervento.setIdCommessa(commessa.split("@")[0]);
				
				
				
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
				
				ArrayList<AMRapportoDTO> lista_rapporti = GestioneAM_BO.getListaRapportiIntervento(Integer.parseInt(id_intervento), session);
				ArrayList<AMOggettoProvaDTO> lista_strumenti = GestioneAM_BO.getListaStrumentiClienteSede(intervento.getId_cliente_utilizzatore(), intervento.getId_sede_utilizzatore(),session);
				ArrayList<AMCampioneDTO> lista_campioni = GestioneAM_BO.getListaCampioni(session);
				ArrayList<AMTipoProvaDTO> lista_tipi_prova = GestioneAM_BO.getListaTipiProva(session);
				ArrayList<AMOperatoreDTO> lista_operatori = GestioneAM_BO.getListaOperatoriAll(session);
				
				
				request.getSession().setAttribute("intervento", intervento);
				request.getSession().setAttribute("lista_rapporti", lista_rapporti);
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
				
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	            		 if(item.getFieldName().equals("fileupload_excel")) {
	            			 fileItem_excel = item;
	            			 filename_excel = item.getName();
	            			 
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
				String note = ret.get("note");
				String ubicazione = ret.get("ubicazione");
				
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				AMOggettoProvaDTO strumento = GestioneAM_BO.getOggettoProvaFromID(Integer.parseInt(id_strumento), session);
				
				PrintWriter  out = response.getWriter();
				
//				if(strumento.getFilename_img() == null || strumento.getFilename_img().equals("")) {
//					
//					myObj.addProperty("success", false);
//					myObj.addProperty("messaggio", "Attenzione! Sullo strumento selezionato non è presente l'immagine!");
//				
//				out.print(myObj);
//					
//				}else {
					
					AMTipoProvaDTO tipo = GestioneAM_BO.getTipoProvaFromID(Integer.parseInt(id_tipo_prova), session);
					AMCampioneDTO campione = GestioneAM_BO.getCampioneFromID(Integer.parseInt(id_campione), session);
					
					AMInterventoDTO intervento = GestioneAM_BO.getInterventoFromID(Integer.parseInt(id_intervento), session);
					AMOperatoreDTO operatore = GestioneAM_BO.getOperatoreFromID(Integer.parseInt(id_operatore), session);
					
					AMProvaDTO prova = new AMProvaDTO();	
					
					prova.setTipoProva(tipo);
					prova.setCampione(campione);
					prova.setStrumento(strumento);
					prova.setEsito(esito);
					prova.setData(df.parse(data));
					prova.setIntervento(intervento);
					prova.setNote(note);
					prova.setUbicazione(ubicazione);
					
					prova.setOperatore(operatore);
					
					session.save(prova);			
					boolean esito_import = true;

					if(filename_excel!=null && !filename_excel.equals("")) {
						prova.setFilename_excel(filename_excel);
						Utility.saveFile(fileItem_excel, Costanti.PATH_FOLDER+"\\AM_interventi\\"+intervento.getId()+"\\"+prova.getId()+"\\excel", filename_excel);
						
						String[] values = GestioneAM_BO.getMatrix(Costanti.PATH_FOLDER+"\\AM_interventi\\"+intervento.getId()+"\\"+prova.getId()+"\\excel\\"+filename_excel);
						
						if(values[3].equals("[]")) {
							esito_import = false;
						}
						
						prova.setMatrixSpess(values[3]);
		
						
					}else {
						int m = prova.getStrumento().getNumero_porzioni();
						int n = 0;
						AMOggettoProvaZonaRifDTO maxZona = null;
						for (AMOggettoProvaZonaRifDTO zona : prova.getStrumento().getListaZoneRiferimento()) {
						    if (maxZona == null || zona.getId() > maxZona.getId()) {
						        maxZona = zona;
						    }
						}
						
						if(maxZona!=null) {
							n = maxZona.getPunto_intervallo_fine();
						}
						
						String matrix = "";
						for (int i = 0; i < n; i++) {
							matrix += "{";
							for (int j = 0; j < m; j++) {
								matrix += "0,";
							}
							matrix += "},";
						}
						prova.setMatrixSpess(matrix);
					}
					
					
					myObj = new JsonObject();
				
					if(esito_import) {
						session.update(prova);
						
						AMRapportoDTO rapporto = new AMRapportoDTO();
						rapporto.setProva(prova);
						rapporto.setData(new Date());
						rapporto.setUtente(utente);
						rapporto.setStato(new StatoCertificatoDTO(1));
						
						session.save(rapporto);
						myObj.addProperty("success", true);
						myObj.addProperty("messaggio", "Prova salvata con successo!");
					}else {
						session.getTransaction().rollback();
						myObj.addProperty("success", false);
						myObj.addProperty("messaggio", "Formato matrice errato!");
					}
					
					out.print(myObj);
					
					
				//}
				
				
				
				
				
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
				
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	            		 if(item.getFieldName().equals("fileupload_excel_mod")) {
	            			 fileItem_excel = item;
	            			 filename_excel = item.getName();
	            			 
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
				String note = ret.get("note_mod");
				String ubicazione = ret.get("ubicazione_mod");
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				AMOggettoProvaDTO strumento = GestioneAM_BO.getOggettoProvaFromID(Integer.parseInt(id_strumento), session);
				PrintWriter  out = response.getWriter();
				
//				if(strumento.getFilename_img() == null || strumento.getFilename_img().equals("")) {
//					
//					myObj.addProperty("success", false);
//					myObj.addProperty("messaggio", "Attenzione! Sullo strumento selezionato non è presente l'immagine!");
//				
//				out.print(myObj);
//					
//				}else {
					AMProvaDTO prova = GestioneAM_BO.getProvaFromID(Integer.parseInt(id_prova), session);	
					
					AMTipoProvaDTO tipo = GestioneAM_BO.getTipoProvaFromID(Integer.parseInt(id_tipo_prova), session);
					AMCampioneDTO campione = GestioneAM_BO.getCampioneFromID(Integer.parseInt(id_campione), session);
					AMInterventoDTO intervento = GestioneAM_BO.getInterventoFromID(Integer.parseInt(id_intervento), session);
					AMOperatoreDTO operatore = GestioneAM_BO.getOperatoreFromID(Integer.parseInt(id_operatore), session);
					
					
					prova.setTipoProva(tipo);
					prova.setCampione(campione);
					prova.setStrumento(strumento);
					prova.setEsito(esito);
					prova.setData(df.parse(data));
					prova.setIntervento(intervento);
					prova.setNote(note);
					prova.setOperatore(operatore);
					prova.setUbicazione(ubicazione);
					
			
					boolean esito_import = true;
					if(filename_excel!=null && !filename_excel.equals("")) {
						prova.setFilename_excel(filename_excel);
						Utility.saveFile(fileItem_excel, Costanti.PATH_FOLDER+"\\AM_interventi\\"+intervento.getId()+"\\"+prova.getId()+"\\excel", filename_excel);
						
						String[] values = GestioneAM_BO.getMatrix(Costanti.PATH_FOLDER+"\\AM_interventi\\"+intervento.getId()+"\\"+prova.getId()+"\\excel\\"+filename_excel);
						
						if(values[3].equals("[]")) {
							esito_import = false;
						}
				
						prova.setMatrixSpess(values[3]);
						
					}
//					else {
//						int m = prova.getStrumento().getNumero_porzioni();
//						int n = 0;
//						AMOggettoProvaZonaRifDTO maxZona = null;
//						for (AMOggettoProvaZonaRifDTO zona : prova.getStrumento().getListaZoneRiferimento()) {
//						    if (maxZona == null || zona.getId() > maxZona.getId()) {
//						        maxZona = zona;
//						    }
//						}
//						
//						if(maxZona!=null) {
//							n = maxZona.getPunto_intervallo_fine();
//						}
//						
//						String matrix = "";
//						for (int i = 0; i < n; i++) {
//							matrix += "{";
//							for (int j = 0; j < m; j++) {
//								matrix += "0,";
//							}
//							matrix += "},";
//						}
//						prova.setMatrixSpess(matrix);
//					}
					
					
					
						
					myObj = new JsonObject();
					
					if(esito_import) {
						session.update(prova);
						
						myObj.addProperty("success", true);
						myObj.addProperty("messaggio", "Prova salvata con successo!");
					}else {
						
						myObj.addProperty("success", false);
						myObj.addProperty("messaggio", "Formato matrice errato!");
					}
					
					out.print(myObj);
		//		}
				
				
			
				
				
				
			}
			else if(action.equals("dettaglio_prova")) {
				
				String id_prova = request.getParameter("id_prova");
				
				id_prova = Utility.decryptData(id_prova);
				
				AMProvaDTO prova = GestioneAM_BO.getProvaFromID(Integer.parseInt(id_prova), session);
				request.getSession().setAttribute("prova", prova);
				
				String rawMatrix = prova.getMatrixSpess(); // es: "[{1.0, 2.0, 3.0}, {4.0, 5.0, 6.0}]"
				List<String> colonne = new ArrayList<>();
				//List<List<Double>> matrixParsed = new ArrayList<>();
				List<List<String>> matrixParsed = new ArrayList<>();
				// Rimuove i bordi esterni
				if(rawMatrix!=null) {
					rawMatrix = rawMatrix.replaceAll("^\\[|\\]$", "").trim();

					// Split per righe (ogni gruppo tra graffe)
					String[] rows = rawMatrix.split("\\},\\s*\\{");

					

					for (String row : rows) {
					    // rimuove graffe residue
					    row = row.replaceAll("[{}]", "");
					    String[] nums = row.split(",");
					    //List<Double> rowList = new ArrayList<>();
					    List<String> rowList = new ArrayList<>();
					    for (String num : nums) {
					       // rowList.add(Double.parseDouble(num.trim()));
					    	 rowList.add(num.trim());
					    }
					    matrixParsed.add(rowList);
					}

					// Set come attributo per la JSP
					

					// Colonne (A, B, C, ...)
					int numCols = matrixParsed.get(0).size();
					
					for (int i = 0; i < numCols; i++) {
					    colonne.add(String.valueOf((char) ('A' + i)));
					}
				}

				Set<AMOggettoProvaZonaRifDTO> lista = prova.getStrumento().getListaZoneRiferimento();
				List<AMOggettoProvaZonaRifDTO> sortedList = lista.stream()
					    .sorted(Comparator.comparing(AMOggettoProvaZonaRifDTO::getId)) // o getIdZona() se hai un altro metodo
					    .collect(Collectors.toList());

					// Ora puoi iterare ordinato
				Map<String, Integer> valori_span = new LinkedHashMap<>();
				

				
					for (AMOggettoProvaZonaRifDTO zona : sortedList) {
						valori_span.put(zona.getIndicazione(),zona.getPunto_intervallo_fine()); 
					}
				
					List<Map.Entry<String, Integer>> listaEntry = new ArrayList<>(valori_span.entrySet());
					
					Gson g = new Gson();
					
					
				AMRapportoDTO rapporto = GestioneAM_BO.getRapportoFromProva(prova.getId(), session);
				
				request.setAttribute("rapporto", rapporto);
				request.setAttribute("colonne", colonne);
				request.setAttribute("matrix_spess", matrixParsed);
			
				request.setAttribute("entryList", listaEntry);
				request.setAttribute("lista_zone_minimi", g.toJson(sortedList));
				 
				
				
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/am_dettaglioProva.jsp");
				dispatcher.forward(request, response);
			}
			
			else if (action.equals("immagine")) {
				
		        AMProvaDTO prova = (AMProvaDTO) request.getSession().getAttribute("prova");
		        
		       String id_immagine = request.getParameter("id_immagine");

		        if (prova != null && prova.getStrumento().getFilename_img()!=null && !prova.getStrumento().getFilename_img().equals("")&& id_immagine==null) {
		        	
		        	String imagePath =	Costanti.PATH_FOLDER+"\\AM_interventi\\Strumenti\\"+prova.getStrumento().getId()+"\\"+prova.getStrumento().getFilename_img();
		        	
		            File imageFile = new File(imagePath);

		            if (imageFile.exists()) {
		                response.setContentType(getServletContext().getMimeType(imageFile.getName()));
		               

		                try (FileInputStream fis = new FileInputStream(imageFile);
		                     OutputStream os = response.getOutputStream()) {

		                    byte[] buffer = new byte[8192];
		                    int bytesRead;
		                    while ((bytesRead = fis.read(buffer)) != -1) {
		                        os.write(buffer, 0, bytesRead);
		                    }
		                }

		            } else {
		                response.sendError(HttpServletResponse.SC_NOT_FOUND, "File immagine non trovato");
		            }
		        }
		        else if(id_immagine!=null) {
		        	AMImmagineCampioneDTO immagine = GestioneAM_BO.getImmagineFromId(Integer.parseInt(id_immagine), session);
		        	
		        	String imagePath =	Costanti.PATH_FOLDER+"\\AM_interventi\\ImmaginiCampione\\"+immagine.getId()+"\\"+immagine.getNome_file();
		        	
		            File imageFile = new File(imagePath);

		            if (imageFile.exists()) {
		                response.setContentType(getServletContext().getMimeType(imageFile.getName()));
		               

		                try (FileInputStream fis = new FileInputStream(imageFile);
		                     OutputStream os = response.getOutputStream()) {

		                    byte[] buffer = new byte[8192];
		                    int bytesRead;
		                    while ((bytesRead = fis.read(buffer)) != -1) {
		                        os.write(buffer, 0, bytesRead);
		                    }
		                }	
		        }
		        else {
		            response.sendError(HttpServletResponse.SC_NOT_FOUND, "File immagine non trovato");
		        }
		    }
			}
			else if(action.equals("genera_certificato")){
				
				ajax = true;
				
				String id_prova = request.getParameter("id_prova");
				String anteprima = request.getParameter("isAnteprima");
				
				id_prova = Utility.decryptData(id_prova);
				
				AMProvaDTO prova = GestioneAM_BO.getProvaFromID(Integer.parseInt(id_prova), session);
				
				PrintWriter  out = response.getWriter();
				
				if(prova.getStrumento().getFilename_img() == null || prova.getStrumento().getFilename_img().equals("")) {
					
					myObj.addProperty("success", false);
					myObj.addProperty("messaggio", "Attenzione! Sullo strumento selezionato non è presente l'immagine!");
				
					out.print(myObj);
					
				}else {
					AMRapportoDTO rapporto = GestioneAM_BO.getRapportoFromProva(prova.getId(), session);
					
					boolean isAnteprima = false;
					if(anteprima!=null && anteprima.equals("1")) {
						isAnteprima = true;
					}
					
					CreateCertificatoAM cert = new CreateCertificatoAM(prova, session, rapporto, isAnteprima);
					
					myObj = new JsonObject();
					
					myObj.addProperty("success", true);
					myObj.addProperty("messaggio", "Certificato salvato con successo!");
					out.print(myObj);
				}
				
			}
			
			
			else if(action.equals("download_certificato")) {
				
				
				String id_prova = request.getParameter("id_prova");
				String anteprima = request.getParameter("isAnteprima");
				
				id_prova = Utility.decryptData(id_prova);
				
				AMProvaDTO prova = GestioneAM_BO.getProvaFromID(Integer.parseInt(id_prova), session);
				
				
				
				String path ="";
				boolean isAnteprima = false;
				if(anteprima!=null && anteprima.equals("1")) {
					isAnteprima = true;
				}
				if(isAnteprima) {
					path = Costanti.PATH_FOLDER+"\\AM_Interventi\\"+prova.getIntervento().getId()+"\\"+prova.getId()+"\\Certificati\\ANTEPRIMA.pdf";
				//	response.setContentType("application/octet-stream");
					  
				//	 response.setHeader("Content-Disposition","attachment;filename=ANTEPRIMA.pdf");
					response.setContentType("application/pdf");	
				}else {
					AMRapportoDTO certificato = GestioneAM_BO.getRapportoFromProva(prova.getId(), session);
					String filename = prova.getId()+"\\Certificati\\"+certificato.getNomeFile();
					path = Costanti.PATH_FOLDER+"\\AM_Interventi\\"+prova.getIntervento().getId()+"\\"+filename;
					response.setContentType("application/pdf");	
					response.setHeader("Content-Disposition", "inline; filename="+filename);
				}
						
				
				
				
				Utility.downloadFile(path, response.getOutputStream());
				
				
				
			}
			
			else if(action.equals("lista_prove")) {
				
				//ArrayList<AMProvaDTO> lista_prove = GestioneAM_BO.getListaProve(session);
				ArrayList<AMRapportoDTO> lista_prove = GestioneAM_BO.getListaRapportiProve(session);
				
				request.setAttribute("lista_prove", lista_prove);

				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/am_listaProve.jsp");
				dispatcher.forward(request, response);
			}
			
			else if(action.equals("salva_patentino")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}
		        
		       
			
				FileItem file_patentino = null;
				String filename_patentino= null;
				FileItem file_firma = null;
				String filename_firma= null;
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	            		  if(item.getFieldName().equals("file_patentino") && !item.getName().equals("")) {
	            			 file_patentino = item;
	            			 filename_patentino = item.getName();
	            		 }
	            		  else if(item.getFieldName().equals("file_firma") && !item.getName().equals("")) {
	            			  file_firma = item;
	            			  filename_firma = item.getName();
		            		 }
	            	 }else
	            	 {
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	            	 }
	            	
	            }
		
				String id_operatore = ret.get("id_operatore");
				String dicitura = ret.get("dicitura");
				
				AMOperatoreDTO operatore = GestioneAM_BO.getOperatoreFromID(Integer.parseInt(id_operatore),session);
				operatore.setDicituraPatentino(dicitura);
				
				if(filename_patentino!=null) {
					Utility.saveFile(file_patentino, Costanti.PATH_FOLDER+"\\AM_interventi\\Patentini\\"+operatore.getId()+"\\", filename_patentino);
					operatore.setPathPatentino(filename_patentino);
				}
				if(filename_firma!=null) {
					Utility.saveFile(file_firma, Costanti.PATH_FOLDER+"\\AM_interventi\\Firme\\"+operatore.getId()+"\\", filename_firma);
					operatore.setFirma(filename_firma);
				}
				
				session.update(operatore);
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Patentino salvato con successo!");
				out.print(myObj);
				
				
			
			}
			else if(action.equals("salva_prova_edit")) {
				
				ajax = true;
				String matrix = request.getParameter("matrix");
				String id_prova = request.getParameter("id_prova");
				String label_minimi = request.getParameter("label_minimi");
				String esito = request.getParameter("esito");
				String note = request.getParameter("note");
				
				
				
				AMProvaDTO prova = GestioneAM_BO.getProvaFromID(Integer.parseInt(id_prova), session);
				
				prova.setMatrixSpess(matrix);
				prova.setNote(note);
			
				if(esito!=null) {
					if(esito.contains("NON CONFORME")) {
						prova.setEsito("NEGATIVO");
					}else {
						prova.setEsito("POSITIVO");
					}	
				}
				

				session.update(prova);
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Salvato con successo!");
				out.print(myObj);
				
			}
			
			else if(action.equals("scarica_template")) {
				
				String path = Costanti.PATH_FOLDER+"\\AM_Interventi\\TemplateAM.xlsx";
				
				String isCad = request.getParameter("isCad");
				
				response.setContentType("application/octet-stream");
				  
				response.setHeader("Content-Disposition","attachment;filename=TemplateAM.xlsx");
				
				if(isCad!=null && isCad.equals("1")) {
					path = Costanti.PATH_FOLDER+"\\AM_Interventi\\Disegno serbatoi.dwg";
					response.setHeader("Content-Disposition","attachment;filename=Disegno serbatoi.dwg");
				}
				
				Utility.downloadFile(path, response.getOutputStream());
			}
			
			else if(action.equals("rigenera_tabella")) {
				
				String id_prova = request.getParameter("id_prova");
				
				AMProvaDTO prova = GestioneAM_BO.getProvaFromID(Integer.parseInt(id_prova), session);
				
				int m = prova.getStrumento().getNumero_porzioni();
				int n = 0;
				AMOggettoProvaZonaRifDTO maxZona = null;
				for (AMOggettoProvaZonaRifDTO zona : prova.getStrumento().getListaZoneRiferimento()) {
				    if (maxZona == null || zona.getId() > maxZona.getId()) {
				        maxZona = zona;
				    }
				}
				
				if(maxZona!=null) {
					n = maxZona.getPunto_intervallo_fine();
				}
				
				String matrix = "";
				for (int i = 0; i < n; i++) {
					matrix += "{";
					for (int j = 0; j < m; j++) {
						matrix += "0,";
					}
					matrix += "},";
				}
				prova.setMatrixSpess(matrix);
				
				session.update(prova);
				
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Tabella rigenerata con successo!");
				out.print(myObj);
				
			}
			
			else if(action.equals("lista_immagini_campione")) {
				
				ArrayList<AMImmagineCampioneDTO> lista_immagini = GestioneAM_BO.getListaImmagineCampione(session);
				
				request.setAttribute("lista_immagini", lista_immagini);

				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/am_listaImmaginiCampione.jsp");
				dispatcher.forward(request, response);
				
			}else if(action.equals("nuova_immagine")) {
				
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
	            		
	            		  if(item.getFieldName().equals("fileupload") && !item.getName().equals("")) {
	            			  fileItem = item;
	            			  filename = item.getName();
	            		 }
	            		  
	            	 }else
	            	 {
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	            	 }
	            	
	            }
		
		        String descrizione = ret.get("descrizione");
			
				if(filename!=null) {
					
					AMImmagineCampioneDTO immagine = new AMImmagineCampioneDTO();
					immagine.setNome_file(filename);
					immagine.setDescrizione(descrizione);
					
					session.save(immagine);
					
					Utility.saveFile(fileItem, Costanti.PATH_FOLDER+"\\AM_interventi\\ImmaginiCampione\\"+immagine.getId()+"\\", filename);
					session.update(immagine);
				}				
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Immagine salvata con successo!");
				out.print(myObj);
				
				
			}
			
			
			else if(action.equals("modifica_immagine")) {
				
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
	            		
	            		  if(item.getFieldName().equals("fileupload_mod") && !item.getName().equals("")) {
	            			  fileItem = item;
	            			  filename = item.getName();
	            		 }
	            		  
	            	 }else
	            	 {
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	            	 }
	            	
	            }
		
		        String descrizione = ret.get("descrizione_mod");
		        String id_immagine = ret.get("id_immagine");
		        
		        AMImmagineCampioneDTO immagine = GestioneAM_BO.getImmagineFromId(Integer.parseInt(id_immagine), session);
		        immagine.setDescrizione(descrizione);
			
				if(filename!=null) {
										
					immagine.setNome_file(filename);

					Utility.saveFile(fileItem, Costanti.PATH_FOLDER+"\\AM_interventi\\ImmaginiCampione\\"+immagine.getId()+"\\", filename);
					
				}	
				
				session.update(immagine);
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Immagine salvata con successo!");
				out.print(myObj);
				
				
			}
			else if(action.equals("elimina_immagine")) {
				
				ajax = true;
				
				String id_immagine = request.getParameter("id_immagine");
				
				AMImmagineCampioneDTO immagine = GestioneAM_BO.getImmagineFromId(Integer.parseInt(id_immagine), session);
				immagine.setDisabilitato(1);
				
				session.update(immagine);
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Immagine eliminata con successo!");
				out.print(myObj);
			}
			else if(action.equals("cambia_stato_intervento")) {
				
				ajax = true;
				
				String id_intervento = request.getParameter("id_intervento");
				String stato = request.getParameter("stato");
				
				AMInterventoDTO intervento = GestioneAM_BO.getInterventoFromID(Integer.parseInt(id_intervento), session);
				
				intervento.setStato(Integer.parseInt(stato));
				
				session.update(intervento);
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Salvato con successo!");
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
