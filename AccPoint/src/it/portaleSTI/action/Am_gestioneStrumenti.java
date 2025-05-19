package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.List;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.AMInterventoDTO;
import it.portaleSTI.DTO.AMOggettoProvaDTO;
import it.portaleSTI.DTO.AMOggettoProvaZonaRifDTO;
import it.portaleSTI.DTO.AMOperatoreDTO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAM_BO;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;

/**
 * Servlet implementation class listaCampioni
 */
@WebServlet(name="amGestioneStrumenti" , urlPatterns = { "/amGestioneStrumenti.do" })

public class Am_gestioneStrumenti extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Am_gestioneStrumenti() {
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

		if(Utility.validateSession(request,response,getServletContext()))return;

		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
		
		String action = request.getParameter("action");
		
		JsonObject myObj = new JsonObject();
		boolean ajax = false;
        response.setContentType("application/json");
        
		
			 
		try {

			if(action.equals("lista")) {
				
				List<ClienteDTO> listaClienti = (List<ClienteDTO>)request.getSession().getAttribute("lista_clienti");

				
				if(listaClienti==null) {
					listaClienti = GestioneAnagraficaRemotaBO.getListaClienti(String.valueOf(utente.getCompany().getId()));							
				}
				
				List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				if(listaSedi== null) {
					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
				}
				
				ArrayList<AMOggettoProvaDTO> lista_strumenti = GestioneAM_BO.getListaStrumenti(session);
				for (AMOggettoProvaDTO s : lista_strumenti) {
					ClienteDTO cl = GestioneAnagraficaRemotaBO.getClienteById(""+s.getId_cliente());
					
					s.setNomeClienteUtilizzatore(cl.getNome());
					SedeDTO sd =null;
					if(s.getId_sede()!=0) {
						sd = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, s.getId_sede(), s.getId_cliente());
						s.setNomeSedeUtilizzatore(sd.getDescrizione() + " - "+sd.getIndirizzo());
					}else {
						s.setNomeSedeUtilizzatore("Non associate");
					}
					
					
				}
				
				request.getSession().setAttribute("lista_strumenti", lista_strumenti);
				request.getSession().setAttribute("lista_clienti", listaClienti);
				request.getSession().setAttribute("lista_sedi", listaSedi);
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/am_listaStrumenti.jsp");
		     	dispatcher.forward(request,response);
				
			}
			else if(action.equals("nuovo")) {
				
				
				ajax = true;
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}
		        
