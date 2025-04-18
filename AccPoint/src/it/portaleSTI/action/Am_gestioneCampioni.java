package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Method;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
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
import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.AMInterventoDTO;
import it.portaleSTI.DTO.AMOggettoProvaDTO;
import it.portaleSTI.DTO.AMOperatoreDTO;
import it.portaleSTI.DTO.AMTipoCampioneDTO;
import it.portaleSTI.DTO.AMCampioneDTO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.ForPiaPianificazioneDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerInterventoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAM_BO;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneCommesseBO;

/**
 * Servlet implementation class listaCampioni
 */
@WebServlet(name="amGestioneCampioni" , urlPatterns = { "/amGestioneCampioni.do" })

public class Am_gestioneCampioni extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final Logger logger = Logger.getLogger(AMInterventoDTO.class); 
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Am_gestioneCampioni() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
		
		String action = request.getParameter("action");
		
		JsonObject myObj = new JsonObject();
	
        response.setContentType("application/json");
        
        try {
        	
        	if(action.equals("get_tipo")) {
        		
        		String id_tipo = request.getParameter("id_tipo");
        		AMTipoCampioneDTO tipo_campione = GestioneAM_BO.getTipoCampioneFromID(Integer.parseInt(id_tipo), session);
        		
        		Gson g = new GsonBuilder().setDateFormat("MM/dd/yyyy").create(); 	
    		
    			PrintWriter out = response.getWriter();
    			myObj.addProperty("success", true);
    			myObj.add("tipo_campione",g.toJsonTree(tipo_campione));
    			
    		    			
            	out.print(myObj);
            	
        		
        	}
        	else if(action.equals("get_campione")) {
        		
        		String id_campione = request.getParameter("id_campione");
        		AMCampioneDTO campione = GestioneAM_BO.getCampioneFromID(Integer.parseInt(id_campione), session);
        		
        		Gson g = new GsonBuilder().setDateFormat("MM/dd/yyyy").create(); 	
    		
    			PrintWriter out = response.getWriter();
    			myObj.addProperty("success", true);
    			myObj.add("campione",g.toJsonTree(campione));
    			
    		    			
            	out.print(myObj);
        		
        		
        	}
        	else {
    			doPost(request, response);		
    		}
        	session.getTransaction().commit();
        	session.close();
        	
        }
        catch(Exception e)
    	{
			
			
			e.printStackTrace();
			session.getTransaction().rollback();
        	session.close();
			PrintWriter out = response.getWriter();			
	        	
	        request.getSession().setAttribute("exception", e);
	        myObj = STIException.getException(e);
	        out.print(myObj);
        	
    	} 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
