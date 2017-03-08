package it.portaleSTI.action;



import it.portaleSTI.DTO.PrenotazioneDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.bo.GestionePrenotazioniBO;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

/**
 * Servlet implementation class GestionePrenotazione
 */
@WebServlet(name="gestionePrenotazione" , urlPatterns = { "/gestionePrenotazione.do" })
public class GestionePrenotazione extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestionePrenotazione() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try
		{
		
		String result = request.getParameter("param");
		
		PrintWriter out = response.getWriter();

		String json = request.getParameter("dataIn");
		
		 JsonElement jelement = new JsonParser().parse(json);
		 
		 JsonObject  jobject = jelement.getAsJsonObject();
		
		
		 int idPrenotazione=Integer.parseInt(jobject.get("idPrenotazione").toString().replaceAll("\"", ""));
		 
		 String note =jobject.get("note").toString();
		
		 JsonObject myObj = new JsonObject();
		
		if (result.equals("app"))
		{

			PrenotazioneDTO prenotazione =GestionePrenotazioniBO.getPrenotazione(idPrenotazione);
			GestionePrenotazioniBO.updatePrenotazione(prenotazione,note ,1);
			
			myObj.addProperty("success", true);
	        out.println(myObj.toString());
	        
	        
		}
		else
		{
			 myObj.addProperty("success", true);
		     out.println(myObj.toString());
		}    
		out.close();
		}
		catch
		(Exception e) 
		{
			 e.printStackTrace();
    	     request.setAttribute("error",STIException.callException(e));
    		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
    	     dispatcher.forward(request,response);	
		}
	}

	

}
