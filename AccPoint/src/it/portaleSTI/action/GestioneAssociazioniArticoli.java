package it.portaleSTI.action;

import it.portaleSTI.DAO.GestioneAccessoDAO;
import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.GestioneTLDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.AccessorioDTO;
import it.portaleSTI.DTO.ArticoloMilestoneDTO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.DotazioneDTO;
import it.portaleSTI.DTO.PermessoDTO;
import it.portaleSTI.DTO.RuoloDTO;
import it.portaleSTI.DTO.TipoCampioneDTO;
import it.portaleSTI.DTO.TipoGrandezzaDTO;
import it.portaleSTI.DTO.UnitaMisuraDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAccessorioBO;
import it.portaleSTI.bo.GestioneCampionamentoBO;
import it.portaleSTI.bo.GestioneDotazioneBO;

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
@WebServlet(name="gestioneAssociazioniArticoli" , urlPatterns = { "/gestioneAssociazioniArticoli.do" })

public class GestioneAssociazioniArticoli extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneAssociazioniArticoli() {
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
			CompanyDTO cmp = (CompanyDTO) request.getSession().getAttribute("usrCompany");
			ArrayList<AccessorioDTO> listaAccessori =  (ArrayList<AccessorioDTO>) GestioneAccessorioBO.getListaAccessori(cmp, session);
			ArrayList<DotazioneDTO> listaDotazioni =  (ArrayList<DotazioneDTO>) GestioneDotazioneBO.getListaDotazioni(cmp, session);
			ArrayList<ArticoloMilestoneDTO> listaArticoli =  (ArrayList<ArticoloMilestoneDTO>) GestioneCampionamentoBO.getListaArticoli(cmp);
			
			request.getSession().setAttribute("listaArticoli",listaArticoli);
	        request.getSession().setAttribute("listaAccessori",listaAccessori);
	        request.getSession().setAttribute("listaDotazioni",listaDotazioni);


			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneAssociazioniArticoli.jsp");
	     	dispatcher.forward(request,response);
	     	session.getTransaction().commit();
			session.close();
		} 
		catch (Exception ex) {
			 session.getTransaction().commit();
				session.close();
		//	ex.printStackTrace();
		     request.setAttribute("error",STIException.callException(ex));
			 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
		     dispatcher.forward(request,response);
		}
	
	}

}
