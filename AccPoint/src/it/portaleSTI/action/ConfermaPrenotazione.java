package it.portaleSTI.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.hibernate.Session;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.PaaPrenotazioneDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneCommesseBO;
import it.portaleSTI.bo.GestioneParcoAutoBO;

/**
 * Servlet implementation class listaCampioni
 */
@WebServlet(name="confermaPrenotazione" , urlPatterns = { "/confermaPrenotazione.do" })

public class ConfermaPrenotazione extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final Logger logger = Logger.getLogger(ConfermaPrenotazione.class); 
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ConfermaPrenotazione() {
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
		
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		try {

			UtenteDTO user = (UtenteDTO)request.getSession().getAttribute("userObj");
			
			logger.error(Utility.getMemorySpace()+" Action: "+"Conferma Prenotazione" +" - Utente: "+user.getNominativo());
			
			ArrayList<PaaPrenotazioneDTO> lista_prenotazioniPerUtente = GestioneParcoAutoBO.getListaPrenotazioniPerUtente(user,session);
			
			request.getSession().setAttribute("listaPrenotazione", lista_prenotazioniPerUtente);
			
			session.getTransaction().commit();
        	session.close();
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/confermaPrenotazione.jsp");
	     	dispatcher.forward(request,response);
			
		} 
		catch(Exception ex)
    	{
			
			
   		 	ex.printStackTrace();
   		 	request.getSession().setAttribute("exception",ex);
   	     	request.setAttribute("error",STIException.callException(ex));
   		 	RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
   	     	dispatcher.forward(request,response);	
    	} 
	
	}

}
