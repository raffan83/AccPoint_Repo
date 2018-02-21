package it.portaleSTI.action;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClassificazioneDTO;
import it.portaleSTI.DTO.LuogoVerificaDTO;
import it.portaleSTI.DTO.PuntoMisuraDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneMisuraBO;
import it.portaleSTI.bo.GestioneStrumentoBO;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.ArrayList;

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

/**
 * Servlet implementation class DettaglioStrumento
 */

@WebServlet(name="gestionePuntoMisura" , urlPatterns = { "/gestionePuntoMisura.do" })
public class GestionePuntoMisura extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestionePuntoMisura() {
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
		Session session =SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		try
		{

			
			String action = request.getParameter("action");
	
			if(action.equals("salva")) {

				String id=request.getParameter("id");
				String id_tabella=request.getParameter("id_tabella");
				String um=request.getParameter("um");
				String valoreCampione=request.getParameter("valoreCampione");
				String valoreMedioCampione=request.getParameter("valoreMedioCampione");
				String valoreStrumento=request.getParameter("valoreStrumento");
				String valoreMedioStrumento=request.getParameter("valoreMedioStrumento");
				String scostamento=request.getParameter("scostamento");
				String accettabilita=request.getParameter("accettabilita");
				String incertezza=request.getParameter("incertezza");
				String esito=request.getParameter("esito");
				String misura=request.getParameter("misura");
				String risoluzione_campione=request.getParameter("risoluzione_campione");
				String risoluzione_misura=request.getParameter("risoluzione_misura");
				String fondoScala=request.getParameter("fondoScala");
				String interpolazione=request.getParameter("interpolazione");
				String per_util=request.getParameter("per_util");

				PuntoMisuraDTO punto = GestioneMisuraBO.getPuntoMisuraById(id);
				
				if(id_tabella!=null) {
					punto.setId_tabella(Integer.parseInt(id_tabella));
				}
				if(um!=null) {
					punto.setUm(um);
				}
				if(valoreCampione!=null) {
					punto.setValoreCampione(new BigDecimal(valoreCampione));
				}
				if(valoreMedioCampione!=null) {
					punto.setValoreMedioCampione(new BigDecimal(valoreMedioCampione));
				}
				if(valoreStrumento!=null) {
					punto.setValoreStrumento(new BigDecimal(valoreStrumento));
				}
				if(valoreMedioStrumento!=null) {
					punto.setValoreMedioStrumento(new BigDecimal(valoreMedioStrumento));
				}
				if(scostamento!=null) {
					punto.setScostamento(new BigDecimal(scostamento));
				}
				if(accettabilita!=null) {
					punto.setAccettabilita(new BigDecimal(accettabilita));
				}
				if(esito!=null) {
					punto.setEsito(esito);
				}
				if(misura!=null) {
					punto.setMisura(new BigDecimal(misura));
				}
				if(risoluzione_campione!=null) {
					punto.setRisoluzione_campione(new BigDecimal(risoluzione_campione));
				}
				if(risoluzione_misura!=null) {
					punto.setRisoluzione_misura(new BigDecimal(risoluzione_misura));
				}
				if(fondoScala!=null) {
					punto.setFondoScala(new BigDecimal(fondoScala));
				}
				if(interpolazione!=null) {
					punto.setInterpolazione(Integer.parseInt(interpolazione));
				}
				if(per_util!=null) {
					punto.setPer_util(Double.parseDouble(per_util));
				}

				
				String message = "Salvato con Successo";
				Boolean success = true;
				if(!GestioneMisuraBO.updatePunto(punto, session)) {
					 session.getTransaction().rollback();
					 session.close();	
					 message = "Errore Salvataggio";
					success = false;
				}
				if(punto.getId_ripetizione() != 0) {
					if(!GestioneMisuraBO.updateValoriMediPunto(punto, session)) {
						 session.getTransaction().rollback();
						 session.close();	
						 message = "Errore Salvataggio";
						success = false;
					}
				}
				Gson gson = new Gson();
				
				// 2. Java object to JSON, and assign to a String
				String jsonInString = gson.toJson(punto);
				
				
					JsonObject myObj = new JsonObject();

					myObj.addProperty("success", success);
					myObj.addProperty("message", message);
					myObj.addProperty("punto", jsonInString);
					
					PrintWriter out = response.getWriter();

			        out.println(myObj.toString());

			}
		     session.getTransaction().commit();
				session.close();
				
	        
		}catch(Exception ex)
    	{
			
			 session.getTransaction().rollback();
			 session.close();
			
   		 ex.printStackTrace();
   	     request.setAttribute("error",STIException.callException(ex));
   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
   	     dispatcher.forward(request,response);	
   	}  
	}
	
	

	private StrumentoDTO getDettaglio(ArrayList<StrumentoDTO> listaStrumenti,String idS) {
		StrumentoDTO strumento =null;
		
		try
		{
		
		
		
		for (int i = 0; i < listaStrumenti.size(); i++) {
			
			if(listaStrumenti.get(i).get__id()==Integer.parseInt(idS))
			{
				return listaStrumenti.get(i);
			}
		}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			strumento=null;
			
		}
		return strumento;
	}

}