				FileItem fileItem = null;
				String filename= null;

		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	                     fileItem = item;
	                     filename = item.getName();
	                     
	            	 }else
	            	 {
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	            	 }
	            	
	            }
		
		        String id_cliente = ret.get("cliente_general");
		        String id_sede = ret.get("sede_general");
		        String descrizione = ret.get("descrizione");
		        String matricola = ret.get("matricola");
		        String tipo = ret.get("tipo");
		        String volume = ret.get("volume");
		        String pressione = ret.get("pressione");
		        String costruttore = ret.get("costruttore");
		        String numero_fabbrica = ret.get("numero_fabbrica");
		        String anno = ret.get("anno");
		        String frequenza = ret.get("frequenza");
		        String data_verifica = ret.get("data_verifica");
		        String data_prossima = ret.get("data_prossima_verifica");
		        String sondaVelocita = ret.get("sonda_velocita");
		        String numeroPorzioni=ret.get("numero_porzioni");
		        String table_zone = ret.get("table_zone");
		        
				String filename_img=filename;
				
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				 
				AMOggettoProvaDTO strumento = new AMOggettoProvaDTO();	
				
				strumento.setId_cliente(Integer.parseInt(id_cliente));
				strumento.setId_sede(Integer.parseInt(id_sede.split("_")[0]));
				strumento.setDescrizione(descrizione);
				strumento.setMatricola(matricola);
				
				strumento.setTipo(tipo);
				strumento.setVolume(volume);
				strumento.setPressione(pressione);
				strumento.setCostruttore(costruttore);
				strumento.setnFabbrica(numero_fabbrica);
				strumento.setSondaVelocita(sondaVelocita);
				
				if(anno!=null && !anno.equals("")) {
					strumento.setAnno(Integer.parseInt(anno));	
				}
				
				if(frequenza!=null && !frequenza.equals("")) {
					strumento.setFrequenza(Integer.parseInt(frequenza));
				}
				if(data_verifica!=null && !data_verifica.equals("")) {
					strumento.setDataVerifica(df.parse(data_verifica));	
				}
				if(data_prossima!=null && !data_prossima.equals("")) {
					strumento.setDataProssimaVerifica(df.parse(data_prossima));	
				}
				
				if(numeroPorzioni.length()>0) 
				{
					strumento.setNumero_porzioni(Integer.parseInt(numeroPorzioni));
				}else 
				{
					strumento.setNumero_porzioni(1);
				}
				
				
				
				session.save(strumento);			
				
				Gson g = new Gson();
				Type listType = new TypeToken<List<List<String>>>() {}.getType();
		        List<List<String>> rows = g.fromJson(table_zone, listType);
		        
		        for (List<String> row : rows) {
		            String zona = row.size() > 0 ? row.get(0) : "";
		            String materiale = row.size() > 1 ? row.get(1) : "";
		            String spessore = row.size() > 2 ? row.get(2) : "";
		            String indicazione = row.size() > 3 ? row.get(3) : "";
		            String punto_intervallo_inizio = row.size() > 4 ? row.get(4) : "";
		            String punto_intervallo_fine = row.size() > 5 ? row.get(5) : "";

		           AMOggettoProvaZonaRifDTO z = new AMOggettoProvaZonaRifDTO();
		           z.setZonaRiferimento(zona);
		           z.setMateriale(materiale);
		           z.setSpessore(spessore);
		           z.setIndicazione(indicazione);
		           z.setPunto_intervallo_inizio(Integer.parseInt(punto_intervallo_inizio));
		           z.setPunto_intervallo_fine(Integer.parseInt(punto_intervallo_fine));
		           
		           z.setIdStrumento(strumento.getId());
		           
		           session.save(z);
		           
		           strumento.getListaZoneRiferimento().add(z);
		        }
				
		    	if(filename_img!=null) {
					
					Utility.saveFile(fileItem, Costanti.PATH_FOLDER+"\\AM_interventi\\Strumenti\\"+strumento.getId(), filename_img);
					strumento.setFilename_img(filename_img);
				}
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Oggetto prova salvato con successo!");
				out.print(myObj);
				
			}else if(action.equals("modifica")) {
				
				ajax = true;
				
				response.setContentType("application/json");
				 
			  	List<FileItem> items = null;
		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
		        	}
		        
		       
				FileItem fileItem = null;
				String filename= null;
		        Hashtable<String,String> ret = new Hashtable<String,String>();
		      
		        for (FileItem item : items) {
	            	 if (!item.isFormField()) {
	            		
	                     fileItem = item;
	                     filename = item.getName();
	                     
	            	 }else
	            	 {
	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
	            	 }
	            	
	            }
		
		        String id = ret.get("id_strumento");
		        String id_cliente = ret.get("cliente_general_mod");
		        String id_sede = ret.get("sede_general_mod");		        
		        String descrizione = ret.get("descrizione_mod");
		        String matricola = ret.get("matricola_mod");
		        String zona_rif_fasciame = ret.get("zona_rif_fasciame_mod");
		        String spessore_fasciame = ret.get("spessore_fasciame_mod");
		        String tipo = ret.get("tipo_mod");
		        String volume = ret.get("volume_mod");
		        String materiale_fasciame = ret.get("materiale_fasciame_mod");
		        String pressione = ret.get("pressione_mod");
		        String costruttore = ret.get("costruttore_mod");
		        String numero_fabbrica = ret.get("numero_fabbrica_mod");
		        String zona_rif_fondo = ret.get("zona_rif_fondo_mod");
		        String spessore_fondo = ret.get("spessore_fondo_mod");
		        String anno = ret.get("anno_mod");
		        String frequenza = ret.get("frequenza_mod");
		        String data_verifica = ret.get("data_verifica_mod");
		        String data_prossima = ret.get("data_prossima_verifica_mod");
		        String sondaVelocita = ret.get("sonda_velocita_mod");
		        String materiale_fondo = ret.get("materiale_sonda_mod");
		        String table_zone = ret.get("table_zone_mod"); 
		        String numeroPorzioni=ret.get("numero_porzioni_mod");
		        
				String filename_img=filename;
				
				
				DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
				
				 
				AMOggettoProvaDTO strumento = GestioneAM_BO.getOggettoProvaFromID(Integer.parseInt(id), session);	
				
				strumento.setId_cliente(Integer.parseInt(id_cliente));
				strumento.setId_sede(Integer.parseInt(id_sede.split("_")[0]));
				strumento.setDescrizione(descrizione);
				strumento.setMatricola(matricola);
				strumento.setTipo(tipo);
				strumento.setVolume(volume);
				strumento.setPressione(pressione);
				strumento.setCostruttore(costruttore);
				strumento.setnFabbrica(numero_fabbrica);
				strumento.setSondaVelocita(sondaVelocita);
				
				
				if(anno!=null && !anno.equals("")) {
					strumento.setAnno(Integer.parseInt(anno));	
				}
				
				if(frequenza!=null && !frequenza.equals("")) {
					strumento.setFrequenza(Integer.parseInt(frequenza));
				}
				if(data_verifica!=null && !data_verifica.equals("")) {
					strumento.setDataVerifica(df.parse(data_verifica));	
				}
				if(data_prossima!=null && !data_prossima.equals("")) {
					strumento.setDataProssimaVerifica(df.parse(data_prossima));	
				}
				
				Gson g = new Gson();
				Type listType = new TypeToken<List<List<String>>>() {}.getType();
		        List<List<String>> rows = g.fromJson(table_zone, listType);
		        Set<AMOggettoProvaZonaRifDTO> zoneDB = new HashSet<>(strumento.getListaZoneRiferimento());
		        Set<Integer> idZoneRicevute = new HashSet<>();
		        
		        
		        for (List<String> row : rows) {
		            String zona = row.size() > 0 ? row.get(0) : "";
		            String materiale = row.size() > 1 ? row.get(1) : "";
		            String spessore = row.size() > 2 ? row.get(2) : "";
		            String indicazione = row.size() > 3 ? row.get(3) : "";
		            String punto_intervallo_inizio = row.size() > 4 ? row.get(4) : "";
		            String punto_intervallo_fine = row.size() > 5 ? row.get(5) : "";
		            String id_zona = row.size() > 6 ? row.get(6) : "";
		            
		            Pattern pattern = Pattern.compile("id\\s*=\\s*\"(\\d+)\"");
		            Matcher matcher = pattern.matcher(id_zona);

		            String idValue = null;
		            if (matcher.find()) {
		                idValue = matcher.group(1);
		            }
		           
		            AMOggettoProvaZonaRifDTO z = null;
		            if(idValue!=null) {
		            
		                idZoneRicevute.add(Integer.parseInt(idValue));
		            	z = GestioneAM_BO.getZonaRiferimentoFromID(Integer.parseInt(idValue), session);
		            }else {
		            	z = new AMOggettoProvaZonaRifDTO();
		            }
		            
		           z.setZonaRiferimento(zona);
		           z.setMateriale(materiale);
		           z.setSpessore(spessore);
		           z.setIndicazione(indicazione);
		           z.setPunto_intervallo_fine(Integer.parseInt(punto_intervallo_fine));
		           z.setPunto_intervallo_inizio(Integer.parseInt(punto_intervallo_inizio));
		           
		           z.setIdStrumento(strumento.getId());
		           
		           session.saveOrUpdate(z);
		           
		           strumento.getListaZoneRiferimento().add(z);
		        }
		        
		        for (AMOggettoProvaZonaRifDTO zonaEsistente : zoneDB) {
		            if (!idZoneRicevute.contains(zonaEsistente.getId())) {
		                session.delete(zonaEsistente);
		            }
		        }
		        
		        if(numeroPorzioni.length()>0) 
				{
					strumento.setNumero_porzioni(Integer.parseInt(numeroPorzioni));
				}else 
				{
					strumento.setNumero_porzioni(1);
				}
		        
		        if(filename_img!=null&& !filename_img.equals("")) {
					
					Utility.saveFile(fileItem, Costanti.PATH_FOLDER+"\\AM_interventi\\Strumenti\\"+strumento.getId(), filename_img);
					strumento.setFilename_img(filename_img);
				}
				
				session.update(strumento);				
							
				
				myObj = new JsonObject();
				PrintWriter  out = response.getWriter();
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Oggetto prova salvato con successo!");
				out.print(myObj);
				
			}
			
			session.getTransaction().commit();
			session.close();
			
			
			
		} 
		catch(Exception e)
    	{
			e.printStackTrace();
			session.getTransaction().rollback();
        	session.close();
			if(ajax) {
				
				PrintWriter out = response.getWriter();
				
	        	
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
