package it.portaleSTI.action;

import java.beans.Introspector;
import java.beans.PropertyDescriptor;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Field;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.JsonObject;

import atg.taglib.json.util.JSONArray;
import atg.taglib.json.util.JSONException;
import atg.taglib.json.util.JSONObject;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;

@WebServlet(name="gestioneTabelleMagazzino" , urlPatterns = { "/gestioneTabelleMagazzino.do" })
@MultipartConfig
public class GestioneTabelleMagazzino extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneTabelleMagazzino() {
        super();
        // TODO Auto-generated constructor stub
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
 
      	try {
		    	JSONObject jo = new JSONObject();
		  
					jo.put("firstName", "John");
				
		    	jo.put("lastName", "Doe");
		
		    	JSONArray listaTabelle = new JSONArray();
		    	listaTabelle.put(jo);
		    	listaTabelle.put(jo);
		    	listaTabelle.put(jo);
		  
	
	    	
	    		request.getSession().setAttribute("listaTabelle",listaTabelle);
	 
	
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneTabelle.jsp");
	     	dispatcher.forward(request,response);
      	} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    		
    		if(Utility.validateSession(request,response,getServletContext()))return;
		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		PrintWriter out = response.getWriter();
		JsonObject myObj = new JsonObject();
   
        response.setContentType("application/json");
        try{
        	
        	
        		Object obj = request.getSession().getAttribute("userObj");
        	   
        		Field[]  campi = obj.getClass().getDeclaredFields();
                 String[] campiStringa = new String[campi.length];
              
                 for (int i = 0; i < campi.length; i++) 
                 {
                     System.out.println(campi[i].getType().toString());
                 }
                 
                 for(PropertyDescriptor propertyDescriptor : 
                     Introspector.getBeanInfo(obj.getClass()).getPropertyDescriptors()){

                     // propertyEditor.getReadMethod() exposes the getter
                     // btw, this may be null if you have a write-only property
                     System.out.println(propertyDescriptor.getReadMethod());
                 }
        	
        }catch(Exception ex)
    		{
	      	ex.printStackTrace();
	        	session.getTransaction().rollback();
	        	session.close();
	        	request.getSession().setAttribute("exception", ex);
	        	//myObj.addProperty("success", false);
	        	//myObj.addProperty("messaggio", STIException.callException(ex).toString());
	        	//out.println(myObj.toString());
	        	myObj = STIException.getException(ex);
	        	out.print(myObj);
   	}  
    	
    	
    }
}
