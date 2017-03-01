package it.portaleSTI.action;

import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneListaStrumenti;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.HibernateException;

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
		
		if(Utility.checkSession(request,response,getServletContext()))return;
		
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
				ArrayList<StrumentoDTO> listaStrumentiPerSede=(ArrayList<StrumentoDTO>)GestioneListaStrumenti.getListaStrumentiPerSediAttiviNEW(idCliente,idSede,idCompany.getId()); 

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
		        out.println(myObj.toString());
		        System.out.println("obj send");
		        out.close();
				} 
			}    
		//	response.getWriter().write("Ciao Mondo");
			
		//	RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaStrumenti.jsp");
	    // 	dispatcher.forward(request,response);
			
		} catch (HibernateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}

}
