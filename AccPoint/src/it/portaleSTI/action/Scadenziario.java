package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAttivitaCampioneBO;
import it.portaleSTI.bo.GestioneCampioneBO;

/**
 * Servlet implementation class Scadenziario
 */

@WebServlet(name= "/scadenziario", urlPatterns = { "/scadenziario.do" })
public class Scadenziario extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final Logger logger = Logger.getLogger(Scadenziario.class);
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Scadenziario() {
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
		
		try {	
		String action = request.getParameter("action");
		
		logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+((UtenteDTO)request.getSession().getAttribute("userObj")).getNominativo());
		
		if(action == null) {
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/scadenziario.jsp");
		    dispatcher.forward(request,response);// TODO Auto-generated method stub
		    
		    session.getTransaction().commit();
        	session.close();
		}
		else if(action.equals("campioni")) {
			
			String id_campione = request.getParameter("id_campione");
			String registroEventi = request.getParameter("registro_eventi");
			String scadenzarioGenerale = request.getParameter("scadenzario_lat_generale");
			
			request.getSession().setAttribute("id_campione", id_campione);
			request.getSession().setAttribute("registroEventi", registroEventi);
			request.getSession().setAttribute("scadenzarioGenerale", scadenzarioGenerale);
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/scadenzarioAttivitaCampioni.jsp");
		    dispatcher.forward(request,response);// TODO Auto-generated method stub
		    
		    session.getTransaction().commit();
        	session.close();
		}
		else if(action.equals("scadenzario")) {
			
			
			
			String id_campione = request.getParameter("id_campione");

			JsonObject myObj = new JsonObject();

		
			
				ArrayList<HashMap<String,Integer>> listaScadenze = null;
			if(id_campione!=null) {
				CampioneDTO	campione = GestioneCampioneDAO.getCampioneFromId(id_campione);				
				
				listaScadenze = GestioneAttivitaCampioneBO.getListaAttivitaScadenziarioCampione(campione, session);
			}else {
				listaScadenze = GestioneAttivitaCampioneBO.getListaAttivitaScadenziario(session);
			}
			
			
			ArrayList<String> lista_tarature = new ArrayList<>();
			ArrayList<String> lista_verifiche_intermedie= new ArrayList<>();
			ArrayList<String> lista_manutenzioni = new ArrayList<>();
			
		
				 Iterator id_manutenzione = listaScadenze.get(0).entrySet().iterator();
		
				    while (id_manutenzione.hasNext()) {
				        Map.Entry pair = (Map.Entry)id_manutenzione.next();
				        lista_manutenzioni.add(pair.getKey() + ";" + pair.getValue());
				        id_manutenzione.remove(); 
				    }
				   
				    Iterator it_verifica = listaScadenze.get(1).entrySet().iterator();
					
				    while (it_verifica.hasNext()) {
				        Map.Entry pair = (Map.Entry)it_verifica.next();
				        lista_verifiche_intermedie.add(pair.getKey() + ";" + pair.getValue());
				        it_verifica.remove(); 
				    }
				    Iterator it_taratura = listaScadenze.get(2).entrySet().iterator();
					
				    while (it_taratura.hasNext()) {
				        Map.Entry pair = (Map.Entry)it_taratura.next();
				        lista_tarature.add(pair.getKey() + ";" + pair.getValue());
				        it_taratura.remove(); 
				    }
			
			PrintWriter out = response.getWriter();
			
			 Gson gson = new Gson(); 
		        
//		        JsonElement obj_funzionamento = gson.toJsonTree(lista_funzionamento);
//		        JsonElement obj_integrita = gson.toJsonTree(lista_integrita);
//		        JsonElement obj_interna = gson.toJsonTree(lista_interna);
		        
		        JsonElement obj_manutenzione = gson.toJsonTree(lista_manutenzioni);
		        JsonElement obj_verifica = gson.toJsonTree(lista_verifiche_intermedie);
		        JsonElement obj_taratura = gson.toJsonTree(lista_tarature);
		       		       
		        myObj.addProperty("success", true);
		  
		        myObj.add("obj_manutenzione", obj_manutenzione);
		        myObj.add("obj_verifica", obj_verifica); 
		        myObj.add("obj_taratura", obj_taratura); 
		        
		        out.println(myObj.toString());

		        out.close();
		        
		        session.getTransaction().commit();
	        	session.close();
		        
		        
			
	    
	    
	}
		} catch (Exception e) {

			session.getTransaction().rollback();
        	session.close();
        	JsonObject myObj = new JsonObject();
			PrintWriter out = response.getWriter();
			e.printStackTrace();	        	
	        request.getSession().setAttribute("exception", e);
	        myObj = STIException.getException(e);
	        out.print(myObj);
        	
		}
	}
}
