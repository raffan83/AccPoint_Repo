package it.portaleSTI.action;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.portaleSTI.DTO.PrenotazioneDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestionePrenotazioniBO;

/**
 * Servlet implementation class ListaPrenotazioni
 */
@WebServlet(name = "listaPrenotazioniCampione", urlPatterns = { "/listaPrenotazioniCampione.do" })
public class ListaPrenotazioniCampione extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final int PrenotazioneDTO = 0;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaPrenotazioniCampione() {
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
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		
		response.setContentType("text/html");
		
		try {
			String idP = request.getParameter("idPrenotazione");
			
			PrenotazioneDTO prenotazione =GestionePrenotazioniBO.getPrenotazione(Integer.parseInt(idP));
			
			String idC =  ""+prenotazione.getCampione().getId();
			
			
			List<PrenotazioneDTO> listaPrenotazioniCampione =GestionePrenotazioniBO.getListaPrenotazione(idC);
			
			request.getSession().setAttribute("listaPrenotazioniCampione",listaPrenotazioniCampione);
			 
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaPrenotazioniCampione.jsp");
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
