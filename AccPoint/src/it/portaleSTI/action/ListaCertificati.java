package it.portaleSTI.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
		
		response.setContentType("text/html");
		
		try 
		{
			String action =request.getParameter("action");

			System.out.println("****"+action);

			
			RequestDispatcher dispatcher = null;
			if(action.equals("lista")){
				dispatcher = getServletContext().getRequestDispatcher("/site/listaCertificatiInLavorazione.jsp");
				
			}else if(action.equals("chiusi")){
				dispatcher = getServletContext().getRequestDispatcher("/site/listaCertificatiChiusi.jsp");
			}else{
				dispatcher = getServletContext().getRequestDispatcher("/site/listaCertificatiInLavorazione.jsp");
			}
			 
	     	dispatcher.forward(request,response);
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
	
	}

}
