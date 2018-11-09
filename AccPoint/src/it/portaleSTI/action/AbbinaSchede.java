package it.portaleSTI.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneStrumentoBO;

/**
 * Servlet implementation class abbinaSchede
 */
@WebServlet(name="abbinaSchede" , urlPatterns = { "/abbinaSchede.do" })

public class AbbinaSchede extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     * 
     */
    public AbbinaSchede() {
    	
        super();
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
		
		/* Test Push*/
		if(Utility.validateSession(request,response,getServletContext()))return;
		
		response.setContentType("text/html");
		 
		try {
			

			ArrayList<TipoStrumentoDTO> listaTipoStrumento = (ArrayList<TipoStrumentoDTO>) GestioneStrumentoBO.getListaTipoStrumento();
			request.getSession().setAttribute("listaTipoStrumento",listaTipoStrumento);
			
			ArrayList<TipoRapportoDTO> listaTipoRapporto = (ArrayList<TipoRapportoDTO>) GestioneStrumentoBO.getListaTipoRapporto();
			request.getSession().setAttribute("listaTipoRapporto",listaTipoRapporto);
			
			
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/abbinaSchede.jsp");
		    dispatcher.forward(request,response);
		    
		}catch(Exception ex)
    	{
   		 ex.printStackTrace();
   	     request.setAttribute("error",STIException.callException(ex));
   	     request.getSession().setAttribute("exception",ex);
   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
   	     dispatcher.forward(request,response);	
   	}  
	
		
		
	}

}
