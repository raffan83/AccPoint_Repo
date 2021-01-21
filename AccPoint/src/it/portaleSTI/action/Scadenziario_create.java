package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.RegistroEventiDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneCampioneBO;


/**
 * Servlet implementation class Scadenziario_create
 */
@WebServlet(name="Scadenziario_create" , urlPatterns = { "/Scadenziario_create.do" })

public class Scadenziario_create extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final Logger logger = Logger.getLogger(Scadenziario_create.class);
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Scadenziario_create() {
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
		
		try
		{
		CompanyDTO cmp=(CompanyDTO)request.getSession().getAttribute("usrCompany");
		
		ArrayList<CampioneDTO> listaCampioni =GestioneCampioneDAO.getListaCampioniInServizio();
		ArrayList<RegistroEventiDTO> listaManutenzioni = GestioneCampioneBO.getListaManutenzioniNonObsolete();
		
		logger.error(Utility.getMemorySpace()+" Action: "+"Scadenziario_create" +" - Utente: "+((UtenteDTO)request.getSession().getAttribute("userObj")).getNominativo());
		
		HashMap<String,Integer>  hMapCampioni = new HashMap<String,Integer>();
		HashMap<String, Integer> mapManutenzioni = new HashMap<String, Integer>();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		for (CampioneDTO campione:listaCampioni)
		{
			if(campione.getDataScadenza()!=null)
			{
				String data=sdf.format(campione.getDataScadenza());
				
				if(!hMapCampioni.containsKey(data))
				{
					hMapCampioni.put(data,1);
				}
				else
				{
					int value=hMapCampioni.get(data)+1;
					hMapCampioni.put(data, value);
				}
			
			}
			
		}
		
		
		for (RegistroEventiDTO man : listaManutenzioni) {
			if(man.getCampione().getFrequenza_manutenzione()!=0) {
				int i=1;
				
				Calendar calendar = Calendar.getInstance();
				calendar.setTime(man.getData_evento());
				calendar.add(Calendar.MONTH, man.getCampione().getFrequenza_manutenzione());
				
				Date date = calendar.getTime();
				
				if(!mapManutenzioni.containsKey(sdf.format(date))) {
					mapManutenzioni.put(sdf.format(date),1);
				}else {
					int value=mapManutenzioni.get(sdf.format(date))+1;
					mapManutenzioni.put(sdf.format(date),value);
				}
				
//				if(mapManutenzioni.get(sdf.format(date))!=null) {					
//					
//					i= mapManutenzioni.get(sdf.format(date))+1;
//				}
				
			//	mapManutenzioni.put(sdf.format(date), i);
			}
		}
		
		ArrayList<String> lista = new ArrayList<>();
		
		 Iterator it = hMapCampioni.entrySet().iterator();
		    while (it.hasNext()) {
		        Map.Entry pair = (Map.Entry)it.next();
		        lista.add(pair.getKey() + ";" + pair.getValue());
		        it.remove(); 
		    }
		    
			ArrayList<String> lista_manutenzioni = new ArrayList<>();
			
			
			 Iterator id_manutenzione = mapManutenzioni.entrySet().iterator();
	
			    while (id_manutenzione.hasNext()) {
			        Map.Entry pair = (Map.Entry)id_manutenzione.next();
			        lista_manutenzioni.add(pair.getKey() + ";" + pair.getValue());
			        id_manutenzione.remove(); 
			    }
		
		PrintWriter out = response.getWriter();
		
		 Gson gson = new Gson(); 
	        JsonObject myObj = new JsonObject();

	        JsonElement obj = gson.toJsonTree(lista);
	        JsonElement obj_manutenzione = gson.toJsonTree(lista_manutenzioni);
	       
	            myObj.addProperty("success", true);
	  
	        myObj.add("dataInfo", obj); 
	        myObj.add("obj_manutenzione", obj_manutenzione);
	        System.out.println(myObj.toString());
	       
	        out.println(myObj.toString());

	        out.close();
		}
		catch(Exception ex)
    	{
    		 ex.printStackTrace();
    	     request.setAttribute("error",STIException.callException(ex));
       	     request.getSession().setAttribute("exception", ex);
    		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
    	     dispatcher.forward(request,response);	
    	}  
	}

}
