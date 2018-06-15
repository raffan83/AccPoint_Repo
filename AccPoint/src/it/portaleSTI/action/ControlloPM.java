package it.portaleSTI.action;

import it.portaleSTI.DTO.TipoMisuraDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.bo.GestioneStrumentoBO;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

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
 * Servlet implementation class ControlloPM
 */
@WebServlet(name="ControlloPM" , urlPatterns = { "/controlloPM.do" })
public class ControlloPM extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ControlloPM() {
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
		response.setContentType("text/html");
		
		 
		try {
			
			String tpS = request.getParameter("tpS");
			System.out.println("*********************"+tpS);
			 
			List<TipoMisuraDTO> listaTipiMisura = GestioneStrumentoBO.getTipiMisura(tpS);
		//	request.getSession().setAttribute("listaClienti",listaClienti);
			
		//	List<SedeDTO> listaSedi = GestioneListaStrumenti.getListaSedi();
		//	request.getSession().setAttribute("listaSedi",listaSedi);
			
		//	ArrayList<StrumentoDTO> strumenti= new ArrayList<StrumentoDTO>();
		//	request.getSession().setAttribute("listaStrumenti",strumenti);
		
			PrintWriter out = response.getWriter();
			
			 Gson gson = new Gson(); 
		        JsonObject myObj = new JsonObject();

		        JsonElement obj = gson.toJsonTree(listaTipiMisura);
		       
		        if(listaTipiMisura!=null && listaTipiMisura.size()>0){
		            myObj.addProperty("success", true);
		        }
		        else {
		            myObj.addProperty("success", false);
		        }
		        myObj.add("dataInfo", obj);
		        out.println(myObj.toString());
		        System.out.println(myObj.toString());
		        out.close();
		        
		//	response.getWriter().write("Ciao Mondo");
			
		//	RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaStrumenti.jsp");
	    // 	dispatcher.forward(request,response);
			
		}catch(Exception ex)
    	{
   		 ex.printStackTrace();
   	     request.setAttribute("error",STIException.callException(ex));
   	     request.getSession().setAttribute("exception",ex);
   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
   	     dispatcher.forward(request,response);	
   	}  
	}

}
