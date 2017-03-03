package it.portaleSTI.action;

import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneListaStrumenti;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.HibernateException;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

/**
 * Servlet implementation class ListaStrumentiSede
 */
@WebServlet(name= "/listaStrumentiSede", urlPatterns = { "/listaStrumentiSede.do" })
public class ListaStrumentiSede extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaStrumentiSede() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.checkSession(request,response,getServletContext()))return;
		
		response.setContentType("text/html");
		
		 
		try {
			
			String sede = request.getParameter("idSede");
			
			if(sede!=null && sede.length()>0)
			{
				String[] tmp=sede.split("_");
			
				CompanyDTO idCompany=(CompanyDTO)request.getSession().getAttribute("usrCompany");
				
				if(idCompany!=null)
				{
				ArrayList<StrumentoDTO> listaStrumentiPerSede=(ArrayList<StrumentoDTO>)GestioneListaStrumenti.getListaStrumentiPerSediAttivi(tmp[0],idCompany.getId()); 

				request.getSession().setAttribute("listaStrumenti", listaStrumentiPerSede);
				PrintWriter out = response.getWriter();
			
				Gson gson = new Gson(); 
		        JsonObject myObj = new JsonObject();

		        JsonElement obj = gson.toJsonTree(listaStrumentiPerSede);
		       
		        if(listaStrumentiPerSede!=null && listaStrumentiPerSede.size()>0){
		            myObj.addProperty("success", true);
		        }
		        else {
		            myObj.addProperty("success", false);
		        }
		        myObj.add("dataInfo", obj);
		        out.println(myObj.toString());
		        System.out.println("obj send");
		        out.close();
				} 
			}    
		}catch(Exception ex)
    	{
   		 ex.printStackTrace();
   	     request.setAttribute("error",STIException.callException(ex));
   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
   	     dispatcher.forward(request,response);	
   	}  
	}

}
