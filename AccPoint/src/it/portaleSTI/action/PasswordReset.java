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

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
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
				
				String username = request.getParameter("username");
				String token = request.getParameter("token");
				UtenteDTO utente = GestioneUtenteBO.getUtenteByUsername(username, sessionH);
				 if(utente != null && utente.getResetToken() != null && !utente.getResetToken().equals("") && utente.getResetToken().equals(token)){
				
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/passwordResetInsert.jsp");
					  request.setAttribute("username",username);
					  request.setAttribute("token",token);
					  dispatcher.forward(request,response);
				}else {
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/pageNotFound.jsp");

					  dispatcher.forward(request,response);
				}
			   
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
