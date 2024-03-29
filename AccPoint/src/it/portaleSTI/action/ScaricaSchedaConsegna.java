package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

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
import org.hibernate.Session;

import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.RilMisuraRilievoDTO;
import it.portaleSTI.DTO.SchedaConsegnaDTO;
import it.portaleSTI.DTO.SchedaConsegnaRilieviDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.StatoCertificatoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerInterventoDTO;
import it.portaleSTI.DTO.VerMisuraDTO;
import it.portaleSTI.DTO.VerStrumentoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.CreateSchedaConsegnaMetrologia;
import it.portaleSTI.bo.CreateSchedaConsegnaVerificazione;
import it.portaleSTI.bo.CreateSchedaConsegnaRilieviDimensionali;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneCertificatoBO;
import it.portaleSTI.bo.GestioneInterventoBO;
import it.portaleSTI.bo.GestioneRilieviBO;
import it.portaleSTI.bo.GestioneVerInterventoBO;

/**
 * Servlet implementation class ScaricaCertificato
 */
@WebServlet(name= "/scaricaSchedaConsegna", urlPatterns = { "/scaricaSchedaConsegna.do" })
public class ScaricaSchedaConsegna extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final Logger logger = Logger.getLogger(ScaricaSchedaConsegna.class);
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ScaricaSchedaConsegna() {
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
	@SuppressWarnings("static-access")
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		if(Utility.validateSession(request,response,getServletContext()))return;
		
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();	
		
		String action = request.getParameter("action");
		boolean ajax = false;
		JsonObject myObj = new JsonObject();
		try
		{
			if(action==null) {
				ajax = true;
				
				logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+((UtenteDTO)request.getSession().getAttribute("userObj")).getNominativo());
				
				String idIntervento= request.getParameter("idIntervento");

				
				InterventoDTO intervento = GestioneInterventoBO.getIntervento(idIntervento, session);
				CompanyDTO cmp =(CompanyDTO)request.getSession().getAttribute("usrCompany");
				UtenteDTO utente = (UtenteDTO)request.getSession().getAttribute("userObj");
				
				ArrayList<CertificatoDTO> listaCertificati = GestioneCertificatoBO.getListaCertificatoByIntervento(new StatoCertificatoDTO(2), intervento,cmp,utente,"N",""+intervento.getId_cliente(),""+intervento.getIdSede());
				
				
				ArrayList<MisuraDTO> listaMisureInt = GestioneInterventoBO.getListaMirureNonObsoleteByIntervento(intervento.getId());
				ArrayList<StrumentoDTO> listaStrumenti = new ArrayList<StrumentoDTO>();
			
				
				for (MisuraDTO misura : listaMisureInt) {
					listaStrumenti.add(misura.getStrumento());
				}
				
				PrintWriter out = response.getWriter();
				
				if(listaStrumenti.size()!=listaCertificati.size()) {
				
				
		        	myObj.addProperty("successo", false);
		        	
				}else {
					myObj.addProperty("successo", true);
				}
				myObj.addProperty("success", true);
			
	
				request.getSession().setAttribute("listaStrumentiInt", listaStrumenti);
				session.getTransaction().commit();
				session.close();
				
				out.print(myObj);
				    
			}
			else if(action.equals("scheda_consegna_metrologia")) {
				
				
				String idIntervento= request.getParameter("idIntervento");
				String notaConsegna= request.getParameter("notaConsegna");
				String corteseAttenzione= request.getParameter("corteseAttenzione");
				String stato= request.getParameter("gridRadios");
				
				idIntervento = Utility.decryptData(idIntervento);
				
				InterventoDTO intervento = GestioneInterventoBO.getIntervento(idIntervento, session);
		
				
				ArrayList<StrumentoDTO> listaStrumenti = (ArrayList<StrumentoDTO>) request.getSession().getAttribute("listaStrumentiInt");
			
				
			
				new CreateSchedaConsegnaMetrologia(intervento,notaConsegna,Integer.parseInt(stato),corteseAttenzione,listaStrumenti,session,getServletContext());
				
				File d = new File(Costanti.PATH_FOLDER+"//"+intervento.getNomePack()+"//SchedaDiConsegna.pdf");
				
				 FileInputStream fileIn = new FileInputStream(d);
				 
				 response.setContentType("application/octet-stream");
				  
				 response.setHeader("Content-Disposition","attachment;filename=SchedaDiConsegna.pdf");
				 
				 ServletOutputStream outp = response.getOutputStream();
				     
				    byte[] outputByte = new byte[1];
				    
				    while(fileIn.read(outputByte, 0, 1) != -1)
				    {
				    	outp.write(outputByte, 0, 1);
				    }
				    
				    
				    fileIn.close();
				    outp.flush();
				    outp.close();
					session.getTransaction().commit();
					session.close();
			}
			
			
			else if(action.equals("rilievi_dimensionali")){
				
				ajax = true;
				
				
				//String corteseAttenzione= request.getParameter("corteseAttenzione");
				//String stato= request.getParameter("gridRadios");
								
				//String id_cliente = request.getParameter("cliente_scn");
				//String id_sede = request.getParameter("sede_scn");
		
				//String commessa = request.getParameter("commessa_scn");
				
				
				response.setContentType("application/json");
//				List<FileItem> items = null;
//		        if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {
//
//		        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
//		        	}
//		        
//		       
//	
//		        Hashtable<String,String> ret = new Hashtable<String,String>();
//		      
//		        for (FileItem item : items) {
//	            	 if (item.isFormField()) {
//	            		
//	                      ret.put(item.getFieldName(), new String (item.getString().getBytes ("iso-8859-1"), "UTF-8"));
//	            	 }
//	            	
//	            }
//				
		        
				String dateFrom = request.getParameter("dateFrom");
				String dateTo = request.getParameter("dateTo");
				String commesse= request.getParameter("commesse");
				
				UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
				
				List<SedeDTO> listaSedi = (List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				if(listaSedi== null) {
					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
				}
				
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				ArrayList<RilMisuraRilievoDTO> lista_rilievi_mese = GestioneRilieviBO.getListaRilieviDate(df.parse(dateFrom),df.parse(dateTo), session);
				Map<String, ArrayList<RilMisuraRilievoDTO>> rilievi_commessa = new HashMap<String, ArrayList<RilMisuraRilievoDTO>>();
				
				for (RilMisuraRilievoDTO rilievo : lista_rilievi_mese) {
					
					ArrayList<RilMisuraRilievoDTO> rilieviCorrispondenti = rilievi_commessa.get(rilievo.getCommessa());
					if(rilieviCorrispondenti == null) {
						rilieviCorrispondenti = new ArrayList<RilMisuraRilievoDTO>();
						
						if(commesse.contains(rilievo.getCommessa())) {
							rilievi_commessa.put(rilievo.getCommessa(), rilieviCorrispondenti);	
						}
						
					}
					if(commesse.contains(rilievo.getCommessa())) {
						rilieviCorrispondenti.add(rilievo);	
					}
					
				}
				
				for (Map.Entry<String, ArrayList<RilMisuraRilievoDTO>> entry : rilievi_commessa.entrySet()) {
					
					  
					String commessa = entry.getKey();
					    
					ArrayList<RilMisuraRilievoDTO> rilieviCorrispondenti = entry.getValue();
					
					SchedaConsegnaRilieviDTO scheda_consegna = new SchedaConsegnaRilieviDTO();
					
					if(rilieviCorrispondenti!=null && rilieviCorrispondenti.size()>0) {
						RilMisuraRilievoDTO rilievo = rilieviCorrispondenti.get(0);
						
						scheda_consegna.setId_cliente(rilievo.getId_cliente_util());
						scheda_consegna.setId_sede(rilievo.getId_sede_util());
						scheda_consegna.setData_creazione(new Date());
						scheda_consegna.setMese(new SimpleDateFormat("MMMM").format(df.parse(dateTo)));
						 Calendar cal = Calendar.getInstance();
				           cal.setTime(df.parse(dateTo));
						scheda_consegna.setAnno(cal.get(Calendar.YEAR));
						scheda_consegna.setNome_cliente(rilievo.getNome_cliente_util());	
						
						scheda_consegna.setCommessa(rilievo.getCommessa());
						if(rilievo.getNome_sede_util()!=null) {
							scheda_consegna.setNome_sede(rilievo.getNome_sede_util());
					
					
					}
								
					
					
					//ArrayList<RilMisuraRilievoDTO> lista_rilievi = GestioneRilieviBO.getListaRilieviSchedaConsegna(Integer.parseInt(id_cliente), Integer.parseInt(id_sede.split("_")[0]), mese,commessa.split("\\*")[0], session);
					String path_firma =  getServletContext().getRealPath("/images") + "\\firme_rilievi\\";
					
					new CreateSchedaConsegnaRilieviDimensionali(rilieviCorrispondenti,commessa.split("\\*")[0],"",0,"", listaSedi, path_firma,utente, cal.get(Calendar.YEAR)+"",new SimpleDateFormat("MMMM").format(df.parse(dateTo))+"", session);
					
					scheda_consegna.setFile("SCN_"+rilieviCorrispondenti.get(0).getCommessa().replace("/", "_")+".pdf");
					
					session.save(scheda_consegna);
					
					}
				}
				
				myObj.addProperty("success", true);
				myObj.addProperty("messaggio", "Schede consegna geneate con successo");
				
				

				session.getTransaction().commit();
				session.close();
				PrintWriter out = response.getWriter();
				out.print(myObj);
				
				
//				SchedaConsegnaRilieviDTO scheda_consegna = new SchedaConsegnaRilieviDTO();
//				
//				scheda_consegna.setId_cliente(Integer.parseInt(id_cliente));
//				scheda_consegna.setId_sede(Integer.parseInt(id_sede.split("_")[0]));
//				scheda_consegna.setData_creazione(new Date());
//				scheda_consegna.setMese(mese);
//				scheda_consegna.setAnno(Integer.parseInt(anno));
//				scheda_consegna.setNome_cliente(GestioneAnagraficaRemotaBO.getClienteById(id_cliente).getNome());	
//				
//				scheda_consegna.setCommessa(commessa.split("\\*")[0]);
//				if(!id_sede.split("_")[0].equals("0")) {
//					scheda_consegna.setNome_sede(GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, Integer.parseInt(id_sede.split("_")[0]), Integer.parseInt(id_cliente)).getDescrizione());
//				}
//								
//				UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
//				
//				ArrayList<RilMisuraRilievoDTO> lista_rilievi = GestioneRilieviBO.getListaRilieviSchedaConsegna(Integer.parseInt(id_cliente), Integer.parseInt(id_sede.split("_")[0]), mese,commessa.split("\\*")[0], session);
//				String path_firma =  getServletContext().getRealPath("/images") + "\\firme_rilievi\\";
//				
//				new CreateSchedaConsegnaRilieviDimensionali(lista_rilievi,commessa.split("\\*")[0],notaConsegna,Integer.parseInt(stato),corteseAttenzione, listaSedi, path_firma,utente, anno, session);
//				
//				scheda_consegna.setFile("SCN_"+lista_rilievi.get(0).getCommessa().replace("/", "_")+".pdf");
//				
//				session.save(scheda_consegna);
//				session.getTransaction().commit();
//				session.close();
//				
//				Calendar cal = Calendar.getInstance();
//				cal.setTime(lista_rilievi.get(0).getData_consegna());
//				
//				File d = new File(Costanti.PATH_FOLDER+"\\RilieviDimensionali\\SchedeConsegna\\"+lista_rilievi.get(0).getId_cliente_util()+"\\"+lista_rilievi.get(0).getId_sede_util()+
//						"\\"+anno+"\\"+lista_rilievi.get(0).getMese_riferimento()+"\\SCN_"+lista_rilievi.get(0).getCommessa().replace("/", "_")+".pdf");
//				
//				 FileInputStream fileIn = new FileInputStream(d);
//				 
//				 response.setContentType("application/octet-stream");
//				  
//				 response.setHeader("Content-Disposition","attachment;filename=SCN_"+lista_rilievi.get(0).getCommessa().replace("/", "_")+".pdf");
//				 
//				 ServletOutputStream outp = response.getOutputStream();
//				     
//				    byte[] outputByte = new byte[1];
//				    
//				    while(fileIn.read(outputByte, 0, 1) != -1)
//				    {
//				    	outp.write(outputByte, 0, 1);
//				    }
//				    
//				    
//				    fileIn.close();
//				    outp.flush();
//				    outp.close();

			}
			else if(action.equals("verificazione")) {
				
				String verIntervento= request.getParameter("verIntervento");
				String notaConsegna= request.getParameter("notaConsegna");
				String corteseAttenzione= request.getParameter("corteseAttenzione");
				String stato= request.getParameter("gridRadios");
				
				verIntervento = Utility.decryptData(verIntervento);
				
				VerInterventoDTO intervento = GestioneVerInterventoBO.getInterventoFromId(Integer.parseInt(verIntervento), session);
				
				ArrayList<VerMisuraDTO> listaMisure = GestioneVerInterventoBO.getListaMisureFromIntervento(Integer.parseInt(verIntervento), session);
				ArrayList<VerStrumentoDTO> listaStrumenti = new ArrayList<VerStrumentoDTO>();
				
				for (VerMisuraDTO misura : listaMisure) {
					listaStrumenti.add(misura.getVerStrumento());
				}
				UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
				
				SchedaConsegnaDTO scheda = new SchedaConsegnaDTO();
				scheda.setAbilitato(1);
				scheda.setVer_intervento(intervento);
				scheda.setStato(0);
				Date date = Calendar.getInstance().getTime();  
                DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy hh:mm:ss");  
              
				scheda.setData_caricamento(dateFormat.format(date));
				new CreateSchedaConsegnaVerificazione(intervento,notaConsegna,Integer.parseInt(stato),corteseAttenzione,listaStrumenti,utente.getCompany());
				scheda.setNome_file("SchedaDiConsegna.pdf");
				
				
				
				File d = new File(Costanti.PATH_FOLDER+"//"+intervento.getNome_pack()+"//SchedaDiConsegna.pdf");
				
				 FileInputStream fileIn = new FileInputStream(d);
				 
				 response.setContentType("application/octet-stream");
				  
				 response.setHeader("Content-Disposition","attachment;filename=SchedaDiConsegna.pdf");
				 
				 ServletOutputStream outp = response.getOutputStream();
				     
				    byte[] outputByte = new byte[1];
				    
				    while(fileIn.read(outputByte, 0, 1) != -1)
				    {
				    	outp.write(outputByte, 0, 1);
				    }
				    
				    
				    fileIn.close();
				    outp.flush();
				    outp.close();
				
				    
				    session.save(scheda);
				    session.getTransaction().commit();
				    session.close();
				    
			}
		}
		catch(Exception e)
    	{
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
