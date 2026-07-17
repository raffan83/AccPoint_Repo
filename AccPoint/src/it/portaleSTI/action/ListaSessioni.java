package it.portaleSTI.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
import it.portaleSTI.DTO.SessioneDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneInterventoBO;
import it.portaleSTI.bo.GestioneSessioneBO;

/**
 * Servlet implementation class ListaStrumentiNew
 */
@WebServlet(name = "listaSessioni", urlPatterns = { "/listaSessioni.do" })
public class ListaSessioni extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaSessioni() {
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
			
			List<SessioneDTO> listaSessioni= new ArrayList<>();
			
			String anno=request.getParameter("year");
			int year=0;
			
			if(anno==null) {
				year = Calendar.getInstance().get(Calendar.YEAR);
			}else 
			{
				year=Integer.parseInt(anno);
			}
			
			
			listaSessioni = GestioneSessioneBO.getSessioni(year);
			
			request.getSession().setAttribute("listaSessioni",listaSessioni);
			request.getSession().setAttribute("current_year", year);
			request.getSession().setAttribute("yearList", Utility.getYearList());

			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaSessioni.jsp");
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
