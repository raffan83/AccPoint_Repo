package it.portaleSTI.action;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.portaleSTI.Util.Utility;

/**
 * Servlet implementation class GestionePacco
 */
@WebServlet("/gestionePacco.do")
public class GestionePacco extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestionePacco() {
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
		
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		
		String id_cliente = request.getParameter("select1");
		String id_sede = request.getParameter("select2");
		String codice_pacco = request.getParameter("codice_pacco");
		String ddt = request.getParameter("ddt");
		
		
		
	}

}
