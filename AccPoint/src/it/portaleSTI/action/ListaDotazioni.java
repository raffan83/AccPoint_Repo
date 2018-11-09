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
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.DotazioneDTO;
import it.portaleSTI.DTO.TipologiaDotazioniDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneDotazioneBO;

/**
 * Servlet implementation class listaCampioni
 */
@WebServlet(name="listaDotazioni" , urlPatterns = { "/listaDotazioni.do" })

public class ListaDotazioni extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaDotazioni() {
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

			ArrayList<DotazioneDTO> listaDotazioni =  (ArrayList<DotazioneDTO>) GestioneDotazioneBO.getListaDotazioni(cmp,session);
			ArrayList<TipologiaDotazioniDTO> listaTipologieDotazioni =  (ArrayList<TipologiaDotazioniDTO>) GestioneDotazioneBO.getListaTipologieDotazioni(session);


	        request.getSession().setAttribute("listaDotazioni",listaDotazioni);
	        request.getSession().setAttribute("listaTipologieDotazioni",listaTipologieDotazioni);

			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaDotazioni.jsp");
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
