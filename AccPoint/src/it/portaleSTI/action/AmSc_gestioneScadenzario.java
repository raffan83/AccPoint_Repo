package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.Month;
import java.time.ZoneId;
import java.time.format.TextStyle;
import java.util.AbstractMap;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.catalina.User;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.GestioneUtenteDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.AmScAllegatoDTO;
import it.portaleSTI.DTO.AmScAttivitaDTO;
import it.portaleSTI.DTO.AmScAttrezzaturaDTO;
import it.portaleSTI.DTO.AmScScadenzarioDTO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.OffOffertaFotoDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.CreateCertificatoAM;
import it.portaleSTI.bo.CreateRapportoScadenzarioAM;
import it.portaleSTI.bo.GestioneAM_ScadenzarioBO;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneFormazioneBO;

/**
 * Servlet implementation class AmSc_gestioneScadenzario
 */
@WebServlet("/amScGestioneScadenzario.do")
public class AmSc_gestioneScadenzario extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AmSc_gestioneScadenzario() {
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

    		Session session = SessionFacotryDAO.get().openSession();
    		session.beginTransaction();
    		
    		UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
    		
    		String action = request.getParameter("action");
    		
    		JsonObject myObj = new JsonObject();
    		boolean ajax = false;
            response.setContentType("application/json");
            
    		
    			 
