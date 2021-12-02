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

import org.hibernate.HibernateException;

import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneStrumentoBO;

/**
 * Servlet implementation class Scadenziario
 */

@WebServlet(name= "/ricercaDateStrumenti", urlPatterns = { "/ricercaDateStrumenti.do" })
public class RicercaDateStrumenti extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RicercaDateStrumenti() {
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
		
		try {
			List<TipoRapportoDTO> lista_tipo_rapporto = GestioneStrumentoBO.getListaTipoRapporto();
			
			
			request.getSession().setAttribute("lista_tipo_rapporto", lista_tipo_rapporto);
			
		
		
		
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/ricercaDateStrumenti.jsp");
	    dispatcher.forward(request,response);// TODO Auto-generated method stub
	    
		
		} catch (Exception e) {
			
			e.printStackTrace();
		}
	}

}
