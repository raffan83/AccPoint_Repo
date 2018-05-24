package it.portaleSTI.action;

import it.portaleSTI.DAO.GestioneInterventoDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.ObjSavePackDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Strings;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneInterventoBO;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.JsonObject;

@WebServlet(name= "/caricaPacchettoDuplicati", urlPatterns = { "/caricaPacchettoDuplicati.do" })

public class CaricaPacchettoDuplicati extends HttpServlet {

	public CaricaPacchettoDuplicati() {
		super();
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		if(Utility.validateSession(request,response,getServletContext()))return;

		ObjSavePackDTO esito=null;
		JsonObject jsono = new JsonObject();
		PrintWriter writer = response.getWriter();


		InterventoDTO intervento= (InterventoDTO)request.getSession().getAttribute("intervento");
		UtenteDTO utente =(UtenteDTO)request.getSession().getAttribute("userObj");

		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();


		try
		{
			String obj =request.getParameter("ids");

			esito =(ObjSavePackDTO)request.getSession().getAttribute("esito");	

			if(obj!=null && obj.length()>0)
			{
				String[] lista =obj.split(",");

				for (int i = 0; i < lista.length; i++) 
				{
					GestioneInterventoBO.updateMisura(lista[i],esito,intervento,utente,session);

					intervento.setnStrumentiMisurati(intervento.getnStrumentiMisurati()+1);
					esito.getInterventoDati().setNumStrMis(esito.getInterventoDati().getNumStrMis()+1);

					GestioneInterventoBO.updateInterventoDati(esito.getInterventoDati(),session);
					GestioneInterventoBO.update(intervento, session);

				}

				jsono.addProperty("success", true);
				jsono.addProperty("messaggio", "Sono stati salvati "+esito.getInterventoDati().getNumStrMis()+" \n"+"Nuovi Strumenti: "+esito.getInterventoDati().getNumStrNuovi());

			}
			else
			{

				if(esito.getInterventoDati().getNumStrMis()==0)
				{
					jsono.addProperty("messaggio","Nessun strumento modificato o inserito");
					GestioneInterventoBO.removeInterventoDati(esito.getInterventoDati(),session);
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
			//jsono.addProperty("success", false);
			//jsono.addProperty("messaggio", "Errore importazione pacchetto [Duplicato]"+e.getMessage());

			jsono = STIException.getException(e);
		}
		writer.write(jsono.toString());
		writer.close();
	} 
}

