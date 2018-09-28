package it.portaleSTI.action;

import it.portaleSTI.DAO.GestioneCertificatoDAO;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.StatoCertificatoDTO;
import it.portaleSTI.DTO.StatoInterventoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneCertificatoBO;
import it.portaleSTI.bo.GestioneInterventoBO;
import it.portaleSTI.bo.GestioneStrumentoBO;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

/**
 * Servlet implementation class GestioneIntervento
 */
@WebServlet(name = "strumentiMisurati", urlPatterns = { "/strumentiMisurati.do" })
public class StrumentiMisurati extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StrumentiMisurati() {
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
		
		try 
		{
			
			String action=request.getParameter("action");

			if(action !=null)
			{
				String id=request.getParameter("id");

				ArrayList<MisuraDTO> listaMisure = new ArrayList<MisuraDTO>();
				RequestDispatcher dispatcher = null;

				if(action.equals("li")){
					
					id=Utility.decryptData(id);
					
					listaMisure = GestioneInterventoBO.getListaMirureByInterventoDati(Integer.parseInt(id));
					if(listaMisure.size() > 0){
						HashMap<String, CertificatoDTO> arrCartificati = new HashMap<String, CertificatoDTO>();
						for (MisuraDTO misura : listaMisure) {
							
							 CertificatoDTO certificato = GestioneCertificatoDAO.getCertificatoByMisura(misura);
							 if(certificato!=null) {
								 arrCartificati.put(""+misura.getId(), certificato);
							 }
							 
					 
						}
						
						request.getSession().setAttribute("arrCartificati", arrCartificati);
					}
 						request.getSession().setAttribute("listaMisure", listaMisure);

					 
					request.getSession().setAttribute("actionParent", "li");
					dispatcher = getServletContext().getRequestDispatcher("/site/listaMisure.jsp");
					dispatcher.forward(request,response);
				}else if(action.equals("lmcheck")) {
					
					id = Utility.decryptData(id);
					
					listaMisure = GestioneStrumentoBO.getListaMisureByStrumento(Integer.parseInt(id));
										
					PrintWriter out = response.getWriter();
										
			        JsonObject myObj = new JsonObject();

			        if(listaMisure.size() > 0){
						 myObj.addProperty("success", true);
					}else {
						myObj.addProperty("success", false);
					}
			        out.println(myObj.toString());

				}else if(action.equals("ls")){
					
					
					
					listaMisure = GestioneStrumentoBO.getListaMisureByStrumento(Integer.parseInt(id));
					if(listaMisure.size() > 0){
						HashMap<String, CertificatoDTO> arrCartificati = new HashMap<String, CertificatoDTO>();
						for (MisuraDTO misura : listaMisure) {
							
							 CertificatoDTO certificato = GestioneCertificatoDAO.getCertificatoByMisura(misura);
							 if(certificato!=null) {
								 arrCartificati.put(""+misura.getId(), certificato);
							 }
							 
					 
						}
						
						request.getSession().setAttribute("arrCartificati", arrCartificati);
					}
					request.getSession().setAttribute("listaMisure", listaMisure);
					
					dispatcher = getServletContext().getRequestDispatcher("/site/listaMisureAjax.jsp");
					dispatcher.forward(request,response);
				}else if(action.equals("lm")){
					
					id = Utility.decryptData(id);
					
					listaMisure = GestioneStrumentoBO.getListaMisureByStrumento(Integer.parseInt(id));
					if(listaMisure.size() > 0){
						HashMap<String, CertificatoDTO> arrCartificati = new HashMap<String, CertificatoDTO>();
						for (MisuraDTO misura : listaMisure) {
							
							 CertificatoDTO certificato = GestioneCertificatoDAO.getCertificatoByMisura(misura);
							 if(certificato!=null) {
								 arrCartificati.put(""+misura.getId(), certificato);
							 }
							 
					 
						}
						
						request.getSession().setAttribute("arrCartificati", arrCartificati);
					}
					request.getSession().setAttribute("listaMisure", listaMisure);
					
					dispatcher = getServletContext().getRequestDispatcher("/site/listaMisure.jsp");
					dispatcher.forward(request,response);
				}else if(action.equals("lt")){
					
					id=Utility.decryptData(id);
					
					listaMisure = GestioneInterventoBO.getListaMirureByIntervento(Integer.parseInt(id));
					if(listaMisure.size() > 0){
						HashMap<String, CertificatoDTO> arrCartificati = new HashMap<String, CertificatoDTO>();
						for (MisuraDTO misura : listaMisure) {
							
							 CertificatoDTO certificato = GestioneCertificatoDAO.getCertificatoByMisura(misura);
							 if(certificato!=null) {
								 arrCartificati.put(""+misura.getId(), certificato);
							 }
							 
					 
						}
						
						request.getSession().setAttribute("arrCartificati", arrCartificati);
					}
 						request.getSession().setAttribute("listaMisure", listaMisure);

				 
					request.getSession().setAttribute("actionParent", "lt");
					dispatcher = getServletContext().getRequestDispatcher("/site/listaMisure.jsp");
					dispatcher.forward(request,response);
				}else if(action.equals("lc")){

					String actionParent = request.getParameter("actionParent");
					listaMisure = (ArrayList<MisuraDTO>) request.getSession().getAttribute("listaMisure");
					if(actionParent.equals("li")) {
						listaMisure = GestioneInterventoBO.getListaMirureByInterventoDati(Integer.parseInt(id));

					}else {
						listaMisure = GestioneInterventoBO.getListaMirureByIntervento(Integer.parseInt(id));

					}
					 
						CompanyDTO cmp =(CompanyDTO)request.getSession().getAttribute("usrCompany");
						UtenteDTO utente = (UtenteDTO)request.getSession().getAttribute("userObj");
						MisuraDTO misura = listaMisure.get(0);
						//ArrayList<CertificatoDTO> listaCertificati = GestioneCertificatoBO.getListaCertificato(new StatoCertificatoDTO(2), null,cmp,utente,null,""+misura.getIntervento().getId_cliente(),""+misura.getIntervento().getIdSede());
						ArrayList<CertificatoDTO> listaCertificati = GestioneCertificatoBO.getListaCertificatoByIntervento(new StatoCertificatoDTO(2), misura.getIntervento(),cmp,utente,null,""+misura.getIntervento().getId_cliente(),""+misura.getIntervento().getIdSede());
						request.getSession().setAttribute("listaMisure", listaMisure);
						request.getSession().setAttribute("listaCertificati", listaCertificati);
						//request.getSession().setAttribute("listaCertificati", listaMisure);
					
					dispatcher = getServletContext().getRequestDispatcher("/site/listaCertificatiMisure.jsp");
					dispatcher.forward(request,response);
				}
						
				
	
				
		     	
			}else{
				request.setAttribute("error","Action Inesistente");
			
		   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
		   	     dispatcher.forward(request,response);
			}

		}catch (Exception ex) {
			 ex.printStackTrace();
	   	     request.setAttribute("error",STIException.callException(ex));
	   	  request.getSession().setAttribute("exception", ex);
	   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
	   	     dispatcher.forward(request,response);	
		}
		
	}

	private CommessaDTO getCommessa(ArrayList<CommessaDTO> listaCommesse,String idCommessa) {

		for (CommessaDTO comm : listaCommesse)
		{
			if(comm.getID_COMMESSA().equals(idCommessa))
			return comm;
		}
			
		
		return null;
	}

}
