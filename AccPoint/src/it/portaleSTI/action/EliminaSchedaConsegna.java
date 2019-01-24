package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneSchedaConsegnaBO;

/**
 * Servlet implementation class EliminaSchedaConsegna
 */
@WebServlet("/eliminaSchedaConsegna.do")
public class EliminaSchedaConsegna extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EliminaSchedaConsegna() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		
		JsonObject jsono = new JsonObject();
		PrintWriter writer = response.getWriter();
		
		response.setContentType("application/json");
		String id = request.getParameter("id_scheda");
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();		
		
		try {
			id = Utility.decryptData(id);
			
		boolean esito= GestioneSchedaConsegnaBO.deleteScheda(Integer.parseInt(id), session);
				
		session.getTransaction().commit();
		session.close();	
		
		
		if(esito==true) {
			jsono.addProperty("success", true);
			jsono.addProperty("messaggio", "Eliminazione riuscita!");
		}else {
			jsono.addProperty("success", false);
			jsono.addProperty("messaggio", "Eliminazione non riuscita!");
		}
		
		
		writer.write(jsono.toString());
		writer.close();
		
		}catch(Exception e) {
			
			e.printStackTrace();
			session.getTransaction().rollback();
			session.close();
			request.getSession().invalidate();

			request.getSession().setAttribute("exception", e);
			//jsono.addProperty("success", false);
			//jsono.addProperty("messaggio", "Errore salvataggio! "+e.getMessage());
			jsono = STIException.getException(e);
			writer.println(jsono.toString());
			writer.close();
		}
	}

}
