package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.PuntoMisuraDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneMisuraBO;

/**
 * Servlet implementation class DettaglioStrumento
 */

@WebServlet(name="gestionePuntoMisura" , urlPatterns = { "/gestionePuntoMisura.do" })
public class GestionePuntoMisura extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final Logger logger = Logger.getLogger(GestionePuntoMisura.class);
       
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
			
			logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+((UtenteDTO)request.getSession().getAttribute("userObj")).getNominativo());
	
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
				
				if(id_tabella!=null && !id_tabella.equals("")) {
					punto.setId_tabella(Integer.parseInt(id_tabella));
				}
				if(um!=null && !um.equals("")) {
					punto.setUm(um);
				}
				if(valoreCampione!=null && !valoreCampione.equals("")) {
					punto.setValoreCampione(new BigDecimal(valoreCampione));
				}
				if(valoreMedioCampione!=null && !valoreMedioCampione.equals("")) {
					punto.setValoreMedioCampione(new BigDecimal(valoreMedioCampione));
				}
				if(valoreStrumento!=null && !valoreStrumento.equals("")) {
					punto.setValoreStrumento(new BigDecimal(valoreStrumento));
				}
				if(valoreMedioStrumento!=null && !valoreMedioStrumento.equals("")) {
					punto.setValoreMedioStrumento(new BigDecimal(valoreMedioStrumento));
				}
				if(scostamento!=null && !scostamento.equals("")) {
					punto.setScostamento(new BigDecimal(scostamento));
				}
				if(accettabilita!=null && !accettabilita.equals("")) {
					punto.setAccettabilita(new BigDecimal(accettabilita));
				}
				if(esito!=null && !esito.equals("")) {
					punto.setEsito(esito);
				}
				if(misura!=null && !misura.equals("")) {
					punto.setMisura(new BigDecimal(misura));
				}
				if(risoluzione_campione!=null && !risoluzione_campione.equals("")) {
					punto.setRisoluzione_campione(new BigDecimal(risoluzione_campione));
				}
				if(risoluzione_misura!=null && !risoluzione_misura.equals("")) {
					punto.setRisoluzione_misura(new BigDecimal(risoluzione_misura));
				}
				if(fondoScala!=null && !fondoScala.equals("")) {
					punto.setFondoScala(new BigDecimal(fondoScala));
				}
				if(interpolazione!=null && !interpolazione.equals("")) {
					punto.setInterpolazione(Integer.parseInt(interpolazione));
				}
				if(per_util!=null && !per_util.equals("")) {
					punto.setPer_util(Double.parseDouble(per_util));
				}
				if(incertezza!=null && !incertezza.equals("")) {
					punto.setIncertezza(new BigDecimal(incertezza));
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
				String jsonInString = gson.toJson(punto.getId_misura());
				
				
					JsonObject myObj = new JsonObject();

					myObj.addProperty("success", success);
					myObj.addProperty("messaggio", message);
					//myObj.addProperty("punto", jsonInString);
					
					myObj.addProperty("id_misura", Utility.encryptData(jsonInString));
					
					PrintWriter out = response.getWriter();

			        out.println(myObj.toString());

			}
		     session.getTransaction().commit();
				session.close();
				
	        
		}catch(Exception ex)
    	{
			
			 session.getTransaction().rollback();
			 session.close();
			
			 JsonObject myObj = new JsonObject();

			// myObj.addProperty("success", false);
			// myObj.addProperty("messaggio", STIException.callException(ex).toString());
 				
				PrintWriter out = response.getWriter();
				myObj = STIException.getException(ex);
		        out.print(myObj);
			 
//   		 ex.printStackTrace();
//   	     request.setAttribute("error",STIException.callException(ex));
//   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
//   	     dispatcher.forward(request,response);	
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
