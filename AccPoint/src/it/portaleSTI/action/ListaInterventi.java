package it.portaleSTI.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneInterventoBO;

/**
 * Servlet implementation class ListaStrumentiNew
 */
@WebServlet(name = "listaInterventi", urlPatterns = { "/listaInterventi.do" })
public class ListaInterventi extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaInterventi() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
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
		
		try {
			
			CompanyDTO cmp=(CompanyDTO)request.getSession().getAttribute("usrCompany");
			UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
			
			List<ClienteDTO> listaClientiInterventi = GestioneInterventoBO.getListaClientiInterventi(session,utente,cmp);
		
			
			request.getSession().setAttribute("listaClienti",listaClientiInterventi);
					
			
			List<SedeDTO> listaSediInterventi =GestioneInterventoBO.getListaSediInterventi(session); 
			
			request.getSession().setAttribute("listaSedi",listaSediInterventi);


			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaInterventi.jsp");
	     	dispatcher.forward(request,response);
	     	
			session.getTransaction().commit();
			session.close();
	     	
		}
		catch(Exception ex)
    	{
			
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
