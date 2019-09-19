package it.portaleSTI.action;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

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
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneInterventoBO;
import it.portaleSTI.bo.GestioneUtenteBO;

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
				
				UtenteDTO user = (UtenteDTO)request.getSession().getAttribute("userObj");
				
				ArrayList<InterventoDatiDTO> lista_interventi_dati = DirectMySqlDAO.getListaInterventiDati(user, session);
				ArrayList<UtenteDTO> lista_utenti = GestioneInterventoBO.getListaUtentiInterventoDati(session);
				
				request.getSession().setAttribute("lista_interventi_dati", lista_interventi_dati);
				request.getSession().setAttribute("lista_utenti", lista_utenti);
				request.getSession().setAttribute("tasto_generate", null);
				request.getSession().setAttribute("tasto_scarico", null);
				request.getSession().setAttribute("dateFrom","");
				request.getSession().setAttribute("dateTo","");
				request.getSession().setAttribute("oper","");
				
				 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaInterventiOperatore.jsp");
			     dispatcher.forward(request,response);		
			     session.close();
			}
			else if(action.equals("attivita_sospese")) {
				
				UtenteDTO user = (UtenteDTO)request.getSession().getAttribute("userObj");				
				
				ArrayList<UtenteDTO> lista_utenti = (ArrayList<UtenteDTO>) request.getSession().getAttribute("lista_utenti");
				
				ArrayList<InterventoDatiDTO> lista_interventi_dati = DirectMySqlDAO.getListaInterventiDatiGenerati(user, session);
				
				request.getSession().setAttribute("lista_interventi_dati", lista_interventi_dati);
				request.getSession().setAttribute("lista_utenti", lista_utenti);
				request.getSession().setAttribute("tasto_generate", 1);
				request.getSession().setAttribute("tasto_scarico", null);
				request.getSession().setAttribute("dateFrom","");
				request.getSession().setAttribute("dateTo","");
				request.getSession().setAttribute("oper","");
				
				 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaInterventiOperatore.jsp");
			     dispatcher.forward(request,response);	
			}
			else if(action.equals("attivita_scarico")) {
				
				UtenteDTO user = (UtenteDTO)request.getSession().getAttribute("userObj");
				ArrayList<UtenteDTO> lista_utenti = (ArrayList<UtenteDTO>) request.getSession().getAttribute("lista_utenti");
				
				ArrayList<InterventoDatiDTO> lista_interventi_dati = DirectMySqlDAO.getListaInterventiDatiScarico(user, session);
				
				request.getSession().setAttribute("lista_interventi_dati", lista_interventi_dati);
				request.getSession().setAttribute("lista_utenti", lista_utenti);
				request.getSession().setAttribute("tasto_scarico", 1);
				request.getSession().setAttribute("tasto_generate", null);
				request.getSession().setAttribute("dateFrom","");
				request.getSession().setAttribute("dateTo","");
				request.getSession().setAttribute("oper","");
				
				 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaInterventiOperatore.jsp");
			     dispatcher.forward(request,response);	
			}
			
			else if(action.equals("filtra_date")) {
				
				String dateFrom = request.getParameter("dateFrom");
				String dateTo = request.getParameter("dateTo");			
				String oper = request.getParameter("oper");
				String mese = request.getParameter("mese");
				
				UtenteDTO user = (UtenteDTO)request.getSession().getAttribute("userObj");	
				
				ArrayList<UtenteDTO> lista_utenti = (ArrayList<UtenteDTO>) request.getSession().getAttribute("lista_utenti");
				if(lista_utenti==null) {
					ArrayList<UtenteDTO> lista_utenti_company = GestioneUtenteBO.getUtentiFromCompany(user.getCompany().getId(), session);
					lista_utenti = new ArrayList<UtenteDTO>();
					for (UtenteDTO utenteDTO : lista_utenti_company) {
						if(utenteDTO.checkRuolo("OP")|| utenteDTO.checkRuolo("AM") || utenteDTO.checkRuolo("RS")) {
							lista_utenti.add(utenteDTO);	
						}
					}
				}
				
				if(mese!=null) {
					Calendar cal = Calendar.getInstance();				
					
					DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			
					dateFrom = df.format(new GregorianCalendar(cal.get(Calendar.YEAR),cal.get(Calendar.MONTH),1).getTime());
					dateTo = df.format(new GregorianCalendar(cal.get(Calendar.YEAR),cal.get(Calendar.MONTH),cal.get(Calendar.DATE)).getTime());
					
				}
				
				ArrayList<InterventoDatiDTO> lista_interventi_dati = DirectMySqlDAO.getListaInterventiDatiPerData(user,dateFrom, dateTo, session);
				
				request.getSession().setAttribute("lista_interventi_dati", lista_interventi_dati);
				request.getSession().setAttribute("lista_utenti", lista_utenti);
				request.getSession().setAttribute("tasto", null);
				request.getSession().setAttribute("dateFrom",dateFrom);
				request.getSession().setAttribute("dateTo",dateTo);
				request.getSession().setAttribute("oper",oper);
				
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
