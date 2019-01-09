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

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.PrenotazioneDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestionePrenotazioniBO;

/**
 * Servlet implementation class DettaglioCampione
 */
@WebServlet(name="listaCertificatiCampione" , urlPatterns = { "/listaCertificatiCampione.do" })

public class ListaCertificatiCampione extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaCertificatiCampione() {
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
		
	try{	
		String idC = request.getParameter("idCamp");

		List<PrenotazioneDTO>  prenotazione=GestionePrenotazioniBO.getListaPrenotazione(idC);
		
		CampioneDTO dettaglio =GestioneCampioneDAO.getCampioneFromId(idC);	

		 Gson gson = new Gson(); 
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
		    

	            request.getSession().setAttribute("dettaglioCampione",dettaglio);
	            request.getSession().setAttribute("myObj",myObj);

	        
			 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaCertificatiCampione.jsp");
		     dispatcher.forward(request,response);

	
	}catch(Exception ex)
	{
		
		 ex.printStackTrace();
	     request.setAttribute("error",STIException.callException(ex));
	     request.getSession().setAttribute("exception", ex);
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
