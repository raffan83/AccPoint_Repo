package it.portaleSTI.action;

import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.GestioneTLDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.PrenotazioneDTO;
import it.portaleSTI.DTO.TipoCampioneDTO;
import it.portaleSTI.DTO.ValoreCampioneDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestionePrenotazioniBO;

/**
 * Servlet implementation class DettaglioCampione
 */
@WebServlet(name="dettaglioCampione" , urlPatterns = { "/dettaglioCampione.do" })

public class DettaglioCampione extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DettaglioCampione() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		Session session = SessionFacotryDAO.get().openSession();
	    
		session.beginTransaction();
		
	try{	
		String idC = request.getParameter("idCamp");
		
		String ajax =  request.getParameter("ajax");

		List<PrenotazioneDTO>  prenotazione=GestionePrenotazioniBO.getListaPrenotazione(idC);		
		
		CampioneDTO dettaglio =GestioneCampioneDAO.getCampioneFromId(idC);	
		
		ArrayList<TipoCampioneDTO> listaTipoCampione= GestioneTLDAO.getListaTipoCampione(session);
//		ArrayList<AttivitaManutenzioneDTO> lista_attivita_manutenzione = GestioneCampioneBO.getListaAttivitaManutenzione(Integer.parseInt(idC));
//		ArrayList<RegistroEventiDTO> lista_eventi = GestioneCampioneBO.getListaRegistroEventi(idC, session);
		 Gson gson = null;
	        JsonObject myObj = new JsonObject();

	      
	       

	            myObj.addProperty("success", true);

	            if(prenotazione!=null )
	            {
	            	myObj.addProperty("prenotazione", false);
	            }
	            else
	            {
	            	myObj.addProperty("prenotazione", true);
	            }
	            
	          
	            
	       
	       
	        
	        
	        request.getSession().setAttribute("listaTipoCampione",listaTipoCampione);
//	        request.getSession().setAttribute("lista_attivita_manutenzione", lista_attivita_manutenzione);
//	        request.getSession().setAttribute("lista_eventi", lista_eventi);
	        
	      
	        
	        if(ajax!=null) {
	        	
	        	gson =	new GsonBuilder().setDateFormat("dd/MM/yyyy").create(); 
	        	JsonElement obj = gson.toJsonTree(dettaglio);
	        	
	        	
	    	    ArrayList<ValoreCampioneDTO> listaVCP = GestioneCampioneDAO.getListaValori(dettaglio.getId());
	    	    
	    		for (ValoreCampioneDTO valoreCampioneDTO : listaVCP) {
	    			valoreCampioneDTO.getCampione().getCompany().setPwd_pec("");
	    			valoreCampioneDTO.getCampione().getCompany().setHost_pec("");
	    			valoreCampioneDTO.getCampione().getCompany().setEmail_pec("");
	    			valoreCampioneDTO.getCampione().getCompany().setPorta_pec("");
	    		}
	    		
	    		
	    	        JsonObject myObjVC = new JsonObject();

	    	        JsonElement objVC = gson.toJsonTree(listaVCP);
	    	     

	    	        myObjVC.addProperty("success", true);
	    	       
	    	        myObjVC.add("dataInfo", objVC);
	    	        
	    	        request.getSession().setAttribute("myObjValoriCampione",myObjVC);
	        	  
	        	 myObj.add("dataInfo", obj);
	        	 response.setContentType("application/json;charset=UTF-8");
	        	PrintWriter out =response.getWriter();
	        	out.print(myObj);
	        	  session.getTransaction().commit();
	  	        session.close();
	        }else {
	        
	        	gson =	new Gson(); 
	        	JsonElement obj = gson.toJsonTree(dettaglio);
	        	
	        	 myObj.add("dataInfo", obj);
	        	 
	        	 request.getSession().setAttribute("myObj",myObj);
	        	 
	        	 
	        	  session.getTransaction().commit();
	  	        session.close();
	        	RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioCampione.jsp");
			     dispatcher.forward(request,response);
	        }
	        
	        
			 

	
	}catch(Exception ex)
	{
		session.getTransaction().rollback();
		session.close();
		 ex.printStackTrace();
	     request.setAttribute("error",STIException.callException(ex));
	     request.getSession().setAttribute("exception",ex);
		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
	     dispatcher.forward(request,response);
		
	}  
	
	}
	
	static CampioneDTO getCampione(ArrayList<CampioneDTO> listaCampioni,String idC) {
		CampioneDTO campione =null;
		
		try
		{		
		for (int i = 0; i < listaCampioni.size(); i++) {
			
			if(listaCampioni.get(i).getId()==Integer.parseInt(idC))
			{
				return listaCampioni.get(i);
			}
		}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			campione=null;
			throw ex;
		}
		return campione;
	}

}
