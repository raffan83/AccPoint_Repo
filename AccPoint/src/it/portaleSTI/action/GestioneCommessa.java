package it.portaleSTI.action;

import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.io.IOException;
import java.lang.reflect.Field;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneCommesseBO;

/**
 * Servlet implementation class GestioneCommessa
 */
@WebServlet(name = "gestioneCommessa", urlPatterns = { "/gestioneCommessa.do" })

public class GestioneCommessa extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneCommessa() {
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
		
		response.setContentType("text/html");
		 
		try {
			CompanyDTO company =(CompanyDTO)request.getSession().getAttribute("usrCompany");
			
			UtenteDTO user = (UtenteDTO)request.getSession().getAttribute("userObj");
			
			
			ArrayList<CommessaDTO> listaCommesse =GestioneCommesseBO.getListaCommesse(company,"",user);
			
			request.getSession().setAttribute("listaCommesse", listaCommesse);
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneCommessa.jsp");
	     	dispatcher.forward(request,response);
			
		} 
		catch(Exception ex)
    	{
   		 ex.printStackTrace();
   	     request.setAttribute("error",STIException.callException(ex));
   	     request.getSession().setAttribute("exception", ex);
   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
   	     dispatcher.forward(request,response);	
   	}  
	}

}