//		if(Utility.validateSession(request,response,getServletContext()))return;

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

			ArrayList<AMCampioneDTO> lista_campioni = GestioneAM_BO.getListaCampioni(session);
			ArrayList<AMTipoCampioneDTO> lista_tipi_campione = GestioneAM_BO.getListaTipiCampione(session);		
			
			request.getSession().setAttribute("lista_campioni", lista_campioni);
			request.getSession().setAttribute("lista_tipi_campione", lista_tipi_campione);
			
			
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/am_listaCampioni.jsp");
	     	dispatcher.forward(request,response);
	     
		}
	
				
				
				else if(action.equals("nuovo")) {
				    
				    ajax = true;
				    
				    response.setContentType("application/json");
				    
				    List<FileItem> items = null;
				    if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1) {
				        items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
				    }
				    
				    FileItem fileItem = null;
				    String filename = null;
				    Hashtable<String, String> ret = new Hashtable<String, String>();
				    
				    for (FileItem item : items) {
				        if (!item.isFormField()) {
				            fileItem = item;
				            filename = item.getName();
				        } else {
				            ret.put(item.getFieldName(), new String(item.getString().getBytes("iso-8859-1"), "UTF-8"));
				        }
				    }

				    // Recupero i dati dal form
				    String tipoCampioneId = ret.get("tipoCampione");
				    String codice_interno = ret.get("codiceInterno");
				    String descrizione = ret.get("denominazione");
				    String matricola = ret.get("matricola");
				    String modello = ret.get("modello");
				    String costruttore = ret.get("costruttore");
				    String nCertificato = ret.get("nCertificato");
				    String dataTaratura = ret.get("data_taratura");
				    String frequenza = ret.get("frequenza");
				    String dataScadenzaCertifica = ret.get("data_scadenza_certificato");
				    
				    // Gestione della data
				    DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				    
				    // Creazione dell'oggetto AMCampione
				    AMCampioneDTO campione = new AMCampioneDTO();
				    campione.setDenominazione(descrizione);
				    campione.setCodiceInterno(codice_interno);
				    campione.setMatricola(matricola);
				    campione.setModello(modello);
				    campione.setCostruttore(costruttore);
				    campione.setnCertificato(nCertificato);
				    
				    if (dataTaratura != null && !dataTaratura.equals("")) {
				    campione.setDataTaratura(df.parse(dataTaratura));
				       
				    }
				    if (frequenza != null && !frequenza.equals("")) {
				        campione.setFrequenza(Integer.parseInt(frequenza));
				    }
				    if (dataScadenzaCertifica != null && !dataScadenzaCertifica.equals("")) {
				        
				        campione.setDataScadenzaCertifica(df.parse(dataScadenzaCertifica));
				        
				    }
				    
				    // Recupero il tipo di campione e ottengo la visibilità delle colonne
				    AMTipoCampioneDTO tipoCampione = GestioneAM_BO.getTipoCampioneFromID(Integer.parseInt(tipoCampioneId), session);
				    campione.setTipoCampione(tipoCampione);
				    String[] visibilitaColonne = tipoCampione.getVisibilitaColonne().split(";");
				    
				    // Impostazione dei campi dinamici in base alla visibilità
				    for (String key : visibilitaColonne) {
				        // Recupera il valore del campo dalla richiesta dinamicamente
				        String value = ret.get(key);
				        
				        // Se il valore non è null o vuoto, procediamo con il settaggio
				        if (value != null && !value.isEmpty()) {
				            // Verifica se il campo esiste e setta dinamicamente
				         
				                // Usa la reflection per invocare il metodo setter appropriato per ogni campo dinamico
				                Method setterMethod = AMCampioneDTO.class.getMethod("set" + Utility.capitalize(key), String.class);
				                setterMethod.invoke(campione, value);
				           
				        }
				    }
				    
				    // Salvataggio nel database
				    session.save(campione);
				    
				    // Risposta JSON
				    myObj = new JsonObject();
				    PrintWriter out = response.getWriter();
				    myObj.addProperty("success", true);
				    myObj.addProperty("messaggio", "Campione salvato con successo!");
				    out.print(myObj);
				}

	else if(action.equals("modifica")) {
				    
				    ajax = true;
				    
				    response.setContentType("application/json");
				    
				    List<FileItem> items = null;
				    if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1) {
				        items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
				    }
				    
				    FileItem fileItem = null;
				    String filename = null;
				    Hashtable<String, String> ret = new Hashtable<String, String>();
				    
				    for (FileItem item : items) {
				        if (!item.isFormField()) {
				            fileItem = item;
				            filename = item.getName();
				        } else {
				            ret.put(item.getFieldName(), new String(item.getString().getBytes("iso-8859-1"), "UTF-8"));
				        }
				    }
				    

				    // Recupero i dati dal form
				    String id_campione = ret.get("id_campione");
				    String tipoCampioneId = ret.get("tipoCampione_mod");
				    String codice_interno = ret.get("codiceInterno_mod");
				    String descrizione = ret.get("denominazione_mod");
				    String matricola = ret.get("matricola_mod");
				    String modello = ret.get("modello_mod");
				    String costruttore = ret.get("costruttore_mod");
				    String nCertificato = ret.get("nCertificato_mod");
				    String dataTaratura = ret.get("data_taratura_mod");
				    String frequenza = ret.get("frequenza_mod");
				    String dataScadenzaCertifica = ret.get("data_scadenza_certificato_mod");
				    
				    // Gestione della data
				    DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				    
				    // Creazione dell'oggetto AMCampione
				    AMCampioneDTO campione = GestioneAM_BO.getCampioneFromID(Integer.parseInt(id_campione), session);
				    campione.setDenominazione(descrizione);
				    campione.setCodiceInterno(codice_interno);
				    campione.setMatricola(matricola);
				    campione.setModello(modello);
				    campione.setCostruttore(costruttore);
				    campione.setnCertificato(nCertificato);
				    
				    if (dataTaratura != null && !dataTaratura.equals("")) {
				    campione.setDataTaratura(df.parse(dataTaratura));
				       
				    }
				    if (frequenza != null && !frequenza.equals("")) {
				        campione.setFrequenza(Integer.parseInt(frequenza));
				    }
				    if (dataScadenzaCertifica != null && !dataScadenzaCertifica.equals("")) {
				        
				        campione.setDataScadenzaCertifica(df.parse(dataScadenzaCertifica));
				        
				    }
				    
				    // Recupero il tipo di campione e ottengo la visibilità delle colonne
				    AMTipoCampioneDTO tipoCampione = GestioneAM_BO.getTipoCampioneFromID(Integer.parseInt(tipoCampioneId), session);
				    String[] visibilitaColonne = tipoCampione.getVisibilitaColonne().split(";");
				    campione.setTipoCampione(tipoCampione);
				    // Impostazione dei campi dinamici in base alla visibilità
				    for (String key : visibilitaColonne) {
				        // Recupera il valore del campo dalla richiesta dinamicamente
				        String value = ret.get(key+"_mod");
				        
				        // Se il valore non è null o vuoto, procediamo con il settaggio
				        if (value != null && !value.isEmpty()) {
				            // Verifica se il campo esiste e setta dinamicamente
				         
				                // Usa la reflection per invocare il metodo setter appropriato per ogni campo dinamico
				                Method setterMethod = AMCampioneDTO.class.getMethod("set" + Utility.capitalize(key), String.class);
				                setterMethod.invoke(campione, value);
				           
				        }
				    }
				    
				    // Salvataggio nel database
				    session.update(campione);
				    
				    // Risposta JSON
				    myObj = new JsonObject();
				    PrintWriter out = response.getWriter();
				    myObj.addProperty("success", true);
				    myObj.addProperty("messaggio", "Campione salvato con successo!");
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
