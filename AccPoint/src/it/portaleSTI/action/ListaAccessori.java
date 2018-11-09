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

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.AccessorioDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.TipologiaAccessoriDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAccessorioBO;

/**
 * Servlet implementation class listaCampioni
 */
@WebServlet(name="listaAccessori" , urlPatterns = { "/listaAccessori.do" })

public class ListaAccessori extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaAccessori() {
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
			
				CompanyDTO cmp=(CompanyDTO)request.getSession().getAttribute("usrCompany");
				ArrayList<AccessorioDTO> listaAccessori =  (ArrayList<AccessorioDTO>) GestioneAccessorioBO.getListaAccessori(cmp,session);
				ArrayList<TipologiaAccessoriDTO> listaTipologieAccessori =  (ArrayList<TipologiaAccessoriDTO>) GestioneAccessorioBO.getListaTipologieAccessori(session);
	
		 
		        request.getSession().setAttribute("listaAccessori",listaAccessori);
		        request.getSession().setAttribute("listaTipologieAccessori",listaTipologieAccessori);

				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaAccessori.jsp");
		     	dispatcher.forward(request,response);
			
			session.getTransaction().commit();
			session.close();
		} 
		catch (Exception ex) {
			
		//	ex.printStackTrace();
			   session.getTransaction().commit();
				session.close();
		     request.setAttribute("error",STIException.callException(ex));
		     request.getSession().setAttribute("exception", ex);
			 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
		     dispatcher.forward(request,response);
		}
	
	}

}
