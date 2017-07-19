package it.portaleSTI.action;

import it.portaleSTI.DAO.GestioneAccessoDAO;
import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.GestioneTLDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.PermessoDTO;
import it.portaleSTI.DTO.RuoloDTO;
import it.portaleSTI.DTO.TipoCampioneDTO;
import it.portaleSTI.DTO.TipoGrandezzaDTO;
import it.portaleSTI.DTO.UnitaMisuraDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneRuoloBO;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

/**
 * Servlet implementation class listaCampioni
 */
@WebServlet(name="listaUtenti" , urlPatterns = { "/listaUtenti.do" })

public class ListaUtenti extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaUtenti() {
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
		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		response.setContentType("text/html");
		
		try 
		{
			
			String idRuolo = request.getParameter("idRuolo");
			if(idRuolo != null && !idRuolo.equals("")){

				ArrayList<UtenteDTO> listaUtenti =  (ArrayList<UtenteDTO>) GestioneAccessoDAO.getListUser();
		        RuoloDTO ruolo = GestioneRuoloBO.getRuoloById(idRuolo, session);

		        request.getSession().setAttribute("listaUtenti",listaUtenti);
		        request.getSession().setAttribute("idRuolo",idRuolo);
		        request.getSession().setAttribute("ruolo",ruolo);

				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaUtentiAssociazione.jsp");
		     	dispatcher.forward(request,response);
			}else{
				ArrayList<UtenteDTO> listaUtenti =  (ArrayList<UtenteDTO>) GestioneAccessoDAO.getListUser();
				ArrayList<CompanyDTO> listaCompany =  (ArrayList<CompanyDTO>) GestioneAccessoDAO.getListCompany();
				ArrayList<RuoloDTO> listaRuoli =  (ArrayList<RuoloDTO>) GestioneAccessoDAO.getListRole();
				
				request.getSession().setAttribute("listaRuoli",listaRuoli);
		        request.getSession().setAttribute("listaUtenti",listaUtenti);
		        request.getSession().setAttribute("listaCompany",listaCompany);


				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaUtenti.jsp");
		     	dispatcher.forward(request,response);
			}
			   session.getTransaction().commit();
				session.close();
			
			
		} 
		catch (Exception ex) {
			
		//	ex.printStackTrace();
			   session.getTransaction().commit();
				session.close();
		     request.setAttribute("error",STIException.callException(ex));
			 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
		     dispatcher.forward(request,response);
		}
	
	}

}
