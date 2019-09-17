package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.MilestoneOperatoreDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;

/**
 * Servlet implementation class GestioneAssegnazioneAttivita
 */
@WebServlet("/gestioneAssegnazioneAttivita.do")
public class GestioneAssegnazioneAttivita extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneAssegnazioneAttivita() {
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
		
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
		
		String action = request.getParameter("action");
		
		JsonObject myObj = new JsonObject();
		boolean ajax = false;
        response.setContentType("application/json");
		try {
			
			if(action.equals("assegna")) {
			
				String str = request.getParameter("str");
				
				
				InterventoDTO intervento = (InterventoDTO) request.getSession().getAttribute("intervento");
				
				String [] line =str.split(";");
				
				for (String attivita : line) {
					
					String[] data=attivita.split("_");
				
					MilestoneOperatoreDTO milestone = new MilestoneOperatoreDTO();
					
					String descrizione=data[0];
					String note=data[1];
					BigDecimal qta_tot =new BigDecimal(data[2]);
					BigDecimal qta_ass= new BigDecimal(data[3]);
					BigDecimal importo_unitario= new BigDecimal(data[4]);
					
					milestone.setIntervento(intervento);
					milestone.setUser(utente);
					milestone.setDescrizioneMilestone(descrizione);
					milestone.setQuantitaTotale(qta_tot);
					milestone.setData(new Date());
					milestone.setQuantitaAssegnata(qta_ass);
					milestone.setPrezzo_un(importo_unitario);
					milestone.setPresso_assegnato(qta_ass.multiply(importo_unitario));
					milestone.setPrezzo_totale(qta_tot.multiply(importo_unitario));
					milestone.setPrezzo_un(importo_unitario);
					milestone.setNote(note);
					
					session.save(milestone);
				}
				
				session.getTransaction().commit();
				session.close();	
				
				PrintWriter out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Attività assegnata con successo!");
				out.print(myObj);
			}
			
			
		}catch (Exception e) {
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
