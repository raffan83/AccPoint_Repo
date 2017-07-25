package it.portaleSTI.action;

import it.portaleSTI.DAO.GestioneAccessoDAO;
import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.GestioneTLDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.PermessoDTO;
import it.portaleSTI.DTO.RuoloDTO;
import it.portaleSTI.DTO.TipoCampioneDTO;
import it.portaleSTI.DTO.TipoGrandezzaDTO;
import it.portaleSTI.DTO.UnitaMisuraDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestionePermessiBO;
import it.portaleSTI.bo.GestioneRuoloBO;
import it.portaleSTI.bo.GestioneUtenteBO;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

/**
 * Servlet implementation class listaCampioni
 */
@WebServlet(name="gestioneAssociazioniArticoliAjax" , urlPatterns = { "/gestioneAssociazioniArticoliAjax.do" })

public class GestioneAssociazioniArticoliAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneAssociazioniArticoliAjax() {
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

		
		Session session =SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		response.setContentType("text/html");
		JsonObject myObj = new JsonObject();
		PrintWriter out = response.getWriter();
		
		try 
		{
			String action = request.getParameter("action");
			if(action != null && !action.equals("")){
				
				if(action.equals("associaRuolo")){
					String idRuolo = request.getParameter("idRuolo");
					String idUtente = request.getParameter("idUtente");
    	 			
					UtenteDTO utente = GestioneUtenteBO.getUtenteById(idUtente, session);
					RuoloDTO ruolo = GestioneRuoloBO.getRuoloById(idRuolo, session);
					
					utente.getListaRuoli().add(ruolo);
					int success = GestioneUtenteBO.saveUtente(utente, "modifica", session);
					
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
					myObj.addProperty("message", "OK");
			        out.println(myObj.toString());
				}
				
				if(action.equals("disassociaRuolo")){
					String idRuolo = request.getParameter("idRuolo");
					String idUtente = request.getParameter("idUtente");
					
					UtenteDTO utente = GestioneUtenteBO.getUtenteById(idUtente, session);
					RuoloDTO ruolo = GestioneRuoloBO.getRuoloById(idRuolo, session);
					
					utente.getListaRuoli().remove(ruolo);
					int success = GestioneUtenteBO.saveUtente(utente, "modifica", session);
					
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
					myObj.addProperty("message", "OK");
			        out.println(myObj.toString());
				}
				
				if(action.equals("associaUtente")){
					String idRuolo = request.getParameter("idRuolo");
					String idUtente = request.getParameter("idUtente");
					
					UtenteDTO utente = GestioneUtenteBO.getUtenteById(idUtente, session);
					RuoloDTO ruolo = GestioneRuoloBO.getRuoloById(idRuolo, session);
					
					utente.getListaRuoli().add(ruolo);
					int success = GestioneUtenteBO.saveUtente(utente, "modifica", session);
					
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
					myObj.addProperty("message", "OK");
			        out.println(myObj.toString());
				}
				
				if(action.equals("disassociaUtente")){
					String idRuolo = request.getParameter("idRuolo");
					String idUtente = request.getParameter("idUtente");
					
					UtenteDTO utente = GestioneUtenteBO.getUtenteById(idUtente, session);
					RuoloDTO ruolo = GestioneRuoloBO.getRuoloById(idRuolo, session);
					
					utente.getListaRuoli().remove(ruolo);
					int success = GestioneUtenteBO.saveUtente(utente, "modifica", session);
					
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
					myObj.addProperty("message", "OK");
			        out.println(myObj.toString());
				}
				
				if(action.equals("associaPermesso")){
					String idRuolo = request.getParameter("idRuolo");
					String idPermesso = request.getParameter("idPermesso");
					
					PermessoDTO permesso = GestionePermessiBO.getPermessoById(idPermesso, session);
					RuoloDTO ruolo = GestioneRuoloBO.getRuoloById(idRuolo, session);
					
					ruolo.getListaPermessi().add(permesso);
					int success = GestioneRuoloBO.saveRuolo(ruolo, "modifica", session);
					
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
					myObj.addProperty("message", "OK");
			        out.println(myObj.toString());
				}
				
				if(action.equals("disassociaPermesso")){
					String idRuolo = request.getParameter("idRuolo");
					String idPermesso = request.getParameter("idPermesso");
					
					PermessoDTO permesso = GestionePermessiBO.getPermessoById(idPermesso, session);
					RuoloDTO ruolo = GestioneRuoloBO.getRuoloById(idRuolo, session);
					
					ruolo.getListaPermessi().remove(permesso);
					int success = GestioneRuoloBO.saveRuolo(ruolo, "modifica", session);
					
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
					myObj.addProperty("message", "OK");
			        out.println(myObj.toString());
				}
				
				
			}else{
				myObj.addProperty("success", false);
				myObj.addProperty("message", "No Action");
		        out.println(myObj.toString());
			}
		} 
		catch (Exception ex) {
			
		//	ex.printStackTrace();
		     request.setAttribute("error",STIException.callException(ex));
			 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
		     dispatcher.forward(request,response);
		}
	
	}

}
