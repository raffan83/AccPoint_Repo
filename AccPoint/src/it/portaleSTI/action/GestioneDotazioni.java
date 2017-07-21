package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Access;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.AccessorioDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.DotazioneDTO;
import it.portaleSTI.DTO.LogMagazzinoDTO;
import it.portaleSTI.DTO.PermessoDTO;
import it.portaleSTI.DTO.RuoloDTO;
import it.portaleSTI.DTO.TipologiaAccessoriDTO;
import it.portaleSTI.DTO.TipologiaDotazioniDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAccessorioBO;
import it.portaleSTI.bo.GestioneDotazioneBO;
import it.portaleSTI.bo.GestioneMagazzinoBO;
import it.portaleSTI.bo.GestionePermessiBO;
import it.portaleSTI.bo.GestioneRuoloBO;
import it.portaleSTI.bo.GestioneUtenteBO;

/**
 * Servlet implementation class GestioneUtenti
 */
@WebServlet(name = "gestioneDotazioni", urlPatterns = { "/gestioneDotazioni.do" })
public class GestioneDotazioni extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneDotazioni() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if(Utility.validateSession(request,response,getServletContext()))return;
		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		PrintWriter out = response.getWriter();
		JsonObject myObj = new JsonObject();
   
        response.setContentType("application/json");
        try{
       	 	
        	String action =  request.getParameter("action");
       	 	
        	if(action !=null )
       	 	{
				
        		UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
        		
    	 		if(action.equals("nuovo"))
    	 		{
    	 			String marca = request.getParameter("marca");
    	 			String modello = request.getParameter("modello");
    	 			String tipologia_id = request.getParameter("tipologia");
    	 			String targa = request.getParameter("targa");
    	 			String matricola = request.getParameter("matricola");
    	 			
    	 			TipologiaDotazioniDTO tipologia = new TipologiaDotazioniDTO();
    	 			tipologia.setId(Integer.parseInt(tipologia_id));
    	 			
    	 			DotazioneDTO dotazione = new DotazioneDTO();
    	 			dotazione.setMarca(marca);
    	 			dotazione.setModello(modello);
    	 			dotazione.setMatricola(matricola);
    	 			dotazione.setTarga(targa);
    	 			dotazione.setCompany(utente.getCompany());

    	 			dotazione.setTipologia(tipologia);
    	 			
    	 			GestioneDotazioneBO.saveDotazione(dotazione, action, session);
    	 			
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio","Salvato con Successo");
				session.getTransaction().commit();
				session.close();

	 			 	
    	 		}else if(action.equals("modifica")){
    	 			
    	 			String id = request.getParameter("id");

    	 			String marca = request.getParameter("marca");
    	 			String modello = request.getParameter("modello");
    	 			String tipologia_id = request.getParameter("tipologia");
    	 			String targa = request.getParameter("targa");
    	 			String matricola = request.getParameter("matricola");
    	 			
    	 			DotazioneDTO dotazione = GestioneDotazioneBO.getDotazioneById(id, session);

    	 			if(marca != null && !marca.equals("")){
    	 				dotazione.setMarca(marca);
    	 			}
    	 			if(modello != null && !modello.equals("")){
    	 				dotazione.setModello(modello);
    	 			}
    	 			if(targa != null && !targa.equals("")){
    	 				dotazione.setTarga(targa);
    	 			}
    	 			if(matricola != null && !matricola.equals("")){
    	 				dotazione.setMatricola(matricola);
    	 			}
    	 			if(tipologia_id != null && !tipologia_id.equals("")){
    	 				TipologiaDotazioniDTO tipologia = new TipologiaDotazioniDTO();
    	 				tipologia.setId(Integer.parseInt(tipologia_id));
    	 			}

    	 			  GestioneDotazioneBO.saveDotazione(dotazione, action, session);
    	 			 
    					myObj.addProperty("success", true);
    					myObj.addProperty("messaggio","Salvato con Successo");
    					session.getTransaction().commit();
    					session.close();
    				
    				 

    	 		}else if(action.equals("elimina")){
    	 			
    	 			String id = request.getParameter("id");

    	 				
    	 			
    	 			DotazioneDTO dotazione = GestioneDotazioneBO.getDotazioneById(id, session);
    	 			
    	 			GestioneDotazioneBO.deleteDotazione(dotazione, session);

    					myObj.addProperty("success", true);
    					myObj.addProperty("messaggio","Elimionato con Successo");
    					session.getTransaction().commit();
    					session.close();

    			
    	 			
    	 				
    	 		}
    	 		
    	 	}else{
       	 		
    			myObj.addProperty("success", false);
    			myObj.addProperty("messaggio", "Nessuna action riconosciuta");  
    		}	
        	out.println(myObj.toString());

        }catch(Exception ex){
        	
        	ex.printStackTrace();
        	session.getTransaction().rollback();
        	session.close();
        	myObj.addProperty("success", false);
        	myObj.addProperty("messaggio", STIException.callException(ex).toString());
        	out.println(myObj.toString());
        } 
	}

}
