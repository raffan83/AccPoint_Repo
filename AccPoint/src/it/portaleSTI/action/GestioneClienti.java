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

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.GestioneAccessoDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.RuoloDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneCompanyBO;
import it.portaleSTI.bo.GestioneRuoloBO;
import it.portaleSTI.bo.GestioneUtenteBO;

/**
 * Servlet implementation class GestioneUtenti
 */

@WebServlet(name = "gestioneClienti", urlPatterns = { "/gestioneClienti.do" })

public class GestioneClienti extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneClienti() {
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
	  
	    	 	if(action.equals("nuovo"))
	    	 		
	    	 		{
	    	 			String nome = request.getParameter("nome");
	    	 			String cognome = request.getParameter("cognome");
	    	 			String user = request.getParameter("user");
	    	 			String passw = request.getParameter("passw");
	    	 			String indirizzo = request.getParameter("indirizzo");
	    	 			String comune = request.getParameter("comune");
	    	 			String cap = request.getParameter("cap");
	    	 			String email = request.getParameter("email");
	    	 			String telefono = request.getParameter("telefono");
	    	 			String clienteId = request.getParameter("cliente");
	    	 			String sedeId = request.getParameter("sede");
	    	 			
	    	 			UtenteDTO utenteCreazione = (UtenteDTO)request.getSession().getAttribute("userObj");
	    	 			
	    	 				    	 			
	    	 			UtenteDTO utente = new UtenteDTO();
	    	 			utente.setNome(nome);
	    	 			utente.setCognome(cognome);
	    	 			utente.setUser(user);
	    	 			utente.setPassw(DirectMySqlDAO.getPassword(passw));
	    	 			utente.setIndirizzo(indirizzo);
	    	 			utente.setComune(comune);
	    	 			utente.setCap(cap);
	    	 			utente.setEMail(email);
	    	 			utente.setTelefono(telefono);
	    	 			utente.setCompany(utenteCreazione.getCompany());
	    	 			utente.setNominativo(nome+" "+cognome);
	    	 			
	    	 		
	    	 			//GestioneUtenteBO.save(utente,session);

	    	 			int success = GestioneUtenteBO.saveUtente(utente, action, session);
	    	 			if(success==0)
	    				{
	    					myObj.addProperty("success", true);
	    					myObj.addProperty("messaggio","Utente salvato con successo");
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
	    	 		
		 			 	
	    	 		}
	    	 	
	    	 	if(action.equals("modifica")){
	    	 			
	    	 			String id = request.getParameter("id");

	    	 			String nome = request.getParameter("nome");
	    	 			String cognome = request.getParameter("cognome");
	    	 			String user = request.getParameter("user");
	    	 			String passw = request.getParameter("passw");
	    	 			String indirizzo = request.getParameter("indirizzo");
	    	 			String comune = request.getParameter("comune");
	    	 			String cap = request.getParameter("cap");
	    	 			String EMail = request.getParameter("email");
	    	 			String telefono = request.getParameter("telefono");
	    	 			String companyId = request.getParameter("company");
	    	 				
	    	 			
	    	 			UtenteDTO utente = GestioneUtenteBO.getUtenteById(id, session);
	    	 			
	    	 			
	    	 			if(nome != null && !nome.equals("")){
	    	 				utente.setNome(nome);
	    	 			}
	    	 			if(cognome != null && !cognome.equals("")){
		    	 			utente.setCognome(cognome);
	    	 			}
	    	 			if(user != null && !user.equals("")){
		    	 			utente.setUser(user);
	    	 			}
	    	 			if(passw != null && !passw.equals("")){
		    	 			utente.setPassw(passw);
	    	 			}
	    	 			if(indirizzo != null && !indirizzo.equals("")){
		    	 			utente.setIndirizzo(indirizzo);
	    	 			}
	    	 			if(comune != null && !comune.equals("")){
		    	 			utente.setComune(comune);
	    	 			}
	    	 			if(cap != null && !cap.equals("")){
		    	 			utente.setCap(cap);
	    	 			}
	    	 			if(EMail != null && !EMail.equals("")){
		    	 			utente.setEMail(EMail);
	    	 			}
	    	 			if(telefono != null && !telefono.equals("")){
		    	 			utente.setTelefono(telefono);
	    	 			}
	    	 			
	    	 			utente.setNominativo(utente.getNome()+" "+utente.getCognome());
	    	 			
	    	 			if(companyId != null && !companyId.equals("")){
		    	 			CompanyDTO company = GestioneCompanyBO.getCompanyById(companyId, session);
	    	 				utente.setCompany(company);
	    	 			}
	    	 			

	    	 			int success = GestioneUtenteBO.saveUtente(utente, action, session);
	    	 			
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
	    	 		}
	   
	       	out.println(myObj.toString());

        }catch(Exception ex){
        	
        	ex.printStackTrace();
        	session.getTransaction().rollback();
        	session.close();
        	request.getSession().setAttribute("exception", ex);
        	myObj.addProperty("success", false);
        	myObj.addProperty("messaggio", STIException.callException(ex).toString());
        	//out.println(myObj.toString());
        } 
	}

}
