package it.portaleSTI.action;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;

/**
 * Servlet implementation class listaCampioni
 */
@WebServlet(name="inserisciOfferta" , urlPatterns = { "/inserisciOfferta.do" })

public class InserimentoOffertaMilestone extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InserimentoOffertaMilestone() {
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
		
	//	if(Utility.validateSession(request,response,getServletContext()))return;

		
	String action = request.getParameter("action");	 
		try {
			
			
			
			
 
		    if(action== null) {
		    	RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/inserisciOfferta.jsp");
		     	dispatcher.forward(request,response);
		    }else if (action.equals("inserisci")){
		    	StringBuilder sb = new StringBuilder();
			    BufferedReader reader = request.getReader();
			    String line;

			    while ((line = reader.readLine()) != null) {
			        sb.append(line);
			    }
			    JsonObject myObj = new JsonObject();
			    String  requestBody = sb.toString();
			    
			    Gson gson = new Gson();
			    Map<String, Object> data = gson.fromJson(requestBody, Map.class);
			   
			     myObj.addProperty("result", requestBody);
			     PrintWriter out = response.getWriter();
			        
			     out.print(myObj);
			    
		    }
		} 
		catch(Exception ex)
    	{
			
			
   		 	ex.printStackTrace();
   		 	request.getSession().setAttribute("exception",ex);
   	     	request.setAttribute("error",STIException.callException(ex));
   		 	RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
   	     	dispatcher.forward(request,response);	
    	} 
	
	}

}
