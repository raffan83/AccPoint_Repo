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
import it.portaleSTI.DTO.ArticoloMilestoneDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAccessorioBO;
import it.portaleSTI.bo.GestioneCampionamentoBO;
import it.portaleSTI.bo.GestioneDotazioneBO;

/**
 * Servlet implementation class listaCampioni
 */
@WebServlet(name="gestioneAssociazioniArticoliAjax" , urlPatterns = { "/gestioneAssociazioniArticoliAjax.do" })

public class GestioneAssociazioniArticoliAjax extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneAssociazioniArticoliAjax() {
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
			String action = request.getParameter("action");

				
				if(action.equals("associaAccessorio")){
					String idAccessorio = request.getParameter("idAccessorio");
					String idArticolo = request.getParameter("idArticolo");
					String quantita = request.getParameter("quantita");
					

					
 					UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
 					
					GestioneAccessorioBO.inserisciAssociazioneArticoloAccessorio(idArticolo, Integer.parseInt(idAccessorio), Integer.parseInt(quantita), utente.getCompany().getId(), utente.getId());
					ArrayList<ArticoloMilestoneDTO> listaArticoli =  (ArrayList<ArticoloMilestoneDTO>) GestioneCampionamentoBO.getListaArticoli(utente.getCompany(),session);
					request.getSession().setAttribute("listaArticoli",listaArticoli);
					
    					myObj.addProperty("success", true);
    					myObj.addProperty("messaggio","Salvato con Successo");
    					
    				
 
				}
				
				if(action.equals("disassociaAccessorio")){
					String idAccessorio = request.getParameter("idAccessorio");
					String idArticolo = request.getParameter("idArticolo");
					UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");

					

 					GestioneAccessorioBO.deleteAssociazioneArticoloAccessorio(idArticolo,Integer.parseInt(idAccessorio));
 					ArrayList<ArticoloMilestoneDTO> listaArticoli =  (ArrayList<ArticoloMilestoneDTO>) GestioneCampionamentoBO.getListaArticoli(utente.getCompany(),session);
					request.getSession().setAttribute("listaArticoli",listaArticoli);
    					myObj.addProperty("success", true);
    					myObj.addProperty("messaggio","Salvato con Successo");

				}
				
				if(action.equals("associaTipologiaDotazione")){
					String idTipologiaDotazione = request.getParameter("idTipologiaDotazione");
					String idArticolo = request.getParameter("idArticolo");
    	 	
					UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
					GestioneDotazioneBO.inserisciAssociazioneArticoloDotazione(idArticolo, Integer.parseInt(idTipologiaDotazione), utente.getCompany().getId(), utente.getId());
					ArrayList<ArticoloMilestoneDTO> listaArticoli =  (ArrayList<ArticoloMilestoneDTO>) GestioneCampionamentoBO.getListaArticoli(utente.getCompany(),session);
					request.getSession().setAttribute("listaArticoli",listaArticoli);

    					myObj.addProperty("success", true);
    					myObj.addProperty("messaggio","Salvato con Successo");
    					
    				
 
				}
				
				if(action.equals("disassociaTipologiaDotazione")){
					String idTipologiaDotazione = request.getParameter("idTipologiaDotazione");
					String idArticolo = request.getParameter("idArticolo");					
					UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
					
					GestioneDotazioneBO.deleteAssociazioneArticoloDotazione(idArticolo, Integer.parseInt(idTipologiaDotazione));
					ArrayList<ArticoloMilestoneDTO> listaArticoli =  (ArrayList<ArticoloMilestoneDTO>) GestioneCampionamentoBO.getListaArticoli(utente.getCompany(),session);
					request.getSession().setAttribute("listaArticoli",listaArticoli);
    					myObj.addProperty("success", true);
    					myObj.addProperty("messaggio","Salvato con Successo");

				}
			
				
			
			
			session.getTransaction().commit();
			session.close();
			
			out.println(myObj.toString());
		} 
		catch (Exception ex) {
			
			session.getTransaction().rollback();
	 		session.close();
	 		
		//	ex.printStackTrace();
		     request.setAttribute("error",STIException.callException(ex));
		     request.getSession().setAttribute("exception",ex);
			 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
		     dispatcher.forward(request,response);
				
		}
	
	}

}
