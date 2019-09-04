package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
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
import it.portaleSTI.bo.CreateVerRapporto;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneVerInterventoBO;
import it.portaleSTI.bo.GestioneVerMisuraBO;
import it.portaleSTI.bo.VerCertificatoBO;

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
			
			ArrayList<VerRipetibilitaDTO> lista_ripetibilita = GestioneVerMisuraBO.getListaRipetibilita(Integer.parseInt(id_misura), session);
			ArrayList<VerDecentramentoDTO> lista_decentramento = GestioneVerMisuraBO.getListaDecentramento(Integer.parseInt(id_misura), session);
			ArrayList<VerLinearitaDTO> lista_linearita = GestioneVerMisuraBO.getListaLinearita(Integer.parseInt(id_misura), session);
			ArrayList<VerAccuratezzaDTO> lista_accuratezza = GestioneVerMisuraBO.getListaAccuratezza(Integer.parseInt(id_misura), session);
			ArrayList<VerMobilitaDTO> lista_mobilita = GestioneVerMisuraBO.getListaMobilita(Integer.parseInt(id_misura), session);
			
			ClienteDTO cliente = GestioneAnagraficaRemotaBO.getClienteById(String.valueOf(misura.getVerStrumento().getId_cliente()));
			List<SedeDTO> listaSedi = (List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
			if(listaSedi== null) {
				listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
			}
			
			SedeDTO sede = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, misura.getVerStrumento().getId_sede(), misura.getVerStrumento().getId_cliente());
			
			ArrayList<String> checkList = null;
			boolean esito_globale = true;
			String esitoCheck = "1";
			
			if(misura.getIs_difetti().equals("S")) {
				esito_globale = false;
			}else {
				if(misura.getSeqRisposte()!=null) {
					checkList = new ArrayList<String>(Arrays.asList(misura.getSeqRisposte().split(";")));	
					if(checkList.contains("1")) {
						esito_globale = false;
					}
				}
				
				if(lista_ripetibilita!=null && lista_ripetibilita.size()>0) {
					for (VerRipetibilitaDTO item : lista_ripetibilita) {
						if(item.getEsito().equals("NEGATIVO")) {
							esito_globale = false;
						}
					}					
				}
				if(lista_linearita!=null && lista_linearita.size()>0) {
					for (VerLinearitaDTO item : lista_linearita) {
						if(item.getEsito().equals("NEGATIVO")) {
							esito_globale = false;
						}
					}					
				}
				if(lista_decentramento!=null && lista_decentramento.size()>0) {
					for (VerDecentramentoDTO item : lista_decentramento) {
						if(item.getEsito().equals("NEGATIVO")) {
							esito_globale = false;
						}
					}					
				}
				if(misura.getVerStrumento().getTipologia().getId()==2) {
					if(lista_accuratezza!=null && lista_accuratezza.size()>0) {
						for (VerAccuratezzaDTO item : lista_accuratezza) {
							if(item.getEsito().equals("NEGATIVO")) {
								esito_globale = false;
							}
						}					
					}	
				}				
				if(misura.getVerStrumento().getTipologia().getId()==2) {
					if(lista_mobilita!=null && lista_mobilita.size()>0) {
						for (VerMobilitaDTO item : lista_mobilita) {
							if(item.getEsito()!=null && item.getEsito().equals("NEGATIVO")) {
								esito_globale = false;
							}
						}					
					}	
				}
				
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
			
			session.close();
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioVerMisura.jsp");
	  	    dispatcher.forward(request,response);
		}
		else if(action.equals("crea_certificato")) {
			
			String id_misura = request.getParameter("id_misura");
			
			id_misura = Utility.decryptData(id_misura);
			
			VerMisuraDTO misura = GestioneVerMisuraBO.getMisuraFromId(Integer.parseInt(id_misura), session);
			
			ArrayList<VerRipetibilitaDTO> lista_ripetibilita = GestioneVerMisuraBO.getListaRipetibilita(Integer.parseInt(id_misura), session);
			ArrayList<VerDecentramentoDTO> lista_decentramento = GestioneVerMisuraBO.getListaDecentramento(Integer.parseInt(id_misura), session);
			ArrayList<VerLinearitaDTO> lista_linearita = GestioneVerMisuraBO.getListaLinearita(Integer.parseInt(id_misura), session);
			ArrayList<VerAccuratezzaDTO> lista_accuratezza = GestioneVerMisuraBO.getListaAccuratezza(Integer.parseInt(id_misura), session);
			ArrayList<VerMobilitaDTO> lista_mobilita = GestioneVerMisuraBO.getListaMobilita(Integer.parseInt(id_misura), session);
			
			ClienteDTO cliente = GestioneAnagraficaRemotaBO.getClienteById(String.valueOf(misura.getVerStrumento().getId_cliente()));
			List<SedeDTO> listaSedi = (List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
			if(listaSedi== null) {
				listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
			}
			
			SedeDTO sede = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, misura.getVerStrumento().getId_sede(), misura.getVerStrumento().getId_cliente());
			
			int motivo = 0;
			boolean esito_globale = true;
			ArrayList<String> checkList = null;	
			if(misura.getIs_difetti().equals("S")) {
				esito_globale = false;
				motivo = 3;
			}else {
				if(misura.getSeqRisposte()!=null) {
					checkList = new ArrayList<String>(Arrays.asList(misura.getSeqRisposte().split(";")));	
					if(checkList.contains("1")) {
						esito_globale = false;
						motivo = 2;
					}
				}
				
				if(lista_ripetibilita!=null && lista_ripetibilita.size()>0) {
					for (VerRipetibilitaDTO item : lista_ripetibilita) {
						if(item.getEsito().equals("NEGATIVO")) {
							esito_globale = false;
							motivo = 1;
						}
					}					
				}
				if(lista_linearita!=null && lista_linearita.size()>0) {
					for (VerLinearitaDTO item : lista_linearita) {
						if(item.getEsito().equals("NEGATIVO")) {
							esito_globale = false;
							motivo = 1;
						}
					}					
				}
				if(lista_decentramento!=null && lista_decentramento.size()>0) {
					for (VerDecentramentoDTO item : lista_decentramento) {
						if(item.getEsito().equals("NEGATIVO")) {
							esito_globale = false;
							motivo = 1;
						}
					}					
				}
				if(lista_accuratezza!=null && lista_accuratezza.size()>0) {
					for (VerAccuratezzaDTO item : lista_accuratezza) {
						if(item.getEsito().equals("NEGATIVO")) {
							esito_globale = false;
							motivo = 1;
						}
					}					
				}		
				
				if(lista_mobilita!=null && lista_mobilita.size()>0) {
					for (VerMobilitaDTO item : lista_mobilita) {
						if(item.getEsito().equals("NEGATIVO")) {
							esito_globale = false;
							motivo = 1;
						}
					}					
				}					
			}				
						
			new CreateVerCertificato(misura, listaSedi, esito_globale, motivo, session);
			//new CreateVerRapporto(misura,listaSedi,esito_globale,motivo, session);
			//String path ="C:\\Users\\antonio.dicivita\\Desktop\\TestVerCertificato.pdf";
			String filename=misura.getVerIntervento().getNome_pack()+"_"+misura.getId()+""+misura.getVerStrumento().getId()+".pdf";
			
			String path = Costanti.PATH_FOLDER+"\\"+misura.getVerIntervento().getNome_pack()+"\\"+filename;
			
			//File d = new File(Costanti.PATH_FOLDER+"//Campioni//"+campione.getId()+"/"+campione.getCertificatoCorrente(campione.getListaCertificatiCampione()).getFilename());
			VerCertificatoDTO cert=VerCertificatoBO.getCertificatoByMisura(misura);
			
			cert.setNomeCertificato(filename);
			cert.setStato(new StatoCertificatoDTO(2));
			
			session.update(cert);
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
			
			ArrayList<VerMisuraDTO> lista_misure = GestioneVerMisuraBO.getListaMisure(session);
			session.close();
			
			request.getSession().setAttribute("lista_misure", lista_misure);
			
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaVerMisure.jsp");
	  	    dispatcher.forward(request,response);
			
					
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
