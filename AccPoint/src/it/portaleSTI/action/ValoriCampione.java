package it.portaleSTI.action;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DTO.ValoreCampioneDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

/**
 * Servlet implementation class ValoriCampione
 */
@WebServlet(name= "/valoriCampione", urlPatterns = { "/valoriCampione.do" })

public class ValoriCampione extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ValoriCampione() {
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
		
		String idCmp = request.getParameter("idCamp");
		
		try
		{
	    ArrayList<ValoreCampioneDTO> listaVCP = GestioneCampioneDAO.getListaValori(Integer.parseInt(idCmp));
	    
		
		
		 Gson gson = new Gson(); 
	        JsonObject myObj = new JsonObject();

	        JsonElement obj = gson.toJsonTree(listaVCP);
	       

	            myObj.addProperty("success", true);
	       
	        myObj.add("dataInfo", obj);
	        
	        request.getSession().setAttribute("myObjValoriCampione",myObj);
	        request.getSession().setAttribute("idCamp",idCmp);

			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/valoriCampione.jsp");
		    dispatcher.forward(request,response);
	        

				
	}catch(Exception ex)
	{
		 ex.printStackTrace();
	     request.setAttribute("error",STIException.callException(ex));
		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
	     dispatcher.forward(request,response);	
	}  

	}
  }
