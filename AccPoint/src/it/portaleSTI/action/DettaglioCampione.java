package it.portaleSTI.action;

import java.io.IOException;
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
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.GestioneTLDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.PrenotazioneDTO;
import it.portaleSTI.DTO.TipoCampioneDTO;
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

		List<PrenotazioneDTO>  prenotazione=GestionePrenotazioniBO.getListaPrenotazione(idC);		
		
		CampioneDTO dettaglio =GestioneCampioneDAO.getCampioneFromId(idC);	
		
		ArrayList<TipoCampioneDTO> listaTipoCampione= GestioneTLDAO.getListaTipoCampione(session);
//		ArrayList<AttivitaManutenzioneDTO> lista_attivita_manutenzione = GestioneCampioneBO.getListaAttivitaManutenzione(Integer.parseInt(idC));
//		ArrayList<RegistroEventiDTO> lista_eventi = GestioneCampioneBO.getListaRegistroEventi(idC, session);
		 Gson gson = new Gson(); 
	        JsonObject myObj = new JsonObject();

	        JsonElement obj = gson.toJsonTree(dettaglio);
	       

	            myObj.addProperty("success", true);

	            if(prenotazione!=null )
	            {
	            	myObj.addProperty("prenotazione", false);
	            }
	            else
	            {
	            	myObj.addProperty("prenotazione", true);
	            }
	            
	          
	            
	       
	        myObj.add("dataInfo", obj);
	        
	        request.getSession().setAttribute("myObj",myObj);
	        request.getSession().setAttribute("listaTipoCampione",listaTipoCampione);
//	        request.getSession().setAttribute("lista_attivita_manutenzione", lista_attivita_manutenzione);
//	        request.getSession().setAttribute("lista_eventi", lista_eventi);
	        
	        session.getTransaction().commit();
	        session.close();
			 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioCampione.jsp");
		     dispatcher.forward(request,response);

	
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
