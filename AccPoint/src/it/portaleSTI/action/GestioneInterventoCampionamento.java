package it.portaleSTI.action;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.AttivitaMilestoneDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.StatoInterventoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneInterventoBO;
import it.portaleSTI.bo.GestioneStrumentoBO;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

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
import com.google.gson.JsonParser;

/**
 * Servlet implementation class GestioneIntervento
 */
@WebServlet(name = "gestioneInterventoCampionamento", urlPatterns = { "/gestioneInterventoCampionamento.do" })
public class GestioneInterventoCampionamento extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneInterventoCampionamento() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		JsonObject myObj = new JsonObject();
		PrintWriter  out = response.getWriter();
		try 
		{
			
			
			String action=request.getParameter("action");
			
			
			if(action ==null || action.equals(""))
			{
			String idCommessa=request.getParameter("idCommessa");
			
			ArrayList<CommessaDTO> listaCommesse =(ArrayList<CommessaDTO>) request.getSession().getAttribute("listaCommesse");
			
			CommessaDTO comm=getCommessa(listaCommesse,idCommessa);
			
			request.getSession().setAttribute("commessa", comm);
			

			List<InterventoDTO> listaInterventi =GestioneInterventoBO.getListaInterventi(idCommessa,session);	
			
			request.getSession().setAttribute("listaInterventi", listaInterventi);

			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneInterventoCampionamento.jsp");
	     	dispatcher.forward(request,response);
			}

	if(action !=null && action.equals("new")){
		 
		
			
				
			String json = request.getParameter("dataIn");
			
			JsonElement jelement = new JsonParser().parse(json);
			
			String codiceArticolo = jelement.getAsJsonObject().get("sede").toString().replaceAll("\"", "");
			
			
		    CommessaDTO comm=(CommessaDTO)request.getSession().getAttribute("commessa");
			InterventoDTO intervento= new InterventoDTO();
			intervento.setDataCreazione(Utility.getActualDateSQL());
			intervento.setPressoDestinatario(Integer.parseInt(jelement.getAsJsonObject().get("sede").toString().replaceAll("\"", "")));
			intervento.setUser((UtenteDTO)request.getSession().getAttribute("userObj"));
			intervento.setIdSede(comm.getK2_ANAGEN_INDR());
			intervento.setId_cliente(comm.getID_ANAGEN());
			intervento.setNome_sede(comm.getANAGEN_INDR_DESCR());
			intervento.setIdCommessa(""+comm.getID_COMMESSA());
			intervento.setStatoIntervento(new StatoInterventoDTO());
			
			CompanyDTO cmp =(CompanyDTO)request.getSession().getAttribute("usrCompany");
			intervento.setCompany(cmp);
			String filename = GestioneStrumentoBO.creaPacchetto(comm.getID_ANAGEN(),comm.getK2_ANAGEN_INDR(),cmp,session,intervento);
			intervento.setNomePack(filename);
			
			intervento.setnStrumentiGenerati(GestioneStrumentoBO.getListaStrumentiPerSediAttiviNEW(""+comm.getID_ANAGEN(),""+comm.getK2_ANAGEN_INDR(),cmp.getId(), session).size());
			intervento.setnStrumentiMisurati(0);
			intervento.setnStrumentiNuovi(0);
			
			GestioneInterventoBO.save(intervento,session);
			
			Gson gson = new Gson();
		
			// 2. Java object to JSON, and assign to a String
			String jsonInString = gson.toJson(intervento);

			
			myObj.addProperty("success", true);
			myObj.addProperty("intervento", jsonInString);
			out.print(myObj);
		}
	
	if(action !=null && action.equals("newPage")){
		 
		
		
	    CommessaDTO comm=(CommessaDTO)request.getSession().getAttribute("commessa");

	    String idAttivita=request.getParameter("idRiga");
		
		ArrayList<AttivitaMilestoneDTO> listaAttivita = comm.getListaAttivita();
		
		AttivitaMilestoneDTO attivita = getAttivita(listaAttivita,idAttivita);
		
		request.getSession().setAttribute("commessa", comm);
		



		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/nuovoInterventoCampionamento.jsp");
     	dispatcher.forward(request,response);
	    
	    
	}
	
	
	session.getTransaction().commit();
	session.close();	
		
		}catch (Exception ex) 
		{	
		  session.getTransaction().rollback();
		  ex.printStackTrace(); 
		  
		  myObj.addProperty("success", false);
		  myObj.addProperty("messaggio", "Errore creazione intervento");
		  out.print(myObj);
	   	     
		}
		
	}

	private AttivitaMilestoneDTO getAttivita(ArrayList<AttivitaMilestoneDTO> listaAttivita, String idAttivita) {
		for (AttivitaMilestoneDTO att : listaAttivita)
		{
			if(att.getId_riga() == Integer.parseInt(idAttivita))
			return att;
		}
			
		return null;
	}

	private CommessaDTO getCommessa(ArrayList<CommessaDTO> listaCommesse,String idCommessa) {

		for (CommessaDTO comm : listaCommesse)
		{
			if(comm.getID_COMMESSA().equals(idCommessa))
			return comm;
		}
			
		
		return null;
	}

}
