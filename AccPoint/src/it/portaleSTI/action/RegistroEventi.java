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

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.AttivitaManutenzioneDTO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CertificatoCampioneDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.TipoManutenzioneDTO;
import it.portaleSTI.DTO.PrenotazioneDTO;
import it.portaleSTI.DTO.RegistroEventiDTO;
import it.portaleSTI.DTO.TipoAttivitaManutenzioneDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneCampioneBO;
import it.portaleSTI.bo.GestionePrenotazioniBO;

/**
 * Servlet implementation class RegistroEventi
 */
@WebServlet("/registroEventi.do")
public class RegistroEventi extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegistroEventi() {
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
		
		String action = request.getParameter("action");
		Session session=SessionFacotryDAO.get().openSession();
		
		session.beginTransaction();
		try{
			if(action==null || action.equals("")) {
				
			String idC = request.getParameter("idCamp");
			
			ArrayList<RegistroEventiDTO> lista_eventi = GestioneCampioneBO.getListaRegistroEventi(idC, session);
			ArrayList<TipoManutenzioneDTO> lista_tipo_manutenzione = GestioneCampioneBO.getListaTipoManutenzione(session);
			ArrayList<TipoAttivitaManutenzioneDTO> lista_tipo_attivita_manutenzione = GestioneCampioneBO.getListaTipoAttivitaManutenzione(session);
			
			request.getSession().setAttribute("lista_eventi", lista_eventi);
			request.getSession().setAttribute("lista_tipo_manutenzione", lista_tipo_manutenzione);
			request.getSession().setAttribute("lista_tipo_attivita_manutenzione", lista_tipo_attivita_manutenzione);
			
			
				 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/registroEventi.jsp");
			     dispatcher.forward(request,response);
			} 

			else if(action!=null && action.equals("manutenzione")) {
				 response.setContentType("application/json");
				 
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
		
				String index = request.getParameter("index");
				String idC = request.getParameter("idCamp");
				String tipo_manutenzione = ret.get("select_tipo_man");
				String data_manutenzione = ret.get("data_manutenzione");
				ArrayList<String> lista_attivita = new ArrayList<String>();
				ArrayList<String> lista_esiti = new ArrayList<String>();
				for(int i=0; i<Integer.parseInt(index);i++) {					
					String attivita = ret.get("descrizione_attivita_"+(i+1));
					String esito = ret.get("select_esito_"+(i+1));
					if(!attivita.equals("")) {
					lista_attivita.add(attivita);
					lista_esiti.add(esito);
					}
				}
				
				
				CampioneDTO campione = GestioneCampioneDAO.getCampioneFromId(idC);
				RegistroEventiDTO evento = new RegistroEventiDTO();
				DateFormat format = new SimpleDateFormat("dd/MM/yyyy");
				Date date = format.parse(data_manutenzione);
				
				evento.setData_evento(date);
				evento.setTipo_manutenzione(new TipoManutenzioneDTO(Integer.parseInt(tipo_manutenzione)));
				
				evento.setCampione(campione);
				
				GestioneCampioneDAO.saveEventoRegistro(evento, session);
				for(int i = 0; i<lista_attivita.size();i++) {
				AttivitaManutenzioneDTO attivita = new AttivitaManutenzioneDTO();
				attivita.setTipo_attivita(new TipoAttivitaManutenzioneDTO(Integer.parseInt(lista_attivita.get(i))));
				attivita.setEvento(evento);
				attivita.setEsito(lista_esiti.get(i));
				GestioneCampioneBO.saveAttivitaManutenzione(attivita, session);
			
				}
				session.getTransaction().commit();
				session.close();
				
				JsonObject myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Manutenzione salvata con successo!");
				out.print(myObj);
			}
			
			else if(action!=null && action.equals("lista_attivita")) {
				String id_evento = request.getParameter("id_evento");
				
				ArrayList<AttivitaManutenzioneDTO> lista_attivita_manutenzione = GestioneCampioneBO.getListaAttivitaManutenzione(Integer.parseInt(id_evento), session);
				
				request.getSession().setAttribute("lista_attivita_manutenzione", lista_attivita_manutenzione);
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaAttivitaManutenzione.jsp");
			     dispatcher.forward(request,response);
				
			}
			
		}catch(Exception ex)
		{
			
			 ex.printStackTrace();
		     request.setAttribute("error",STIException.callException(ex));
			 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
		     dispatcher.forward(request,response);
			
		} 
		
		
		
	}
	
	static CampioneDTO getCampione(ArrayList<CampioneDTO> listaCampioni,String idC) {
		CampioneDTO campione =null;
		
		try
		{		
		for (int i = 0; i < listaCampioni.size(); i++) {
			
			if(listaCampioni.get(i).getId()==Integer.parseInt(idC))
			{
				return listaCampioni.get(i);
			}
		}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			campione=null;
			throw ex;
		}
		return campione;
	}
	
	

}
