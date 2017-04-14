package it.portaleSTI.action;

import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.InterventoDTO;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class GestioneInterventoDati
 */
@WebServlet(name = "gestioneInterventoDati", urlPatterns = { "/gestioneInterventoDati.do" })
public class GestioneInterventoDati extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneInterventoDati() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String idIntervento=request.getParameter("idIntervento");
		
		ArrayList<InterventoDTO> listaInterventi=(ArrayList<InterventoDTO>) request.getSession().getAttribute("listaInterventi");
		
		InterventoDTO intervento=getIntervento(listaInterventi,idIntervento);
		
		request.getSession().setAttribute("intervento", intervento);
	
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneInterventoDati.jsp");
     	dispatcher.forward(request,response);
     	
	}

	private InterventoDTO getIntervento(ArrayList<InterventoDTO> listaInterventi,String idIntervento) {
		
		for (InterventoDTO intervento: listaInterventi)
		{
			if(intervento.getId()==Integer.parseInt(idIntervento))
				return intervento;
		}
		return null;
	}

}
