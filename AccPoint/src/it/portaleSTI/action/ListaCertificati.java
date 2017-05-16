package it.portaleSTI.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.StatoCertificatoDTO;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneCertificatoBO;

/**
 * Servlet implementation class listaCampioni
 */
@WebServlet(name="listaCertificati" , urlPatterns = { "/listaCertificati.do" })

public class ListaCertificati extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaCertificati() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;

		response.setContentType("text/html");
		
		try 
		{
			String action =request.getParameter("action");

			System.out.println("****"+action);

			
			RequestDispatcher dispatcher = null;
			ArrayList<CertificatoDTO> listaCertificati = null;
			if(action.equals("lavorazione")){
				listaCertificati = GestioneCertificatoBO.getListaCertificato(new StatoCertificatoDTO(1,""), null);
				request.getSession().setAttribute("listaCertificati",listaCertificati);
				dispatcher = getServletContext().getRequestDispatcher("/site/listaCertificatiInLavorazione.jsp");
				
			}else if(action.equals("chiusi")){
				listaCertificati = GestioneCertificatoBO.getListaCertificato(new StatoCertificatoDTO(2,""), null);
				request.getSession().setAttribute("listaCertificati",listaCertificati);
				dispatcher = getServletContext().getRequestDispatcher("/site/listaCertificatiChiusi.jsp");
			}else if(action.equals("annullati")){
				listaCertificati = GestioneCertificatoBO.getListaCertificato(new StatoCertificatoDTO(3,""), null);
				request.getSession().setAttribute("listaCertificati",listaCertificati);
				dispatcher = getServletContext().getRequestDispatcher("/site/listaCertificatiAnnullati.jsp");
			}
			 
	     	dispatcher.forward(request,response);
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
	
	}

}
