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
import it.portaleSTI.DTO.LogMagazzinoDTO;
import it.portaleSTI.DTO.PermessoDTO;
import it.portaleSTI.DTO.RuoloDTO;
import it.portaleSTI.DTO.TipologiaAccessoriDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAccessorioBO;
import it.portaleSTI.bo.GestioneCampionamentoBO;
import it.portaleSTI.bo.GestioneMagazzinoBO;
import it.portaleSTI.bo.GestionePermessiBO;
import it.portaleSTI.bo.GestioneRuoloBO;
import it.portaleSTI.bo.GestioneUtenteBO;

/**
 * Servlet implementation class GestioneUtenti
 */
@WebServlet(name = "gestioneAccessori", urlPatterns = { "/gestioneAccessori.do" })
public class GestioneAccessori extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneAccessori() {
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
    	 			String nome = request.getParameter("nome");
    	 			String descrizione = request.getParameter("descrizione");
    	 			String quantita = request.getParameter("quantita");
    	 			String tipologia_id = request.getParameter("tipologia");
    	 			
    	 			TipologiaAccessoriDTO tipologia = new TipologiaAccessoriDTO();
    	 			tipologia.setId(Integer.parseInt(tipologia_id));
    	 			
    	 			AccessorioDTO accessorio = new AccessorioDTO();
    	 			accessorio.setNome(nome);
    	 			accessorio.setDescrizione(descrizione);
    	 			accessorio.setQuantitaFisica(Integer.parseInt(quantita));
    	 			accessorio.setCompany(utente.getCompany());
    	 			accessorio.setUser(utente);
    	 			accessorio.setTipologia(tipologia);
    	 			
    	 			int success = GestioneAccessorioBO.saveAccessorio(accessorio, action, session);
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
    	 			

    	 			myObj.addProperty("success", true);
	 			 	myObj.addProperty("messaggio", "Accessorio salvato con successo");  
	 			 	
    	 		}else if(action.equals("modifica")){
    	 			
    	 			String id = request.getParameter("id");

    	 			String nome = request.getParameter("nome");
    	 			String descrizione = request.getParameter("descrizione");
    	 			String quantita = request.getParameter("quantita");
    	 			String tipologia_id = request.getParameter("tipologia");
    	 			
    	 			
    	 			
    	 			AccessorioDTO accessorio = GestioneAccessorioBO.getAccessorioById(id, session);

    	 			if(nome != null && !nome.equals("")){
    	 				accessorio.setNome(nome);
    	 			}
    	 			if(descrizione != null && !descrizione.equals("")){
    	 				accessorio.setDescrizione(descrizione);
    	 			}
    	 			if(quantita != null && !quantita.equals("")){
    	 				accessorio.setQuantitaFisica(Integer.parseInt(quantita));
    	 			}
    	 			if(tipologia_id != null && !tipologia_id.equals("")){
    	 				TipologiaAccessoriDTO tipologia = new TipologiaAccessoriDTO();
    	 				tipologia.setId(Integer.parseInt(tipologia_id));
    	 			}
    	 			int success = GestioneAccessorioBO.saveAccessorio(accessorio, action, session);
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
    	 	

    	 		}else if(action.equals("elimina")){
    	 			
    	 			String id = request.getParameter("id");

    	 				
    	 			
    	 			AccessorioDTO accessorio = GestioneAccessorioBO.getAccessorioById(id, session);
    	 			
    	 			int success = GestioneAccessorioBO.deleteAccessorio(accessorio, session);
    	 			if(success==0)
    				{
    					myObj.addProperty("success", true);
    					myObj.addProperty("messaggio","Elimionato con Successo");
    					session.getTransaction().commit();
    					session.close();
    				
    				}
    				if(success==1)
    				{
    					
    					myObj.addProperty("success", false);
    					myObj.addProperty("messaggio","Errore Eliminazione");
    					
    					session.getTransaction().rollback();
    			 		session.close();
    			 		
    				} 
    	 			
    	 				
    	 		}else if(action.equals("caricoscarico")){
    	 			
    	 			String id = request.getParameter("id");

    	 			String quantita = request.getParameter("quantita");
    	 			String note = request.getParameter("note");
    	 			
    	 			AccessorioDTO accessorio = GestioneAccessorioBO.getAccessorioById(id, session);
    	 			
    	 			
    	 			
    	 			int quantitaFisica = accessorio.getQuantitaFisica();

    	 			if(quantita != null && !quantita.equals("")){
    	 				accessorio.setQuantitaFisica(Integer.parseInt(quantita)+quantitaFisica);
    	 			}

    	 			int success = GestioneAccessorioBO.saveAccessorio(accessorio, action, session);
    	 			if(success==0)
    				{
    	 				
    	 				LogMagazzinoDTO logMagazzino = new LogMagazzinoDTO();        	 			
        	 			logMagazzino.setAccessorio(accessorio);
        	 			if(Integer.parseInt(quantita)>0) {
        	 				logMagazzino.setOperazione("CARICO");
        	 			}else {
        	 				logMagazzino.setOperazione("SCARICO");
        	 			}
        	 			if(note != null && !note.equals("")){
        	 				logMagazzino.setNote(note);
        	 			}else {
        	 				logMagazzino.setNote("");
        	 			}
        	 			logMagazzino.setQuantita_prima(quantitaFisica);
        	 			logMagazzino.setQuantita_dopo(accessorio.getQuantitaFisica());
    	 				logMagazzino.setUser(utente);
    	 				logMagazzino.setData(new Date());
    	 				
    	 				GestioneCampionamentoBO.save(logMagazzino,session);
        	 			
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
        	//myObj.addProperty("success", false);
        	//myObj.addProperty("messaggio", STIException.callException(ex).toString());
        	myObj = STIException.getException(ex);
			request.getSession().setAttribute("exception", ex);
        	out.println(myObj.toString());
        } 
	}

}
