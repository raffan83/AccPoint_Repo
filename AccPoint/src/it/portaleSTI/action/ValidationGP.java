package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.httpclient.util.DateParseException;
import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.BachecaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.GPDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneBachecaBO;
import it.portaleSTI.bo.GestioneCompanyBO;
import it.portaleSTI.bo.GestioneUtenteBO;
import it.portaleSTI.bo.GestioneValidazioneGPBO;

/**
 * Servlet implementation class GestioneBacheca
 */
@WebServlet("/validationGP.do")
public class ValidationGP extends HttpServlet {
	private static final long serialVersionUID = 1L;

    
	static final Logger logger = Logger.getLogger(ValidationGP.class);
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ValidationGP() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		response.setContentType("application/json");
		JsonObject myObj = new JsonObject();
		PrintWriter out = response.getWriter();
		try{			
			String nome=request.getParameter("nome");
			String cognome=request.getParameter("cognome");
			String dataNascita=request.getParameter("dataNascita");
			String esito=request.getParameter("esito");

			GPDTO greenPass = new GPDTO();
			
			if(nome!=null) 
			{
				greenPass.setNome(nome);
			}
			if(cognome!=null) 
			{
				greenPass.setCognome(cognome);
			}
			if(dataNascita!=null) 
			{
				try 
				{
					SimpleDateFormat sdf= new SimpleDateFormat("yyyy-MM-dd");
					Date dn=sdf.parse(dataNascita);
					
					greenPass.setDataNascita(dn);
				}
				catch (Exception e) {
					greenPass.setDataNascita(new Date());
				}
			}
			if(esito!=null) 
			{
				greenPass.setEsito(esito);
			}
			greenPass.setDataVerifica(new Date());
			
			System.out.println(nome+" "+cognome+" "+dataNascita+" "+esito);
			
			GestioneValidazioneGPBO.bundleGP(greenPass,session);
			//logger.error(nome+" "+cognome+" "+dataNascita+" "+esito);
			//generate JWT
			//   	myObj.add("userObj", utente.getUtenteJsonObject(true));
				myObj.addProperty("STATUS","OK");
				
			   	
		
			
		}catch(Exception ex)
		{
			myObj.addProperty("STATUS","KO");
			ex.printStackTrace();
		}  
				
		out.println(myObj);
	
	}
}
