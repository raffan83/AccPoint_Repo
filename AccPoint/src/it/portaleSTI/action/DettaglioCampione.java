package it.portaleSTI.action;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

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
		
		if(Utility.checkSession(request,response,getServletContext()))return;
		
	try{	
		String idC = request.getParameter("idCamp");
		System.out.println("*********************"+idC);
		
		HashMap<Integer, Integer> prenotazioni=null;
		HashMap<Integer, String> company=null;
		
		if(Utility.checkSession(request.getSession(),"SES_Prenotazioni"))
		{
			prenotazioni=(HashMap<Integer, Integer>)request.getSession().getAttribute("SES_Prenotazioni");
		}else
		{
			prenotazioni=GestioneCampioneDAO.getListPrenotazioni();
			request.getSession().setAttribute("SES_Prenotazioni", prenotazioni);
		}
		
		String myId=""+((CompanyDTO)request.getSession().getAttribute("usrCompany")).getId();
		
		ArrayList<CampioneDTO> listaCampioni = (ArrayList<CampioneDTO>)request.getSession().getAttribute("listaCampioni");
		
		CampioneDTO dettaglio =getCampione(listaCampioni,idC);
	
		PrintWriter out = response.getWriter();
		
		 Gson gson = new Gson(); 
	        JsonObject myObj = new JsonObject();

	        JsonElement obj = gson.toJsonTree(dettaglio);
	       

	            myObj.addProperty("success", true);
	            
	            System.out.println(prenotazioni.get(idC));
	            
	            if(prenotazioni.get(Integer.parseInt(idC))!=null )
	            {
	            	myObj.addProperty("prenotazione", false);
	            }
	            else
	            {
	            	myObj.addProperty("prenotazione", true);
	            }
	            
	            if(dettaglio.getId_company_utilizzatore()== Integer.parseInt(myId) && (dettaglio.getStatoPrenotazione().equals("0")||dettaglio.getStatoPrenotazione().equals("1")))
	            {
	            	myObj.addProperty("controllo", true);
	            }
	            else
	            {
	            	myObj.addProperty("controllo", false);
	            }
	            
	       
	        myObj.add("dataInfo", obj);
	        out.println(myObj.toString());
	        System.out.println(myObj.toString());
	        out.close();
	        
	
	}catch(Exception ex)
	{
		 ex.printStackTrace();
	     request.setAttribute("error",STIException.callException(ex));
		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
	     dispatcher.forward(request,response);	
	}  
	
	}
	
	private CampioneDTO getCampione(ArrayList<CampioneDTO> listaCampioni,String idC) {
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
			
		}
		return campione;
	}

}
