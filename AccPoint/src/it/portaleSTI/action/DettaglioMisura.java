package it.portaleSTI.action;

import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.PuntoMisuraDTO;
import it.portaleSTI.DTO.StatoInterventoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneInterventoBO;
import it.portaleSTI.bo.GestioneMisuraBO;
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

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

/**
 * Servlet implementation class GestioneIntervento
 */
@WebServlet(name = "dettaglioMisura", urlPatterns = { "/dettaglioMisura.do" })
public class DettaglioMisura extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DettaglioMisura() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		/*
		 * CHIAMATA LINK PROVENIENTE DA STRUMENTI
		 * BISOGNA CONTROLLARE SE L'UTENTE HA I PERMESSI PER ACCEDERE ALLA MISURA
		 */
		
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		
		try 
		{
			
			
			String idMisura=request.getParameter("idMisura");
			
			MisuraDTO misura = GestioneMisuraBO.getMiruraByID(Integer.parseInt(idMisura));
			
			
			request.getSession().setAttribute("misura", misura);
			
			int numeroTabelle = GestioneMisuraBO.getTabellePerMisura(misura.getListaPunti());
			
			ArrayList<ArrayList<PuntoMisuraDTO>> arrayPunti = new ArrayList<ArrayList<PuntoMisuraDTO>>();
			
			for(int i = 0; i < numeroTabelle; i++){
				ArrayList<PuntoMisuraDTO> punti = GestioneMisuraBO.getListaPuntiByIdTabella(misura.getListaPunti(), i+1);
				
				arrayPunti.add(punti);
			}

			request.getSession().setAttribute("arrayPunti", arrayPunti);

			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioMisura.jsp");
	     	dispatcher.forward(request,response);
			

		
		}catch (Exception ex) {
			 ex.printStackTrace();
	   	     request.setAttribute("error",STIException.callException(ex));
	   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
	   	     dispatcher.forward(request,response);	
		}
		
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
