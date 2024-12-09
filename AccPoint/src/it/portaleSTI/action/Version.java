package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.BachecaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneBachecaBO;
import it.portaleSTI.bo.GestioneCompanyBO;
import it.portaleSTI.bo.GestioneUtenteBO;

/**
 * Servlet implementation class GestioneBacheca
 */
@WebServlet("/version.do")
public class Version extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String DASM_VERSION = "3.1.2";
	private static final String DASM_VER_VERSION ="3.4.1";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Version() {
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
	
		response.setContentType("application/json");
		JsonObject myObj = new JsonObject();
		PrintWriter out = response.getWriter();
		try{			

				//generate JWT
			//   	myObj.add("userObj", utente.getUtenteJsonObject(true));
				myObj.addProperty("DASMTAR", DASM_VERSION);
				myObj.addProperty("DASMTARVER",DASM_VER_VERSION);
			   	
		
			
		}catch(Exception ex)
		{
			ex.printStackTrace();
		}  
				
		out.println(myObj);
	
	}
}
