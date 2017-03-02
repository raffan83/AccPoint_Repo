package it.portaleSTI.action;

import it.portaleSTI.DAO.GestioneAccessoDAO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.PrenotazioneDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestionePrenotazioni;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ListaPrenotazione
 */
@WebServlet(name = "listaPrenotazioni", urlPatterns = { "/listaPrenotazioni.do" })

public class ListaPrenotazione extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaPrenotazione() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.checkSession(request,response,getServletContext()))return;
		
		response.setContentType("text/html");
		
		try {
			
			HashMap<Integer, String> company=null;
			
			if(Utility.checkSession(request.getSession(),"SES_Company"))
			{
				company=(HashMap<Integer, String>)request.getSession().getAttribute("SES_Company");
			}else
			{
				company=GestioneAccessoDAO.getListCompany();
				request.getSession().setAttribute("SES_Company", company);
			}
			
			int myId=((CompanyDTO)request.getSession().getAttribute("usrCompany")).getId();
			
			ArrayList<PrenotazioneDTO> listaPrenotazioni =GestionePrenotazioni.getListaPrenotaziony(myId);
			
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
