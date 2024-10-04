package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.map.HashedMap;
import org.apache.log4j.Logger;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DTO.ControlloOreDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;

/**
 * Servlet implementation class GestioneOreScaricate
 */
@WebServlet("/gestioneOreScaricate.do")
public class GestioneOreScaricate extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	static final Logger logger = Logger.getLogger(GestioneOreScaricate.class);
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneOreScaricate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if (request.getSession().getAttribute("userObj")==null ) {
			request.getSession().setAttribute("urlStatico", "/gestioneOreScaricate.do?action=lista");
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/index.jsp");
            dispatcher.forward(request,response);
		}else {
			doPost(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		try {
			
			
	
			String action = request.getParameter("action");
			
			if(action!=null && action.equals("lista")) {
				
				String global = request.getParameter("global");
				ArrayList<ControlloOreDTO> listaOre = DirectMySqlDAO.getOrePrevisteOreScaricate();
				Map<String, String> orePrevisteTotati = DirectMySqlDAO.getOrePrevisteTotali();
				
				Map<String, String> map = new HashMap<String, String>();
				
				for(int y=0;y<listaOre.size();y++) 
				{
			     String id_commessa=listaOre.get(y).getId_commessa();
				 String oreTotali= 	orePrevisteTotati.get(id_commessa);
				 
				 if(oreTotali!=null) 
				 {
					listaOre.get(y).setId_commessa(id_commessa+"("+oreTotali+")"); 
				 }
				
				}
				
				
				for (int i=0;i<listaOre.size();i++) {
					if(listaOre.get(i).getGlb_fase()!=null && map.containsKey(listaOre.get(i).getGlb_fase()) && listaOre.get(i).getDuplicato()!=1) {
						for (int j=0;j<listaOre.size();j++) {
							if(listaOre.get(j).getGlb_fase()!=null && listaOre.get(j).getGlb_fase().equals(listaOre.get(i).getGlb_fase())) {
								listaOre.get(j).setDuplicato(1);
							}
						}
					}else {
						map.put(listaOre.get(i).getGlb_fase(), listaOre.get(i).getGlb_fase());
					}
				}
				
				request.getSession().setAttribute("listaOre", listaOre);
				request.getSession().setAttribute("global", global);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaOreScaricate.jsp");
		     	dispatcher.forward(request,response);
				
			}

		}catch(Exception e) {
			
		
   			    			
    			e.printStackTrace();
    			request.setAttribute("error",STIException.callException(e));
    	  	     request.getSession().setAttribute("exception", e);
    			 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
    		     dispatcher.forward(request,response);	
        
			
		}
	}

}
