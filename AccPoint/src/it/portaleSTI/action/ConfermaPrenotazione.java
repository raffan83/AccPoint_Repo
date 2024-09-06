package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.google.gson.JsonObject;

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

		if (request.getSession().getAttribute("userObj")==null ) {
			request.getSession().setAttribute("urlStatico", "/confermaPrenotazione.do");
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/index.jsp");
            dispatcher.forward(request,response);
		}else {
			doPost(request, response);
		}
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
		boolean ajax = false;
		try {
			
			String action = request.getParameter("action");
			
			if(action == null) {
				UtenteDTO user = (UtenteDTO)request.getSession().getAttribute("userObj");
				
				logger.error(Utility.getMemorySpace()+" Action: "+"Lista Prenotazioni Utente" +" - Utente: "+user.getNominativo());
				
				ArrayList<PaaPrenotazioneDTO> lista_prenotazioniPerUtente = GestioneParcoAutoBO.getListaPrenotazioniPerUtente(user,session);
				
				request.getSession().setAttribute("listaPrenotazione", lista_prenotazioniPerUtente);
				
			
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/confermaPrenotazione.jsp");
		     	dispatcher.forward(request,response);
			}
			else if(action!=null && action.equals("conferma_prenotazione")) {			
				
				ajax = true;
				
				String id = request.getParameter("id_prenotazione");			

				logger.error(Utility.getMemorySpace()+" Action: "+"Conferma Prenotazione");
				
				PaaPrenotazioneDTO prenotazione = GestioneParcoAutoBO.getPrenotazioneFromId(Integer.parseInt(id), session);
				prenotazione.setStato_prenotazione(2);
				prenotazione.setData_conferma(new Date());
				
				PrintWriter out = response.getWriter();
				JsonObject myObj = new JsonObject();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Prenotazione Confermata!");
	        	out.print(myObj);
			}

			session.getTransaction().commit();
        	session.close();
			
		} 
		catch(Exception ex)
    	{
			if(ajax) {
				
				PrintWriter out = response.getWriter();
				
				JsonObject myObj = new JsonObject();
	        	request.getSession().setAttribute("exception", ex);
	        	myObj = STIException.getException(ex);
	        	out.print(myObj);
        	}else {
			
	   		 	ex.printStackTrace();
	   		 	request.getSession().setAttribute("exception",ex);
	   	     	request.setAttribute("error",STIException.callException(ex));
	   		 	RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
	   	     	dispatcher.forward(request,response);	
        	}
    	} 
	
	}

}
