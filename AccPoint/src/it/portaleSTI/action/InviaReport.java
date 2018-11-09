package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonObject;

import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;

/**
 * Servlet implementation class InviaReport
 */
@WebServlet("/inviaReport.do")
public class InviaReport extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InviaReport() {
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


		if(Utility.validateSession(request,response,getServletContext()))return;
		
		JsonObject myObj = new JsonObject();
		PrintWriter  out = response.getWriter();
		try {
		Exception e = (Exception)request.getSession().getAttribute("exception");
		
		UtenteDTO utente = (UtenteDTO)request.getSession().getAttribute("userObj");
		
		Date data = new Date();
		SimpleDateFormat dt = new SimpleDateFormat("dd/MM/yyyy HH:mm");
		dt.format(data);

		StringWriter sw = new StringWriter();
		PrintWriter pw = new PrintWriter(sw);
		e.printStackTrace(pw);
		
		 String to = Costanti.EMAIL_EXCEPTION_REPORT;
		
		  String subject = "Report Eccezione";
		
		  String hmtlMex = "<h3>Attenzione! L'utente "+utente.getNominativo()+"  ha generato la seguente eccezione: </h3><br /><br>Pagina: "+request.getHeader("referer")+"<br><br>Data: "+dt.format(data)+"<br><br>"+sw.toString();

		  
			Utility.sendEmail(to,subject,hmtlMex);
			
		
			myObj.addProperty("success", true);

			out.print(myObj);
			
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
			request.getSession().setAttribute("exception", e1);
			myObj = STIException.getException(e1);
			out.print(myObj);
		}
		
	}

}
