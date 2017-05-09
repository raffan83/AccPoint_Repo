package it.portaleSTI.action;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.GestioneTLDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.PrenotazioneDTO;
import it.portaleSTI.DTO.ScadenzaDTO;
import it.portaleSTI.DTO.StatoStrumentoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.TipoGrandezzaDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.DTO.UnitaMisuraDTO;
import it.portaleSTI.DTO.ValoreCampioneDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestionePrenotazioniBO;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;

/**
 * Servlet implementation class DettaglioCampione
 */
@WebServlet(name="nuovoStrumento" , urlPatterns = { "/nuovoStrumento.do" })

public class NuovoStrumento extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NuovoStrumento() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		
	try{	
		
		
		


			
			PrintWriter out = response.getWriter();

	
				String ref_stato_strumento = request.getParameter("ref_stato_strumento");
				String denominazione = request.getParameter("denominazione");
				String codice_interno = request.getParameter("codice_interno");
				String costruttore = request.getParameter("costruttore");
				String modello = request.getParameter("modello");
				String matricola = request.getParameter("matricola");
				String risoluzione = request.getParameter("risoluzione");
				String campo_misura = request.getParameter("campo_misura");
				String ref_tipo_strumento = request.getParameter("ref_tipo_strumento");
				String freq_mesi = request.getParameter("freq_mesi");
	
				String dataUltimaVerifica = request.getParameter("dataUltimaVerifica");
				String dataProssimaVerifica = request.getParameter("dataProssimaVerifica");
				String ref_tipo_rapporto = request.getParameter("ref_tipo_rapporto");			
				
				
				StrumentoDTO strumento = new StrumentoDTO();
				strumento.setStato_strumento(new StatoStrumentoDTO(Integer.parseInt(ref_stato_strumento),""));
				strumento.setDenominazione(denominazione);
				strumento.setCodice_interno(codice_interno);
				strumento.setCostruttore(costruttore);
				strumento.setModello(modello);
				strumento.setMatricola(matricola);
				strumento.setRisoluzione(risoluzione);
				strumento.setCampo_misura(campo_misura);
				strumento.setTipo_strumento(new TipoStrumentoDTO(Integer.parseInt(ref_tipo_strumento),""));

				/*
				 * Save Hibernate abnd return strumento
				 */
				
				ScadenzaDTO scadenza = new ScadenzaDTO();
				scadenza.setFreq_mesi(Integer.parseInt(freq_mesi));

				DateFormat df = new SimpleDateFormat("dd/m/yyyy");

				scadenza.setDataUltimaVerifica(df.parse(dataUltimaVerifica));
				scadenza.setDataProssimaVerifica(df.parse(dataProssimaVerifica));
				scadenza.setTipo_rapporto(new TipoRapportoDTO(Integer.parseInt(ref_tipo_rapporto),""));
				scadenza.setIdStrumento(id_strumento);
				
			
			/*
			 * TODO salvataggio su db
			 */
			
			 JsonObject myObj = new JsonObject();

					myObj.addProperty("success", true);
			        out.println(myObj.toString());

	
	}catch(Exception ex)
	{
		
		 ex.printStackTrace();
	     request.setAttribute("error",STIException.callException(ex));
		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
	     dispatcher.forward(request,response);
		
	}  
	
	}
	
	static CampioneDTO getCampione(ArrayList<CampioneDTO> listaCampioni,String idC) {
		CampioneDTO campione =null;
		
		try
		{		
		for (int i = 0; i < listaCampioni.size(); i++) {
			
			if(listaCampioni.get(i).getId()==Integer.parseInt(idC))
			{
				return listaCampioni.get(i);
			}
		}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			campione=null;
			throw ex;
		}
		return campione;
	}

}
