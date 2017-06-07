package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;

/**
 * Servlet implementation class GestioneUtenti
 */

@WebServlet(name = "gestioneUtenti", urlPatterns = { "/gestioneUtenti.do" })
public class GestioneUtenti extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneUtenti() {
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
	    	 			String nome = request.getParameter("nome");
	    	 			String cognome = request.getParameter("cognome");
	    	 			String user = request.getParameter("user");
	    	 			String passw = request.getParameter("passw");
	    	 			String indirizzo = request.getParameter("indirizzo");
	    	 			String comune = request.getParameter("comune");
	    	 			String cap = request.getParameter("cap");
	    	 			String EMail = request.getParameter("EMail");
	    	 			String telefono = request.getParameter("telefono");
	    	 			String companyId = request.getParameter("company");
	    	 				
	    	 			CompanyDTO company = new CompanyDTO();
	    	 			company.setId(Integer.parseInt(companyId));
	    	 			
	    	 			UtenteDTO utente = new UtenteDTO();
	    	 			utente.setNome(nome);
	    	 			utente.setCognome(cognome);
	    	 			utente.setUser(user);
	    	 			utente.setPassw(passw);
	    	 			utente.setIndirizzo(indirizzo);
	    	 			utente.setComune(comune);
	    	 			utente.setCap(cap);
	    	 			utente.setEMail(EMail);
	    	 			utente.setTelefono(telefono);
	    	 			utente.setCompany(company);

	    	 			/*
	    	 			 * TO DO Salvataggio Nuovo Utente
	    	 			 */
	    	 			
	    	 			
	    	 		}else if(action.equals("modifica")){
	    	 			
	    	 		}else if(action.equals("elimina")){
	    	 			
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
        	myObj.addProperty("success", false);
        	myObj.addProperty("messaggio", STIException.callException(ex).toString());
        	out.println(myObj.toString());
        } 
	}

}
