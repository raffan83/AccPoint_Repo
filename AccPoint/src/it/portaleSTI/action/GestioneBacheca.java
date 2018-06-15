package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;

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
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneBachecaBO;
import it.portaleSTI.bo.GestioneCommesseBO;
import it.portaleSTI.bo.GestioneCompanyBO;
import it.portaleSTI.bo.GestioneStrumentoBO;
import it.portaleSTI.bo.GestioneUtenteBO;

/**
 * Servlet implementation class GestioneBacheca
 */
@WebServlet("/gestioneBacheca.do")
public class GestioneBacheca extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneBacheca() {
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
		
		String action = request.getParameter("action");
		
		PrintWriter writer = response.getWriter();
		JsonObject myObj = new JsonObject();
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();

		if(action ==null || action.equals("")) {
		
		try {	
		UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
		
		String id_company= String.valueOf(utente.getCompany().getId());
		
		
		ArrayList<CompanyDTO> lista_company = new ArrayList<CompanyDTO>();
		ArrayList<UtenteDTO> lista_utenti = new ArrayList<UtenteDTO>();
		if(utente.isTras()) {			
			lista_company = GestioneCompanyBO.getAllCompany(session);
			lista_utenti = GestioneUtenteBO.getAllUtenti(session);
			
		}else {
			CompanyDTO company;
				company = GestioneCompanyBO.getCompanyById(id_company, session);
				lista_company.add(company);
				lista_utenti = GestioneUtenteBO.getUtentiFromCompany(Integer.parseInt(id_company), session);
		}	
		

		request.getSession().setAttribute("oggetto", null);
		request.getSession().setAttribute("destinatario", null);
		request.getSession().setAttribute("company_risposta", null);
		request.getSession().setAttribute("lista_company", lista_company);
		request.getSession().setAttribute("lista_destinatari", lista_utenti);
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneBacheca.jsp");
     	dispatcher.forward(request,response);
	
	
	} catch (Exception e) {
		e.printStackTrace();
	     request.setAttribute("error",STIException.callException(e));
	     request.getSession().setAttribute("exception",e);
		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
	     dispatcher.forward(request,response);
			}
			
		}
		
		else if(action.equals("salva")) {
			
			UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
			String id_company = request.getParameter("id_company");
			String[] destinatario = request.getParameterValues("destinatario[]");
			String titolo = request.getParameter("titolo");
			String testo = request.getParameter("testo");

			
			try {
				
				CompanyDTO company = GestioneCompanyBO.getCompanyById(id_company, session);
				BachecaDTO messaggio = new BachecaDTO();
				
				
				if(destinatario[0].equals("0")) {
					messaggio.setDestinatario(destinatario[0]);
					messaggio.setLetto(String.valueOf(destinatario[0])+"_0");
				}else {
					String destinatario_split[] = destinatario[0].split("_");
					String dest =destinatario_split[1];
					String dest_letto = dest+"_0";
					for(int i=1; i<destinatario.length; i++) {						
						String destinatario_split1[] = destinatario[i].split("_");
						dest = dest +";"+ destinatario_split1[1];
						dest_letto = dest_letto +";" +dest+"_0";
					}
					
					messaggio.setDestinatario(dest);
					messaggio.setLetto(dest_letto);
				}					
				messaggio.setLetto_da_me(0);
				messaggio.setCompany(company);
				messaggio.setData(new Timestamp(System.currentTimeMillis()));
				messaggio.setUtente(utente);
				messaggio.setTitolo(titolo);
				messaggio.setTesto(testo);

				GestioneBachecaBO.saveMessaggio(messaggio, session);
				
				session.getTransaction().commit();
				
				ArrayList<BachecaDTO> lista_messaggi = GestioneBachecaBO.getMessaggiPerUtente(utente.getId(), session);
				request.getSession().setAttribute("lista_messaggi", lista_messaggi);
				session.close();
				

				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Messaggio inviato correttamente!");
				
				writer.write(myObj.toString());
				writer.close();
				
				
				
				
				
			} catch (Exception e) {

				e.printStackTrace();
				request.getSession().setAttribute("exception", e);
				
				myObj = STIException.getException(e);
				writer.print(myObj);
				
			}
			
			
			
		}
		
