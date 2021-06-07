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
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.StatoInterventoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneInterventoBO;

/**
 * Servlet implementation class ListaStrumentiSede
 */
@WebServlet(name= "/listaInterventiSede", urlPatterns = { "/listaInterventiSede.do" })
public class ListaInterventiSede extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaInterventiSede() {
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
			
			String param = request.getParameter("idSede");
			
			
			
			if(param!=null && param.length()>0 && !param.equals("null"))
			{
				
				String[] tmp=param.split(";");
				
				String idSede;
				String idCliente=tmp[1];
				
				if(tmp[0]!=null && !tmp[0].equalsIgnoreCase("null"))
				{
					idSede=tmp[0].split("_")[0];
				}
				else
				{
					idSede="0";
				}
				
				System.out.println("id_Cliente: "+idCliente +"\nid_Sede: "+idSede);
				
				UtenteDTO user = (UtenteDTO)request.getSession().getAttribute("userObj");
				CompanyDTO idCompany=(CompanyDTO)request.getSession().getAttribute("usrCompany");
				
				if(idCompany!=null)
				{

					
					ArrayList<InterventoDTO> listaInterventiPerSede = GestioneInterventoBO.getListaInterventiDaSede(idCliente,idSede,idCompany.getId(),user, session); 
					request.getSession().setAttribute("listaInterventi", listaInterventiPerSede);
					ArrayList<StatoInterventoDTO> listaStatoInterventi = GestioneTLDAO.getListaStatoIntervento(session);
					request.getSession().setAttribute("listaStatoInterventi", listaStatoInterventi);
					
					
					PrintWriter out = response.getWriter();
				
					Gson gson = new Gson();
			        JsonObject myObj = new JsonObject();
	
			        JsonElement obj = gson.toJsonTree(listaInterventiPerSede);
			       
			        if(listaInterventiPerSede!=null && listaInterventiPerSede.size()>0){
			            myObj.addProperty("success", true);
			        }
			        else {
			            myObj.addProperty("success", false);
			        }
	
	
			        myObj.add("dataInfo", obj);
			        
			        request.getSession().setAttribute("myObj",myObj);
			        request.getSession().setAttribute("id_Cliente",idCliente);
			        request.getSession().setAttribute("id_Sede",idSede);

					 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaInterventiSede.jsp");
				     dispatcher.forward(request,response);
			        
		        
				} 
			}
		session.getTransaction().commit();
		session.close();
		}
		
		
		catch(Exception ex)
    	{
		 session.getTransaction().rollback();
		 session.close();
   		 ex.printStackTrace();
   	     request.setAttribute("error",STIException.callException(ex));
   	     request.getSession().setAttribute("exception", ex);
   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
   	     dispatcher.forward(request,response);	
   	} 
		
	}

}
