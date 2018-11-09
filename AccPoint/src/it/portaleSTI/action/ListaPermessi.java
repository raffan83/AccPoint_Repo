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

import it.portaleSTI.DAO.GestioneAccessoDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.PermessoDTO;
import it.portaleSTI.DTO.RuoloDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneRuoloBO;

/**
 * Servlet implementation class listaCampioni
 */
@WebServlet(name="listaPermessi" , urlPatterns = { "/listaPermessi.do" })

public class ListaPermessi extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaPermessi() {
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
		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		response.setContentType("text/html");
		
		try 
		{
			String idRuolo = request.getParameter("idRuolo");
			if(idRuolo != null && !idRuolo.equals("")){

				ArrayList<PermessoDTO> listaPermessi =  (ArrayList<PermessoDTO>) GestioneAccessoDAO.getListPermission();
		        RuoloDTO ruolo = GestioneRuoloBO.getRuoloById(idRuolo, session);

		        request.getSession().setAttribute("listaPermessi",listaPermessi);
		        request.getSession().setAttribute("idRuolo",idRuolo);
		        request.getSession().setAttribute("ruolo",ruolo);

				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaPermessiAssociazione.jsp");
		     	dispatcher.forward(request,response);
			}else{
				ArrayList<PermessoDTO> listaPermessi =  (ArrayList<PermessoDTO>) GestioneAccessoDAO.getListPermission();
		        request.getSession().setAttribute("listaPermessi",listaPermessi);

				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaPermessi.jsp");
		     	dispatcher.forward(request,response);
			}
			   session.getTransaction().commit();
				session.close();
			
		} 
		catch (Exception ex) {
			 session.getTransaction().commit();
				session.close();
		//	ex.printStackTrace();
		     request.setAttribute("error",STIException.callException(ex));
	   	     request.getSession().setAttribute("exception", ex);
			 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
		     dispatcher.forward(request,response);
		}
	
	}

}
