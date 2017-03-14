package it.portaleSTI.action;

import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.bo.GestioneInterventoBO;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class GestioneIntervento
 */
@WebServlet(name = "gestioneIntervento", urlPatterns = { "/gestioneIntervento.do" })
public class GestioneIntervento extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneIntervento() {
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
		
		try 
		{
			String idCommessa=request.getParameter("idCommessa");
			
			ArrayList<CommessaDTO> listaCommesse =(ArrayList<CommessaDTO>) request.getSession().getAttribute("listaCommesse");
			
			CommessaDTO comm=getCommessa(listaCommesse,idCommessa);
			
			request.getSession().setAttribute("commessa", comm);
			
			ArrayList<InterventoDTO> listaInterventi =GestioneInterventoBO.getListaCommesse(idCommessa);	
			
			request.getSession().setAttribute("listaInterventi", listaInterventi);
		
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneIntervento.jsp");
	     	dispatcher.forward(request,response);
		} 
		catch (Exception ex) {
			 ex.printStackTrace();
	   	     request.setAttribute("error",STIException.callException(ex));
	   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
	   	     dispatcher.forward(request,response);	
		}
		
	}

	private CommessaDTO getCommessa(ArrayList<CommessaDTO> listaCommesse,String idCommessa) {

		for (CommessaDTO comm : listaCommesse)
		{
			if(comm.getID_COMMESSA()==Integer.parseInt(idCommessa))
			return comm;
		}
			
		
		return null;
	}

}
