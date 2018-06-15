package it.portaleSTI.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.portaleSTI.Exception.STIException;

/**
 * Servlet implementation class VisualizzaReport
 */
@WebServlet("/visualizzaReport.do")
public class VisualizzaReport extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public VisualizzaReport() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		Exception e = (Exception)request.getSession().getAttribute("exception");
		
		request.setAttribute("error",STIException.callException(e));
		request.getSession().setAttribute("exception", e);
		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
	     dispatcher.forward(request,response);
		
	}

}
