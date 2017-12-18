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
import it.portaleSTI.DTO.TipoTrendDTO;
import it.portaleSTI.DTO.TrendDTO;
import it.portaleSTI.DTO.UnitaMisuraDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneCompanyBO;
import it.portaleSTI.bo.GestioneTrendBO;
import it.portaleSTI.bo.GestioneUtenteBO;

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
@WebServlet(name="listaTrend" , urlPatterns = { "/listaTrend.do" })

public class ListaTrend extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaTrend() {
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
			String idCompany = request.getParameter("idCompany");
			if(idCompany != null && !idCompany.equals("")) 
			{

				ArrayList<TrendDTO> listaTrend =  (ArrayList<TrendDTO>) GestioneTrendBO.getListaTrendUser(idCompany, session);
				ArrayList<TipoTrendDTO> listaTipoTrend =  (ArrayList<TipoTrendDTO>) GestioneTrendBO.getListaTipoTrend(session);

 		        request.getSession().setAttribute("listaTrend",listaTrend);
 		        request.getSession().setAttribute("listaTipoTrend",listaTipoTrend);
 		        
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaTrendSelect.jsp");
		     	dispatcher.forward(request,response);
	 				
			}else{
				ArrayList<CompanyDTO> listaCompany =  (ArrayList<CompanyDTO>) GestioneCompanyBO.getAllCompany(session);
				
 		        request.getSession().setAttribute("listaCompany",listaCompany);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaTrend.jsp");
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
