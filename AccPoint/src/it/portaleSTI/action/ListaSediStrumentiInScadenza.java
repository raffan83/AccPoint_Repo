package it.portaleSTI.action;

import it.portaleSTI.DAO.GestioneTLDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClassificazioneDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.LuogoVerificaDTO;
import it.portaleSTI.DTO.StatoStrumentoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneStrumentoBO;

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

import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

/**
 * Servlet implementation class ListaStrumentiSede
 */
@WebServlet(name= "/listaSediStrumentiInScadenza", urlPatterns = { "/listaSediStrumentiInScadenza.do" })
public class ListaSediStrumentiInScadenza extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaSediStrumentiInScadenza() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		response.setContentType("text/html");
		
		 
		try {
			
			String dateFrom =request.getParameter("dateFrom");
			String dateTo =request.getParameter("dateTo");
			
			
			if(dateFrom!=null && dateFrom.length()>0 && !dateFrom.equals("null") && dateTo!=null && dateTo.length()>0 && !dateTo.equals("null"))
			{
				
				
					
				ArrayList<TipoStrumentoDTO> listaTipoStrumento = GestioneTLDAO.getListaTipoStrumento();
				ArrayList<TipoRapportoDTO> listaTipoRapporto = GestioneTLDAO.getListaTipoRapporto();
				ArrayList<StatoStrumentoDTO> listaStatoStrumento = GestioneTLDAO.getListaStatoStrumento();
				ArrayList<LuogoVerificaDTO> listaLuogoVerifica = GestioneTLDAO.getListaLuogoVerifica();
				ArrayList<ClassificazioneDTO> listaClassificazione = GestioneTLDAO.getListaClassificazione();
				ArrayList<StrumentoDTO> listaStrumenti=GestioneStrumentoBO.getListaStrumenti(0, dateFrom, dateTo); 

				HashMap<String,ArrayList<StrumentoDTO>> listaStrumentiPerSede = new HashMap<String,ArrayList<StrumentoDTO>>();
				
				for (StrumentoDTO strumento : listaStrumenti) {
					if(listaStrumentiPerSede.containsKey(""+strumento.getId__sede_())) {
						ArrayList<StrumentoDTO> listaS = listaStrumentiPerSede.get(""+strumento.getId__sede_());
						listaS.add(strumento);
						listaStrumentiPerSede.put(""+strumento.getId__sede_(), listaS);
					}else {
						ArrayList<StrumentoDTO> listaS = new ArrayList<StrumentoDTO>();
						listaS.add(strumento);
						listaStrumentiPerSede.put(""+strumento.getId__sede_(), listaS);
					}
					
				}
				
				request.getSession().setAttribute("listaStrumentiPerSede", listaStrumentiPerSede);
				PrintWriter out = response.getWriter();
			
				Gson gson = new Gson(); 
		        JsonObject myObj = new JsonObject();

		        JsonElement obj = gson.toJsonTree(listaStrumentiPerSede);
		       
		        if(listaStrumentiPerSede!=null && listaStrumentiPerSede.size()>0){
		            myObj.addProperty("success", true);
		        }
		        else {
		            myObj.addProperty("success", false);
		        }


		        myObj.add("dataInfo", obj);
		        
		        request.getSession().setAttribute("myObj",myObj);

		        request.getSession().setAttribute("listaTipoStrumento",listaTipoStrumento);
		        request.getSession().setAttribute("listaStatoStrumento",listaStatoStrumento);
		        request.getSession().setAttribute("listaTipoRapporto",listaTipoRapporto);
		        request.getSession().setAttribute("listaLuogoVerifica",listaLuogoVerifica);
		        request.getSession().setAttribute("listaClassificazione",listaClassificazione);
				 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaSediStrumentiInScadenza.jsp");
			     dispatcher.forward(request,response);
		        
		        
				
			}
		session.getTransaction().commit();
		session.close();
		}
		
		
		catch(Exception ex)
    	{
		 session.getTransaction().rollback();
   		 ex.printStackTrace();
   	     request.setAttribute("error",STIException.callException(ex));
   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
   	     dispatcher.forward(request,response);	
   	} 
		
	}

}