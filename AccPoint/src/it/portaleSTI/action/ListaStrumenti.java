package it.portaleSTI.action;

import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.bo.GestioneListaStrumenti;

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

/**
 * Servlet implementation class listaStrumenti
 */
@WebServlet(name = "listaStrumenti", urlPatterns = { "/listaStrumenti.do" })

public class ListaStrumenti extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaStrumenti() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		 
		try {
			List<ClienteDTO> listaClienti = GestioneListaStrumenti.getListaClienti();
			request.getSession().setAttribute("listaClienti",listaClienti);
			
			List<SedeDTO> listaSedi = GestioneListaStrumenti.getListaSedi();
			request.getSession().setAttribute("listaSedi",listaSedi);
			
			ArrayList<StrumentoDTO> strumenti= new ArrayList<StrumentoDTO>();
			request.getSession().setAttribute("listaStrumenti",strumenti);
			
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaStrumenti.jsp");
	     	dispatcher.forward(request,response);
			
		} catch (HibernateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
     	
	}

}
