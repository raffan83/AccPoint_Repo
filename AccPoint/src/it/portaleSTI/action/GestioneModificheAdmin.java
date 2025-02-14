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

import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.StatoCertificatoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.bo.GestioneCertificatoBO;
import it.portaleSTI.bo.GestioneModificheAdminBO;

/**
 * Servlet implementation class GestioneModificheAdmin
 */
@WebServlet("/gestioneModificheAdmin.do")
public class GestioneModificheAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneModificheAdmin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		String action = request.getParameter("action");

		
		JsonObject myObj = new JsonObject();
		boolean ajax = false;
		
		try {
			
			if(action==null) {
			
				
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneModificheAdmin.jsp");
		     	dispatcher.forward(request,response);
				
				
				
			}
			else if(action!=null && action.equals("ricerca")) {
				
				String tipo_ricerca = request.getParameter("tipo_ricerca");
				String id = request.getParameter("id");
				
				ArrayList<CertificatoDTO> lista = GestioneModificheAdminBO.getElementiRicerca(tipo_ricerca, id, session);
				
				request.getSession().setAttribute("lista", lista);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneModificheAdminTabella.jsp");
		     	dispatcher.forward(request,response);
			}
			
			else if(action!=null && action.equals("cambia_stato")) {
				
				ajax = true;
				
				String id_certificato = request.getParameter("id_certificato");
				
				CertificatoDTO certificato = GestioneCertificatoBO.getCertificatoById(id_certificato);
				certificato.setStato(new StatoCertificatoDTO(1));
				
				
				session.update(certificato);
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Salvato con successo!");
				
				PrintWriter out = response.getWriter();
	        	out.print(myObj);
				
			}
			
			
			
			
			session.getTransaction().commit();
        	session.close();
			
		}catch(Exception e) {
			
			session.getTransaction().rollback();
        	session.close();
			if(ajax) {
				
				PrintWriter out = response.getWriter();
				e.printStackTrace();
	        	
	        	request.getSession().setAttribute("exception", e);
	        	myObj = STIException.getException(e);
	        	out.print(myObj);
        	}else {
   			    			
    			e.printStackTrace();
    			request.setAttribute("error",STIException.callException(e));
    	  	     request.getSession().setAttribute("exception", e);
    			 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
    		     dispatcher.forward(request,response);	
        	}
			
		}
	}

}
