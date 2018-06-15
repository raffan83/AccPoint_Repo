package it.portaleSTI.action;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.GestioneAccessoDAO;
import it.portaleSTI.DAO.GestioneTLDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.BachecaDTO;
import it.portaleSTI.DTO.ClassificazioneDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.LuogoVerificaDTO;
import it.portaleSTI.DTO.PermessoDTO;
import it.portaleSTI.DTO.StatoStrumentoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.DTO.TipoTrendDTO;
import it.portaleSTI.DTO.TrendDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneBachecaBO;
import it.portaleSTI.bo.GestioneCompanyBO;
import it.portaleSTI.bo.GestioneStrumentoBO;
import it.portaleSTI.bo.GestioneTrendBO;
import it.portaleSTI.bo.GestioneUtenteBO;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

/**
 * Servlet implementation class Login
 */
@WebServlet("/registrazione.do")
public class Registrazione extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final Logger logger = Logger.getLogger(Registrazione.class);
    /**
     * Default constructor. 
     */
    public Registrazione() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
		 
	        		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/registrazione.jsp");
				dispatcher.forward(request,response);
	   
	    	} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
		} 
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
	//	if(Utility.validateSession(request,response,getServletContext()))return;
		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();

		try{
			
		    response.setContentType("text/html");
	        
		    String user=request.getParameter("user");

	        
	        Boolean utenteCheck=GestioneAccessoDAO.controlloUsername(user);
	        String nome = request.getParameter("nome");
 			String cognome = request.getParameter("cognome");
	 		String passw = request.getParameter("passw");
	 		String cpassw = request.getParameter("cpassw");
 			String indirizzo = request.getParameter("indirizzo");
 			String comune = request.getParameter("comune");
 			String cap = request.getParameter("cap");
 			String email = request.getParameter("email");
 			String telefono = request.getParameter("telefono");
 			String descrizioneCompany = request.getParameter("descrizioneCompany");
 			if(!passw.equals(cpassw)) {
 				
 				request.setAttribute("success", false);
                request.setAttribute("errorMessage", "Errore Conferma Password, accertarsi di aver inserito la stessa Password");
                request.setAttribute("user", user);
                request.setAttribute("nome", nome);
                request.setAttribute("cognome", cognome);
                request.setAttribute("indirizzo", indirizzo);
                request.setAttribute("comune", comune);
                request.setAttribute("cap", cap);
                request.setAttribute("email", email);
                request.setAttribute("telefono", telefono);
                request.setAttribute("descrizioneCompany", descrizioneCompany);

                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/registrazione.jsp");
	            dispatcher.forward(request,response);
 			}else  if(!utenteCheck)
	        {
 	 		 
 	 			CompanyDTO company = new CompanyDTO();
	 			company.setId(1);
	 				    	 			
	 			UtenteDTO utente = new UtenteDTO();
	 			
	 			utente.setDescrizioneCompany(descrizioneCompany);
	 			utente.setNome(nome);
	 			utente.setCognome(cognome);
	 			utente.setUser(user);
	 			utente.setPassw(DirectMySqlDAO.getPassword(passw));
	 			utente.setIndirizzo(indirizzo);
	 			utente.setComune(comune);
	 			utente.setCap(cap);
	 			utente.setEMail(email);
	 			utente.setTelefono(telefono);
	 			utente.setCompany(company);
	 			utente.setNominativo(nome+" "+cognome);
	 		 
	 				utente.setIdCliente(0);
	 	 
	 		 
	 				utente.setIdSede(0);
	 			 
	 			utente.setTipoutente(null);
	 			utente.setCv(null);
	 			utente.setResetToken(null);
	 			
	 			 
	 				utente.setAbilitato(0);
	 			 
	 			
	 			int success = GestioneUtenteBO.saveUtente(utente, "nuovo", session);
	 			
	 			JsonObject myObj = new JsonObject();

	 			if(success==0)
				{
	 				myObj = GestioneUtenteBO.sendEmailAmministratoreNuovoUtente(utente, session);

	 				request.setAttribute("success", true);
	 				request.setAttribute("errorMessage", myObj.get("messaggio"));
  					session.getTransaction().commit();
					session.close();
				
				}else {
					
					request.setAttribute("success", false);
					request.setAttribute("errorMessage", "Errore Salvataggio");

					
					
					
					
					session.getTransaction().rollback();
			 		session.close();
			 		
				} 
  			 	
 	        	
	       
	 			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/registrazione.jsp");
				dispatcher.forward(request,response);
	        }
	        else
	        {
	        		request.setAttribute("success", false);
                request.setAttribute("errorMessage", "Username gia presente");
                request.setAttribute("user", user);
                request.setAttribute("nome", nome);
                request.setAttribute("cognome", cognome);
                request.setAttribute("indirizzo", indirizzo);
                request.setAttribute("comune", comune);
                request.setAttribute("cap", cap);
                request.setAttribute("email", email);
                request.setAttribute("telefono", telefono);
                request.setAttribute("descrizioneCompany", descrizioneCompany);

                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/registrazione.jsp");
	            dispatcher.forward(request,response);
	             
	        }
			}
		catch(Exception ex)
    	{
			session.getTransaction().rollback();
	 		session.close();
    	 
	 		if(ex.getMessage().equals("Invalid Addresses")) {
	 				request.setAttribute("success", false);
	 				request.setAttribute("errorMessage", "Errore Email errata");
	 	        
	                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/registrazione.jsp");
	       	     dispatcher.forward(request,response);	

	 		}else {
	 			System.out.println(ex.getMessage());


	 			request.setAttribute("error",STIException.callException(ex));
	 	   	     request.getSession().setAttribute("exception", ex);
    		 		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
    	    	     dispatcher.forward(request,response);	

	 		}
    	}  
	}

	

}