    		try {
    			
    			if(action == null) {
    				
    				
    				List<ClienteDTO> listaClienti = (List<ClienteDTO>)request.getSession().getAttribute("lista_clienti");
    				List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
    				if(listaSedi== null) {
    					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
    				}
    				if(utente.checkRuolo("S2")) {
    					ClienteDTO cliente = GestioneAnagraficaRemotaBO.getClienteById(utente.getIdCliente()+"");
    					
    					listaClienti = new ArrayList<ClienteDTO>();
    					listaClienti.add(cliente);
    				}else {
    					if(listaClienti==null) {
        					listaClienti = GestioneAnagraficaRemotaBO.getListaClienti(String.valueOf(utente.getCompany().getId()));							
        				}
        				
        				
        				
    				}
    				
    				
    				
    									
    				request.getSession().setAttribute("lista_clienti", listaClienti);				
    				request.getSession().setAttribute("lista_sedi", listaSedi);

    				Gson gson = new GsonBuilder().create();
    				JsonArray listaCl = gson.toJsonTree(listaClienti).getAsJsonArray();
    				
    				request.getSession().setAttribute("listaCl", listaCl.toString().replace("\'", ""));
    							
    				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/am_sc_scadenzario.jsp");
    		     	dispatcher.forward(request,response);
    			}

    			else if(action.equals("lista")) {
    				
    				String idCliente = request.getParameter("id_cliente");
    				String idSede = request.getParameter("id_sede");
    				String anno = request.getParameter("anno");
    				
    				if(anno == null) {
    					anno = ""+Calendar.getInstance().get(Calendar.YEAR);
    				}
    				
    				
    				
    				ArrayList<AmScAttrezzaturaDTO> lista_attrezzature = GestioneAM_ScadenzarioBO.getListaAttrezzature(Integer.parseInt(idCliente), Integer.parseInt(idSede.split("_")[0]),session);
    				ArrayList<AmScScadenzarioDTO> lista_scadenze = GestioneAM_ScadenzarioBO.getListaScadenze(Integer.parseInt(idCliente), Integer.parseInt(idSede.split("_")[0]),Integer.parseInt(anno), session);
    				ArrayList<AmScAttivitaDTO> lista_attivita = GestioneAM_ScadenzarioBO.getListaAttivita(session);
    				
    				Map<Integer, Map<String, Integer>> conteggiPerAttrezzatura = new HashMap<>();

    				for (AmScScadenzarioDTO scadenza : lista_scadenze) {
    				    AmScAttrezzaturaDTO attrezzatura = scadenza.getAttrezzatura();
    				    Integer idAttrezzatura = attrezzatura.getId();
    				    java.sql.Date data =  new java.sql.Date(scadenza.getDataProssimaAttivita().getTime());

    				    if (data != null) {
    				        LocalDate localDate = data.toLocalDate(); 
    				        String mese = localDate.getMonth().getDisplayName(TextStyle.FULL, Locale.ITALIAN).toUpperCase();

    				        // Recupera o crea la mappa dei conteggi per questa attrezzatura
    				        Map<String, Integer> mappaMesi = conteggiPerAttrezzatura.computeIfAbsent(idAttrezzatura, k -> new HashMap<>());

    				        // Incrementa il contatore per il mese
    				        mappaMesi.put(mese, mappaMesi.getOrDefault(mese, 0) + 1);
    				    }
    				}

    				  
    				  Set<Integer> attrezzatureAggiornate = new HashSet<>();

    				    for (AmScScadenzarioDTO scadenza : lista_scadenze) {
    				        AmScAttrezzaturaDTO attrezzatura = scadenza.getAttrezzatura();
    				        Integer idAttrezzatura = attrezzatura.getId();

    				        if (!attrezzatureAggiornate.contains(idAttrezzatura)) {
    				            Map<String, Integer> scadenzeMese = conteggiPerAttrezzatura.get(idAttrezzatura);
    				            if (scadenzeMese != null) {
    				                attrezzatura.setMapScadenze(new HashMap<>(scadenzeMese));
    				            }
    				            attrezzatureAggiornate.add(idAttrezzatura); // per non riscrivere più volte
    				        }
    				    }
    				
    				request.getSession().setAttribute("lista_attrezzature", lista_attrezzature);
    				request.getSession().setAttribute("lista_attivita", lista_attivita);
    				request.getSession().setAttribute("anno", anno);
    				
    				
    				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/am_sc_scadenzario_cliente_sede.jsp");
    		     	dispatcher.forward(request,response);
    			}else if(action.equals("lista_scadenze_mese")) {
    				
    				String id_attrezzatura = request.getParameter("id_attrezzatura");
    				String mese = request.getParameter("mese");
    				String anno = request.getParameter("anno");
    				
    				if(anno == null) {
    					anno = ""+Calendar.getInstance().get(Calendar.YEAR);
    				}
    				
    		
    				
    				ArrayList<AmScScadenzarioDTO> scadenze = GestioneAM_ScadenzarioBO.getListaScadenzeAttrezzatura(Integer.parseInt(id_attrezzatura), Integer.parseInt(mese), Integer.parseInt(anno),false, session);
    				
    				request.getSession().setAttribute("scadenze", scadenze);
    				request.getSession().setAttribute("mese", Month.of(Integer.parseInt(mese)+1).getDisplayName(TextStyle.FULL, new Locale("it")).toUpperCase());
    				request.getSession().setAttribute("anno", anno);
    				
    				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/am_sc_lista_scadenze_attrezzatura.jsp");
    		     	dispatcher.forward(request,response);
    			}
    			else if(action.equals("nuova_scadenza")) {
    				
    				ajax = true;
    				
    				response.setContentType("application/json");
    				List<FileItem> items = null;
    		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

    		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
    		        	}
    		        
    		       
    				FileItem fileItem = null;
    			
    		        Hashtable<String,String> ret = new Hashtable<String,String>();
    		        
    		        ArrayList<FileItem> listaItems = new ArrayList<FileItem> ();		       
    		        ArrayList<String> filenames = new ArrayList<String> ();
    		   
    		        Map<String, AbstractMap.SimpleEntry<FileItem, String>> map = new HashMap<>();
    		        for (FileItem item : items) {
    	            	 if (!item.isFormField()) {
    	            		
    	            		 if(item.getFieldName().startsWith("allegati_attivita")) {
    	            			 String id = item.getFieldName().split("_")[2];
    	            		        map.put(id, new AbstractMap.SimpleEntry<>(item, item.getName()));
    	            			 
    	            		 }
    	                     	                     
    	            	 }else
    	            	 {
    	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
    	            	 }
    	            	
    	            }
    		      
    		 

    				String id_attrezzatura = ret.get("attrezzatura");
    				String id_attivita = ret.get("id_attivita");
    				
    				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
    				for (String id : id_attivita.split(";")) {
    					String[] values = id.split(",");
    					
    					AmScScadenzarioDTO s = new AmScScadenzarioDTO();
        				AmScAttrezzaturaDTO attrezzatura = (AmScAttrezzaturaDTO) session.get(AmScAttrezzaturaDTO.class, Integer.parseInt(id_attrezzatura));        			
        				s.setAttrezzatura(attrezzatura);
        				AmScAttivitaDTO attivita = (AmScAttivitaDTO) session.get(AmScAttivitaDTO.class, Integer.parseInt(values[0]));
        				if(attivita == null) {
        					attivita = new AmScAttivitaDTO();
        					attivita.setId(Integer.parseInt(values[0]));
        					attivita.setDescrizione(values[values.length-1]);
        					session.save(attivita);
        				}
        				s.setAttivita(attivita);
        				
        				s.setDataAttivita(df.parse(values[1]));
        				
        				s.setEsito(values[2]);
        				if(values.length>3 ) {
	        				if(values[3]!= null && !values[3].equals(""))	{
	        					s.setFrequenza(Integer.parseInt(values[3]));
	        					
	        				}
        				
        				
	        				if(values.length>4 ) {
		        				if(values[4]!= null && !values[4].equals(""))	{
		        					s.setDataProssimaAttivita(df.parse(values[4]));
		        					s.setTipo(0);
		        				}else {
		        					s.setTipo(1);
		        				}
	        				}
        				}
        				if(values.length>5) {
        					s.setNote(values[5]);
        				}
        				s.setUtente(utente);
        				session.save(s);
        				
        				AbstractMap.SimpleEntry<FileItem, String> entry = map.get(attivita.getId()+"");
        				
        					
        				if (entry != null) {
        				    FileItem item = entry.getKey();      // il FileItem
        				    String filename = entry.getValue();  // il nome del file
        				    
        				    if(filename!=null && !filename.equals("")) {
        				    	 Utility.saveFile(item, Costanti.PATH_FOLDER+"\\AMGestioneSistemi\\"+s.getAttrezzatura().getId()+"\\AllegatiAttivita\\"+s.getId()+"\\"+s.getAttivita().getId()+"\\", filename);
             				    
             				    AmScAllegatoDTO allegato = new AmScAllegatoDTO();
             				    allegato.setNome_file(filename);
             				    allegato.setId_attivita(s.getId());
             				    session.save(allegato);
        				    }
        				   
        				    
        				}
        					
        					        				
					}
    				
    				
    				myObj = new JsonObject();
    				PrintWriter  out = response.getWriter();
    				myObj.addProperty("success", true);
    				myObj.addProperty("messaggio", "Scadenza salvata con successo!");
    				out.print(myObj);

    				
    			}
    			else if(action.equals("nuova_attrezzatura")) {
    				
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

    				String descrizione_attrezzatura = ret.get("descrizione_attrezzatura");
    				String cliente = ret.get("cliente_attrezzatura");
    				String sede = ret.get("sede_attrezzatura");

        				AmScAttrezzaturaDTO attrezzatura = new AmScAttrezzaturaDTO();
        				attrezzatura.setDescrizione(descrizione_attrezzatura);
        				attrezzatura.setIdCliente(Integer.parseInt(cliente));
        				attrezzatura.setIdSede(Integer.parseInt(sede));
        				
        				session.save(attrezzatura);
    				
    				myObj = new JsonObject();
    				PrintWriter  out = response.getWriter();
    				myObj.addProperty("success", true);
    				myObj.addProperty("messaggio", "Attrezzatura salvata con successo!");
    				out.print(myObj);
    			}
    			else if(action.equals("lista_allegati")) {
    				
    				String id_scadenza = request.getParameter("id");
    				
    				ArrayList<AmScAllegatoDTO> lista_allegati = GestioneAM_ScadenzarioBO.getListaAllegatiScadenza(Integer.parseInt(id_scadenza), session);
    				Gson g = new Gson();
    				myObj = new JsonObject();
    				PrintWriter  out = response.getWriter();
    				myObj.addProperty("success", true);
    				myObj.add("lista_allegati", g.toJsonTree(lista_allegati));
    				out.print(myObj);
    			}
    			else if(action.equals("elimina_allegato")) {
    				
    				String id_allegato = request.getParameter("id_allegato");
    				
    				AmScAllegatoDTO allegato = (AmScAllegatoDTO) session.get(AmScAllegatoDTO.class, Integer.parseInt(id_allegato));
    				allegato.setDisabilitato(1);
    				session.update(allegato);
    				
    				myObj = new JsonObject();
    				PrintWriter  out = response.getWriter();
    				myObj.addProperty("success", true);
    				myObj.addProperty("messaggio", "Eliminato con successo!");
    				out.print(myObj);
    			}
    			
