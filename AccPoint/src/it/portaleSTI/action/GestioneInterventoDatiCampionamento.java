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
import it.portaleSTI.DTO.InterventoCampionamentoDTO;
import it.portaleSTI.DTO.PrenotazioneAccessorioDTO;
import it.portaleSTI.DTO.PrenotazioniDotazioneDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneCampionamentoBO;

/**
 * Servlet implementation class GestioneInterventoDati
 */
@WebServlet(name = "gestioneInterventoDatiCampionamento", urlPatterns = { "/gestioneInterventoDatiCampionamento.do" })
public class GestioneInterventoDatiCampionamento extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneInterventoDatiCampionamento() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		try {	
			
			String idIntervento=request.getParameter("idIntervento");
					
			InterventoCampionamentoDTO interventoCampionamento=GestioneCampionamentoBO.getIntervento(idIntervento);
			
			ArrayList<PrenotazioniDotazioneDTO> listaPrenotazioniDotazioni = GestioneCampionamentoBO.getListaPrenotazioniDotazione(idIntervento,session);
			ArrayList<PrenotazioneAccessorioDTO> listaPrenotazioniAccessori = GestioneCampionamentoBO.getListaPrenotazioniAccessori(idIntervento,session);
	

			request.getSession().setAttribute("interventoCampionamento", interventoCampionamento);
			request.getSession().setAttribute("listaPrenotazioniAccessori", listaPrenotazioniAccessori);
			request.getSession().setAttribute("listaPrenotazioniDotazioni", listaPrenotazioniDotazioni);
			
			session.getTransaction().commit();
	     	session.close();	
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneInterventoDatiCampionamento.jsp");     	
			dispatcher.forward(request,response);


	     	
		
		}catch(Exception ex){
			
			 session.getTransaction().rollback();
			 session.close();
			
			 ex.printStackTrace();
		     request.setAttribute("error",STIException.callException(ex));
	  	     request.getSession().setAttribute("exception", ex);
			 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
		     dispatcher.forward(request,response);	
		} 
     	
	}
}
