package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.RuoloDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneCompanyBO;
import it.portaleSTI.bo.GestioneUtenteBO;

/**
 * Servlet implementation class GestioneUtenti
 */
@WebServlet(name = "gestioneCompany", urlPatterns = { "/gestioneCompany.do" })
public class GestioneCompany extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneCompany() {
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
					
	    	 		if(action.equals("nuovo"))
	    	 		{
	    	 			String denominazione = request.getParameter("denominazione");
	    	 			String pIva = request.getParameter("piva");
	    	 			String indirizzo = request.getParameter("indirizzo");
	    	 			String comune = request.getParameter("comune");
	    	 			String cap = request.getParameter("cap");
	    	 			String EMail = request.getParameter("email");
	    	 			String telefono = request.getParameter("telefono");
	    	 			String codAffiliato = request.getParameter("codiceAffiliato");
	    	 			String email_pec = request.getParameter("email_pec");
	    	 			String password_pec = request.getParameter("password_pec");
	    	 			String host_pec = request.getParameter("host_pec");
	    	 			String porta_pec = request.getParameter("porta_pec");
	    	 			
	    	 
	    	 			
	    	 			CompanyDTO company = new CompanyDTO();
	    	 			company.setDenominazione(denominazione);
	    	 			company.setpIva(pIva);
	    	 			company.setIndirizzo(indirizzo);
	    	 			company.setComune(comune);
	    	 			company.setCap(cap);
	    	 			company.setMail(EMail);
	    	 			company.setTelefono(telefono);
	    	 			company.setCodAffiliato(codAffiliato);
	    	 			company.setEmail_pec(email_pec);
	    	 			String pwd_encrypted = Utility.encrypt(password_pec, Costanti.SALT_PEC);
	    	 			company.setPwd_pec(pwd_encrypted);
	    	 			company.setHost_pec(host_pec);
	    	 			company.setPorta_pec(porta_pec);
	    	 			

	    	 			int success = GestioneCompanyBO.saveCompany(company,action,session);

	    	 			if(success==0)
	    				{
	    					myObj.addProperty("success", true);
	    					myObj.addProperty("messaggio","Company salvata con successo");
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
		 			 	
	    	 		}else if(action.equals("modifica")){
	    	 			
	    	 			String id = request.getParameter("modid");

	    	 			String denominazione = request.getParameter("moddenominazione");
	    	 			String pIva = request.getParameter("modpiva");
	    	 			String indirizzo = request.getParameter("modindirizzo");
	    	 			String comune = request.getParameter("modcomune");
	    	 			String cap = request.getParameter("modcap");
	    	 			String EMail = request.getParameter("modemail");
	    	 			String telefono = request.getParameter("modtelefono");
	    	 			String codAffiliato = request.getParameter("modcodiceAffiliato");
	    	 			String email_pec = request.getParameter("mod_email_pec");
	    	 			String password_pec = request.getParameter("mod_password_pec");
	    	 			String host_pec = request.getParameter("mod_host_pec");
	    	 			String porta_pec = request.getParameter("mod_porta_pec");
	    	 			
	    	 
	    	 			
	    	 			
	    	 			CompanyDTO company = GestioneCompanyBO.getCompanyById(id, session);
	    	 			
	    	 			if(denominazione != null && !denominazione.equals("")){
		    	 			company.setDenominazione(denominazione);
	    	 			}
	    	 			if(pIva != null && !pIva.equals("")){
		    	 			company.setpIva(pIva);
	    	 			}
	    	 			if(indirizzo != null && !indirizzo.equals("")){
		    	 			company.setIndirizzo(indirizzo);
	    	 			}
	    	 			if(comune != null && !comune.equals("")){
		    	 			company.setComune(comune);
	    	 			}
	    	 			if(cap != null && !cap.equals("")){
		    	 			company.setCap(cap);
	    	 			}
	    	 			if(EMail != null && !EMail.equals("")){
		    	 			company.setMail(EMail);
	    	 			}
	    	 			if(telefono != null && !telefono.equals("")){
		    	 			company.setTelefono(telefono);
	    	 			}
	    	 			if(codAffiliato != null && !codAffiliato.equals("")){
		    	 			company.setCodAffiliato(codAffiliato);
	    	 			}
	    	 			if(email_pec != null && !email_pec.equals("")) {
	    	 				company.setEmail_pec(email_pec);
	    	 			}
	    	 			if(password_pec != null && !password_pec.equals("")) {
	    	 				String pwd_encrypted = Utility.encrypt(password_pec, Costanti.SALT_PEC);
		    	 			company.setPwd_pec(pwd_encrypted);
	    	 			}
	    	 			if(host_pec != null && !host_pec.equals("")) {
	    	 				company.setHost_pec(host_pec);
	    	 			}
	    	 			if(porta_pec != null && !porta_pec.equals("")) {
	    	 				company.setPorta_pec(porta_pec);
	    	 			}
	    	 			

	    	 			int success = GestioneCompanyBO.saveCompany(company,action,session);

	    	 			if(success==0)
	    				{
	    					myObj.addProperty("success", true);
	    					myObj.addProperty("messaggio","Company modificata con successo");
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

	    	 				
	    	 			
	    	 			CompanyDTO company = GestioneCompanyBO.getCompanyById(id, session);
	    	 			

	    	 			/*
	    	 			 * TO DO Elimina Company
	    	 			 */
	    	 			
	    	 			
	    	 			myObj.addProperty("success", true);
		 			 	myObj.addProperty("messaggio", "Company eliminato con successo");  
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
        	request.getSession().setAttribute("exception", ex);
        	myObj.addProperty("success", false);
        	myObj.addProperty("messaggio", STIException.callException(ex).toString());
        	//out.println(myObj.toString());
        } 
	}

}
