package it.portaleSTI.action;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.Exception.STIException;



/**
 * Servlet implementation class GestioneVersionePortale
 */
@WebServlet("/gestioneLog.do")
public class GestioneLog extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneLog() {
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


//if(Utility.validateSession(request,response,getServletContext()))return;
		
		response.setContentType("text/html");
		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		JsonObject myObj = new JsonObject();
		boolean ajax = false;
//		String action = request.getParameter("action");
		
//		UtenteDTO utente=(UtenteDTO)request.getSession().getAttribute("userObj");
		
		try {
			
				
			  String filePath = "c:\\log\\status.log";
		        List<String> lines = new ArrayList<>();

		        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
		            String line;
		            while ((line = reader.readLine()) != null) {
		                lines.add(line);
		            }
		        }

		        Collections.reverse(lines);
		        request.setAttribute("lines", lines);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneLog.jsp");
		     	dispatcher.forward(request,response);
				
			
		}
			catch(Exception ex)
	    	{
				session.getTransaction().rollback();
	        	session.close();
				if(ajax) {
					PrintWriter out = response.getWriter();
					ex.printStackTrace();
		        	
		        	request.getSession().setAttribute("exception", ex);
		        	myObj = STIException.getException(ex);
		        	out.print(myObj);
	        	}else {
			   		ex.printStackTrace();
			   		request.setAttribute("error",STIException.callException(ex));
			   	    request.getSession().setAttribute("exception", ex);
			   		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/page/error.jsp");
			   	    dispatcher.forward(request,response);	
	        	}
	    	}  
	}
}
