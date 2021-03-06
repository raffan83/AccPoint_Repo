package it.portaleSTI.action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.AccessorioDTO;
import it.portaleSTI.DTO.ArticoloMilestoneDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.DotazioneDTO;
import it.portaleSTI.DTO.TipologiaDotazioniDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAccessorioBO;
import it.portaleSTI.bo.GestioneCampionamentoBO;
import it.portaleSTI.bo.GestioneDotazioneBO;

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
			
			
			String categoria =request.getParameter("categoria");
			CompanyDTO cmp = (CompanyDTO) request.getSession().getAttribute("usrCompany");
			
			if(categoria==null )
			{
			
			
			ArrayList<AccessorioDTO> listaAccessori =  (ArrayList<AccessorioDTO>) GestioneAccessorioBO.getListaAccessori(cmp, session);
			ArrayList<DotazioneDTO> listaDotazioni =  (ArrayList<DotazioneDTO>) GestioneDotazioneBO.getListaDotazioni(cmp, session);
			ArrayList<ArticoloMilestoneDTO> listaArticoli =  (ArrayList<ArticoloMilestoneDTO>) GestioneCampionamentoBO.getListaArticoli(cmp,session);
			
			request.getSession().setAttribute("listaArticoli",listaArticoli);
	        request.getSession().setAttribute("listaAccessori",listaAccessori);
	        request.getSession().setAttribute("listaDotazioni",listaDotazioni);

	        
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneAssociazioniArticoli.jsp");
	     	dispatcher.forward(request,response);
			}
			
			if(categoria!=null && categoria.equals("accessorio"))
			{
				String idArticolo = request.getParameter("idArticolo");

					ArrayList<ArticoloMilestoneDTO> listaArticoli = (ArrayList<ArticoloMilestoneDTO>) request.getSession().getAttribute("listaArticoli");
					ArticoloMilestoneDTO articolo = GestioneCampionamentoBO.getArticoloById(idArticolo, listaArticoli);
					ArrayList<AccessorioDTO> listaAccessori= GestioneAccessorioBO.getListaAccessori(cmp, session);
			        
					request.getSession().setAttribute("idArticolo",idArticolo);
			        request.getSession().setAttribute("articolo",articolo);

					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaAccessoriArticoli.jsp");
			     	dispatcher.forward(request,response);
			}
			
			if(categoria!=null && categoria.equals("dotazione"))
			{
				String idArticolo = request.getParameter("idArticolo");

					ArrayList<ArticoloMilestoneDTO> listaArticoli = (ArrayList<ArticoloMilestoneDTO>) request.getSession().getAttribute("listaArticoli");
					ArticoloMilestoneDTO articolo = GestioneCampionamentoBO.getArticoloById(idArticolo, listaArticoli);
					ArrayList<TipologiaDotazioniDTO> listaTipologiaDotazioni = GestioneDotazioneBO.getListaTipologieDotazioni(session);
					
			        request.getSession().setAttribute("idArticolo",idArticolo);
			        request.getSession().setAttribute("articolo",articolo);
			        request.getSession().setAttribute("listaTipologiaDotazioni",listaTipologiaDotazioni);
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaDotazioniArticoli.jsp");
			     	dispatcher.forward(request,response);
			}
	     	
	     	session.getTransaction().commit();
			session.close();
		} 
		catch (Exception ex) {
			 session.getTransaction().commit();
				session.close();
		//	ex.printStackTrace();
		     request.setAttribute("error",STIException.callException(ex));
		     request.getSession().setAttribute("exception",ex);
			 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
		     dispatcher.forward(request,response);
		}
	
	}

}
