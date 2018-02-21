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

import org.hibernate.Query;
import org.hibernate.Session;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.SchedaConsegnaDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.Util.Utility;

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
		
		
		String idIntervento= request.getParameter("idIntervento");
		
				
		Query query  = session.createQuery( "from SchedaConsegnaDTO WHERE id_intervento= :_id");
		
		query.setParameter("_id", Integer.parseInt(idIntervento));
		List<SchedaConsegnaDTO> result =query.list();
		
		request.getSession().setAttribute("schede_consegna", result);

		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaSchedeConsegna.jsp");
     	dispatcher.forward(request,response);

	}

}
