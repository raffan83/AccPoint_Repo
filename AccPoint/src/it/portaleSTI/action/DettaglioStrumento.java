package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

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

import it.portaleSTI.DAO.GestioneTLDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClassificazioneDTO;
import it.portaleSTI.DTO.LuogoVerificaDTO;
import it.portaleSTI.DTO.StatoStrumentoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneStrumentoBO;

/**
 * Servlet implementation class DettaglioStrumento
 */

@WebServlet(name="dettaglioStrumento" , urlPatterns = { "/dettaglioStrumento.do" })
public class DettaglioStrumento extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DettaglioStrumento() {
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
		Session session =SessionFacotryDAO.get().openSession();
 		
		try
		{

		String idS = request.getParameter("id_str");

		StrumentoDTO dettaglio = GestioneStrumentoBO.getStrumentoById(idS, session);
		
		String s =null;
		
		s.toCharArray();
		
		PrintWriter out = response.getWriter();
		
		 Gson gson = new Gson(); 
	        JsonObject myObj = new JsonObject();

	        JsonElement obj = gson.toJsonTree(dettaglio);
	       

	            myObj.addProperty("success", true);
	       
	        myObj.add("dataInfo", obj);
//	        out.println(myObj.toString());
//	        System.out.println(myObj.toString());
//	        out.close();
	        
	        int id_Sede = dettaglio.getId__sede_();
	        int id_cliente = dettaglio.getId_cliente();
	        
	        request.getSession().setAttribute("myObj",myObj);
	        
			ArrayList<TipoStrumentoDTO> listaTipoStrumento = GestioneTLDAO.getListaTipoStrumento();
			ArrayList<TipoRapportoDTO> listaTipoRapporto = GestioneTLDAO.getListaTipoRapporto();
			ArrayList<StatoStrumentoDTO> listaStatoStrumento = GestioneTLDAO.getListaStatoStrumento();
			ArrayList<LuogoVerificaDTO> listaLuogoVerifica = GestioneTLDAO.getListaLuogoVerifica();
			ArrayList<ClassificazioneDTO> listaClassificazione = GestioneTLDAO.getListaClassificazione();

			
	        request.getSession().setAttribute("listaTipoStrumento",listaTipoStrumento);
	        request.getSession().setAttribute("listaStatoStrumento",listaStatoStrumento);
	        request.getSession().setAttribute("listaTipoRapporto",listaTipoRapporto);
	        request.getSession().setAttribute("listaLuogoVerifica",listaLuogoVerifica);
	        request.getSession().setAttribute("listaClassificazione",listaClassificazione);
	        request.getSession().setAttribute("id_Sede", String.valueOf(id_Sede));
	        request.getSession().setAttribute("id_Cliente", String.valueOf(id_cliente));
	   
 	    	session.close();
	    				
	        
			 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioStrumento.jsp");
		     dispatcher.forward(request,response);
		     
		 
	        
		}catch(Exception ex)
    	{
			
 	    session.close();
			
   		 ex.printStackTrace();
   	     request.setAttribute("error",STIException.callException(ex));
   	     request.getSession().setAttribute("exception",ex);
   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
   	     dispatcher.forward(request,response);	
   	}  
	}
	
	

	private StrumentoDTO getDettaglio(ArrayList<StrumentoDTO> listaStrumenti,String idS) {
		StrumentoDTO strumento =null;
		
		try
		{
		
		
		
		for (int i = 0; i < listaStrumenti.size(); i++) {
			
			if(listaStrumenti.get(i).get__id()==Integer.parseInt(idS))
			{
				return listaStrumenti.get(i);
			}
		}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			strumento=null;
			
		}
		return strumento;
	}

}