		else if(action.equals("dettaglio_messaggio")) {
			
		
			String id_messaggio = request.getParameter("id_messaggio");
			
			BachecaDTO messaggio = GestioneBachecaBO.getMessaggioFromId(Integer.parseInt(id_messaggio), session);
			
			request.getSession().setAttribute("messaggio", messaggio);
			
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioMessaggio.jsp");
		     dispatcher.forward(request,response);
		
		
		}
		
		else if(action.equals("letto")) {
			
			String id_messaggio = request.getParameter("id_messaggio");
			UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
			BachecaDTO messaggio = GestioneBachecaBO.getMessaggioFromId(Integer.parseInt(id_messaggio), session);
			
			messaggio.setLetto(messaggio.getLetto()+";"+String.valueOf(utente.getId()).concat("_1"));
			messaggio.setLetto_da_me(1);

			GestioneBachecaBO.updateMessaggio(messaggio, session);
			ArrayList<BachecaDTO> lista_messaggi = GestioneBachecaBO.getMessaggiPerUtente(utente.getId(), session);
			request.getSession().setAttribute("lista_messaggi", lista_messaggi);
			session.getTransaction().commit();
			session.close();
			
			String jsonObj = new Gson().toJson(lista_messaggi);
			
			myObj.addProperty("json", jsonObj);
			//myObj.addProperty("success", true);
			//myObj.addProperty("messaggio", "Messaggio inviato correttamente!");
			

			writer.print(myObj);
			writer.close();
		}
		
		else if(action.equals("rispondi")) {
			
			try {	
				UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
				
				String id_company= String.valueOf(utente.getCompany().getId());
				String destinatario = request.getParameter("destinatario");
				String oggetto = request.getParameter("oggetto");
				String company_risposta = request.getParameter("company");
				
				ArrayList<CompanyDTO> lista_company = new ArrayList<CompanyDTO>();
				ArrayList<UtenteDTO> lista_utenti = new ArrayList<UtenteDTO>();
				if(utente.isTras()) {			
					lista_company = GestioneCompanyBO.getAllCompany(session);
					lista_utenti = GestioneUtenteBO.getAllUtenti(session);
					
				}else {
					CompanyDTO company;
						company = GestioneCompanyBO.getCompanyById(id_company, session);
						lista_company.add(company);
						lista_utenti = GestioneUtenteBO.getUtentiFromCompany(Integer.parseInt(id_company), session);
				}	
				
				if(destinatario!=null) {

					for(int i=0; i<lista_utenti.size();i++) {
						if(lista_utenti.get(i).getId()==Integer.parseInt(destinatario)) {
							request.getSession().setAttribute("destinatario", lista_utenti.get(i));
						}
					}
				}
				
				if(oggetto!=null) {
				request.getSession().setAttribute("oggetto", oggetto);
				}
				
				if(company_risposta!=null) {
					for(int i=0; i<lista_company.size();i++) {
						if(lista_company.get(i).getId()==Integer.parseInt(company_risposta)) {
							request.getSession().setAttribute("company_risposta", lista_company.get(i));
						}
					}
					
				}
				request.getSession().setAttribute("lista_company", lista_company);
				request.getSession().setAttribute("lista_destinatari", lista_utenti);
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneBacheca.jsp");
		     	dispatcher.forward(request,response);
			
			
			} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					     request.setAttribute("error",STIException.callException(e));
					     request.getSession().setAttribute("exception", e);
						 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
					     dispatcher.forward(request,response);
							
					}
					
				
				
			
		}
		
		
		
	}

}
