package it.portaleSTI.action;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.GestioneTLDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.TipoCampioneDTO;
import it.portaleSTI.DTO.TipoGrandezzaDTO;
import it.portaleSTI.DTO.UnitaMisuraDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;

/**
 * Servlet implementation class listaCampioni
 */
@WebServlet(name="listaCampioniPrenotabili" , urlPatterns = { "/listaCampioniPrenotabili.do" })

public class ListaCampioniPrenotabili extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaCampioniPrenotabili() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		response.setContentType("text/html");
		
		try 
		{
		
			
			ArrayList<CampioneDTO> listaCampioni=new ArrayList<CampioneDTO>();
			
			
				listaCampioni =GestioneCampioneDAO.getListaCampioniPrenotabili();
			
			
			
			
			 ArrayList<TipoGrandezzaDTO> tgArr = GestioneTLDAO.getListaTipoGrandezza(session);
		        JsonArray tgArrJson = new JsonArray();
		        JsonObject umArrJson = new JsonObject();
		        JsonObject jsObjDefault = new JsonObject();
		        jsObjDefault.addProperty("label", "Seleziona");
		        jsObjDefault.addProperty("value", "0");
				tgArrJson.add(jsObjDefault);
		        for (Iterator iterator = tgArr.iterator(); iterator.hasNext();) {
					TipoGrandezzaDTO tipoGrandezzaDTO = (TipoGrandezzaDTO) iterator.next();
					JsonObject jsObj = new JsonObject();
					jsObj.addProperty("label", tipoGrandezzaDTO.getNome().replace("'", " "));
					jsObj.addProperty("value", ""+tipoGrandezzaDTO.getId());

					JsonArray umArrJsonChild = new JsonArray();

			        for (Iterator iterator2 = tipoGrandezzaDTO.getListaUM().iterator(); iterator2.hasNext();) {
						UnitaMisuraDTO unitaMisuraDTO = (UnitaMisuraDTO) iterator2.next();
						JsonObject jsObj2 = new JsonObject();
						jsObj2.addProperty("label", unitaMisuraDTO.getNome().replace("'", " "));
						jsObj2.addProperty("value", ""+unitaMisuraDTO.getId());
						umArrJsonChild.add(jsObj2);
					}
				        
			        umArrJson.add(""+tipoGrandezzaDTO.getId(), umArrJsonChild);
				     tgArrJson.add(jsObj);
				}		        		 
		        
		        
		        request.getSession().setAttribute("listaTipoGrandezza",tgArrJson);
		        request.getSession().setAttribute("listaUnitaMisura",umArrJson);

			
			
			
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			ArrayList<TipoCampioneDTO> listaTipoCampione= GestioneTLDAO.getListaTipoCampione(session);
			request.getSession().setAttribute("listaTipoCampione",listaTipoCampione);
			request.getSession().setAttribute("listaCampioni",listaCampioni);
			session.close();
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaCampioniPrenotabili.jsp");
	     	dispatcher.forward(request,response);
		} 
		catch (Exception ex) {
			
			session.close();
			ex.printStackTrace();
		     request.setAttribute("error",STIException.callException(ex));
		     request.getSession().setAttribute("exception", ex);
			 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
			 dispatcher.forward(request,response);
		}
		 
	}

}
