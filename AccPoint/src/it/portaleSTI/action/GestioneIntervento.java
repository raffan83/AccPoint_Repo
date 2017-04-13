package it.portaleSTI.action;

import it.portaleSTI.DAO.GestioneStrumentoDAO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.StatoInterventoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneInterventoBO;
import it.portaleSTI.bo.GestioneListaStrumenti;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
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
import com.google.gson.JsonParser;

/**
 * Servlet implementation class GestioneIntervento
 */
@WebServlet(name = "gestioneIntervento", urlPatterns = { "/gestioneIntervento.do" })
public class GestioneIntervento extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneIntervento() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		
		try 
		{
			String action=request.getParameter("action");
			
			
			if(action ==null || action.equals(""))
			{
			String idCommessa=request.getParameter("idCommessa");
			
			ArrayList<CommessaDTO> listaCommesse =(ArrayList<CommessaDTO>) request.getSession().getAttribute("listaCommesse");
			
			CommessaDTO comm=getCommessa(listaCommesse,idCommessa);
			
			request.getSession().setAttribute("commessa", comm);
			
			ArrayList<InterventoDTO> listaInterventi =GestioneInterventoBO.getListaInterventi(idCommessa);	
			
			request.getSession().setAttribute("listaInterventi", listaInterventi);
		
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneIntervento.jsp");
	     	dispatcher.forward(request,response);
		
		 } 
			 if(action !=null && action.equals("new"))
		 {
		JsonObject myObj = new JsonObject();
		PrintWriter out = response.getWriter();
			
		try
		{			
			String json = request.getParameter("dataIn");
			
			JsonElement jelement = new JsonParser().parse(json);
			
			
			

		    CommessaDTO comm=(CommessaDTO)request.getSession().getAttribute("commessa");
			InterventoDTO intervento= new InterventoDTO();
			java.sql.Date date = new java.sql.Date(new java.util.Date().getTime());
			intervento.setDataCreazione(date);
			intervento.setPressoDestinatario(Integer.parseInt(jelement.getAsJsonObject().get("sede").toString().replaceAll("\"", "")));
			intervento.setUser((UtenteDTO)request.getSession().getAttribute("userObj"));
			intervento.setIdSede(comm.getK2_ANAGEN_INDR());
			intervento.setId_cliente(comm.getID_ANAGEN());
			intervento.setNome_sede(comm.getANAGEN_INDR_DESCR());
			intervento.setIdCommessa(""+comm.getID_ANAGEN_COMM());
			intervento.setStatoIntervento(new StatoInterventoDTO());
			
			CompanyDTO cmp =(CompanyDTO)request.getSession().getAttribute("usrCompany");
			intervento.setCompany(cmp);
			String filename = GestioneListaStrumenti.creaPacchetto(comm.getID_ANAGEN(),comm.getK2_ANAGEN_INDR(),cmp);
			intervento.setNomePack(filename);
			
			intervento.setnStrumentiGenerati(GestioneListaStrumenti.getListaStrumentiPerSediAttiviNEW(""+comm.getID_ANAGEN(),""+comm.getANAGEN_INDR_DESCR(),cmp.getId()).size());
			intervento.setnStrumentiMisurati(0);
			intervento.setnStrumentiNuovi(0);
			
			GestioneIntervento.save(intervento);
			
			myObj.addProperty("success", true);
		
			out.print(myObj);
		}
		catch (Exception e) 
		{
			myObj.addProperty("success", false);
			out.print(myObj);
			e.printStackTrace();

		}
			
		 }	
		
		
		}
		
		catch (Exception ex) {
			 ex.printStackTrace();
	   	     request.setAttribute("error",STIException.callException(ex));
	   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
	   	     dispatcher.forward(request,response);	
		}
		
	}


	private static void save(InterventoDTO intervento) {
		// TODO Auto-generated method stub
		
	}

	private CommessaDTO getCommessa(ArrayList<CommessaDTO> listaCommesse,String idCommessa) {

		for (CommessaDTO comm : listaCommesse)
		{
			if(comm.getID_COMMESSA()==Integer.parseInt(idCommessa))
			return comm;
		}
			
		
		return null;
	}

}
