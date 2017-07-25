package it.portaleSTI.action;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.GestioneTLDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CertificatoCampioneDTO;
import it.portaleSTI.DTO.DotazioneDTO;
import it.portaleSTI.DTO.PrenotazioneAccessorioDTO;
import it.portaleSTI.DTO.PrenotazioneDTO;
import it.portaleSTI.DTO.PrenotazioniDotazioneDTO;
import it.portaleSTI.DTO.TipoCampioneDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneDotazioneBO;
import it.portaleSTI.bo.GestionePrenotazioniBO;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

/**
 * Servlet implementation class DettaglioCampione
 */
@WebServlet(name="dettaglioPrenotazioneDotazione" , urlPatterns = { "/dettaglioPrenotazioneDotazione.do" })

public class DettaglioPrenotazioneDotazione extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DettaglioPrenotazioneDotazione() {
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
		String id = request.getParameter("idDotazione");


		
		DotazioneDTO dotazione =GestioneDotazioneBO.getDotazioneById(id, session);
		
//		ArrayList<PrenotazioniDotazioneDTO> prenotazioni = new ArrayList<PrenotazioniDotazioneDTO>();
//		prenotazioni.addAll(dotazione.getListaPrenotazioni());
		
		 Gson gson = new Gson(); 
	        JsonObject myObj = new JsonObject();
	        
	        
	        
	        
	        
	        JsonArray prenotaizoneArr = new JsonArray();
	        
	        
	        
		      for (Iterator iterator = dotazione.getListaPrenotazioni().iterator(); iterator.hasNext();) {
		    	
		    	JsonObject prenotazioneObj = new JsonObject();
		    			
				PrenotazioniDotazioneDTO pren = (PrenotazioniDotazioneDTO) iterator.next();
				
				prenotazioneObj.addProperty("title", pren.getNote());
				prenotazioneObj.addProperty("start", pren.getPrenotatoDal().toString());
				prenotazioneObj.addProperty("end", pren.getPrenotatoAl().toString());
				prenotazioneObj.addProperty("overlap", false);
				prenotazioneObj.addProperty("editable", false);
				prenotazioneObj.addProperty("nome", pren.getDotazione().getModello());
				prenotazioneObj.addProperty("id", ""+pren.getDotazione().getId());
				prenotazioneObj.addProperty("backgroundColor", "#11b200");
				prenotazioneObj.addProperty("borderColor", "#11b200");
				prenotaizoneArr.add(prenotazioneObj);
		 
				
			}
	        
	        
	        
	        
	        
	        
	       

	            myObj.addProperty("success", true);

	          
	          
	            
	       
	        myObj.add("dataInfo", prenotaizoneArr);
	        
	        request.getSession().setAttribute("myObj",myObj);
	        //request.getSession().setAttribute("listaPrenotazioni",listaPrenotazioni);
	        
			 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioPrenotazioneDotazione.jsp");
		     dispatcher.forward(request,response);

		 	session.getTransaction().commit();
			session.close();
		} 
		catch (Exception ex) {
			
		//	ex.printStackTrace();
			   session.getTransaction().commit();
				session.close();
		     request.setAttribute("error",STIException.callException(ex));
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
