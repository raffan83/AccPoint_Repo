package it.portaleSTI.action;

import it.portaleSTI.DAO.GestioneAccessoDAO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Login
 */
@WebServlet("/login.do")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * Default constructor. 
     */
    public Login() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		if(Utility.checkSession(request,response,getServletContext()))return;
		
		try{
		    response.setContentType("text/html");
	        
		    String user=request.getParameter("uid");
	        String pwd=request.getParameter("pwd");
	        
	        UtenteDTO utente=GestioneAccessoDAO.controllaAccesso(user,pwd);
	        
	        if(utente!=null)
	        {
	        	 request.setAttribute("forward","site/home.jsp"); 	
	        	 request.getSession().setAttribute("nomeUtente","  "+utente.getNominativo());
	        	 request.getSession().setAttribute("idUtente",utente.getId());
	        	 request.getSession().setAttribute("tipoAccount",utente.getTipoutente());
	        	 
	        	 request.getSession().setAttribute("userObj", utente);
	        	 request.getSession().setAttribute("usrCompany", GestioneAccessoDAO.getCompany(utente.getId()));
	        	
	        	RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/frames.jsp");
	        	dispatcher.forward(request,response);
	        }
	        else
	        {
	        	RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/homeErrorAccess.jsp");
	             dispatcher.forward(request,response);
	        }
			}
			catch(Exception ex)
        	{
        		 ex.printStackTrace();
        	     request.setAttribute("error",STIException.callException(ex));
        		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
        	     dispatcher.forward(request,response);	
        	}  
	}

	

}
