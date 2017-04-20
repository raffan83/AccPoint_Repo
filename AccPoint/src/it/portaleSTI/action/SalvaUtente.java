package it.portaleSTI.action;



import it.portaleSTI.DAO.GestioneAccessoDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.PrenotazioneDTO;
import it.portaleSTI.DTO.StatoPrenotazioneDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.bo.GestionePrenotazioniBO;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

/**
 * Servlet implementation class GestionePrenotazione
 */
@WebServlet(name="salvaUtente" , urlPatterns = { "/salvaUtente.do" })
public class SalvaUtente extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SalvaUtente() {
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

			UtenteDTO utente = (UtenteDTO)request.getSession().getAttribute("userObj");
			utente.setIndirizzo(jobject.get("indirizzoUsr").getAsString());
			utente.setComune(jobject.get("comuneUsr").getAsString());
			utente.setCap(jobject.get("capUsr").getAsString());
			utente.setEMail(jobject.get("emailUsr").getAsString());
			utente.setTelefono(jobject.get("telUsr").getAsString());
			GestioneAccessoDAO.updateUser(utente);

			request.getSession().setAttribute("userObj", utente);
			
		 	
		 	JsonObject myObj = new JsonObject();

		 	myObj.addProperty("success", true);
			out.println(myObj.toString());
		   
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
