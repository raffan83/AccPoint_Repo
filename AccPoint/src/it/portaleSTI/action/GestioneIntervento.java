package it.portaleSTI.action;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.StatoInterventoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneCommesseBO;
import it.portaleSTI.bo.GestioneInterventoBO;
import it.portaleSTI.bo.GestioneStrumentoBO;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Query;
import org.hibernate.Session;

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
		
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		JsonObject myObj = new JsonObject();
		PrintWriter  out = response.getWriter();
		String action=request.getParameter("action");
		try 
		{
			
	
			if(action ==null || action.equals(""))
			{
			String idCommessa=request.getParameter("idCommessa");
			
		//	ArrayList<CommessaDTO> listaCommesse =(ArrayList<CommessaDTO>) request.getSession().getAttribute("listaCommesse");
			
	
			
			CommessaDTO comm=GestioneCommesseBO.getCommessaById(idCommessa);
			
			
			
			request.getSession().setAttribute("commessa", comm);
			

			List<InterventoDTO> listaInterventi =GestioneInterventoBO.getListaInterventi(idCommessa,session);	
			
			if(comm.getSYS_STATO().equals("1CHIUSA")) 
			{
				StatoInterventoDTO stato = new StatoInterventoDTO();
				stato.setId(2);
				stato.setDescrizione("CHIUSO");
				for (InterventoDTO intervento :listaInterventi) 
				{
					intervento.setStatoIntervento(stato);
					GestioneInterventoBO.update(intervento, session);
				}
			}
			
			request.getSession().setAttribute("listaInterventi", listaInterventi);

			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneIntervento.jsp");
	     	dispatcher.forward(request,response);
			}

	if(action !=null && action.equals("new")){
		 
		
			
				
			String json = request.getParameter("dataIn");
			
			JsonElement jelement = new JsonParser().parse(json);
			

		    CommessaDTO comm=(CommessaDTO)request.getSession().getAttribute("commessa");
			InterventoDTO intervento= new InterventoDTO();
			intervento.setDataCreazione(Utility.getActualDateSQL());
			intervento.setPressoDestinatario(Integer.parseInt(jelement.getAsJsonObject().get("sede").toString().replaceAll("\"", "")));
			intervento.setUser((UtenteDTO)request.getSession().getAttribute("userObj"));
			intervento.setIdSede(comm.getK2_ANAGEN_INDR_UTIL());
			intervento.setId_cliente(comm.getID_ANAGEN_UTIL());
			
			String nomeCliente="";
			
		//	if(comm.getANAGEN_INDR_INDIRIZZO()!=null && comm.getANAGEN_INDR_INDIRIZZO().length()>0)
		//	{
		//		nomeCliente=comm.getID_ANAGEN_NOME()+ " - "+ comm.getANAGEN_INDR_INDIRIZZO();
		//	}else
		//	{
				nomeCliente=comm.getNOME_UTILIZZATORE()+ " - "+ comm.getINDIRIZZO_UTILIZZATORE(); 
		//	}
			
			intervento.setNome_sede(nomeCliente);
			intervento.setIdCommessa(""+comm.getID_COMMESSA());
			intervento.setStatoIntervento(new StatoInterventoDTO());
			
			CompanyDTO cmp =(CompanyDTO)request.getSession().getAttribute("usrCompany");
			intervento.setCompany(cmp);
			
			String filename = GestioneStrumentoBO.creaPacchetto(comm.getID_ANAGEN_UTIL(),comm.getK2_ANAGEN_INDR_UTIL(),cmp,comm.getID_ANAGEN_NOME(),session,intervento);
			
			intervento.setNomePack(filename);
			
			intervento.setnStrumentiGenerati(GestioneStrumentoBO.getListaStrumentiPerSediAttiviNEW(""+comm.getID_ANAGEN_UTIL(),""+comm.getK2_ANAGEN_INDR_UTIL(),cmp.getId(), session).size());
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
		if(action !=null && action.equals("chiudi")){
			 
			
			
			
			String idIntervento = request.getParameter("idIntervento" );
			InterventoDTO intervento = GestioneInterventoBO.getIntervento(idIntervento);
			
				StatoInterventoDTO stato = new StatoInterventoDTO();
				stato.setId(2);
				intervento.setStatoIntervento(stato);		
						
	
				GestioneInterventoBO.update(intervento,session);
				
				Gson gson = new Gson();
			
				// 2. Java object to JSON, and assign to a String
				String jsonInString = gson.toJson(intervento);
	
				
				myObj.addProperty("success", true);
				myObj.addProperty("intervento", jsonInString);
				myObj.addProperty("messaggio", "Intervento chiuso");
			
			out.print(myObj);
		}
		if(action !=null && action.equals("apri")){
			 
			
			
			
			String idIntervento = request.getParameter("idIntervento" );

			InterventoDTO intervento = GestioneInterventoBO.getIntervento(idIntervento);
			
				StatoInterventoDTO stato = new StatoInterventoDTO();
				stato.setId(1);
				intervento.setStatoIntervento(stato);		
						
	
				GestioneInterventoBO.update(intervento,session);
				
				Gson gson = new Gson();
			
				// 2. Java object to JSON, and assign to a String
				String jsonInString = gson.toJson(intervento);
	
				
				myObj.addProperty("success", true);
				myObj.addProperty("intervento", jsonInString);
				myObj.addProperty("messaggio", "Intervento aperto");
			
			out.print(myObj);
		}
		
		if(action !=null && action.equals("nuova_sede")) {
			String id_intervento = request.getParameter("id_intervento");
			String nome_sede = request.getParameter("nome_sede");
			
			InterventoDTO intervento = GestioneInterventoBO.getIntervento(id_intervento);
			
			intervento.setNome_sede(nome_sede);
			
			GestioneInterventoBO.update(intervento, session);
			
			Gson gson = new Gson();
			String jsonInString = gson.toJson(intervento);
			
			
			myObj.addProperty("success", true);
			myObj.addProperty("intervento", jsonInString);
			myObj.addProperty("messaggio", "Sede aggiornata con successo!");
		
		out.print(myObj);
			
		}
	
			session.getTransaction().commit();
			session.close();	
		
		}catch (Exception ex) 
		{	
		  session.getTransaction().rollback();
		  ex.printStackTrace(); 
		  
		  if(action==null || action=="") {
			  myObj.addProperty("success", false);
		  }
		  
		  myObj.addProperty("success", false);	
		  if(action !=null && action.equals("new")){
			  myObj.addProperty("messaggio", "Errore creazione intervento.");
		  }
		  if(action !=null && action.equals("chiudi")){
			  myObj.addProperty("messaggio", "Errore chiusura intervento.");
		  }
		  request.getSession().setAttribute("exception", ex);
		  out.print(myObj);
	   	     
		}
		
	}
}
