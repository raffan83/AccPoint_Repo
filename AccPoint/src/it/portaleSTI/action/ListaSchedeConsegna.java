package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.SchedaConsegnaDTO;
import it.portaleSTI.DTO.SchedaConsegnaRilieviDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneSchedaConsegnaBO;

/**
 * Servlet implementation class ListaSchedeConsegna
 */
@WebServlet("/listaSchedeConsegna.do")
public class ListaSchedeConsegna extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaSchedeConsegna() {
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
		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
		
		String action = request.getParameter("action");
		JsonObject myObj = new JsonObject();
		boolean ajax = false;
        response.setContentType("application/json");
		try {
			if(action==null || action.equals("")) {
				
				ArrayList<SchedaConsegnaDTO> lista_schede_consegna = GestioneSchedaConsegnaBO.getListaSchedeConsegnaAll(session);
				ArrayList<SchedaConsegnaRilieviDTO> lista_schede_consegna_rilievi = GestioneSchedaConsegnaBO.getListaSchedeConsegnaRilievi(session);
				
				session.close();
				request.getSession().setAttribute("lista_schede_consegna", lista_schede_consegna);
				request.getSession().setAttribute("lista_schede_consegna_rilievi", lista_schede_consegna_rilievi);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaSchedeConsegnaTab.jsp");
		     	dispatcher.forward(request,response);
				
				
			}else if(action.equals("cambia_stato")) {
				ajax = true;
				
				String id_scheda = request.getParameter("id_scheda");
				String rilievo = request.getParameter("rilievo");
				
				if(rilievo.equals("1")) {
					SchedaConsegnaRilieviDTO schedaRil = GestioneSchedaConsegnaBO.getSchedaConsegnaRilievoFromId(Integer.parseInt(id_scheda), session);
					if(schedaRil.getStato()==0) {
						schedaRil.setStato(1);
					}else {
						schedaRil.setStato(0);
					}
					session.update(schedaRil);
				}else {
					SchedaConsegnaDTO scheda = GestioneSchedaConsegnaBO.getSchedaConsegnaFromId(Integer.parseInt(id_scheda), session);
					if(scheda.getStato()==0) {
						scheda.setStato(1);
					}else {
						scheda.setStato(0);
					}
					session.update(scheda);
				}
				
				session.getTransaction().commit();
				session.close();
				
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Stato cambiato con successo!");
				PrintWriter out = response.getWriter();
				out.print(myObj);
				
				
			}
			
		}		
		catch (Exception e) {
			session.getTransaction().rollback();
        	session.close();
			if(ajax) {
				PrintWriter out = response.getWriter();
				e.printStackTrace();
	        	
	        	request.getSession().setAttribute("exception", e);
	        	myObj = STIException.getException(e);
	        	out.print(myObj);
        	}else {
   			    			
    			e.printStackTrace();
    			request.setAttribute("error",STIException.callException(e));
    	  	     request.getSession().setAttribute("exception", e);
    			 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
    		     dispatcher.forward(request,response);	
        	}
		}
	}

}
