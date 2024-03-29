package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.GestioneUtenteDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneUtenteBO;

/**
 * Servlet implementation class AreaUtente
 */

@WebServlet(name="passwordReset" , urlPatterns = { "/passwordReset.do" })

public class PasswordReset extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public PasswordReset() {
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
		
		PrintWriter out = response.getWriter();
		String action = request.getParameter("action");
		org.hibernate.Session sessionH = SessionFacotryDAO.get().openSession();
		sessionH.beginTransaction();
			
 		try
		{
 			
 			
			
			
			if(action.equals("resetView")) {
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/passwordResetMail.jsp");
			    dispatcher.forward(request,response);
				  
			}else if(action.equals("resetSend")) {
				
				String username = request.getParameter("username");
				
				JsonObject myObj = GestioneUtenteBO.sendEmail(username, sessionH, "https://www.calver.it/passwordReset.do");
				if(myObj.get("success").getAsBoolean()) {
					sessionH.getTransaction().commit();
					sessionH.close();
				}else {
					sessionH.getTransaction().rollback();
			   		 sessionH.close();
				}
				 out.println(myObj.toString());
			}else if(action.equals("resetPass")){
				
	
				String token = request.getParameter("token");
		        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/passwordResetInsert.jsp");
				request.setAttribute("token",token);
				dispatcher.forward(request,response);
			
			}else if(action.equals("resetChange")){
				
				String username = request.getParameter("username");
				String token = request.getParameter("token");
				String password = request.getParameter("password");

				JsonObject myObj = GestioneUtenteBO.sendEmailChange(username, password, token, sessionH);
				if(myObj.get("success").getAsBoolean()) {
					sessionH.getTransaction().commit();
					sessionH.close();
				}else {
					sessionH.getTransaction().rollback();
			   		 sessionH.close();
				}
				 out.println(myObj.toString());
			   
			}
			else if(action.equals("primo_accesso")){
				String id_utente = request.getParameter("id_utente");
				String old_pwd = request.getParameter("old_pwd");
				String password = request.getParameter("password");
				String old_password_inserted = request.getParameter("old_password_inserted");
				//JsonObject myObj = ;
				
				JsonObject myObj = new JsonObject();
			
				if(!old_password_inserted.equals(Utility.decryptData(old_pwd))) {
					myObj.addProperty("success", false);
					myObj.addProperty("messaggio", "Attenzione! Password provvisoria errata!");
				}
				else if(old_password_inserted.equals(Utility.decryptData(old_pwd))&& password.equals(Utility.decryptData(old_pwd))) {
					myObj.addProperty("success", false);
					myObj.addProperty("messaggio", "Attenzione! La password deve essere diversa dalla password provvisoria!");
				}
				else {
					UtenteDTO utente = GestioneUtenteBO.getUtenteById(Utility.decryptData(id_utente), sessionH);
					utente.setPrimoAccesso(0);
					DirectMySqlDAO.savePwdutente(utente.getId(), password);
					myObj.addProperty("success", true);
					myObj.addProperty("messaggio", "Password modificata con successo!");
					sessionH.getTransaction().commit();
			   		
				}
				 sessionH.close();
				 out.println(myObj.toString());
			}
		    
		}catch(Exception ex)
	    	{
			 sessionH.getTransaction().rollback();
	   		 sessionH.close();
			if(action.equals("resetSend")) {
				 	
				JsonObject myObj = new JsonObject();
				  request.getSession().setAttribute("exception", ex);
					myObj.addProperty("success", false);
					myObj.addProperty("messaggio", STIException.callException(ex).toString());
			        out.println(myObj.toString());
			}else {
	    		
				ex.printStackTrace();
	    	     	request.setAttribute("error",STIException.callException(ex));
	    	   	     request.getSession().setAttribute("exception", ex);
	    	     	RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
	    	     	dispatcher.forward(request,response);	
			}  
	    	}  
	}

}
