package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.PermessoDTO;
import it.portaleSTI.DTO.RuoloDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestionePermessiBO;
import it.portaleSTI.bo.GestioneRuoloBO;
import it.portaleSTI.bo.GestioneUtenteBO;

/**
 * Servlet implementation class GestioneUtenti
 */
@WebServlet(name = "gestioneRuoli", urlPatterns = { "/gestioneRuoli.do" })
public class GestioneRuoli extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneRuoli() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if(Utility.validateSession(request,response,getServletContext()))return;
		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		PrintWriter out = response.getWriter();
		JsonObject myObj = new JsonObject();
   
        response.setContentType("application/json");
        try{
       	 	
        	String action =  request.getParameter("action");
       	 	
        	if(action !=null )
       	 	{
				
    	 		if(action.equals("nuovo"))
    	 		{
    	 			String sigla = request.getParameter("sigla");
    	 			String descrizione = request.getParameter("descrizione");
    
    	 			
    	 			String permessi = request.getParameter("permessi");
 
    	 			
    	 			RuoloDTO ruolo = new RuoloDTO();
    	 			ruolo.setSigla(sigla);
    	 			ruolo.setDescrizione(descrizione);

    	 			

    	 			if(!permessi.equals("") && permessi != null){
    	 				String[] explode = permessi.split(",");
    	 			
	    	 			Set<PermessoDTO> listPermessi = new HashSet<>();
	    	 			for(int i = 0; i < explode.length; i++){
	    	 				PermessoDTO permesso = GestionePermessiBO.getPermessoById(explode[i], session);

	    	 				listPermessi.add(permesso);
	    	 			}
	    	 			ruolo.setListaPermessi(listPermessi);
    	 			}
    	 			
    	 			
    	 			int success = GestioneRuoloBO.saveRuolo(ruolo, action, session);
    	 			if(success==0)
    				{
    					myObj.addProperty("success", true);
    					myObj.addProperty("messaggio","Salvato con Successo");
    					session.getTransaction().commit();
    					session.close();
    				
    				}
    				if(success==1)
    				{
    					
    					myObj.addProperty("success", false);
    					myObj.addProperty("messaggio","Errore Salvataggio");
    					
    					session.getTransaction().rollback();
    			 		session.close();
    			 		
    				} 
    	 			

    	 			myObj.addProperty("success", true);
	 			 	myObj.addProperty("messaggio", "Ruolo salvato con successo");  
	 			 	
    	 		}else if(action.equals("modifica")){
    	 			
    	 			String id = request.getParameter("id");

    	 			String sigla = request.getParameter("sigla");
    	 			String descrizione = request.getParameter("descrizione");
    	 			
    	 			
    	 			RuoloDTO ruolo = GestioneRuoloBO.getRuoloById(id, session);

    	 			if(sigla != null && !sigla.equals("")){
    	 				ruolo.setSigla(sigla);
    	 			}
    	 			if(descrizione != null && !descrizione.equals("")){
    	 				ruolo.setDescrizione(descrizione);
    	 			}


    	 			int success = GestioneRuoloBO.saveRuolo(ruolo, action, session);
    	 			if(success==0)
    				{
    					myObj.addProperty("success", true);
    					myObj.addProperty("messaggio","Salvato con Successo");
    					session.getTransaction().commit();
    					session.close();
    				
    				}
    				if(success==1)
    				{
    					
    					myObj.addProperty("success", false);
    					myObj.addProperty("messaggio","Errore Salvataggio");
    					
    					session.getTransaction().rollback();
    			 		session.close();
    			 		
    				} 
    	 			
    	 			
    	 			
    	 			
    	 			myObj.addProperty("success", true);
	 			 	myObj.addProperty("messaggio", "Utente modificato con successo");  
    	 		}else if(action.equals("elimina")){
    	 			
    	 			String id = request.getParameter("id");

    	 				
    	 			
    	 			RuoloDTO ruolo = GestioneRuoloBO.getRuoloById(id, session);
    	 			

    	 			/*
    	 			 * TO DO Elimina Ruolo
    	 			 */
    	 			
    	 			
    	 			myObj.addProperty("success", true);
	 			 	myObj.addProperty("messaggio", "Utente eliminato con successo");  
    	 		}
    	 		
    	 	}else{
       	 		
    			myObj.addProperty("success", false);
    			myObj.addProperty("messaggio", "Nessuna action riconosciuta");  
    		}	
        	out.println(myObj.toString());

        }catch(Exception ex){
        	
        	ex.printStackTrace();
        	session.getTransaction().rollback();
        	session.close();
        	request.getSession().setAttribute("exception", ex);
        	myObj.addProperty("success", false);
        	myObj.addProperty("messaggio", STIException.callException(ex).toString());
        	out.println(myObj.toString());
        } 
	}

}
