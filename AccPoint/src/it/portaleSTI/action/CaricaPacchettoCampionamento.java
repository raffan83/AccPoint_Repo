package it.portaleSTI.action;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.InterventoCampionamentoDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.ObjSavePackDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneCampionamentoBO;
import it.portaleSTI.bo.GestioneInterventoBO;
import it.portaleSTI.bo.GestioneInterventoCampionamentoBO;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.hibernate.Session;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;



/**
 * Servlet implementation class ScaricaStrumento
 */
@WebServlet(name= "/caricaPacchettoCampionamento", urlPatterns = { "/caricaPacchettoCampionamento.do" })

public class CaricaPacchettoCampionamento extends HttpServlet {


	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CaricaPacchettoCampionamento() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		if(Utility.validateSession(request,response,getServletContext()))return;
		
		JsonObject jsono = new JsonObject();
		PrintWriter writer = response.getWriter();
		
		InterventoCampionamentoDTO intervento= (InterventoCampionamentoDTO)request.getSession().getAttribute("interventoCampionamento");
		UtenteDTO utente =(UtenteDTO)request.getSession().getAttribute("userObj");
		
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();

		ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
		writer = response.getWriter();
		response.setContentType("application/json");
		
		ObjSavePackDTO esito=null;
		
		try {
			List<FileItem> items = uploadHandler.parseRequest(request);
			for (FileItem item : items) {
				if (!item.isFormField()) 
				{
					 esito =GestioneInterventoBO.savePackUpload(item,intervento.getNomePack());
					 
					 
					 if(esito.getEsito()==0)
						{
							jsono.addProperty("success", false);
							jsono.addProperty("messaggio", esito.getErrorMsg());
						}
					 if(esito.getEsito()==1)
						{

 
							esito = GestioneInterventoCampionamentoBO.saveDataDB(esito,intervento,session,utente, getServletContext());
 
							ArrayList<InterventoCampionamentoDTO> listaInterventi = (ArrayList<InterventoCampionamentoDTO>) GestioneCampionamentoBO.getListaInterventi(intervento.getID_COMMESSA(),session);	
							
							JsonArray listaInterventiJson = new JsonArray();
							for (InterventoCampionamentoDTO interventoCampionamentoDTO : listaInterventi) {
								JsonObject interventoJson = new JsonObject();
								interventoJson.addProperty("id", ""+interventoCampionamentoDTO.getId());
								interventoJson.addProperty("idAttivita", ""+interventoCampionamentoDTO.getIdAttivita());
								interventoJson.addProperty("statoUpload", interventoCampionamentoDTO.getStatoUpload());
								listaInterventiJson.add(interventoJson);
							}
							request.getSession().setAttribute("listaInterventiJson", listaInterventiJson);
							
							jsono.addProperty("success", true); 
							jsono.addProperty("messaggio", "Salvataggio Effettuato");
						}
						if(esito.getEsito()==2)
						{
							jsono.addProperty("success", false);
							jsono.addProperty("messaggio", "Il file risulta ancora aperto, finalizzare la chiusura in Calver Camp");						
						}
					 
				}
				
				
			}	
				
			session.getTransaction().commit();
			session.close();		
			
			writer.write(jsono.toString());
			writer.close();
			
		}catch (Exception e) 
		{
			e.printStackTrace();
			session.getTransaction().rollback();
			session.close();
			request.getSession().invalidate();

			jsono.addProperty("success", false);
			jsono.addProperty("messaggio", "Errore importazione pacchetto "+e.getMessage());
			
			request.getSession().setAttribute("exception", e);
			writer.println(jsono.toString());
			writer.close();
		}	
	
	}

}
