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
import it.portaleSTI.DTO.AMInterventoDTO;
import it.portaleSTI.DTO.AMOggettoProvaDTO;
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
					intervento.setNomeSedeUtilizzatore(cl.getNome() +" - "+cl.getIndirizzo()+"_"+cl.getCap()+"- "+cl.getCitta()+" ("+cl.getProvincia()+")");
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
					intervento.setNomeSedeUtilizzatore(cl.getNome() +" - "+cl.getIndirizzo()+"_"+cl.getCap()+"- "+cl.getCitta()+" ("+cl.getProvincia()+")");
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
				String note = ret.get("note");
				
				
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
				prova.setNote(note);
				
				prova.setOperatore(operatore);
				
				session.save(prova);			
				boolean esito_import = true;
//				if(fileItem_excel!=null) {
//					prova.setFilename_excel(filename_excel);
//					Utility.saveFile(fileItem_excel, Costanti.PATH_FOLDER+"\\AM_interventi\\"+intervento.getId()+"\\"+prova.getId()+"\\excel", filename_excel);
//					
//					String matrix = GestioneAM_BO.getMatrix(Costanti.PATH_FOLDER+"\\AM_interventi\\"+intervento.getId()+"\\"+prova.getId()+"\\excel\\"+filename_excel);
//					if(matrix.equals("[]")) {
//						esito_import = false;
//					}
//					
//					prova.setMatrixSpess(matrix);
//				}
				if(filename_excel!=null && !filename_excel.equals("")) {
					prova.setFilename_excel(filename_excel);
					Utility.saveFile(fileItem_excel, Costanti.PATH_FOLDER+"\\AM_interventi\\"+intervento.getId()+"\\"+prova.getId()+"\\excel", filename_excel);
					
					String[] values = GestioneAM_BO.getMatrix(Costanti.PATH_FOLDER+"\\AM_interventi\\"+intervento.getId()+"\\"+prova.getId()+"\\excel\\"+filename_excel);
					
					if(values[3].equals("[]")) {
						esito_import = false;
					}
					
					
					prova.setSpess_min_fasciame(values[0]);					
					prova.setSpess_min_fondo_sup(values[1]);
					prova.setSpess_min_fondo_inf(values[2]);
					
					prova.setMatrixSpess(values[3]);
					prova.setLabel_minimi(values[4]);
					
				}
				
				if(filename_img!=null) {
					prova.setFilename_img(filename_img);
					Utility.saveFile(fileItem_img, Costanti.PATH_FOLDER+"\\AM_interventi\\"+intervento.getId()+"\\"+prova.getId()+"\\img", filename_img);
				}
							
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
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
				String note = ret.get("note_mod");
				
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
				prova.setNote(note);
				prova.setOperatore(operatore);
				
				
		
				boolean esito_import = true;
				if(filename_excel!=null && !filename_excel.equals("")) {
					prova.setFilename_excel(filename_excel);
					Utility.saveFile(fileItem_excel, Costanti.PATH_FOLDER+"\\AM_interventi\\"+intervento.getId()+"\\"+prova.getId()+"\\excel", filename_excel);
					
					String[] values = GestioneAM_BO.getMatrix(Costanti.PATH_FOLDER+"\\AM_interventi\\"+intervento.getId()+"\\"+prova.getId()+"\\excel\\"+filename_excel);
					
					if(values[3].equals("[]")) {
						esito_import = false;
					}
					prova.setLabel_minimi(values[4]);
					
					prova.setSpess_min_fasciame(values[0]);					
					prova.setSpess_min_fondo_sup(values[1]);
					prova.setSpess_min_fondo_inf(values[2]);
					
					prova.setMatrixSpess(values[3]);
					
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
			else if(action.equals("dettaglio_prova")) {
				
				String id_prova = request.getParameter("id_prova");
				
				id_prova = Utility.decryptData(id_prova);
				
				AMProvaDTO prova = GestioneAM_BO.getProvaFromID(Integer.parseInt(id_prova), session);
				request.getSession().setAttribute("prova", prova);
				
				String rawMatrix = prova.getMatrixSpess(); // es: "[{1.0, 2.0, 3.0}, {4.0, 5.0, 6.0}]"
				List<String> colonne = new ArrayList<>();
				List<List<Double>> matrixParsed = new ArrayList<>();
				// Rimuove i bordi esterni
				if(rawMatrix!=null) {
					rawMatrix = rawMatrix.replaceAll("^\\[|\\]$", "").trim();

					// Split per righe (ogni gruppo tra graffe)
					String[] rows = rawMatrix.split("\\},\\s*\\{");

					

					for (String row : rows) {
					    // rimuove graffe residue
					    row = row.replaceAll("[{}]", "");
					    String[] nums = row.split(",");
					    List<Double> rowList = new ArrayList<>();
					    for (String num : nums) {
					        rowList.add(Double.parseDouble(num.trim()));
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
				
				AMRapportoDTO rapporto = GestioneAM_BO.getRapportoFromProva(prova.getId(), session);
				
				request.setAttribute("rapporto", rapporto);
				request.setAttribute("colonne", colonne);
				request.setAttribute("matrix_spess", matrixParsed);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/am_dettaglioProva.jsp");
				dispatcher.forward(request, response);
			}
			
			else if (action.equals("immagine")) {
				
		        AMProvaDTO prova = (AMProvaDTO) request.getSession().getAttribute("prova");

		        if (prova != null && prova.getFilename_img()!=null && !prova.getFilename_img().equals("")) {
		        	
		        	String imagePath =	Costanti.PATH_FOLDER+"\\AM_interventi\\"+prova.getIntervento().getId()+"\\"+prova.getId()+"\\img\\"+prova.getFilename_img();
		         
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
		        } else {
		            response.sendError(HttpServletResponse.SC_NOT_FOUND, "File immagine non trovato");
		        }
		    }
			
			else if(action.equals("genera_certificato")){
				
				ajax = true;
				
				String id_prova = request.getParameter("id_prova");
				String anteprima = request.getParameter("isAnteprima");
				
				AMProvaDTO prova = GestioneAM_BO.getProvaFromID(Integer.parseInt(id_prova), session);
				
				AMRapportoDTO rapporto = GestioneAM_BO.getRapportoFromProva(prova.getId(), session);
				
				boolean isAnteprima = false;
				if(anteprima!=null && anteprima.equals("1")) {
					isAnteprima = true;
				}
				
				CreateCertificatoAM cert = new CreateCertificatoAM(prova, session, rapporto, isAnteprima);
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Certificato salvato con successo!");
				out.print(myObj);
				
			}
			
			
			else if(action.equals("download_certificato")) {
				
				
				String id_prova = request.getParameter("id_prova");
				String anteprima = request.getParameter("isAnteprima");
				
				AMProvaDTO prova = GestioneAM_BO.getProvaFromID(Integer.parseInt(id_prova), session);
				
				String path ="";
				boolean isAnteprima = false;
				if(anteprima!=null && anteprima.equals("1")) {
					isAnteprima = true;
				}
				if(isAnteprima) {
					path = Costanti.PATH_FOLDER+"\\AM_Interventi\\"+prova.getIntervento().getId()+"\\"+prova.getId()+"\\Certificati\\ANTEPRIMA.pdf";
					response.setContentType("application/octet-stream");
					  
					 response.setHeader("Content-Disposition","attachment;filename=ANTEPRIMA.pdf");
				}else {
					path = Costanti.PATH_FOLDER+"\\AM_Interventi\\"+prova.getIntervento().getId()+"\\"+prova.getId()+"\\Certificati\\"+prova.getnRapporto()+".pdf";
					response.setContentType("application/pdf");	
				}
						
				
				
				
				Utility.downloadFile(path, response.getOutputStream());
				
				
				
			}
			
			else if(action.equals("lista_prove")) {
				
				ArrayList<AMProvaDTO> lista_prove = GestioneAM_BO.getListaProve(session);
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
			
				
				if(esito.contains("NON CONFORME")) {
					prova.setEsito("NEGATIVO");
				}else {
					prova.setEsito("POSITIVO");
				}
				prova.setLabel_minimi(label_minimi);
				session.update(prova);
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Salvato con successo!");
				out.print(myObj);
				
			}
			
			else if(action.equals("scarica_template")) {
				
				String path = Costanti.PATH_FOLDER+"\\AM_Interventi\\TemplateAM.xlsx";
					response.setContentType("application/octet-stream");
					  
					 response.setHeader("Content-Disposition","attachment;filename=TemplateAM.xlsx");
				
				
				Utility.downloadFile(path, response.getOutputStream());
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
