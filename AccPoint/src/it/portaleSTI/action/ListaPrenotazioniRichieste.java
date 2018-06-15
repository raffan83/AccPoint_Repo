package it.portaleSTI.action;

import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.PrenotazioneDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestionePrenotazioniBO;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ListaPrenotazioniRichieste
 */
@WebServlet(name = "listaPrenotazioniRichieste", urlPatterns = { "/listaPrenotazioniRichieste.do" })

public class ListaPrenotazioniRichieste extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaPrenotazioniRichieste() {
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

			int myId=((CompanyDTO)request.getSession().getAttribute("usrCompany")).getId();
			
			List<PrenotazioneDTO> listaPrenotazioni =GestionePrenotazioniBO.getListaPrenotazioniRichieste(myId);
			
			request.getSession().setAttribute("listaPrenotazioni",listaPrenotazioni);
			 
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaPrenotazioniRichieste.jsp");
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
