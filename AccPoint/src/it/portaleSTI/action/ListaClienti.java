package it.portaleSTI.action;

import it.portaleSTI.DAO.GestioneAccessoDAO;
import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.GestioneTLDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.PermessoDTO;
import it.portaleSTI.DTO.RuoloDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.TipoCampioneDTO;
import it.portaleSTI.DTO.TipoGrandezzaDTO;
import it.portaleSTI.DTO.UnitaMisuraDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneRuoloBO;
import it.portaleSTI.bo.GestioneStrumentoBO;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

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
@WebServlet(name="listaClienti" , urlPatterns = { "/listaClienti.do" })

public class ListaClienti extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaClienti() {
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
			UtenteDTO user = (UtenteDTO)request.getSession().getAttribute("userObj");
 	 
			ArrayList<UtenteDTO> listaUtenti =  (ArrayList<UtenteDTO>) GestioneAccessoDAO.getListClienti(user.getCompany().getId());
			ArrayList<CompanyDTO> listaCompany =  (ArrayList<CompanyDTO>) GestioneAccessoDAO.getListCompany();

			ArrayList<ClienteDTO>  listaClienti = (ArrayList<ClienteDTO>) GestioneStrumentoBO.getListaClientiNew(""+user.getCompany().getId());
			ArrayList<SedeDTO>  listaSedi = (ArrayList<SedeDTO>) GestioneStrumentoBO.getListaSediNew();
			
 			request.getSession().setAttribute("listaUtenti",listaUtenti);
		   	request.getSession().setAttribute("listaCompany",listaCompany);
		   	request.getSession().setAttribute("listaClienti",listaClienti);
		   	request.getSession().setAttribute("listaSedi",listaSedi);

			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaClienti.jsp");
		    dispatcher.forward(request,response);
		
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
