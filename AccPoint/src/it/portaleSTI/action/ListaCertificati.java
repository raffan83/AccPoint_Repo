package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
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

import com.lowagie.text.pdf.codec.Base64.InputStream;


import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.StatoCertificatoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
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
		Boolean ajax = false;
		try 
		{
			String action =request.getParameter("action");

			System.out.println("****"+action);

			
			RequestDispatcher dispatcher = null;
			ArrayList<CertificatoDTO> listaCertificati = null;
			
			request.getSession().setAttribute("action",action);
			CompanyDTO cmp =(CompanyDTO)request.getSession().getAttribute("usrCompany");
			UtenteDTO utente = (UtenteDTO)request.getSession().getAttribute("userObj");
			
			if(action.equals("tutti")){
				listaCertificati = GestioneCertificatoBO.getListaCertificato(null, null,cmp,utente);
				request.getSession().setAttribute("listaCertificati",listaCertificati);
				dispatcher = getServletContext().getRequestDispatcher("/site/listaCertificati.jsp");
		     	dispatcher.forward(request,response);

				
			}else if(action.equals("lavorazione")){
				listaCertificati = GestioneCertificatoBO.getListaCertificato(new StatoCertificatoDTO(1), null,cmp,utente);
				request.getSession().setAttribute("listaCertificati",listaCertificati);
				dispatcher = getServletContext().getRequestDispatcher("/site/listaCertificatiInLavorazione.jsp");
		     	dispatcher.forward(request,response);

				
			}else if(action.equals("chiusi")){
				listaCertificati = GestioneCertificatoBO.getListaCertificato(new StatoCertificatoDTO(2), null,cmp,utente);
				
				request.getSession().setAttribute("listaCertificati",listaCertificati);
				dispatcher = getServletContext().getRequestDispatcher("/site/listaCertificatiChiusi.jsp");
		     	dispatcher.forward(request,response);

			}else if(action.equals("annullati")){
				listaCertificati = GestioneCertificatoBO.getListaCertificato(new StatoCertificatoDTO(3), null,cmp,utente);
				request.getSession().setAttribute("listaCertificati",listaCertificati);
				dispatcher = getServletContext().getRequestDispatcher("/site/listaCertificatiAnnullati.jsp");
		     	dispatcher.forward(request,response);

			}else if(action.equals("creaCertificato")){

				ajax = true;
				ServletContext context =getServletContext();
	
				
				String idCertificato = request.getParameter("idCertificato");
				
				GestioneCertificatoBO.createCertificato(idCertificato,session,context);

					myObj.addProperty("success", true);
					myObj.addProperty("message", "Misura Approvata, il certificato &egrave; stato genereato con successo");
			        out.println(myObj.toString());
			        
			     
			}else if(action.equals("inviaEmailCertificato")){
				ajax = true;
				String idCertificato = request.getParameter("idCertificato");
				
				/*
				 * TO DO invia email CERTIFICATO
				 */

					myObj.addProperty("success", true);
					myObj.addProperty("message", "Certificato inviato con successo");
			        out.println(myObj.toString());
			        
			    
			}else if(action.equals("firmaCertificato")){
				ajax = true;
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
				ajax = true;
				String idCertificato = request.getParameter("idCertificato");
				
				CertificatoDTO certificato =GestioneCertificatoBO.getCertificatoById(idCertificato);
				
				certificato.getStato().setId(3);
				
				session.update(certificato);
			
				
					myObj.addProperty("success", true);
					myObj.addProperty("message", "Certificato Annullato");
			        out.println(myObj.toString());
			        
			}else if(action.equals("approvaCertificatiMulti")){
				ajax = true;

				String selezionati = request.getParameter("dataIn");

				
				JsonElement jelement = new JsonParser().parse(selezionati);
				JsonObject jsonObj = jelement.getAsJsonObject();
				JsonArray jsArr = jsonObj.get("ids").getAsJsonArray();
				
				for(int i=0; i<jsArr.size(); i++){
					String id =  jsArr.get(i).toString().replaceAll("\"", "");
				
					ServletContext context =getServletContext();

					GestioneCertificatoBO.createCertificato(id,session,context);

						
				}				
					myObj.addProperty("success", true);
					myObj.addProperty("message", "Sono stati approvati "+jsArr.size()+" certificati ");
			        out.println(myObj.toString());
			        
			}else if(action.equals("annullaCertificatiMulti")){
				ajax = true;
				String selezionati = request.getParameter("dataIn");

				
				JsonElement jelement = new JsonParser().parse(selezionati);
				JsonObject jsonObj = jelement.getAsJsonObject();
				JsonArray jsArr = jsonObj.get("ids").getAsJsonArray();
				
				for(int i=0; i<jsArr.size(); i++){
					String id =  jsArr.get(i).toString().replaceAll("\"", "");
					
					CertificatoDTO certificato =GestioneCertificatoBO.getCertificatoById(id);
					
					certificato.getStato().setId(3);
					
					session.update(certificato);
				}

					myObj.addProperty("success", true);
					myObj.addProperty("message", "Sono stati approvati "+jsArr.size()+" certificati ");
			        out.println(myObj.toString());
			        
			}
			
			   session.getTransaction().commit();
		       session.close();
			 
		} 
		catch (Exception e) {
			e.printStackTrace();
			if(ajax) {
				session.getTransaction().rollback();
				session.close();
				myObj.addProperty("success", false);
				myObj.addProperty("message", "Errore generazione certificato: "+e.getMessage());
			}else {
 			     request.setAttribute("error",STIException.callException(e));
				 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
			     dispatcher.forward(request,response);
			}

		}
	
	}

}
