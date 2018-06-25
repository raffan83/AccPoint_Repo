package it.portaleSTI.action;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;

import com.google.gson.Gson;
import com.google.gson.JsonArray;

import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.PuntoMisuraDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneMisuraBO;

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
			String action = request.getParameter("action");
			
			if(action==null || action.equals("")) {
			MisuraDTO misura = GestioneMisuraBO.getMiruraByID(Integer.parseInt(idMisura));
			
			
			request.getSession().setAttribute("misura", misura);
			
			int numeroTabelle = GestioneMisuraBO.getMaxTabellePerMisura(misura.getListaPunti());
			
			ArrayList<ArrayList<PuntoMisuraDTO>> arrayPunti = new ArrayList<ArrayList<PuntoMisuraDTO>>();
			
			for(int i = 0; i < numeroTabelle; i++){
				ArrayList<PuntoMisuraDTO> punti = GestioneMisuraBO.getListaPuntiByIdTabella(misura.getListaPunti(), i+1);
				
				if(punti.size()>0)
				{
					
					arrayPunti.add(punti);
				}
			}

			request.getSession().setAttribute("arrayPunti", arrayPunti);

			Gson gson = new Gson();
			JsonArray listaPuntJson = gson.toJsonTree(arrayPunti).getAsJsonArray();
			request.setAttribute("listaPuntJson", listaPuntJson);
			
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioMisura.jsp");
	     	dispatcher.forward(request,response);
			}
			
			else if(action.equals("download")) {
				
				String id_punto = request.getParameter("id_punto");
				
				byte[] blob = GestioneMisuraBO.getFileBlob(Integer.parseInt(id_punto));

				response.setContentType("application/octet-stream");
				  
				 response.setHeader("Content-Disposition","attachment;filename=allegato.pdf");

	              ServletOutputStream outp = response.getOutputStream();
	          
	              ByteArrayInputStream bis = new ByteArrayInputStream(blob);
					
	              IOUtils.copy(bis, outp);
	              outp.close();

			}     
		
		}catch (Exception ex) {
			 ex.printStackTrace();
	   	     request.setAttribute("error",STIException.callException(ex));
	   	     request.getSession().setAttribute("exception",ex);
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
