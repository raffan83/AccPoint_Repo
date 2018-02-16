package it.portaleSTI.action;

import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.DatatablesParamsDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneCommesseBO;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonPrimitive;

/**
 * Servlet implementation class GestioneCommessa
 */
@WebServlet(name = "listaCommesse", urlPatterns = { "/listaCommesse.do" })

public class ListaCommesse extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaCommesse() {
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
		
		 
		try {
			String action = request.getParameter("action");
			if(action == null || action.equals("")) {
				
				response.setContentType("text/html");

				CompanyDTO company =(CompanyDTO)request.getSession().getAttribute("usrCompany");
				
				UtenteDTO user = (UtenteDTO)request.getSession().getAttribute("userObj");
						
				ArrayList<CommessaDTO> listaCommesse =GestioneCommesseBO.getListaCommesse(company,"",user);
				
				request.getSession().setAttribute("listaCommesse", listaCommesse);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaCommesse.jsp");
		     	dispatcher.forward(request,response);
			
			}else if(action.equals("lista")) {
				response.setContentType("application/json");
				DatatablesParamsDTO param = new DatatablesParamsDTO(request);    

				String sEcho = param.sEcho;
				int iTotalRecords; // total number of records (unfiltered)
				int iTotalDisplayRecords; //value will be set when code filters companies by keyword
				JsonArray data = new JsonArray(); //data that will be shown in the table

				
				ArrayList<CommessaDTO> listaCommesse = (ArrayList<CommessaDTO>) request.getSession().getAttribute("listaCommesse");
				
				iTotalRecords = listaCommesse.size();
				List<CommessaDTO> commesse = new LinkedList<CommessaDTO>();
				for(CommessaDTO c : listaCommesse){
					if(	c.getID_COMMESSA().toLowerCase().contains(param.sSearch.toLowerCase())
						||
						c.getID_ANAGEN_NOME().toLowerCase().contains(param.sSearch.toLowerCase())
						||
						c.getANAGEN_INDR_DESCR().toLowerCase().contains(param.sSearch.toLowerCase())
						||
						c.getANAGEN_INDR_INDIRIZZO().toLowerCase().contains(param.sSearch.toLowerCase())
						||
						c.getSYS_STATO().toLowerCase().contains(param.sSearch.toLowerCase())
						)
					{
						commesse.add(c); // add company that matches given search criterion
					}
				}
				iTotalDisplayRecords = commesse.size(); // number of companies that match search criterion should be returned
				
				final int sortColumnIndex = param.iSortColumnIndex;
				final int sortDirection = param.sSortDirection.equals("asc") ? -1 : 1;
				
				Collections.sort(commesse, new Comparator<CommessaDTO>(){
					@Override
					public int compare(CommessaDTO c1, CommessaDTO c2) {	
						switch(sortColumnIndex){
						case 0:
							return c1.getID_COMMESSA().compareTo(c2.getID_COMMESSA()) * sortDirection;
						case 1:
							return c1.getID_ANAGEN_NOME().compareTo(c2.getID_ANAGEN_NOME()) * sortDirection;
						case 2:
							return c1.getANAGEN_INDR_DESCR().compareTo(c2.getANAGEN_INDR_DESCR()) * sortDirection;
						case 3:
							return c1.getANAGEN_INDR_INDIRIZZO().compareTo(c2.getANAGEN_INDR_INDIRIZZO()) * sortDirection;
						case 4:
							return c1.getSYS_STATO().compareTo(c2.getSYS_STATO()) * sortDirection;
						}
						return 0;
					}
				});
				
				if(commesse.size()< param.iDisplayStart + param.iDisplayLength) {
					commesse = commesse.subList(param.iDisplayStart, commesse.size());
				} else {
					commesse = commesse.subList(param.iDisplayStart, param.iDisplayStart + param.iDisplayLength);
				}
			 
					JsonObject jsonResponse = new JsonObject();			
					jsonResponse.addProperty("sEcho", sEcho);
					jsonResponse.addProperty("iTotalRecords", iTotalRecords);
					jsonResponse.addProperty("iTotalDisplayRecords", iTotalDisplayRecords);
					
					DateFormat df = new SimpleDateFormat("dd/MM/yyyy");

					for(CommessaDTO c : commesse){
						JsonArray row = new JsonArray();
						row.add(new JsonPrimitive(""+c.getID_COMMESSA()));
						row.add(new JsonPrimitive(""+c.getID_ANAGEN_NOME()));
						row.add(new JsonPrimitive(c.getANAGEN_INDR_DESCR()+" "+c.getANAGEN_INDR_INDIRIZZO()));
						row.add(new JsonPrimitive(""+c.getSYS_STATO()));
						if(c.getFIR_CHIUSURA_DT()!=null) {
							row.add(new JsonPrimitive(df.format(c.getFIR_CHIUSURA_DT())));
						}
						row.add(new JsonPrimitive(df.format(c.getDT_COMMESSA())));
						data.add(row);
					}
					jsonResponse.add("aaData", data);
					
					response.setContentType("application/Json");
					response.getWriter().print(jsonResponse.toString());
					
				 

			}
			
		} 
		catch(Exception ex)
    	{
   		 ex.printStackTrace();
   	     request.setAttribute("error",STIException.callException(ex));
   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
   	     dispatcher.forward(request,response);	
   	}  
	}

}
