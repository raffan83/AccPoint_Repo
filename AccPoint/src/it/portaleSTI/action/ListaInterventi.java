package it.portaleSTI.action;

import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneStrumentoBO;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		 
		try {
			
			CompanyDTO cmp=(CompanyDTO)request.getSession().getAttribute("usrCompany");

			String idCompany=""+cmp.getId();
			
			List<ClienteDTO> listaClienti = GestioneStrumentoBO.getListaClientiNew(idCompany);
			request.getSession().setAttribute("listaClienti",listaClienti);
			
			List<SedeDTO> listaSedi = GestioneStrumentoBO.getListaSediNew();
			request.getSession().setAttribute("listaSedi",listaSedi);


			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaInterventi.jsp");
	     	dispatcher.forward(request,response);
			
		}
		catch(Exception ex)
    	{
   		 ex.printStackTrace();
   	     request.setAttribute("error",STIException.callException(ex));
   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
   	     dispatcher.forward(request,response);	
   	}  
     	
	}

}