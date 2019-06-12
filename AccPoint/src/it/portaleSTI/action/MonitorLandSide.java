package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.hibernate.Session;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;

import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;

/**
 * Servlet implementation class MonitorLandSide
 */
@WebServlet(name = "MonitorLandslide", urlPatterns = { "/monitorLandslide.do" })
public class MonitorLandSide extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MonitorLandSide() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		String action = request.getParameter("action");
		
		JsonObject myObj = new JsonObject();
		boolean ajax = false;
        response.setContentType("application/json");
		try {
			
			if(action==null) {
				
				String toRead = "1 2 3 4 5 6";
				
				Client client = ClientBuilder.newClient();

				 WebTarget target = client.target("http://localhost:8080/ServiceMonitorLandide/rest/monitor");

				 
			     
			    
				     Response response1 = target.request().post(Entity.entity("", MediaType.APPLICATION_JSON));
				     System.out.println("Response code: " + response1.getStatus());
				     
				     if(response1.getStatus() == 200) 
				     {
				    	  // aggiorna sul db i dati dell'utente
							String s = response1.readEntity(String.class);
							JSONParser parser = new JSONParser(); 
							
							Object obj = parser.parse(s);
							JSONObject jsonObj = (JSONObject) obj;
							
							String accessToken = (String) jsonObj.get("serialRead");
							
							toRead=accessToken;
							
				     }
				
				
				session.close();
				
				request.getSession().setAttribute("toRead", toRead);
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/monitorLandslide.jsp");
		  	    dispatcher.forward(request,response);
		  	    
		  	    
			}	
		
	}catch (Exception e) {
			session.getTransaction().rollback();
        	session.close();
			if(ajax) {
				PrintWriter out = response.getWriter();
				e.printStackTrace();
	        	
	        	request.getSession().setAttribute("exception", e);
	        	myObj = STIException.getException(e);
	        	out.print(myObj);
        	}else {
   			    			
    			e.printStackTrace();
    			request.setAttribute("error",STIException.callException(e));
    	  	     request.getSession().setAttribute("exception", e);
    			 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
    		     dispatcher.forward(request,response);	
        	}
		}
	}
}
