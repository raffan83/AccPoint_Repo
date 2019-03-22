package it.portaleSTI.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.GestioneInterventoDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.InterventoDatiDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneInterventoBO;

/**
 * Servlet implementation class ListaInterventiOperatore
 */
@WebServlet("/listaInterventiOperatore.do")
public class ListaInterventiOperatore extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaInterventiOperatore() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		response.setContentType("text/html");
		String action = request.getParameter("action");
		
		try {
			
			if(action==null || action.equals("")) {
				
				ArrayList<InterventoDatiDTO> lista_interventi_dati = DirectMySqlDAO.getListaInterventiDati(session);
				
				request.getSession().setAttribute("lista_interventi_dati", lista_interventi_dati);
				request.getSession().setAttribute("tasto", null);
				
				 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaInterventiOperatore.jsp");
			     dispatcher.forward(request,response);		
			     session.close();
			}
			else if(action.equals("attivita_sospese")) {
				
				ArrayList<InterventoDatiDTO> lista_interventi_dati = DirectMySqlDAO.getListaInterventiDatiGenerati(session);
				
				request.getSession().setAttribute("lista_interventi_dati", lista_interventi_dati);
				request.getSession().setAttribute("tasto", 1);
				
				 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaInterventiOperatore.jsp");
			     dispatcher.forward(request,response);	
			}
			
			
		}
		catch(Exception ex) {
			 session.getTransaction().rollback();
			 session.close();
	   		 ex.printStackTrace();
	   	     request.setAttribute("error",STIException.callException(ex));
	   	     request.getSession().setAttribute("exception", ex);
	   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
	   	     dispatcher.forward(request,response);	
		}
		
	}

}
