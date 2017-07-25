package it.portaleSTI.action;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneStrumentoBO;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

/**
 * Servlet implementation class DettaglioStrumento
 */

@WebServlet(name="dettaglioStrumentoFull" , urlPatterns = { "/dettaglioStrumentoFull.do" })
public class DettaglioStrumentoFull extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DettaglioStrumentoFull() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if (request.getSession().getAttribute("userObj")==null ) {
			request.getSession().setAttribute("urlStatico", "/dettaglioStrumentoFull.do?id_str="+request.getParameter("id_str"));
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/index.jsp");
            dispatcher.forward(request,response);
		}else {
			doPost(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if(Utility.validateSession(request,response,getServletContext()))return;
		Session session =SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		try
		{

		String idS = request.getParameter("id_str");

		 
		//ArrayList<StrumentoDTO> listaStrumenti = (ArrayList<StrumentoDTO>)request.getSession().getAttribute("listaStrumenti");
		
		
		StrumentoDTO dettaglio = GestioneStrumentoBO.getStrumentoById(idS, session);
		
		//StrumentoDTO dettaglio =getDettaglio(listaStrumenti,idS);
	
		PrintWriter out = response.getWriter();
		
		 Gson gson = new Gson(); 
	        JsonObject myObj = new JsonObject();

	        JsonElement obj = gson.toJsonTree(dettaglio);
	       

	            myObj.addProperty("success", true);
	       
	        myObj.add("dataInfo", obj);
//	        out.println(myObj.toString());
//	        System.out.println(myObj.toString());
//	        out.close();
	        
	        request.getSession().setAttribute("myObj",myObj);

			 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioStrumentoFull.jsp");
		     dispatcher.forward(request,response);
		     
		     session.getTransaction().commit();
				session.close();
				
	        
		}catch(Exception ex)
    	{
			
			 session.getTransaction().rollback();
			 session.close();
			
   		 ex.printStackTrace();
   	     request.setAttribute("error",STIException.callException(ex));
   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
   	     dispatcher.forward(request,response);	
   	}  
	}
	
	

	private StrumentoDTO getDettaglio(ArrayList<StrumentoDTO> listaStrumenti,String idS) {
		StrumentoDTO strumento =null;
		
		try
		{
		
		
		
		for (int i = 0; i < listaStrumenti.size(); i++) {
			
			if(listaStrumenti.get(i).get__id()==Integer.parseInt(idS))
			{
				return listaStrumenti.get(i);
			}
		}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			strumento=null;
			
		}
		return strumento;
	}

}
