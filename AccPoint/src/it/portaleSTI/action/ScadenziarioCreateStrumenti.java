package it.portaleSTI.action;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneStrumentoBO;

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
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;


/**
 * Servlet implementation class Scadenziario_create
 */
@WebServlet(name="ScadenziarioCreateStrumenti" , urlPatterns = { "/ScadenziarioCreateStrumenti.do" })

public class ScadenziarioCreateStrumenti extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ScadenziarioCreateStrumenti() {
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
		CompanyDTO cmp=(CompanyDTO)request.getSession().getAttribute("usrCompany");
		
		ArrayList<HashMap<String,String>> listaStrumenti = GestioneStrumentoBO.getListaStrumentiScadenziario();

		
		ArrayList<String> lista = new ArrayList<>();
		for (HashMap<String, String> hashMap : listaStrumenti) {
			 Iterator it = hashMap.entrySet().iterator();
			 	String numeroStrumenti="";
			 	String dataprossimaverifica="";
			    while (it.hasNext()) {
			        Map.Entry pair = (Map.Entry)it.next();
			        if(pair.getKey().equals("numerostrumenti")) {
			        	     numeroStrumenti =  ""+pair.getValue();
			        }
			        if(pair.getKey().equals("dataprossimaverifica")) {
			        		dataprossimaverifica =  ""+pair.getValue();
			        }
			        
			        it.remove(); 
			    }
			    lista.add(dataprossimaverifica + ";" + numeroStrumenti);
		}
		
		
		
		
		
		PrintWriter out = response.getWriter();
		
		 Gson gson = new Gson(); 
	        JsonObject myObj = new JsonObject();

	        JsonElement obj = gson.toJsonTree(lista);
	       
	       
	            myObj.addProperty("success", true);
	  
	        myObj.add("dataInfo", obj); 
	        
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
