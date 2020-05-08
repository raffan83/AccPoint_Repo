package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneAttivitaCampioneBO;
import it.portaleSTI.bo.GestioneVerStrumentiBO;

/**
 * Servlet implementation class ScadenzarioVerificazione
 */
@WebServlet("/scadenzarioVerificazione.do")
public class ScadenzarioVerificazione extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ScadenzarioVerificazione() {
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
		
		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		boolean ajax = false;
		JsonObject myObj = new JsonObject();
		
		UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
		
		try {
						
			if(action == null) {
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/scadenzarioVerStrumenti.jsp");
			    dispatcher.forward(request,response);// TODO Auto-generated method stub
			    
			    session.close();
			}	
			else if(action.equals("scadenzario")) {
				
				ajax = true;
				
				List<ClienteDTO> listaClienti = (List<ClienteDTO>)request.getSession().getAttribute("lista_clienti");
				if(listaClienti==null) {				
					listaClienti = GestioneAnagraficaRemotaBO.getListaClienti(String.valueOf(utente.getCompany().getId()));							
				}
				
				List<Integer> lista_id_clienti = new ArrayList<Integer>();
				
				for (ClienteDTO clienteDTO : listaClienti) {
					lista_id_clienti.add(clienteDTO.get__id());
				}
				
				HashMap<String,Integer> listaScadenze = GestioneVerStrumentiBO.getListaScadenzeVerificazione(session, lista_id_clienti);
				
				ArrayList<String> lista_strumenti_scadenza = new ArrayList<>();				
			
					 Iterator scadenza = listaScadenze.entrySet().iterator();
			
					    while (scadenza.hasNext()) {
					        Map.Entry pair = (Map.Entry)scadenza.next();
					        lista_strumenti_scadenza.add(pair.getKey() + ";" + pair.getValue());
					        scadenza.remove(); 
					    }

				PrintWriter out = response.getWriter();
				
				 Gson gson = new Gson(); 
			        
			        
			        JsonElement obj_scadenze = gson.toJsonTree(lista_strumenti_scadenza);

			       		       
			        myObj.addProperty("success", true);
			  
			        myObj.add("obj_scadenze", obj_scadenze);
			        
			        out.println(myObj.toString());

			        out.close();
			        
			        session.getTransaction().commit();
		        	session.close();
				
			}
			
			
			
		} catch (Exception e) {
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
