package it.portaleSTI.action;

import it.portaleSTI.DAO.GestioneTLDAO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneListaStrumenti;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

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
 * Servlet implementation class ListaStrumentiSede
 */
@WebServlet(name= "/listaStrumentiSedeNew", urlPatterns = { "/listaStrumentiSedeNew.do" })
public class ListaStrumentiSedeNew extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaStrumentiSedeNew() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		
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
				
			
				CompanyDTO idCompany=(CompanyDTO)request.getSession().getAttribute("usrCompany");
				
				if(idCompany!=null)
				{
					
				ArrayList<TipoStrumentoDTO> listaTipoStrumento = GestioneTLDAO.getListaTipoStrumento();
				ArrayList<TipoRapportoDTO> listaTipoRapporto = GestioneTLDAO.getListaTipoRapporto();
				ArrayList<TipoStrumentoDTO> listaStatoStrumento = GestioneTLDAO.getListaStatoStrumento();

				ArrayList<StrumentoDTO> listaStrumentiPerSede=GestioneListaStrumenti.getListaStrumentiPerSediAttiviNEW(idCliente,idSede,idCompany.getId()); 

				request.getSession().setAttribute("listaStrumenti", listaStrumentiPerSede);
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
		        request.getSession().setAttribute("id_Cliente",idCliente);
		        request.getSession().setAttribute("id_Sede",idSede);
		        request.getSession().setAttribute("listaTipoStrumento",listaTipoStrumento);
		        request.getSession().setAttribute("listaStatoStrumento",listaStatoStrumento);
		        request.getSession().setAttribute("listaTipoRapporto",listaTipoRapporto);
				 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaStrumentiSede.jsp");
			     dispatcher.forward(request,response);
		        
		        
				} 
			}    
		}catch(Exception ex)
    	{
   		 ex.printStackTrace();
   	     request.setAttribute("error",STIException.callException(ex));
   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
   	     dispatcher.forward(request,response);	
   	}  
	}

}
