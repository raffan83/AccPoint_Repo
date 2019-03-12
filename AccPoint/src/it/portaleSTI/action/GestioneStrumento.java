package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.GestioneTLDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClassificazioneDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.LuogoVerificaDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.StatoStrumentoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.CreateSchedaListaStrumenti;
import it.portaleSTI.bo.GestioneMisuraBO;
import it.portaleSTI.bo.GestioneStrumentoBO;

/**
 * Servlet implementation class DettaglioCampione
 */
@WebServlet(name="gestioneStrumento" , urlPatterns = { "/gestioneStrumento.do" })
@MultipartConfig
public class GestioneStrumento extends HttpServlet {
	private static final long serialVersionUID = 1L;
	boolean ajax=false;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneStrumento() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
	try{	
	

		String action=  request.getParameter("action");
		
		

		if(action !=null)
		{
			StrumentoDTO strumento = null;
			if(action.equals("toggleFuoriServizio")){
				ajax=true;
				PrintWriter out = response.getWriter();
  		        response.setContentType("application/json");
				strumento = GestioneStrumentoBO.getStrumentoById( request.getParameter("idStrumento"), session);
				
				CompanyDTO idCompany=(CompanyDTO)request.getSession().getAttribute("usrCompany");
				UtenteDTO user=(UtenteDTO)request.getSession().getAttribute("userObj");
				
				
				ArrayList<StrumentoDTO> listaStrumentiPerSede=GestioneStrumentoBO.getListaStrumentiPerSediAttiviNEW(request.getParameter("idCliente"),request.getParameter("idSede"),idCompany.getId(), session,user); 

				request.getSession().setAttribute("listaStrumenti", listaStrumentiPerSede);
				
				if(strumento.getStato_strumento() != null && strumento.getStato_strumento().getId() == 7225){
					strumento.setStato_strumento(new StatoStrumentoDTO(7226, "In serivzio"));
				}else{
					strumento.setStato_strumento(new StatoStrumentoDTO(7225, "Fuori servizio"));
				}
				JsonObject myObj = new JsonObject();

				Boolean success = GestioneStrumentoBO.update(strumento, session);
					
					String message = "";
					if(success){
						message = "Salvato con Successo";
					}else{
						message = "Errore Salvataggio";
					}
				
				
					Gson gson = new Gson();
					
					// 2. Java object to JSON, and assign to a String

					
					

						myObj.addProperty("success", success);
						myObj.addProperty("messaggio", message);
				        out.println(myObj.toString());

			}else if(action.equals("pdffiltrati")) {
				
				ajax=false;
				String idsStrumenti = request.getParameter("idstrumenti");
				
 				String cliente = request.getParameter("cliente");
				String sede = request.getParameter("sede");
				
				ArrayList<StrumentoDTO> arrayStrumenti = GestioneStrumentoBO.getStrumentiByIds(idsStrumenti, session);
				
				new CreateSchedaListaStrumenti(arrayStrumenti,cliente, sede ,session,getServletContext());
				
				
				File output = new File(Costanti.PATH_FOLDER+"//temp//SchedaListastrumenti.pdf");
				
				 FileInputStream fileIn = new FileInputStream(output);
				 
				 response.setContentType("application/octet-stream");
				  
				 response.setHeader("Content-Disposition","attachment;filename=SchedaListastrumenti.pdf");
				 
				 ServletOutputStream outp = response.getOutputStream();
				     
				    byte[] outputByte = new byte[1];
				    
				    while(fileIn.read(outputByte, 0, 1) != -1)
				    {
				    	outp.write(outputByte, 0, 1);
				    }
				    
				    
				    fileIn.close();
				    outp.flush();
				    outp.close();

				    Utility.removeDirectory(new File(Costanti.PATH_FOLDER+"//temp//"));
			 
				
				
				
			}
			
			else if(action.equals("filtra")) {
			
				ajax=false;
				String nome = request.getParameter("nome");
				String marca = request.getParameter("marca");
				String modello = request.getParameter("modello");
				String matricola = request.getParameter("matricola");
				String codice_interno = request.getParameter("codice_interno");
				
				CompanyDTO idCompany=(CompanyDTO)request.getSession().getAttribute("usrCompany");
				
				ArrayList<StrumentoDTO> lista_strumenti_filtrati = GestioneStrumentoBO.getStrumentiFiltrati(nome, marca, modello, matricola, codice_interno, idCompany.getId());

				if(idCompany!=null)
				{
					
				ArrayList<TipoStrumentoDTO> listaTipoStrumento = GestioneTLDAO.getListaTipoStrumento();
				ArrayList<TipoRapportoDTO> listaTipoRapporto = GestioneTLDAO.getListaTipoRapporto();
				ArrayList<StatoStrumentoDTO> listaStatoStrumento = GestioneTLDAO.getListaStatoStrumento();
				ArrayList<LuogoVerificaDTO> listaLuogoVerifica = GestioneTLDAO.getListaLuogoVerifica();
				ArrayList<ClassificazioneDTO> listaClassificazione = GestioneTLDAO.getListaClassificazione();

				
				HashMap<String,Integer> statoStrumenti = new HashMap<String,Integer>();
				HashMap<String,Integer> denominazioneStrumenti = new HashMap<String,Integer>();
				HashMap<String,Integer> tipoStrumenti = new HashMap<String,Integer>();
				HashMap<String,Integer> freqStrumenti = new HashMap<String,Integer>();
				HashMap<String,Integer> repartoStrumenti = new HashMap<String,Integer>();
				HashMap<String,Integer> utilizzatoreStrumenti = new HashMap<String,Integer>();
				

				Gson gson = new Gson(); 
				
				request.getSession().setAttribute("statoStrumentiJson", gson.toJsonTree(statoStrumenti).toString());
				request.getSession().setAttribute("tipoStrumentiJson", gson.toJsonTree(tipoStrumenti).toString());
				request.getSession().setAttribute("denominazioneStrumentiJson", gson.toJsonTree(denominazioneStrumenti).toString());
				request.getSession().setAttribute("freqStrumentiJson", gson.toJsonTree(freqStrumenti).toString());
				request.getSession().setAttribute("repartoStrumentiJson", gson.toJsonTree(repartoStrumenti).toString());
				request.getSession().setAttribute("utilizzatoreStrumentiJson", gson.toJsonTree(utilizzatoreStrumenti).toString());
				

				PrintWriter out = response.getWriter();
			
				
		        JsonObject myObj = new JsonObject();

		        
		       
		        if(lista_strumenti_filtrati!=null && lista_strumenti_filtrati.size()>0){
		            myObj.addProperty("success", true);
		        }
		        else {
		            myObj.addProperty("success", false);
		        }
		        
		        
		        ArrayList<MisuraDTO> lista_misure = new ArrayList<MisuraDTO>();
		        
		        for(int i=0;i<lista_strumenti_filtrati.size();i++) {
		        	lista_misure = GestioneStrumentoBO.getListaMisureByStrumento(lista_strumenti_filtrati.get(i).get__id());
		        	ArrayList<Integer>lista_id_misure = new ArrayList<Integer>();
		        	for(int j = 0; j<lista_misure.size();j++) {
		        		lista_id_misure.add(lista_misure.get(j).getId());
		        	}
		        		Integer max = Collections.max(lista_id_misure);
		        	lista_strumenti_filtrati.get(i).setUltimaMisura(GestioneMisuraBO.getMiruraByID(max));
		        	
		        }

		        JsonElement obj = gson.toJsonTree(lista_strumenti_filtrati);
		        myObj.add("dataInfo", obj);
		        
		        request.getSession().setAttribute("myObj",myObj);

		        request.getSession().setAttribute("listaTipoStrumento",listaTipoStrumento);
		        request.getSession().setAttribute("listaStatoStrumento",listaStatoStrumento);
		        request.getSession().setAttribute("listaTipoRapporto",listaTipoRapporto);
		        request.getSession().setAttribute("listaLuogoVerifica",listaLuogoVerifica);
		        request.getSession().setAttribute("listaClassificazione",listaClassificazione);

					request.getSession().setAttribute("lista_strumenti_filtrati", lista_strumenti_filtrati);
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaStrumentiFiltrati.jsp");
				     dispatcher.forward(request,response);

				} 
			}
		session.getTransaction().commit();
		session.close();


		}else{
			ajax=true;
			PrintWriter out = response.getWriter();
 	        response.setContentType("application/json");
			JsonObject myObj = new JsonObject();

			myObj.addProperty("success", false);
			myObj.addProperty("messaggio", "Nessuna action riconosciuta");
	        out.println(myObj.toString());
		}

		 //  session.getTransaction().commit();
		//	session.close();
	}catch(Exception e)
	{
//		 ex.printStackTrace();
//         response.setContentType("application/json");
         PrintWriter out = response.getWriter();
		 JsonObject myObj = new JsonObject();
//			request.getSession().setAttribute("exception", ex);
//		
//        session.getTransaction().rollback();
//		session.close();
//		myObj = STIException.getException(ex);
//		out.print(myObj);

		 session.getTransaction().rollback();
     	session.close();
		if(ajax) {
			e.printStackTrace();
			request.getSession().setAttribute("exception", e);
			myObj = STIException.getException(e);
			out.print(myObj);
		
		}else {
		e.printStackTrace();
   	     request.setAttribute("error",STIException.callException(e));
   	  request.getSession().setAttribute("exception", e);
   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
   	     dispatcher.forward(request,response);
		}
		
	}  
	
	}
	


}
