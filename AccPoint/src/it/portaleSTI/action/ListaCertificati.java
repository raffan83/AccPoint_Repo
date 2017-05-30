package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.StatoCertificatoDTO;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneCertificatoBO;

/**
 * Servlet implementation class listaCampioni
 */
@WebServlet(name="listaCertificati" , urlPatterns = { "/listaCertificati.do" })

public class ListaCertificati extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaCertificati() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;

		Session session =SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		response.setContentType("text/html");
		JsonObject myObj = new JsonObject();
		PrintWriter out = response.getWriter();
		
		try 
		{
			String action =request.getParameter("action");

			System.out.println("****"+action);

			
			RequestDispatcher dispatcher = null;
			ArrayList<CertificatoDTO> listaCertificati = null;
			
			request.getSession().setAttribute("action",action);
			
			if(action.equals("tutti")){
				listaCertificati = GestioneCertificatoBO.getListaCertificato(null, null);
				request.getSession().setAttribute("listaCertificati",listaCertificati);
				dispatcher = getServletContext().getRequestDispatcher("/site/listaCertificati.jsp");
		     	dispatcher.forward(request,response);

				
			}else if(action.equals("lavorazione")){
				listaCertificati = GestioneCertificatoBO.getListaCertificato(new StatoCertificatoDTO(1), null);
				request.getSession().setAttribute("listaCertificati",listaCertificati);
				dispatcher = getServletContext().getRequestDispatcher("/site/listaCertificatiInLavorazione.jsp");
		     	dispatcher.forward(request,response);

				
			}else if(action.equals("chiusi")){
				listaCertificati = GestioneCertificatoBO.getListaCertificato(new StatoCertificatoDTO(2), null);
				request.getSession().setAttribute("listaCertificati",listaCertificati);
				dispatcher = getServletContext().getRequestDispatcher("/site/listaCertificatiChiusi.jsp");
		     	dispatcher.forward(request,response);

			}else if(action.equals("annullati")){
				listaCertificati = GestioneCertificatoBO.getListaCertificato(new StatoCertificatoDTO(3), null);
				request.getSession().setAttribute("listaCertificati",listaCertificati);
				dispatcher = getServletContext().getRequestDispatcher("/site/listaCertificatiAnnullati.jsp");
		     	dispatcher.forward(request,response);

			}else if(action.equals("creaCertificato")){

				String idCertificato = request.getParameter("idCertificato");
				
				GestioneCertificatoBO.createCertificato(idCertificato,session);

					myObj.addProperty("success", true);
					myObj.addProperty("message", "Misura Approvata, il certificato &egrave; stato genereato con successo");
			        out.println(myObj.toString());
			        
			     
			}else if(action.equals("inviaEmailCertificato")){

				String idCertificato = request.getParameter("idCertificato");
				
				/*
				 * TO DO invia email CERTIFICATO
				 */

					myObj.addProperty("success", true);
					myObj.addProperty("message", "Certificato inviato con successo");
			        out.println(myObj.toString());
			        
			    
			}else if(action.equals("firmaCertificato")){

				String idCertificato = request.getParameter("idCertificato");
				
				/*
				 * TO DO firma CERTIFICATO
				 */

					myObj.addProperty("success", true);
					myObj.addProperty("message", "Certificato firmato");
			        out.println(myObj.toString());
			        
			       session.getTransaction().commit();
			       session.close();
			}else if(action.equals("annullaCertificato")){

				String idCertificato = request.getParameter("idCertificato");
				
				CertificatoDTO certificato =GestioneCertificatoBO.getCertificatoById(idCertificato);
				
				certificato.getStato().setId(3);
				
				session.update(certificato);
			
				
					myObj.addProperty("success", true);
					myObj.addProperty("message", "Certificato Annullato");
			        out.println(myObj.toString());
			        
			}else if(action.equals("approvaCertificatiMulti")){


				String selezionati = request.getParameter("dataIn");

				
				JsonElement jelement = new JsonParser().parse(selezionati);
				JsonObject jsonObj = jelement.getAsJsonObject();
				JsonArray jsArr = jsonObj.get("ids").getAsJsonArray();
				
				for(int i=0; i<jsArr.size(); i++){
					String id =  jsArr.get(i).toString();
					System.out.println(id);
				}
				
				
					myObj.addProperty("success", true);
					myObj.addProperty("message", "Certificati Approvati");
			        out.println(myObj.toString());
			        
			}else if(action.equals("annullaCertificatiMulti")){

				String selezionati = request.getParameter("dataIn");

				
				JsonElement jelement = new JsonParser().parse(selezionati);
				JsonObject jsonObj = jelement.getAsJsonObject();
				JsonArray jsArr = jsonObj.get("ids").getAsJsonArray();
				
				for(int i=0; i<jsArr.size(); i++){
					String id =  jsArr.get(i).toString();
					System.out.println(id);
				}


			
				
					myObj.addProperty("success", true);
					myObj.addProperty("message", "Certificati Annullati");
			        out.println(myObj.toString());
			        
			}
			
			   session.getTransaction().commit();
		       session.close();
			 
		} 
		catch (Exception e) {
			e.printStackTrace();
			session.getTransaction().rollback();
			session.close();
			myObj.addProperty("success", false);
			myObj.addProperty("message", "Errore generazione certificato: "+e.getMessage());
		}
	
	}

}
