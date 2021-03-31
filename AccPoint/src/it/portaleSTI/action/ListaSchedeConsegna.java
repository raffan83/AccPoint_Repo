package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

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
				
				ArrayList<SchedaConsegnaDTO> lista_schede_consegna_all = GestioneSchedaConsegnaBO.getListaSchedeConsegnaAll(session);
				ArrayList<SchedaConsegnaRilieviDTO> lista_schede_consegna_rilievi = GestioneSchedaConsegnaBO.getListaSchedeConsegnaRilievi(0,0,session);
								
				ArrayList<SchedaConsegnaDTO> lista_schede_consegna = new ArrayList<SchedaConsegnaDTO>();
				ArrayList<SchedaConsegnaDTO> lista_schede_consegna_verificazione = new ArrayList<SchedaConsegnaDTO>();
				
				for (SchedaConsegnaDTO sc : lista_schede_consegna_all) {
					if(sc.getIntervento()==null) {
						lista_schede_consegna_verificazione.add(sc);
					}else {
						lista_schede_consegna.add(sc);
					}
				}
				
				session.close();
				request.getSession().setAttribute("lista_schede_consegna", lista_schede_consegna);
				request.getSession().setAttribute("lista_schede_consegna_rilievi", lista_schede_consegna_rilievi);
				request.getSession().setAttribute("lista_schede_consegna_verificazione", lista_schede_consegna_verificazione);
				
				 request.getSession().setAttribute("rilievo_attivo","");
				 request.getSession().setAttribute("verificazione_attivo","");
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
			
			else if(action.equals("filtra_date")) {
				
				String dateFrom = request.getParameter("dateFrom");
				String dateTo = request.getParameter("dateTo");
				String rilievo = request.getParameter("rilievo");
				String verificazione = request.getParameter("verificazione");
				
				ArrayList<SchedaConsegnaDTO> lista_schede_consegna = null;
				ArrayList<SchedaConsegnaDTO> lista_schede_consegna_all = null;
				ArrayList<SchedaConsegnaRilieviDTO> lista_schede_consegna_rilievi = null;
				ArrayList<SchedaConsegnaDTO> lista_schede_consegna_verificazione = null;
				if(rilievo!=null && rilievo.equals("0") && verificazione!=null && verificazione.equals("0") ) {
					
					 lista_schede_consegna = GestioneSchedaConsegnaBO.getListaSchedeConsegnaDate(dateFrom, dateTo,session);
					 lista_schede_consegna_rilievi = GestioneSchedaConsegnaBO.getListaSchedeConsegnaRilievi(0,0,session);
					 lista_schede_consegna_verificazione = (ArrayList<SchedaConsegnaDTO>) request.getSession().getAttribute("lista_schede_consegna_verificazione");
					 request.getSession().setAttribute("dateFromScheda",dateFrom);
					 request.getSession().setAttribute("dateToScheda",dateTo);	
					 request.getSession().setAttribute("dateFromRil","");
					 request.getSession().setAttribute("dateToRil","");
					 request.getSession().setAttribute("rilievo_attivo","");
					 request.getSession().setAttribute("dateFromVer","");
					 request.getSession().setAttribute("dateToVer","");
					 request.getSession().setAttribute("verificazione_attivo","");
				}
				else if(verificazione!=null && verificazione.equals("1")) {
					// lista_schede_consegna = GestioneSchedaConsegnaBO.getListaSchedeConsegnaDate(dateFrom, dateTo,session);
					 lista_schede_consegna = (ArrayList<SchedaConsegnaDTO>) request.getSession().getAttribute("lista_schede_consegna");
					 lista_schede_consegna_rilievi = GestioneSchedaConsegnaBO.getListaSchedeConsegnaRilievi(0,0,session);
					 lista_schede_consegna_verificazione = GestioneSchedaConsegnaBO.getListaSchedeConsegnaVerificazioneDate(dateFrom, dateTo, session);
					 request.getSession().setAttribute("dateFromScheda","");
					 request.getSession().setAttribute("dateToScheda","");	
					 request.getSession().setAttribute("dateFromRil","");
					 request.getSession().setAttribute("dateToRil","");
					 request.getSession().setAttribute("rilievo_attivo","");
					 request.getSession().setAttribute("dateFromVer",dateFrom);
					 request.getSession().setAttribute("dateToVer",dateTo);
					 request.getSession().setAttribute("verificazione_attivo",1);
				}
				else {
					// lista_schede_consegna = GestioneSchedaConsegnaBO.getListaSchedeConsegnaAll(session);
					lista_schede_consegna = (ArrayList<SchedaConsegnaDTO>) request.getSession().getAttribute("lista_schede_consegna");
					 lista_schede_consegna_rilievi = GestioneSchedaConsegnaBO.getListaSchedeConsegnaRilieviDate(dateFrom, dateTo, session);
					 lista_schede_consegna_verificazione = (ArrayList<SchedaConsegnaDTO>) request.getSession().getAttribute("lista_schede_consegna_verificazione");
					 request.getSession().setAttribute("dateFromRil",dateFrom);
					 request.getSession().setAttribute("dateToRil",dateTo);
					 request.getSession().setAttribute("dateFromScheda","");
					 request.getSession().setAttribute("dateToScheda","");
					 request.getSession().setAttribute("rilievo_attivo",1);
					 request.getSession().setAttribute("dateFromVer","");
					 request.getSession().setAttribute("dateToVer","");
					 request.getSession().setAttribute("verificazione_attivo","");
					 
				}
				
				session.close();
				request.getSession().setAttribute("lista_schede_consegna", lista_schede_consegna);
				request.getSession().setAttribute("lista_schede_consegna_rilievi", lista_schede_consegna_rilievi);
				request.getSession().setAttribute("lista_schede_consegna_verificazione", lista_schede_consegna_verificazione);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaSchedeConsegnaTab.jsp");
		     	dispatcher.forward(request,response);
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
