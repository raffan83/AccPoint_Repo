package it.portaleSTI.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.SchedaConsegnaDTO;
import it.portaleSTI.DTO.SchedaConsegnaRilieviDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerInterventoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneRilieviBO;
import it.portaleSTI.bo.GestioneSchedaConsegnaBO;
import it.portaleSTI.bo.GestioneVerInterventoBO;

/**
 * Servlet implementation class ShowSchedeConsegna
 */
@WebServlet("/showSchedeConsegna.do")
public class ShowSchedeConsegna extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShowSchedeConsegna() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		if(Utility.validateSession(request,response,getServletContext()))return;
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();	
		
		String action = request.getParameter("action");
		try {
			
			if(action==null) {
			
				String idIntervento= request.getParameter("idIntervento");
				idIntervento = Utility.decryptData(idIntervento);
				List<SchedaConsegnaDTO> result=GestioneSchedaConsegnaBO.getListaSchedeConsegna(Integer.parseInt(idIntervento), session);
				
				request.getSession().setAttribute("schede_consegna", result);
				request.getSession().setAttribute("verificazione", null);
		
				session.getTransaction().commit();
				session.close();	
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaSchedeConsegna.jsp");
		     	dispatcher.forward(request,response);
	     	
			}else if(action!=null && action.equals("rilievi")){
				
				ArrayList<SchedaConsegnaRilieviDTO> lista_schede_consegna = GestioneSchedaConsegnaBO.getListaSchedeConsegnaRilievi(session);
				
				request.getSession().setAttribute("lista_schede_consegna", lista_schede_consegna);
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaSchedeConsegnaRilievi.jsp");
		     	dispatcher.forward(request,response);
				
			}else if(action!=null && action.equals("verificazione")){
				
				String idIntervento= request.getParameter("idIntervento");
				idIntervento = Utility.decryptData(idIntervento);
				
				VerInterventoDTO intervento = GestioneVerInterventoBO.getInterventoFromId(Integer.parseInt(idIntervento), session);
				List<SchedaConsegnaDTO> result=GestioneSchedaConsegnaBO.getListaSchedeConsegnaVerificazione(Integer.parseInt(idIntervento), session);
				
				request.getSession().setAttribute("schede_consegna", result);
				request.getSession().setAttribute("intervento", intervento);
				request.getSession().setAttribute("verificazione", 1);
		
				session.getTransaction().commit();
				session.close();	
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaSchedeConsegna.jsp");
		     	dispatcher.forward(request,response);
				
			}
	     	
		}catch(Exception ex) {
			
			 ex.printStackTrace();
    		 session.getTransaction().rollback();
    		 session.close();
    	     request.setAttribute("error",STIException.callException(ex));
       	     request.getSession().setAttribute("exception", ex);
    		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
    	     dispatcher.forward(request,response);	
			
		}
	}

}
