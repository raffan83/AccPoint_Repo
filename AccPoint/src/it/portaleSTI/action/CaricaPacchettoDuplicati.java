package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.ObjSavePackDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Strings;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneInterventoBO;

@WebServlet(name= "/caricaPacchettoDuplicati", urlPatterns = { "/caricaPacchettoDuplicati.do" })

public class CaricaPacchettoDuplicati extends HttpServlet {

	static final Logger logger = Logger.getLogger(CaricaPacchettoDuplicati.class);
	
	public CaricaPacchettoDuplicati() {
		super();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		if(Utility.validateSession(request,response,getServletContext()))return;

		ObjSavePackDTO esito=null;
		JsonObject jsono = new JsonObject();
		PrintWriter writer = response.getWriter();


		InterventoDTO interv= (InterventoDTO)request.getSession().getAttribute("intervento");
		UtenteDTO utente =(UtenteDTO)request.getSession().getAttribute("userObj");

		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();


		try
		{
			
			logger.error(Utility.getMemorySpace()+" Action: "+"CaricaPacchettoDuplicati" +" - Utente: "+utente.getNominativo());
			
			String obj =request.getParameter("ids");
			String note_obsolescenza = request.getParameter("note");
			String non_sovrascrivere = request.getParameter("non_sovrascrivere");

			InterventoDTO intervento= (InterventoDTO) session.get(InterventoDTO.class, interv.getId()); 
			
			esito =(ObjSavePackDTO)request.getSession().getAttribute("esito");	
			ArrayList<MisuraDTO> listaMisureDuplicate =(ArrayList<MisuraDTO>)request.getSession().getAttribute("listaMisureDuplicate");
			if(non_sovrascrivere!=null && non_sovrascrivere.equals("1")) {
				
				int strumentiMisurati = esito.getInterventoDati().getNumStrMis();
				
				esito = GestioneInterventoBO.saveDataDB(listaMisureDuplicate, esito, intervento, utente, true,true, session);
				
				jsono.addProperty("success", true);
				jsono.addProperty("messaggio", "Sono stati salvati "+(esito.getInterventoDati().getNumStrMis()+strumentiMisurati)+" \n"+"Nuovi Strumenti: "+esito.getInterventoDati().getNumStrNuovi());
				GestioneInterventoBO.setControllato(intervento.getId(), utente.getId(), 0, session);
				
			}
			else if(obj!=null && obj.length()>0)
			{
				String[] lista =obj.split(",");
				String[] note = note_obsolescenza.split(",");

				for (int i = 0; i < lista.length; i++) 
				{
					
					esito = GestioneInterventoBO.updateMisura(listaMisureDuplicate,lista[i],esito,intervento,utente, note[i], session);	

				}

				jsono.addProperty("success", true);
				jsono.addProperty("messaggio", "Sono stati salvati "+esito.getInterventoDati().getNumStrMis()+" \n"+"Nuovi Strumenti: "+esito.getInterventoDati().getNumStrNuovi());
				GestioneInterventoBO.setControllato(intervento.getId(), utente.getId(), 0, session);
			}
			else
			{

				if(esito.getInterventoDati().getNumStrMis()==0)
				{
					jsono.addProperty("messaggio","Nessun strumento modificato o inserito");
					
					jsono.addProperty("success", true);
				}
				else
				{
					jsono.addProperty("success", true);
					jsono.addProperty("messaggio", Strings.CARICA_PACCHETTO_ESITO_1(esito.getInterventoDati().getNumStrMis(), esito.getInterventoDati().getNumStrNuovi()));

				}
			}
			session.getTransaction().commit();
			session.close();



		}catch (Exception e) {

			request.getSession().setAttribute("exception", e);
			session.getTransaction().rollback();
			session.close();
			//jsono.addProperty("success", false);
			//jsono.addProperty("messaggio", "Errore importazione pacchetto [Duplicato]"+e.getMessage());

			jsono = STIException.getException(e);
		}
		writer.write(jsono.toString());
		writer.close();
	} 
}

