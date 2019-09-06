package it.portaleSTI.action;

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
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.ComuneDTO;
import it.portaleSTI.DTO.ProvinciaDTO;
import it.portaleSTI.DTO.RilMisuraRilievoDTO;
import it.portaleSTI.DTO.RilStatoRilievoDTO;
import it.portaleSTI.DTO.RilTipoRilievoDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerInterventoDTO;
import it.portaleSTI.DTO.VerInterventoStrumentiDTO;
import it.portaleSTI.DTO.VerMisuraDTO;
import it.portaleSTI.DTO.VerStrumentoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneCommesseBO;
import it.portaleSTI.bo.GestioneRilieviBO;
import it.portaleSTI.bo.GestioneUtenteBO;
import it.portaleSTI.bo.GestioneVerInterventoBO;
import it.portaleSTI.bo.GestioneVerStrumentiBO;

/**
 * Servlet implementation class GestioneInterventoVerStrumento
 */
@WebServlet("/gestioneVerIntervento.do")
public class GestioneVerIntervento extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneVerIntervento() {
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
			
			if(action.equals("lista")) {
				
				if(request.getSession().getAttribute("listaClientiAll")==null) 
				{
					request.getSession().setAttribute("listaClientiAll",GestioneAnagraficaRemotaBO.getListaClientiAll());
				}	
				
				if(request.getSession().getAttribute("listaSediAll")==null) 
				{				
						request.getSession().setAttribute("listaSediAll",GestioneAnagraficaRemotaBO.getListaSediAll());				
				}			
		
				List<ClienteDTO> listaClienti = (List<ClienteDTO>)request.getSession().getAttribute("lista_clienti");
				if(listaClienti==null) {
					listaClienti = GestioneAnagraficaRemotaBO.getListaClienti(String.valueOf(utente.getCompany().getId()));							
				}
				
				List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				if(listaSedi== null) {
					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
				}
				
				
				ArrayList<VerInterventoDTO> lista_interventi = GestioneVerInterventoBO.getListaVerInterventi(session);
				ArrayList<CommessaDTO> lista_commesse = GestioneCommesseBO.getListaCommesse(utente.getCompany(), "", utente,0, true);
				ArrayList<UtenteDTO> lista_tecnici = GestioneUtenteBO.getUtentiFromCompany(utente.getCompany().getId(), session);
				ArrayList<ComuneDTO> lista_comuni = GestioneAnagraficaRemotaBO.getListaComuni(session);
								
				request.getSession().setAttribute("lista_interventi", lista_interventi);
				request.getSession().setAttribute("lista_commesse", lista_commesse);
				request.getSession().setAttribute("lista_tecnici", lista_tecnici);
				request.getSession().setAttribute("lista_clienti", listaClienti);				
				request.getSession().setAttribute("lista_sedi", listaSedi);
				request.getSession().setAttribute("lista_comuni", lista_comuni);
				
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaVerInterventi.jsp");
		  	    dispatcher.forward(request,response);	
				
			}
			else if(action.equals("nuovo")) {
				
				ajax=true;
				PrintWriter out = response.getWriter();
				List<FileItem> items = null;
	            if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

	            		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
	            	}
				
        		
    	 		FileItem fileItem = null;
				
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
    	            	 if (!item.isFormField()) {       		
    	                     fileItem = item;                     
    	            	 }else
    	            	 {
    	                    ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));

    	            	 }
	            }
				
				String cliente = ret.get("cliente");
				String sede = ret.get("sede");
				String commessa = ret.get("commessa");				
				String tecnico_verificatore = ret.get("tecnico_verificatore");
				//String tecnico_riparatore = ret.get("tecnico_riparatore");
				String data_prevista = ret.get("data_prevista");
				String luogo = ret.get("luogo");
					
				ClienteDTO cl = null;
				List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				SedeDTO sd = null;
				if(!sede.equals("0")) {
					cl = GestioneAnagraficaRemotaBO.getClienteFromSede(cliente, sede.split("_")[0]);
					sd = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, Integer.parseInt(sede.split("_")[0]), Integer.parseInt(cliente));
				}else {
					cl = GestioneAnagraficaRemotaBO.getClienteById(cliente);
				}
				VerInterventoDTO intervento = new VerInterventoDTO();
				
				intervento.setId_cliente(Integer.parseInt(cliente));
				intervento.setId_sede(Integer.parseInt(sede.split("_")[0]));
				String provincia = GestioneAnagraficaRemotaBO.getProvinciaFromSigla(cl.getProvincia(), session);
				if(provincia!=null) {
					intervento.setProvincia(provincia.toUpperCase());	
				}
				intervento.setNome_cliente(cl.getNome());
				if(!sede.equals("0")) {
					intervento.setNome_sede(sd.getDescrizione() + " - "+sd.getIndirizzo());
				}
				intervento.setCommessa(commessa.split("\\*")[0]);
				intervento.setData_creazione(new Date());
				SimpleDateFormat sdf = new SimpleDateFormat("ddMMYYYYhhmmss");

				String timeStamp=sdf.format(new Date());
				
				intervento.setId_company(utente.getCompany().getId());
				intervento.setNome_pack("VER"+utente.getCompany().getId()+""+timeStamp);
				
				sdf = new SimpleDateFormat("dd/MM/yyyy");
				intervento.setData_prevista(sdf.parse(data_prevista));
