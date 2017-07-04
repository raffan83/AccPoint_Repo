package it.portaleSTI.action;



import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.PrenotazioneDTO;
import it.portaleSTI.DTO.StatoPrenotazioneDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.bo.GestioneCampioneBO;
import it.portaleSTI.bo.GestionePrenotazioniBO;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

/**
 * Servlet implementation class GestionePrenotazione
 */
@WebServlet(name="gestionePrenotazione" , urlPatterns = { "/gestionePrenotazione.do" })
public class GestionePrenotazione extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestionePrenotazione() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		

		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();


		
		try
		{
		
		String result = request.getParameter("param");
		
		PrintWriter out = response.getWriter();

		String json = request.getParameter("dataIn");
		
		JsonElement jelement = new JsonParser().parse(json);
		 
		JsonObject  jobject = jelement.getAsJsonObject();
		
		 
		
		 
		 String note =jobject.get("nota").toString().replaceAll("\"", "");
		
		 JsonObject myObj = new JsonObject();
		
		if (result.equals("app"))
		{
			 int idPrenotazione=Integer.parseInt(jobject.get("idPrenotazione").toString().replaceAll("\"", ""));

			PrenotazioneDTO prenotazione =GestionePrenotazioniBO.getPrenotazione(idPrenotazione);
			
			prenotazione.getStato().setId(1);
			prenotazione.setNoteApprovazione(note);
			prenotazione.setDataApprovazione(new Date());
			prenotazione.setDataGestione(new Date());
			
			int success = GestionePrenotazioniBO.updatePrenotazione(prenotazione, session);
			if(success==0)
			{
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio","Salvato con Successo");
				session.getTransaction().commit();
				session.close();
			
			}
			if(success==1)
			{
				
				myObj.addProperty("success", false);
				myObj.addProperty("messaggio","Errore Salvataggio");
				
				session.getTransaction().rollback();
		 		session.close();
		 		
			}
	        out.println(myObj.toString());
	        
	        
		}else if(result.equals("pren")){
			
			
			String start = jobject.get("start").getAsString();
			String end = jobject.get("end").getAsString();
			
			
			
			PrenotazioneDTO prenotazione = new PrenotazioneDTO();
			
			Gson gson = new Gson();

			CampioneDTO campione = gson.fromJson(jobject.get("campione"), CampioneDTO.class);		
			prenotazione.setCampione(campione);
			
			CompanyDTO companyRich = (CompanyDTO)request.getSession().getAttribute("usrCompany");
			prenotazione.setCompanyRichiedente(companyRich);
			
			UtenteDTO utente = (UtenteDTO)request.getSession().getAttribute("userObj");
			prenotazione.setUserRichiedente(utente);
			
			DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			
			Date dateStart = format.parse(start);
			prenotazione.setPrenotatoDal(dateStart);
			
			Date dateEnd = format.parse(end);
			prenotazione.setPrenotatoAl(dateEnd);
			
			prenotazione.setDataRichiesta(new Date());
			
			prenotazione.setNote(note);
			
			StatoPrenotazioneDTO statop = new StatoPrenotazioneDTO();
			statop.setId(0);
			prenotazione.setStato(statop);
			
			
			int success = GestionePrenotazioniBO.savePrenotazione(prenotazione, session);

			if(success==0)
			{
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio","Salvato con Successo");
				session.getTransaction().commit();
				session.close();
			
			}
			if(success==1)
			{
				
				myObj.addProperty("success", false);
				myObj.addProperty("messaggio","Errore Salvataggio");
				
				session.getTransaction().rollback();
		 		session.close();
		 		
			}
		
		     out.println(myObj.toString());
		}
		else
		{
			 int idPrenotazione=Integer.parseInt(jobject.get("idPrenotazione").toString().replaceAll("\"", ""));

			PrenotazioneDTO prenotazione =GestionePrenotazioniBO.getPrenotazione(idPrenotazione);
			prenotazione.setDataGestione(new Date());
			prenotazione.getStato().setId(2);
			prenotazione.setNoteApprovazione(note);
			
			int success = GestionePrenotazioniBO.updatePrenotazione(prenotazione, session);
			if(success==0)
			{
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio","Salvato con Successo");
				session.getTransaction().commit();
				session.close();
			
			}
			if(success==1)
			{
				
				myObj.addProperty("success", false);
				myObj.addProperty("messaggio","Errore Salvataggio");
				
				session.getTransaction().rollback();
		 		session.close();
		 		
			}
			 out.println(myObj.toString());
		}    
		out.close();
		}
		catch
		(Exception e) 
		{
			session.getTransaction().rollback();
			session.close();
			 e.printStackTrace();
    	     request.setAttribute("error",STIException.callException(e));
    		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
    	     dispatcher.forward(request,response);	
		}
	}

	

}