    			else if(action.equals("download_allegato")) {
    				
    				String id_allegato = request.getParameter("id_allegato");
    				
    				AmScAllegatoDTO allegato = (AmScAllegatoDTO) session.get(AmScAllegatoDTO.class, Integer.parseInt(id_allegato));
    				AmScScadenzarioDTO scadenza = (AmScScadenzarioDTO) session.get(AmScScadenzarioDTO.class, allegato.getId_attivita());
    				
    				response.setContentType("application/octet-stream");
    				
    				String path = Costanti.PATH_FOLDER+"\\AMGestioneSistemi\\"+scadenza.getAttrezzatura().getId()+"\\AllegatiAttivita\\"+scadenza.getId()+"\\"+scadenza.getAttivita().getId()+"\\"+allegato.getNome_file();
    				
    					response.setHeader("Content-Disposition","attachment;filename="+ allegato.getNome_file());
    					Utility.downloadFile(path, response.getOutputStream());
    			
    				
    			}
    			else if(action.equals("lista_attivita")) {
    				
    				String dateFrom = request.getParameter("dateFrom");
					String dateTo = request.getParameter("dateTo");
					String tipo_filtro = request.getParameter("tipo_filtro");
					String id_attrezzatura = request.getParameter("id_attrezzatura");
					
					if(tipo_filtro.equals("data")) {
						if(dateFrom == null && dateTo == null) {
							DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
							
							Date today = new Date();
							
							Calendar cal = Calendar.getInstance();
							cal.setTime(today);
							
							dateTo = df.format(cal.getTime());
							
							cal.add(Calendar.DATE, -90);
							Date startDate = cal.getTime();
							
							
							dateFrom = df.format(startDate);
							
							
						}
					}
					int id_cliente = 0;
					int id_sede = 0;
					
					if(utente.checkRuolo("S2")) {
						id_cliente = utente.getIdCliente();
						id_sede = utente.getIdSede();
					}
					
					ArrayList<AmScScadenzarioDTO>lista_attivita = null;
					ArrayList<AmScAttrezzaturaDTO> lista_attrezzatura = GestioneAM_ScadenzarioBO.getListaAttrezzature(id_cliente, id_sede, session);
					
					if(tipo_filtro.equals("data")) {
						lista_attivita = GestioneAM_ScadenzarioBO.getListaAttivitaDate(dateFrom, dateTo,id_cliente,id_sede, session);
					}else {
						
						lista_attivita = GestioneAM_ScadenzarioBO.getListaScadenzeAttrezzatura(Integer.parseInt(id_attrezzatura), 0, 0, false,session);
					
					}
					
					request.getSession().setAttribute("dateFrom", dateFrom); 
					request.getSession().setAttribute("dateTo", dateTo); 
					request.getSession().setAttribute("id_attrezzatura", id_attrezzatura); 
					request.getSession().setAttribute("tipo_filtro", tipo_filtro); 
					request.getSession().setAttribute("lista_attivita", lista_attivita);    
					request.getSession().setAttribute("lista_attrezzatura", lista_attrezzatura); 
    				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/am_sc_lista_attivita.jsp");
    		     	dispatcher.forward(request,response);
    				
    			}
    			else if(action.equals("crea_report")) {
    				
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

    				String id_attrezzatura = ret.get("attrezzatura_report");
    				String anno = ret.get("anno_report");

        			ArrayList<AmScScadenzarioDTO> lista_scadenze = GestioneAM_ScadenzarioBO.getListaScadenzeAttrezzatura(Integer.parseInt(id_attrezzatura), 0, Integer.parseInt(anno), true, session);
    				
        			CreateRapportoScadenzarioAM cert = new CreateRapportoScadenzarioAM(lista_scadenze, session);
        			
    				myObj = new JsonObject();
    				PrintWriter  out = response.getWriter();
    				myObj.addProperty("success", true);
    			
    				out.print(myObj);
    				
    				
    			}else if(action.equals("download_report")) {
    				
    				String id_attrezzatura = request.getParameter("id_attrezzatura");
    			
    			
    				response.setContentType("application/pdf");
    				
    				String path = Costanti.PATH_FOLDER+"\\AMGestioneSistemi\\"+id_attrezzatura+"\\Report\\Report_"+id_attrezzatura+".pdf";
    				
    					response.setHeader("Content-Disposition","inline;filename= Report_"+id_attrezzatura+".pdf");
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