//				if(tecnico_riparatore!=null && !tecnico_riparatore.equals("")) {
//					intervento.setUser_riparatore(GestioneUtenteBO.getUtenteById(tecnico_riparatore, session));	
//				}				
				intervento.setIn_sede_cliente(Integer.parseInt(luogo));
				intervento.setUser_creation(utente);
				intervento.setUser_verificazione(GestioneUtenteBO.getUtenteById(tecnico_verificatore, session));
				
				ArrayList<VerStrumentoDTO> lista_strumenti = GestioneVerStrumentiBO.getStrumentiClienteSede(Integer.parseInt(cliente), Integer.parseInt(sede.split("_")[0]), session);
				int strumenti_gen = 0;
				
				if(lista_strumenti!=null) {
					strumenti_gen = lista_strumenti.size();
				}				
				
				intervento.setnStrumentiGenerati(strumenti_gen);
				session.save(intervento);
				
				session.getTransaction().commit();
				
				session.close();
				myObj.addProperty("success", true);				
				myObj.addProperty("messaggio", "Intervento inserito con successo!");
				out.print(myObj);
				
			}
			else if(action.equals("modifica")) {
				
				ajax=true;
				PrintWriter out = response.getWriter();
				List<FileItem> items = null;
	            if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

	            		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
	            	}
				
        		
    	 		FileItem fileItem = null;
				
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
    	            	 if (!item.isFormField()) {       		
    	                     fileItem = item;                     
    	            	 }else
    	            	 {
    	                    ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));

    	            	 }
	            }
				
		        String id_intervento = ret.get("id_intervento");
				String cliente = ret.get("cliente_mod");
				String sede = ret.get("sede_mod");
				String commessa = ret.get("commessa_mod");				
				String tecnico = ret.get("tecnico_verificatore_mod");
				//String tecnico_riparatore = ret.get("tecnico_riparatore_mod");
				String data_prevista = ret.get("data_prevista_mod");
				String luogo = ret.get("luogo_mod");
					
				ClienteDTO cl = null; 
				
				List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				SedeDTO sd = null;
				if(!sede.equals("0")) {
					cl = GestioneAnagraficaRemotaBO.getClienteFromSede(cliente, sede.split("_")[0]);
					sd = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, Integer.parseInt(sede.split("_")[0]), Integer.parseInt(cliente));
				}else {
					cl = GestioneAnagraficaRemotaBO.getClienteById(cliente);
				}
				
				VerInterventoDTO intervento = GestioneVerInterventoBO.getInterventoFromId(Integer.parseInt(id_intervento), session);
				
				intervento.setId_cliente(Integer.parseInt(cliente));
				intervento.setId_sede(Integer.parseInt(sede.split("_")[0]));
				String provincia = GestioneAnagraficaRemotaBO.getProvinciaFromSigla(cl.getProvincia(), session);
				if(provincia!=null) {
					intervento.setProvincia(provincia.toUpperCase());	
				}
				intervento.setNome_cliente(cl.getNome());
				if(!sede.equals("0")) {
					intervento.setNome_sede(sd.getDescrizione() + " - "+sd.getIndirizzo());
				}
				if(commessa!=null && !commessa.equals("")) {
					intervento.setCommessa(commessa.split("\\*")[0]);	
				}
				
				intervento.setData_creazione(new Date());
				SimpleDateFormat sdf = new SimpleDateFormat("ddMMYYYYhhmmss");

				String timeStamp=sdf.format(new Date());
				
				intervento.setId_company(utente.getCompany().getId());
				intervento.setNome_pack("VER"+utente.getCompany().getId()+""+timeStamp);
				
				sdf = new SimpleDateFormat("dd/MM/yyyy");
				intervento.setData_prevista(sdf.parse(data_prevista));
//				if(tecnico_riparatore!=null && !tecnico_riparatore.equals("") && !tecnico_riparatore.equals("0")) {
//					intervento.setUser_riparatore(GestioneUtenteBO.getUtenteById(tecnico_riparatore, session));	
//				}else {
//					intervento.setUser_riparatore(null);
//				}
				
				intervento.setIn_sede_cliente(Integer.parseInt(luogo));
				intervento.setUser_creation(utente);
				intervento.setUser_verificazione(GestioneUtenteBO.getUtenteById(tecnico, session));
				
				session.update(intervento);
				
				session.getTransaction().commit();
				
				session.close();
				myObj.addProperty("success", true);				
				myObj.addProperty("messaggio", "Intervento modificato con successo!");
				out.print(myObj);
			}
			else if(action.equals("dettaglio")) {
				
				String id_intervento = request.getParameter("id_intervento");
				
				id_intervento = Utility.decryptData(id_intervento);
				VerInterventoDTO interventover = GestioneVerInterventoBO.getInterventoFromId(Integer.parseInt(id_intervento), session);				
				
				ArrayList<VerMisuraDTO> lista_misure = GestioneVerInterventoBO.getListaMisureFromIntervento(Integer.parseInt(id_intervento), session);
				ArrayList<VerInterventoStrumentiDTO> lista_strumenti_intervento = GestioneVerStrumentiBO.getListaStrumentiIntervento(Integer.parseInt(id_intervento), session);
				
				request.getSession().setAttribute("interventover", interventover);
				request.getSession().setAttribute("lista_misure", lista_misure);
				request.getSession().setAttribute("lista_strumenti_intervento", lista_strumenti_intervento);
				session.close();
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioVerIntervento.jsp");
		  	    dispatcher.forward(request,response);
			}
			
		}catch (Exception e) {
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
