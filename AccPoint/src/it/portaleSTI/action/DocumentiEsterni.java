package it.portaleSTI.action;

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

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.DocumentoCampioneDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneCampioneBO;
import it.portaleSTI.bo.GestioneStrumentoBO;

/**
 * Servlet implementation class documentiEsterni
 */
@WebServlet(name="documentiEsterni" , urlPatterns = { "/documentiEsterni.do" })
public class DocumentiEsterni extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DocumentiEsterni() {
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
		// TODO Auto-generated method stub
		if(Utility.validateSession(request,response,getServletContext()))return;
		Session session =SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		try {
			
			String action = request.getParameter("action");
			
			if(action==null || action.equals("")) {
			
			
			String idS = request.getParameter("id_str");
						
			StrumentoDTO strumento = GestioneStrumentoBO.getStrumentoById(idS, session);
			
			PrintWriter out = response.getWriter();
			
			 Gson gson = new Gson(); 
		        
			 JsonObject myObj = new JsonObject();

		        JsonElement obj = gson.toJsonTree(strumento.getListaDocumentiEsterni());
		       
		        myObj.addProperty("success", true);
		       
		        myObj.add("dataInfo", obj);

		        request.getSession().setAttribute("strumento",strumento);
		        request.getSession().setAttribute("myObj",myObj);

				 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/documentiEsterniStrumento.jsp");
			     dispatcher.forward(request,response);
			     
			     session.getTransaction().commit();
					session.close();
			}
			else if(action.equals("campioni")) {
				
				String idS = request.getParameter("id_str");
				
			//	CampioneDTO campione = GestioneCampioneDAO.getCampioneFromId(idS);
							
				 Gson gson = new Gson(); 
			        
				 JsonObject myObj = new JsonObject();
				 
				 ArrayList<DocumentoCampioneDTO> lista_documenti_esterni = GestioneCampioneBO.getListaDocumentiEsterni(Integer.parseInt(idS),session);

			        //JsonElement obj = gson.toJsonTree(campione.getListaDocumentiEsterni());
			       
			      //  myObj.addProperty("success", true);
			       
			       // myObj.add("dataInfo", obj);

			        //request.getSession().setAttribute("campione",campione);
				 request.getSession().setAttribute("lista_documenti_esterni",lista_documenti_esterni);
			        request.getSession().setAttribute("id_campione",idS);
			        session.close();
					 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/documentiEsterniCampione.jsp");
				     dispatcher.forward(request,response);
	   
						
			}
			else if(action.equals("documentazione_tecnica_campioni")) {
				
				String idS = request.getParameter("id_str");
				 
				 ArrayList<DocumentoCampioneDTO> lista_documentazione_tecnica = GestioneCampioneBO.getListaDocumentazioneTecnica(Integer.parseInt(idS),session);

				 request.getSession().setAttribute("lista_documentazione_tecnica",lista_documentazione_tecnica);
			        request.getSession().setAttribute("id_campione",idS);
			        session.close();
					 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/documentazioneTecnicaCampione.jsp");
				     dispatcher.forward(request,response);
	   
						
			}
			
			
		}catch(Exception ex)
    		{
			
			 session.getTransaction().rollback();
			 session.close();
			
	   		 ex.printStackTrace();
	   	     request.setAttribute("error",STIException.callException(ex));
	   	     request.getSession().setAttribute("exception",ex);
	   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
	   	     dispatcher.forward(request,response);	
	   	}  
 	}

}
