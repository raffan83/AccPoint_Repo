package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.StatoCertificatoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerAccuratezzaDTO;
import it.portaleSTI.DTO.VerCertificatoDTO;
import it.portaleSTI.DTO.VerDecentramentoDTO;
import it.portaleSTI.DTO.VerLinearitaDTO;
import it.portaleSTI.DTO.VerMisuraDTO;
import it.portaleSTI.DTO.VerMobilitaDTO;
import it.portaleSTI.DTO.VerRipetibilitaDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.CreateVerCertificato;

import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneCommesseBO;
import it.portaleSTI.bo.GestioneCompanyBO;
import it.portaleSTI.bo.GestioneVerCertificatoBO;
import it.portaleSTI.bo.GestioneVerInterventoBO;
import it.portaleSTI.bo.GestioneVerMisuraBO;

/**
 * Servlet implementation class GestioneVerMisura
 */
@WebServlet("/gestioneVerMisura.do")
public class GestioneVerMisura extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneVerMisura() {
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
		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
		
		String action = request.getParameter("action");
		
		JsonObject myObj = new JsonObject();
		boolean ajax = false;
        response.setContentType("application/json");
		try {
			
		if(action!=null && action.equals("dettaglio")) {
			
			String id_misura = request.getParameter("id_misura");
			
			id_misura = Utility.decryptData(id_misura);
			
			VerMisuraDTO misura = GestioneVerMisuraBO.getMisuraFromId(Integer.parseInt(id_misura), session);
			
			ArrayList<VerRipetibilitaDTO> lista_ripetibilita  = new ArrayList<VerRipetibilitaDTO>(misura.getListaPuntiRipetibilita());
			ArrayList<VerDecentramentoDTO> lista_decentramento = new ArrayList<VerDecentramentoDTO>(misura.getListaPuntiDecentramento());
			ArrayList<VerLinearitaDTO> lista_linearita = new ArrayList<VerLinearitaDTO>(misura.getListaPuntiLinearita());
			ArrayList<VerAccuratezzaDTO> lista_accuratezza = new ArrayList<VerAccuratezzaDTO>(misura.getListaPuntiAccuratezza());
			ArrayList<VerMobilitaDTO> lista_mobilita = new ArrayList<VerMobilitaDTO>(misura.getListaPuntiMobilita());
			
			VerCertificatoDTO certificato = GestioneVerCertificatoBO.getCertificatoByMisura(misura);
			
			ClienteDTO cliente = GestioneAnagraficaRemotaBO.getClienteById(String.valueOf(misura.getVerStrumento().getId_cliente()));
			List<SedeDTO> listaSedi = (List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
			if(listaSedi== null) {
				listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
			}
			
			SedeDTO sede = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, misura.getVerStrumento().getId_sede(), misura.getVerStrumento().getId_cliente());
			
			String esitoCheck = "1";
			
			ArrayList<String> checkList = new ArrayList<String>(Arrays.asList(misura.getSeqRisposte().split(";")));
			
			
			int motivo = GestioneVerMisuraBO.getEsito(misura);
			boolean esito_globale = true;
			if(motivo!=0) {
				esito_globale = false;			
			}
			
			
			if(new ArrayList<String>(Arrays.asList(misura.getSeqRisposte().split(";"))).contains("1")) {
				esitoCheck= "0";
			}
			
			request.getSession().setAttribute("lista_ripetibilita", lista_ripetibilita);
			request.getSession().setAttribute("lista_decentramento", lista_decentramento);
			request.getSession().setAttribute("lista_linearita", lista_linearita);
			request.getSession().setAttribute("lista_accuratezza", lista_accuratezza);
			request.getSession().setAttribute("lista_mobilita", lista_mobilita);
			request.getSession().setAttribute("cliente", cliente);		
			request.getSession().setAttribute("sede", sede);	
			request.getSession().setAttribute("misura", misura);
			request.getSession().setAttribute("checkList", checkList);
			request.getSession().setAttribute("esitoCheck", esitoCheck);
			request.getSession().setAttribute("esito_globale", esito_globale);
			request.getSession().setAttribute("certificato", certificato);
			request.getSession().setAttribute("motivo", motivo);
			
			
			session.close();
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioVerMisura.jsp");
	  	    dispatcher.forward(request,response);
		}
		
		else if(action.equals("download_immagine")) {
			
			String id_misura = request.getParameter("id_misura");
			String filename = request.getParameter("filename");
			String nome_pack = request.getParameter("nome_pack");
			
			id_misura = Utility.decryptData(id_misura);
			
			String path = Costanti.PATH_FOLDER+"\\"+nome_pack+"\\"+id_misura+"\\"+filename;
			
			File d = new File(path);
			 FileInputStream fileIn = new FileInputStream(d);
			 
			 response.setContentType("application/octet-stream");
							 
			 response.setHeader("Content-Disposition","attachment;filename="+filename);
			 
			 ServletOutputStream outp = response.getOutputStream();
			     
			    byte[] outputByte = new byte[1];
			    
			    while(fileIn.read(outputByte, 0, 1) != -1)
			    {
			    	outp.write(outputByte, 0, 1);
			    }
			    
			    
			    session.getTransaction().commit();
			    session.close();
			    fileIn.close();
		
			    outp.flush();
			    outp.close();
		}
		else if(action.equals("lista")) {
			
			ArrayList<VerMisuraDTO> lista_misure = GestioneVerMisuraBO.getListaMisure(utente, session);
		
			
			for (VerMisuraDTO misura : lista_misure) {
				if(misura.getVerIntervento().getId_sede()==0) {
					String indirizzo = "";
					ClienteDTO cliente = GestioneAnagraficaRemotaBO.getClienteById(""+misura.getVerIntervento().getId_cliente());
					if(cliente.getNome()!=null) {
						indirizzo = cliente.getNome();
					}
					if( cliente.getIndirizzo()!=null) {
						indirizzo = indirizzo + " - "+cliente.getIndirizzo();				
					}						
					if(cliente.getCitta()!=null) {
							indirizzo = indirizzo + " - "+cliente.getCitta();
					}
				misura.getVerIntervento().setNome_sede(indirizzo);	
				
				}				

			}
			
			request.getSession().setAttribute("lista_misure", lista_misure);
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaVerMisure.jsp");
	  	    dispatcher.forward(request,response);
			
	  		session.close();
		}
			
			
			
		}catch (Exception e) {
			session.getTransaction().rollback();
        	session.close();
			if(ajax) {
				PrintWriter out = response.getWriter();
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
