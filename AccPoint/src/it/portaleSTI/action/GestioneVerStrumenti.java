package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.record.crypto.Biff8DecryptingStream;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.ForCorsoAllegatiDTO;
import it.portaleSTI.DTO.ForCorsoCatAllegatiDTO;
import it.portaleSTI.DTO.ForCorsoCatDTO;
import it.portaleSTI.DTO.ForCorsoDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerAllegatoStrumentoDTO;
import it.portaleSTI.DTO.VerFamigliaStrumentoDTO;
import it.portaleSTI.DTO.VerInterventoDTO;
import it.portaleSTI.DTO.VerLegalizzazioneBilanceDTO;
import it.portaleSTI.DTO.VerStrumentoDTO;
import it.portaleSTI.DTO.VerTipoStrumentoDTO;
import it.portaleSTI.DTO.VerTipologiaStrumentoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneFormazioneBO;
import it.portaleSTI.bo.GestioneUtenteBO;
import it.portaleSTI.bo.GestioneVerLegalizzazioneBilanceBO;
import it.portaleSTI.bo.GestioneVerStrumentiBO;

/**
 * Servlet implementation class GestioneVerStrumenti
 */
@WebServlet("/gestioneVerStrumenti.do")
public class GestioneVerStrumenti extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final Logger logger = Logger.getLogger(GestioneVerStrumenti.class);
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneVerStrumenti() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
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
			
			logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+utente.getNominativo());
			
			if(action==null) {


//				if(request.getSession().getAttribute("listaClientiAll")==null) 
//				{
//					request.getSession().setAttribute("listaClientiAll",GestioneAnagraficaRemotaBO.getListaClientiAll());
//				}	
//				
//				if(request.getSession().getAttribute("listaSediAll")==null) 
//				{				
//						request.getSession().setAttribute("listaSediAll",GestioneAnagraficaRemotaBO.getListaSediAll());				
//				}			
		
				List<ClienteDTO> listaClienti = (List<ClienteDTO>)request.getSession().getAttribute("lista_clienti");
				if(listaClienti==null) {
					listaClienti = GestioneAnagraficaRemotaBO.getListaClienti(String.valueOf(utente.getCompany().getId()));							
				}
				
				List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				if(listaSedi== null) {
					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
				}
									
				request.getSession().setAttribute("lista_clienti", listaClienti);				
				request.getSession().setAttribute("lista_sedi", listaSedi);

				Gson gson = new GsonBuilder().create();
				JsonArray listaCl = gson.toJsonTree(listaClienti).getAsJsonArray();
				
				request.getSession().setAttribute("listaCl", listaCl.toString().replace("\'", ""));
				
				session.getTransaction().commit();
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneVerStrumenti.jsp");
		  	    dispatcher.forward(request,response);	
				
			}
			
			else if(action.equals("lista")) {
				
				String id_cliente = request.getParameter("id_cliente");
				String id_sede = request.getParameter("id_sede");
				
				ArrayList<VerStrumentoDTO> lista_strumenti = GestioneVerStrumentiBO.getStrumentiClienteSede(Integer.parseInt(id_cliente), Integer.parseInt(id_sede.split("_")[0]), session);
				ArrayList<VerTipoStrumentoDTO> lista_tipo_strumento = GestioneVerStrumentiBO.getListaTipoStrumento(session);
				ArrayList<VerTipologiaStrumentoDTO> lista_tipologie_strumento = GestioneVerStrumentiBO.getListaTipologieStrumento(session);
				ArrayList<VerFamigliaStrumentoDTO> lista_famiglie_strumento = GestioneVerStrumentiBO.getListaFamiglieStrumento(session);
				
				request.getSession().setAttribute("lista_strumenti",lista_strumenti);
				request.getSession().setAttribute("lista_tipo_strumento",lista_tipo_strumento);
				request.getSession().setAttribute("lista_tipologie_strumento",lista_tipologie_strumento);
				request.getSession().setAttribute("lista_famiglie_strumento",lista_famiglie_strumento);	
				
				session.getTransaction().commit();
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneVerStrumentiSede.jsp");
		  	    dispatcher.forward(request,response);	
			}
			else if(action.equals("nuovo")) {				

				ajax=true;
				PrintWriter out = response.getWriter();
				List<FileItem> items = null;
	            if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

	            		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
	            	}
				        		

				
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		        ArrayList<FileItem> lista_file = new ArrayList<FileItem>();
		      
		        for (FileItem item : items) {
    	            	 if (!item.isFormField()) { 
    	            		 if(item.getName()!=null && !item.getName().equals("")) {
    	            			 lista_file.add(item);	 
    	            		 }
    	            		                      
    	            	 }else
    	            	 {
    	                    ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));

    	            	 }
    	            	
	            }
				
		        
		        List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				if(listaSedi== null) {
					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
				}
				
				String cliente = ret.get("id_cliente");
				String sede = ret.get("id_sede");
				String denominazione = ret.get("denominazione");				
				String costruttore = ret.get("costruttore");
				String modello = ret.get("modello");
				String matricola = ret.get("matricola");
				String classe = ret.get("classe");
				String tipo_ver_strumento = ret.get("tipo_ver_strumento");
				String um = ret.get("um");
				String data_ultima_verifica = ret.get("data_ultima_verifica");
				String data_prossima_verifica = ret.get("data_prossima_verifica");
				String portata_min_c1 = ret.get("portata_min_c1");
				String portata_max_c1 = ret.get("portata_max_c1");
				String div_ver_c1 = ret.get("div_ver_c1");
				String div_rel_c1 = ret.get("div_rel_c1");
				String numero_div_c1 = ret.get("numero_div_c1");
				String portata_min_c2 = ret.get("portata_min_c2");
				String portata_max_c2 = ret.get("portata_max_c2");
				String div_ver_c2 = ret.get("div_ver_c2");
				String div_rel_c2 = ret.get("div_rel_c2");
				String numero_div_c2 = ret.get("numero_div_c2");
				String portata_min_c3 = ret.get("portata_min_c3");
				String portata_max_c3 = ret.get("portata_max_c3");
				String div_ver_c3 = ret.get("div_ver_c3");
				String div_rel_c3 = ret.get("div_rel_c3");
				String numero_div_c3 = ret.get("numero_div_c3");
				String data_messa_in_servizio = ret.get("data_messa_in_servizio");
				String anno_marcatura_ce = ret.get("anno_marcatura_ce");
				String tipologia = ret.get("tipologia");
				String famiglia_strumento = ret.get("famiglia_strumento");
				String freq_mesi = ret.get("freq_mesi");
				String selezionati = ret.get("provv_legalizzazione_selezionati");
				String obsoleto = ret.get("obsoleto");
				
				VerStrumentoDTO strumento = new VerStrumentoDTO();
				
				strumento.setId_cliente(Integer.parseInt(cliente));
				strumento.setId_sede(Integer.parseInt(sede.split("_")[0]));
				ClienteDTO cl = GestioneAnagraficaRemotaBO.getClienteById(cliente);
				strumento.setNome_cliente(cl.getNome());

				SedeDTO sd =null;
				if(!sede.equals("0")) {
					sd = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, Integer.parseInt(sede.split("_")[0]), Integer.parseInt(cliente));
					strumento.setNome_sede(sd.getDescrizione() + " - "+sd.getIndirizzo());
				}else {
					strumento.setNome_sede("Non associate");
				}
				
				strumento.setCostruttore(costruttore);
				SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
				
				if(data_prossima_verifica!=null && !data_prossima_verifica.equals("")) {
					strumento.setData_prossima_verifica(sdf.parse(data_prossima_verifica));	
				}	
				if(data_ultima_verifica!=null && !data_ultima_verifica.equals("")) {
					strumento.setData_ultima_verifica(sdf.parse(data_ultima_verifica));	
				}				
				strumento.setDenominazione(denominazione);				
				strumento.setMatricola(matricola);
				strumento.setModello(modello);
				strumento.setClasse(Integer.parseInt(classe));
				strumento.setUm(um);
				strumento.setTipo(new VerTipoStrumentoDTO(Integer.parseInt(tipo_ver_strumento),""));
				strumento.setTipologia(new VerTipologiaStrumentoDTO(Integer.parseInt(tipologia),""));
				strumento.setFreqMesi(Integer.parseInt(freq_mesi));
				if(obsoleto == null) {
					strumento.setObsoleto(0);
				}else {
					strumento.setObsoleto(Integer.parseInt(obsoleto));
				}
				if(div_rel_c1!=null && !div_rel_c1.equals("")) {
					strumento.setDiv_rel_C1(new BigDecimal(div_rel_c1));	
				}
				if(div_ver_c1!=null && !div_ver_c1.equals("")) {
					strumento.setDiv_ver_C1(new BigDecimal(div_ver_c1));	
				}
				if(numero_div_c1!=null && !numero_div_c1.equals("")) {
					strumento.setNumero_div_C1(new BigDecimal(numero_div_c1));	
				}
				if(portata_max_c1!=null && !portata_max_c1.equals("")) {
					strumento.setPortata_max_C1(new BigDecimal(portata_max_c1));	
				}
				if(portata_min_c1!=null && !portata_min_c1.equals("")) {
					strumento.setPortata_min_C1(new BigDecimal(portata_min_c1));	
				}
				if(anno_marcatura_ce!=null && !anno_marcatura_ce.equals("")) {
					strumento.setAnno_marcatura_ce(Integer.parseInt(anno_marcatura_ce));	
				}
				
				strumento.setData_messa_in_servizio(sdf.parse(data_messa_in_servizio));
				strumento.setFamiglia_strumento(new VerFamigliaStrumentoDTO(famiglia_strumento,""));
				
				if(!tipo_ver_strumento.equals("1")) {
					if(div_rel_c2!=null && !div_rel_c2.equals("")) {
						strumento.setDiv_rel_C2(new BigDecimal(div_rel_c2));	
					}
					if(div_ver_c2!=null && !div_ver_c2.equals("")) {
						strumento.setDiv_ver_C2(new BigDecimal(div_ver_c2));	
					}
					if(portata_max_c2!=null && !portata_max_c2.equals("")) {
						strumento.setPortata_max_C2(new BigDecimal(portata_max_c2));	
					}
					if(portata_max_c2!=null && !portata_max_c2.equals("")) {
						strumento.setPortata_max_C2(new BigDecimal(portata_max_c2));	
					}
					if(portata_min_c2!=null && !portata_min_c2.equals("")) {
						strumento.setPortata_min_C2(new BigDecimal(portata_min_c2));	
					}
					if(numero_div_c2!=null && !numero_div_c2.equals("")) {
						strumento.setNumero_div_C2(new BigDecimal(numero_div_c2));	
					}
					if(div_rel_c3!=null && !div_rel_c3.equals("")) {
						strumento.setDiv_rel_C3(new BigDecimal(div_rel_c3));	
					}
					if(div_ver_c3!=null && !div_ver_c3.equals("")) {
						strumento.setDiv_ver_C3(new BigDecimal(div_ver_c3));	
					}
					if(numero_div_c3!=null && !numero_div_c3.equals("")) {
						strumento.setNumero_div_C3(new BigDecimal(numero_div_c3));	
					}
					if(portata_max_c3!=null && !portata_max_c3.equals("")) {
						strumento.setPortata_max_C3(new BigDecimal(portata_max_c3));	
					}
					if(portata_min_c3!=null && !portata_min_c3.equals("")) {
						strumento.setPortata_min_C3(new BigDecimal(portata_min_c3));	
					}
					
				}else {
					strumento.setDiv_rel_C2(null);
					strumento.setDiv_ver_C2(null);
					strumento.setNumero_div_C2(null);
					strumento.setPortata_max_C2(null);
					strumento.setPortata_min_C2(null);
					strumento.setDiv_rel_C3(null);
					strumento.setDiv_ver_C3(null);
					strumento.setNumero_div_C3(null);
					strumento.setPortata_max_C3(null);
					strumento.setPortata_min_C3(null);
				}


				session.save(strumento);
				
				for (FileItem item : lista_file) {
					saveFile(item, strumento.getId(), item.getName());
					VerAllegatoStrumentoDTO allegato = new VerAllegatoStrumentoDTO();
					allegato.setStrumento(strumento);
					allegato.setNome_file(item.getName());
					session.save(allegato);
				}
								
				
				if(selezionati!=null && !selezionati.equals("")) {
					for(int i = 0;i<selezionati.split(";").length;i++) {
						
						VerLegalizzazioneBilanceDTO provvedimento = GestioneVerLegalizzazioneBilanceBO.getProvvedimentoFromId(Integer.parseInt(selezionati.split(";")[i]), session);
						strumento.getLista_legalizzazione_bilance().add(provvedimento);					
					}					
				}
				
				session.getTransaction().commit();				
				
				
				session.close();
				myObj.addProperty("success", true);				
				myObj.addProperty("messaggio", "Strumento inserito con successo!");
				out.print(myObj);
				
				
			}
			else if(action.equals("modifica")) {
				
				ajax=true;
				PrintWriter out = response.getWriter();
				List<FileItem> items = null;
	            if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

	            		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
	            	}
				
        		
    	 		FileItem fileItem = null;
				
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
    	            	 if (!item.isFormField()) {       		
    	                     fileItem = item;                     
    	            	 }
    	            	 else
    	            	 {
    	                    ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));

    	            	 }
	            }
		        
		        List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				if(listaSedi== null) {
					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
				}
				
		        String id_strumento = ret.get("id_strumento");
				String cliente = ret.get("cliente_mod");
				String sede = ret.get("sede_mod");
				String denominazione = ret.get("denominazione_mod");				
				String costruttore = ret.get("costruttore_mod");
				String modello = ret.get("modello_mod");
				String matricola = ret.get("matricola_mod");
				String classe = ret.get("classe_mod");
				String tipo_ver_strumento = ret.get("tipo_ver_strumento_mod");
				String um = ret.get("um_mod");
				String data_ultima_verifica = ret.get("data_ultima_verifica_mod");
				String data_prossima_verifica = ret.get("data_prossima_verifica_mod");
				String portata_min_c1 = ret.get("portata_min_c1_mod");
				String portata_max_c1 = ret.get("portata_max_c1_mod");
				String div_ver_c1 = ret.get("div_ver_c1_mod");
				String div_rel_c1 = ret.get("div_rel_c1_mod");
				String numero_div_c1 = ret.get("numero_div_c1_mod");
				String portata_min_c2 = ret.get("portata_min_c2_mod");
				String portata_max_c2 = ret.get("portata_max_c2_mod");
				String div_ver_c2 = ret.get("div_ver_c2_mod");
				String div_rel_c2 = ret.get("div_rel_c2_mod");
				String numero_div_c2 = ret.get("numero_div_c2_mod");
				String portata_min_c3 = ret.get("portata_min_c3_mod");
				String portata_max_c3 = ret.get("portata_max_c3_mod");
				String div_ver_c3 = ret.get("div_ver_c3_mod");
				String div_rel_c3 = ret.get("div_rel_c3_mod");
				String numero_div_c3 = ret.get("numero_div_c3_mod");
				String data_messa_in_servizio = ret.get("data_messa_in_servizio_mod");
				String anno_marcatura_ce = ret.get("anno_marcatura_ce_mod");
				String tipologia = ret.get("tipologia_mod");
				String famiglia_strumento = ret.get("famiglia_strumento_mod");
				String freq_mesi = ret.get("freq_mesi_mod");
				String obsoleto = ret.get("obsoleto_mod");
				
				VerStrumentoDTO strumento = GestioneVerStrumentiBO.getVerStrumentoFromId(Integer.parseInt(id_strumento), session);
				
				strumento.setId_cliente(Integer.parseInt(cliente));
				strumento.setId_sede(Integer.parseInt(sede.split("_")[0]));
				ClienteDTO cl = GestioneAnagraficaRemotaBO.getClienteById(cliente);
				strumento.setNome_cliente(cl.getNome());
				
				SedeDTO sd =null;
				if(!sede.equals("0")) {
					sd = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, Integer.parseInt(sede.split("_")[0]), Integer.parseInt(cliente));
					strumento.setNome_sede(sd.getDescrizione() + " - "+sd.getIndirizzo());
				}else {
					strumento.setNome_sede("Non associate");
				}
								
				if(obsoleto == null) {
					strumento.setObsoleto(0);
				}else {
					strumento.setObsoleto(Integer.parseInt(obsoleto));
				}
				strumento.setCostruttore(costruttore);
				SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
				if(data_prossima_verifica!=null && !data_prossima_verifica.equals("")) {
					strumento.setData_prossima_verifica(sdf.parse(data_prossima_verifica));	
				}else {
					strumento.setData_prossima_verifica(null);	
				}
				if(data_ultima_verifica!=null && !data_ultima_verifica.equals("")) {
					strumento.setData_ultima_verifica(sdf.parse(data_ultima_verifica));	
				}else {
					strumento.setData_ultima_verifica(null);	
				}	
				strumento.setDenominazione(denominazione);				
				strumento.setMatricola(matricola);
				strumento.setModello(modello);
				strumento.setClasse(Integer.parseInt(classe));
				strumento.setUm(um);
				strumento.setTipo(new VerTipoStrumentoDTO(Integer.parseInt(tipo_ver_strumento),""));
				strumento.setTipologia(new VerTipologiaStrumentoDTO(Integer.parseInt(tipologia),""));
				strumento.setFreqMesi(Integer.parseInt(freq_mesi));
				if(div_rel_c1!=null && !div_rel_c1.equals("")) {
					strumento.setDiv_rel_C1(new BigDecimal(div_rel_c1));	
				}else {
					strumento.setDiv_rel_C1(null);	
				}
				if(div_ver_c1!=null && !div_ver_c1.equals("")) {
					strumento.setDiv_ver_C1(new BigDecimal(div_ver_c1));	
				}else {
					strumento.setDiv_ver_C1(null);
				}
				if(numero_div_c1!=null && !numero_div_c1.equals("")) {
					strumento.setNumero_div_C1(new BigDecimal(numero_div_c1));	
				}else {
					strumento.setNumero_div_C1(null);	
				}
				if(portata_max_c1!=null && !portata_max_c1.equals("")) {
					strumento.setPortata_max_C1(new BigDecimal(portata_max_c1));	
				}else {
					strumento.setPortata_max_C1(null);	
				}
				if(portata_min_c1!=null && !portata_min_c1.equals("")) {
					strumento.setPortata_min_C1(new BigDecimal(portata_min_c1));	
				}else {
					strumento.setPortata_min_C1(null);	
				}
				if(anno_marcatura_ce!=null && !anno_marcatura_ce.equals("")) {
					strumento.setAnno_marcatura_ce(Integer.parseInt(anno_marcatura_ce));	
				}
				strumento.setData_messa_in_servizio(sdf.parse(data_messa_in_servizio));
				strumento.setFamiglia_strumento(new VerFamigliaStrumentoDTO(famiglia_strumento,""));

				
				if(!tipo_ver_strumento.equals("1")) {
					if(div_rel_c2!=null && !div_rel_c2.equals("")) {
						strumento.setDiv_rel_C2(new BigDecimal(div_rel_c2));	
					}else {
						strumento.setDiv_rel_C2(null);	
					}
					if(div_ver_c2!=null && !div_ver_c2.equals("")) {
						strumento.setDiv_ver_C2(new BigDecimal(div_ver_c2));	
					}else {
						strumento.setDiv_ver_C2(null);	
					}
					if(portata_max_c2!=null && !portata_max_c2.equals("")) {
						strumento.setPortata_max_C2(new BigDecimal(portata_max_c2));	
					}else {
						strumento.setPortata_max_C2(null);	
					}
					if(portata_max_c2!=null && !portata_max_c2.equals("")) {
						strumento.setPortata_max_C2(new BigDecimal(portata_max_c2));	
					}else {
						strumento.setPortata_max_C2(null);
					}
					if(portata_min_c2!=null && !portata_min_c2.equals("")) {
						strumento.setPortata_min_C2(new BigDecimal(portata_min_c2));	
					}else {
						strumento.setPortata_min_C2(null);
					}
					if(numero_div_c2!=null && !numero_div_c2.equals("")) {
						strumento.setNumero_div_C2(new BigDecimal(numero_div_c2));	
					}else {
						strumento.setNumero_div_C2(null);
					}
					if(div_rel_c3!=null && !div_rel_c3.equals("")) {
						strumento.setDiv_rel_C3(new BigDecimal(div_rel_c3));	
					}else {
						strumento.setDiv_rel_C3(null);
					}
					if(div_ver_c3!=null && !div_ver_c3.equals("")) {
						strumento.setDiv_ver_C3(new BigDecimal(div_ver_c3));	
					}else {
						strumento.setDiv_ver_C3(null);
					}
					if(numero_div_c3!=null && !numero_div_c3.equals("")) {
						strumento.setNumero_div_C3(new BigDecimal(numero_div_c3));	
					}else {
						strumento.setNumero_div_C3(null);	
					}
					if(portata_max_c3!=null && !portata_max_c3.equals("")) {
						strumento.setPortata_max_C3(new BigDecimal(portata_max_c3));	
					}else {
						strumento.setPortata_max_C3(null);
					}
					if(portata_min_c3!=null && !portata_min_c3.equals("")) {
						strumento.setPortata_min_C3(new BigDecimal(portata_min_c3));	
					}else {
						strumento.setPortata_min_C3(null);
					}
				
				}
				else {
					strumento.setDiv_rel_C2(null);
					strumento.setDiv_ver_C2(null);
					strumento.setNumero_div_C2(null);
					strumento.setPortata_max_C2(null);
					strumento.setPortata_min_C2(null);
					strumento.setDiv_rel_C3(null);
					strumento.setDiv_ver_C3(null);
					strumento.setNumero_div_C3(null);
					strumento.setPortata_max_C3(null);
					strumento.setPortata_min_C3(null);
				}

				session.update(strumento);
								
				session.getTransaction().commit();
				
				session.close();
				myObj.addProperty("success", true);				
				myObj.addProperty("messaggio", "Strumento modificato con successo!");
				out.print(myObj);
				
				
			}
			
			else if(action.equals("allegati")) {
				
				String id_strumento = request.getParameter("id_strumento");
							
				ArrayList<VerAllegatoStrumentoDTO> lista_allegati_strumento = GestioneVerStrumentiBO.getListaAllegatiStrumento(Integer.parseInt(id_strumento), session);
				
				request.getSession().setAttribute("lista_allegati_strumento", lista_allegati_strumento);
				
				request.getSession().setAttribute("id_strumento", id_strumento);				
				
				session.getTransaction().commit();
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaAllegatiVerStrumento.jsp");
		     	dispatcher.forward(request,response);
				
			}
			else if(action.equals("upload_allegati")){
				
				ajax = true;
				
				String id_strumento = request.getParameter("id_strumento");			
								
				ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
				PrintWriter out = response.getWriter();
				response.setContentType("application/json");						
					
					List<FileItem> items = uploadHandler.parseRequest(request);
					for (FileItem item : items) {
						if (!item.isFormField()) {							
								
							VerAllegatoStrumentoDTO allegato_strumento = new VerAllegatoStrumentoDTO();
							VerStrumentoDTO strumento = GestioneVerStrumentiBO.getVerStrumentoFromId(Integer.parseInt(id_strumento), session);
							allegato_strumento.setStrumento(strumento);
							allegato_strumento.setNome_file(item.getName().replaceAll("'", "_"));
							saveFile(item, strumento.getId(),item.getName());	
							session.save(allegato_strumento);							
						}
					}

					session.getTransaction().commit();
					session.close();	
					myObj.addProperty("success", true);
					myObj.addProperty("messaggio", "Upload effettuato con successo!");
					out.print(myObj);
			}
			else if(action.equals("download_allegato")){
				
				String id_strumento = request.getParameter("id_strumento");				
				String id_allegato = request.getParameter("id_allegato");				
			
				VerAllegatoStrumentoDTO allegato_strumento = GestioneVerStrumentiBO.getAllegatoStrumentoFormId(Integer.parseInt(id_allegato), session);
					
				String path = Costanti.PATH_FOLDER+"//Verificazione//Strumenti//"+id_strumento+"//"+allegato_strumento.getNome_file();
				response.setContentType("application/octet-stream");
				response.setHeader("Content-Disposition","attachment;filename="+ allegato_strumento.getNome_file());
		
				ServletOutputStream outp = response.getOutputStream();
				 File file = new File(path);
					
					FileInputStream fileIn = new FileInputStream(file);

			
					    byte[] outputByte = new byte[1];
					    
					    while(fileIn.read(outputByte, 0, 1) != -1)
					    {
					    	outp.write(outputByte, 0, 1);
					    }
					    				    
					 
					    fileIn.close();
					    outp.flush();
					    outp.close();
				
				session.close();
				
			}
			
			
			else if(action.equals("elimina_allegato")) {
				
				ajax=true;				

				String id_allegato = request.getParameter("id_allegato");				
			
				VerAllegatoStrumentoDTO allegato_strumento = GestioneVerStrumentiBO.getAllegatoStrumentoFormId(Integer.parseInt(id_allegato), session);
			
				session.delete(allegato_strumento);	
				
				
				PrintWriter out = response.getWriter();
				session.getTransaction().commit();
				session.close();	
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Allegato eliminato con successo!");
				out.print(myObj);
				
				
			}
			
			else if(action.equals("strumenti_scadenza")) {
				
				String data = request.getParameter("data");
				
				ArrayList<VerStrumentoDTO> lista_strumenti = GestioneVerStrumentiBO.getlistaStrumentiScadenza(data,data,utente, session);
				ArrayList<VerTipoStrumentoDTO> lista_tipo_strumento = GestioneVerStrumentiBO.getListaTipoStrumento(session);
				ArrayList<VerTipologiaStrumentoDTO> lista_tipologie_strumento = GestioneVerStrumentiBO.getListaTipologieStrumento(session);
				ArrayList<VerFamigliaStrumentoDTO> lista_famiglie_strumento = GestioneVerStrumentiBO.getListaFamiglieStrumento(session);
				
				request.getSession().setAttribute("lista_strumenti",lista_strumenti);
				request.getSession().setAttribute("lista_tipo_strumento",lista_tipo_strumento);
				request.getSession().setAttribute("lista_tipologie_strumento",lista_tipologie_strumento);
				request.getSession().setAttribute("lista_famiglie_strumento",lista_famiglie_strumento);	
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				request.getSession().setAttribute("data",sdf.parseObject(data));
				
				
				session.getTransaction().commit();
				session.close();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaVerStrumentiScadenza.jsp");
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

	
	
	 private void saveFile(FileItem item, int id_strumento, String filename) {

		 	String path_folder = Costanti.PATH_FOLDER+"//Verificazione//Strumenti//"+id_strumento+"//";
			File folder=new File(path_folder);
			
			if(!folder.exists()) {
				folder.mkdirs();
			}
		
			
			while(true)
			{
				File file=null;
				
				
				file = new File(path_folder+filename);					
				
					try {
						item.write(file);
						break;

					} catch (Exception e) 
					{

						e.printStackTrace();
						break;
					}
			}
		
		}
	 
 private void downloadFile(String path,  ServletOutputStream outp) throws Exception {
		 
		 File file = new File(path);
			
			FileInputStream fileIn = new FileInputStream(file);

	
			    byte[] outputByte = new byte[1];
			    
			    while(fileIn.read(outputByte, 0, 1) != -1)
			    {
			    	outp.write(outputByte, 0, 1);
			    }
			    				    
			 
			    fileIn.close();
			    outp.flush();
			    outp.close();
	 }
}
