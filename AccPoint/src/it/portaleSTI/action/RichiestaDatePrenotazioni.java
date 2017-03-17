package it.portaleSTI.action;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;


/**
 * Servlet implementation class Scadenziario_create
 */
@WebServlet(name="RichiestaDatePrenotazioni" , urlPatterns = { "/richiestaDatePrenotazioni.do" })

public class RichiestaDatePrenotazioni extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RichiestaDatePrenotazioni() {
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
		
		try
		{

		String idC = request.getParameter("idCamp");

		PrintWriter out = response.getWriter();

		
		//TO-DO
		//RESTITUIRE JSON CON LE DATE DI INZIO E FINE PRENOTAZIONE NEL FORMATO 
		 Gson gson = new Gson(); 
	        JsonObject myObj = new JsonObject();

	        JsonParser jsonParser = new JsonParser();

	        JsonElement jsonElement = jsonParser.parse("{dataInfo:[{title:'prenotato',start:'2017-03-05',end:'2017-03-07',overlap:false,editable:false},{title:'prenotato',start:'2017-03-15',end:'2017-03-17',overlap:false,editable:false},{title:'prenotato',start:'2017-03-25',end:'2017-03-27',overlap:false,editable:false},{title:'prenotato',start:'2017-03-19',end:'2017-03-22',overlap:false,editable:false}]}");

	         myObj.addProperty("success", true);
	  
	        myObj.add("dataInfo", jsonElement); 

	        
	        System.out.println(myObj.toString());
	       
	        out.println(myObj.toString());

	        out.close();
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
