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
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneCertificatoBO;

/**
 * Servlet implementation class listaCampioni
 */
@WebServlet(name="listaCertificati" , urlPatterns = { "/listaCertificati.do" })

public class ListaCertificati extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaCertificati() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;

		Session session =SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		response.setContentType("text/html");
		JsonObject myObj = new JsonObject();
		PrintWriter out = response.getWriter();
		
		try 
		{
			String action =request.getParameter("action");

			System.out.println("****"+action);

			
			RequestDispatcher dispatcher = null;
			ArrayList<CertificatoDTO> listaCertificati = null;
			if(action.equals("lavorazione")){
				listaCertificati = GestioneCertificatoBO.getListaCertificato(new StatoCertificatoDTO(1), null);
				request.getSession().setAttribute("listaCertificati",listaCertificati);
				dispatcher = getServletContext().getRequestDispatcher("/site/listaCertificatiInLavorazione.jsp");
		     	dispatcher.forward(request,response);

				
			}else if(action.equals("chiusi")){
				listaCertificati = GestioneCertificatoBO.getListaCertificato(new StatoCertificatoDTO(2), null);
				request.getSession().setAttribute("listaCertificati",listaCertificati);
				dispatcher = getServletContext().getRequestDispatcher("/site/listaCertificatiChiusi.jsp");
		     	dispatcher.forward(request,response);

			}else if(action.equals("annullati")){
				listaCertificati = GestioneCertificatoBO.getListaCertificato(new StatoCertificatoDTO(3), null);
				request.getSession().setAttribute("listaCertificati",listaCertificati);
				dispatcher = getServletContext().getRequestDispatcher("/site/listaCertificatiAnnullati.jsp");
		     	dispatcher.forward(request,response);

			}else if(action.equals("creaCertificato")){

				String idCertificato = request.getParameter("idCertificato");
				
				GestioneCertificatoBO.createCertificato(idCertificato,session);

					myObj.addProperty("success", true);
					myObj.addProperty("message", "Misura Approvata, il certificato è stato genereato con successo");
			        out.println(myObj.toString());
			        
			       session.getTransaction().commit();
			       session.close();
			}
			 
		} 
		catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
			session.close();
			myObj.addProperty("success", false);
			myObj.addProperty("message", "Errore generazione certificato: "+e.getMessage());
		}
	
	}

}
