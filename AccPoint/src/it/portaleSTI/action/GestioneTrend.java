package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import it.portaleSTI.DTO.PermessoDTO;
import it.portaleSTI.DTO.RuoloDTO;
import it.portaleSTI.DTO.TipoTrendDTO;
import it.portaleSTI.DTO.TrendDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneCompanyBO;
import it.portaleSTI.bo.GestionePermessiBO;
import it.portaleSTI.bo.GestioneRuoloBO;
import it.portaleSTI.bo.GestioneTrendBO;
import it.portaleSTI.bo.GestioneUtenteBO;

/**
 * Servlet implementation class GestioneUtenti
 */
@WebServlet(name = "gestioneTrend", urlPatterns = { "/gestioneTrend.do" })
public class GestioneTrend extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneTrend() {
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
    	 			String data = request.getParameter("data");
    	 			String val = request.getParameter("val");
    	 			String companyid = request.getParameter("company");
    	 			String tipoTrendId = request.getParameter("tipoTrend");
    	 			String tipoTrendCustom = request.getParameter("tipoTrendCustom");
    	 			
    	 			TrendDTO trend = new TrendDTO();
    	 			TipoTrendDTO tipoTrend = new TipoTrendDTO();
				
    	 			if(tipoTrendCustom == null || tipoTrendCustom.equals("")) {
					tipoTrend.setId(Integer.parseInt(tipoTrendId));
				}else {
					
					tipoTrend.setDescrizione(tipoTrendCustom);
					
					int idTipoTrend = GestioneTrendBO.saveTipoTrend(tipoTrend,session);
					
				}
    	 			
    	 			CompanyDTO company = GestioneCompanyBO.getCompanyById(companyid, session);
    	 			
    	 			DateFormat df = new SimpleDateFormat("dd/MM/yyyy");

    	 			trend.setData(new Date(df.parse(data).getTime()));
    	 			
    	 			trend.setVal(Integer.parseInt(val));
    	 			trend.setCompany(company);
    	 			trend.setTipoTrend(tipoTrend);
    	 			

    	 			int success = GestioneTrendBO.saveTrend(trend, action, session);
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
	 			 	myObj.addProperty("messaggio", "Trend salvato con successo");  
	 			 	
    	 		}else if(action.equals("modifica")){
    	 			
    	 			String id = request.getParameter("id");

    	 			String data = request.getParameter("data");
    	 			String val = request.getParameter("val");
    	 			String companyid = request.getParameter("company");
    	 			String tipoTrendId = request.getParameter("tipotrend");
    	 			
    	 			CompanyDTO company = GestioneCompanyBO.getCompanyById(companyid, session);
    	 		
    	 			TrendDTO trend = GestioneTrendBO.getTrendById(id,session);
    	 			
    	 			DateFormat df = new SimpleDateFormat("dd/MM/yyyy");

    	 			trend.setData(new Date(df.parse(data).getTime()));
    	 			
    	 			trend.setVal(Integer.parseInt(val));
    	 			trend.setCompany(company);

    	 			TipoTrendDTO tipoTrend = new TipoTrendDTO();
    	 			tipoTrend.setId(Integer.parseInt(tipoTrendId));


    	 			int success = GestioneTrendBO.saveTrend(trend, action, session);
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
	 			 	myObj.addProperty("messaggio", "Trend modificato con successo");  
    	 		}else if(action.equals("elimina")){
    	 			
    	 			String id = request.getParameter("id");

    	 				
    	 			
    	 			TrendDTO ruolo = GestioneTrendBO.getTrendById(id, session);
    	 			

    	 			/*
    	 			 * TO DO Elimina Ruolo
    	 			 */
    	 			
    	 			
    	 			myObj.addProperty("success", true);
	 			 	myObj.addProperty("messaggio", "Trend eliminato con successo");  
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