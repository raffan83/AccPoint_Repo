package it.portaleSTI.action;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.InterventoCampionamentoDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.PrenotazioneAccessorioDTO;
import it.portaleSTI.DTO.PrenotazioniDotazioneDTO;
import it.portaleSTI.DTO.PuntoMisuraDTO;
import it.portaleSTI.DTO.StatoInterventoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.CreateRelazioneCampionamento;
import it.portaleSTI.bo.GestioneCampionamentoBO;
import it.portaleSTI.bo.GestioneInterventoBO;
import it.portaleSTI.bo.GestioneMisuraBO;
import it.portaleSTI.bo.GestioneStrumentoBO;
import net.sf.dynamicreports.report.builder.component.ImageBuilder;

import java.awt.Image;
import java.awt.image.RenderedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.ghost4j.document.PDFDocument;
import org.ghost4j.renderer.SimpleRenderer;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

/**
 * Servlet implementation class GestioneIntervento
 */
@WebServlet(name = "creazioneRelazioneCampionamento", urlPatterns = { "/creazioneRelazioneCampionamento.do" })
public class CreazioneRelazioneCampionamento extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreazioneRelazioneCampionamento() {
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
		try 
		{

			
			
			String action=request.getParameter("action");
			
			
			if(action.equals("relazioneCampionamento"))
			{
				String idIntervento= request.getParameter("idIntervento");
				
				InterventoCampionamentoDTO interventoCampionamento=GestioneCampionamentoBO.getIntervento(idIntervento);
				
				ArrayList<PrenotazioniDotazioneDTO> listaPrenotazioniDotazioni = GestioneCampionamentoBO.getListaPrenotazioniDotazione(idIntervento,session);
				ArrayList<PrenotazioneAccessorioDTO> listaPrenotazioniAccessori = GestioneCampionamentoBO.getListaPrenotazioniAccessori(idIntervento,session);
		

				request.getSession().setAttribute("interventoCampionamento", interventoCampionamento);

				
				session.getTransaction().commit();
		     	session.close();	
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/creazioneRelazioneInterventoDatiCampionamento.jsp");     	
				dispatcher.forward(request,response);


				
			 	
			}
			
			if(action.equals("gerneraRelazioneCampionamento")){
			 
				String idIntervento= request.getParameter("idIntervento");
				InterventoCampionamentoDTO interventoCampionamento=GestioneCampionamentoBO.getIntervento(idIntervento);

				String html = request.getParameter("data");
				
				LinkedHashMap<String, Object> componenti = new LinkedHashMap<>();
				
				componenti.put("text", html);
				componenti.put("scheda", null);

				
				new CreateRelazioneCampionamento(componenti,interventoCampionamento,session,getServletContext());
 
			}
			
		
			
		
		
		
		
		}catch (Exception ex) {
			 ex.printStackTrace();
	   	     request.setAttribute("error",STIException.callException(ex));
	   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
	   	     dispatcher.forward(request,response);	
		}
		
	}



}
