package it.portaleSTI.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import it.portaleSTI.DAO.GestioneInterventoDAO;
import it.portaleSTI.DAO.SQLLiteDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.ClassificazioneDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.InterventoDatiDTO;
import it.portaleSTI.DTO.LatMasterDTO;
import it.portaleSTI.DTO.LatMisuraDTO;
import it.portaleSTI.DTO.LuogoVerificaDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.PuntoMisuraDTO;
import it.portaleSTI.DTO.ScadenzaDTO;
import it.portaleSTI.DTO.StatoCertificatoDTO;
import it.portaleSTI.DTO.StatoInterventoDTO;
import it.portaleSTI.DTO.StatoPackDTO;
import it.portaleSTI.DTO.StatoRicezioneStrumentoDTO;
import it.portaleSTI.DTO.StatoStrumentoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.TipoStrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneCommesseBO;
import it.portaleSTI.bo.GestioneCompanyBO;
import it.portaleSTI.bo.GestioneInterventoBO;
import it.portaleSTI.bo.GestioneStrumentoBO;

/**
 * Servlet implementation class GestioneIntervento
 */
@WebServlet(name = "gestioneIntervento", urlPatterns = { "/gestioneIntervento.do" })
public class GestioneIntervento extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneIntervento() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		JsonObject myObj = new JsonObject();
		PrintWriter  out = response.getWriter();
		String action=request.getParameter("action");
		try 
		{
			
	
			if(action ==null || action.equals(""))
			{
			String idCommessa=request.getParameter("idCommessa");
			
		
			idCommessa = Utility.decryptData(idCommessa);
			
			CommessaDTO comm=GestioneCommesseBO.getCommessaById(idCommessa);		
			
			request.getSession().setAttribute("commessa", comm);
			

			List<InterventoDTO> listaInterventi =GestioneInterventoBO.getListaInterventi(idCommessa,session);	
			ArrayList<CompanyDTO> lista_company = GestioneCompanyBO.getAllCompany(session);
			
			if(comm.getSYS_STATO().equals("1CHIUSA")) 
			{
				StatoInterventoDTO stato = new StatoInterventoDTO();
				stato.setId(2);
				stato.setDescrizione("CHIUSO");
				for (InterventoDTO intervento :listaInterventi) 
				{
					intervento.setStatoIntervento(stato);
					GestioneInterventoBO.update(intervento, session);
				}
			}
			
			request.getSession().setAttribute("listaInterventi", listaInterventi);
			request.getSession().setAttribute("lista_company", lista_company);

			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/gestioneIntervento.jsp");
	     	dispatcher.forward(request,response);
			}

	if(action !=null && action.equals("new")){
		 
			
			String json = request.getParameter("dataIn");
			
			JsonElement jelement = new JsonParser().parse(json);
			
			String company = null;
			if(jelement.getAsJsonObject().get("company")!=null) {
				company = jelement.getAsJsonObject().get("company").toString().replaceAll("\"", "");
			}

		    CommessaDTO comm=(CommessaDTO)request.getSession().getAttribute("commessa");
			InterventoDTO intervento= new InterventoDTO();
			intervento.setDataCreazione(Utility.getActualDateSQL());
			intervento.setPressoDestinatario(Integer.parseInt(jelement.getAsJsonObject().get("sede").toString().replaceAll("\"", "")));
			intervento.setUser((UtenteDTO)request.getSession().getAttribute("userObj"));
			intervento.setIdSede(comm.getK2_ANAGEN_INDR_UTIL());
			intervento.setId_cliente(comm.getID_ANAGEN_UTIL());
			
			intervento.setNome_cliente(comm.getNOME_UTILIZZATORE());
			intervento.setNome_sede(comm.getINDIRIZZO_UTILIZZATORE());
			intervento.setIdCommessa(""+comm.getID_COMMESSA());
			intervento.setStatoIntervento(new StatoInterventoDTO());
			
			CompanyDTO cmp = null;
			if(company!=null && !company.equals("")) {
				cmp = new CompanyDTO(Integer.parseInt(company), "", "", "", "", "", "", "", "");
			}else {
				cmp = (CompanyDTO)request.getSession().getAttribute("usrCompany");
			}
			
			intervento.setCompany(cmp);
			
			String filename = GestioneStrumentoBO.creaPacchetto(comm.getID_ANAGEN_UTIL(),comm.getK2_ANAGEN_INDR_UTIL(),cmp,comm.getID_ANAGEN_NOME(),session,intervento);
			
			intervento.setNomePack(filename);
			
			intervento.setnStrumentiGenerati(GestioneStrumentoBO.getListaStrumentiPerSediAttiviNEW(""+comm.getID_ANAGEN_UTIL(),""+comm.getK2_ANAGEN_INDR_UTIL(),cmp.getId(), session,intervento.getUser()).size());
			intervento.setnStrumentiMisurati(0);
			intervento.setnStrumentiNuovi(0);
			
			GestioneInterventoBO.save(intervento,session);
			
			Gson gson = new Gson();
		
			// 2. Java object to JSON, and assign to a String
			String jsonInString = gson.toJson(intervento);

			
			myObj.addProperty("success", true);
			myObj.addProperty("intervento", jsonInString);
			myObj.addProperty("encrypted", Utility.encryptData(String.valueOf(intervento.getId())));
			out.print(myObj);
		}
		if(action !=null && action.equals("chiudi")){
			 
			
			String idIntervento = request.getParameter("idIntervento" );
			
			idIntervento = Utility.decryptData(idIntervento);
					
			InterventoDTO intervento = GestioneInterventoBO.getIntervento(idIntervento);
			
				StatoInterventoDTO stato = new StatoInterventoDTO();
				stato.setId(2);
				intervento.setStatoIntervento(stato);		
						
	
				GestioneInterventoBO.update(intervento,session);
				
				Gson gson = new Gson();
			
				// 2. Java object to JSON, and assign to a String
				String jsonInString = gson.toJson(intervento);
	
				
				myObj.addProperty("success", true);
				myObj.addProperty("intervento", jsonInString);
				myObj.addProperty("id_intervento", idIntervento);
				myObj.addProperty("messaggio", "Intervento chiuso");
			
			out.print(myObj);
		}
		if(action !=null && action.equals("apri")){
			 			
			String idIntervento = request.getParameter("idIntervento" );
			
			idIntervento = Utility.decryptData(idIntervento);

			InterventoDTO intervento = GestioneInterventoBO.getIntervento(idIntervento);
			
				StatoInterventoDTO stato = new StatoInterventoDTO();
				stato.setId(1);
				intervento.setStatoIntervento(stato);		
						
	
				GestioneInterventoBO.update(intervento,session);
				
				Gson gson = new Gson();
			
				// 2. Java object to JSON, and assign to a String
				String jsonInString = gson.toJson(intervento);
	
				
				myObj.addProperty("success", true);
				myObj.addProperty("intervento", jsonInString);
				myObj.addProperty("id_intervento", idIntervento);
				myObj.addProperty("messaggio", "Intervento aperto");
			
			out.print(myObj);
		}
		
		if(action !=null && action.equals("nuova_sede")) {
			String id_intervento = request.getParameter("id_intervento");
			String nome_sede = request.getParameter("nome_sede");
			
			InterventoDTO intervento = GestioneInterventoBO.getIntervento(id_intervento);
			
			intervento.setNome_sede(nome_sede);
			
			GestioneInterventoBO.update(intervento, session);
			
			Gson gson = new Gson();
			String jsonInString = gson.toJson(intervento);
			
			
			myObj.addProperty("success", true);
			myObj.addProperty("intervento", jsonInString);
			myObj.addProperty("messaggio", "Sede aggiornata con successo!");
		
		out.print(myObj);
			
		}
		
		else if(action !=null && action.equals("nuova_misura")) {
			
			UtenteDTO utente =(UtenteDTO)request.getSession().getAttribute("userObj");
			
			ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
			
			response.setContentType("application/json");
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			
			List<FileItem> items;
		
				items = uploadHandler.parseRequest(request);
				String lat_master = null;		
				String id_intervento = null;				
				String filename_excel = null;
				String filename_pdf = null;
				String id_strumento=null;
				String nCertificato=null;
				FileItem file_excel = null;
				FileItem file_pdf = null;
				String note_obsolescenza = null;
				
				for (FileItem item : items) {
					if (item.isFormField()) {
						if(item.getFieldName().equals("lat_master")) {
							lat_master = item.getString();
						}	
						else if(item.getFieldName().equals("id_intervento")) {
							id_intervento = item.getString();
						}	
						else if(item.getFieldName().equals("id_strumento")) {
							id_strumento = item.getString();
						}	
						else if(item.getFieldName().equals("nCertificato")) {
							nCertificato = item.getString();
						}	
						else if(item.getFieldName().equals("note_obsolescenza_form")) {
							note_obsolescenza = item.getString();
						}
					}
					else {
						if(item.getFieldName().equals("fileupload_excel")) {
							file_excel = item;
							filename_excel = item.getName();
						}else {
							file_pdf = item;
							filename_pdf = item.getName();
						}						
					}
				}
				
				StrumentoDTO strumento = GestioneStrumentoBO.getStrumentoById(id_strumento, session);
				
				InterventoDTO intervento = GestioneInterventoBO.getIntervento(id_intervento);
				
				boolean isPresent=GestioneInterventoDAO.isPresentStrumento(intervento.getId(),strumento,session);
				ArrayList<StrumentoDTO> lista_duplicati = new ArrayList<StrumentoDTO>();
				if((note_obsolescenza==null||note_obsolescenza.equals("")) && isPresent) {
					lista_duplicati.add(strumento);
					Gson gson = new Gson();
					String jsonInString = gson.toJson(lista_duplicati);					
					
					myObj.addProperty("success", true);				
					myObj.addProperty("duplicato",jsonInString);
					out.print(myObj);
					
				}else {
				
					InterventoDatiDTO interventoDati = new InterventoDatiDTO();
					
					String nomeFileExcel= "";
					if(lat_master!=null && !lat_master.equals("")) {
						nomeFileExcel = saveExcelFile(file_excel,intervento.getNomePack(), true);				
					}else {
						nomeFileExcel = saveExcelFile(file_excel,intervento.getNomePack(), false);
					}
					String nomeFilePdfCertificato= saveExcelPDF(file_pdf,intervento.getNomePack(),intervento.getId(),id_strumento);
					
					interventoDati.setId_intervento(intervento.getId());
					interventoDati.setNomePack(nomeFileExcel);
					interventoDati.setDataCreazione(new Date());
					interventoDati.setStato(new StatoPackDTO(3));
					interventoDati.setNumStrMis(1);
					interventoDati.setNumStrNuovi(0);
					interventoDati.setUtente(utente);
					if(lat_master!=null && !lat_master.equals("")) {
						interventoDati.setLat("S");
					}
					
					intervento.setnStrumentiMisurati(intervento.getnStrumentiMisurati()+1);
		    		
		    		session.update(intervento);
		    		session.save(interventoDati);
		    		
		    		LatMisuraDTO misuraLAT = new LatMisuraDTO();
		    		
		    		if(lat_master!=null && !lat_master.equals("")) {
		    			
			    		misuraLAT.setIntervento(intervento);	
		 				misuraLAT.setIntervento_dati(interventoDati);
		 				misuraLAT.setStrumento(strumento);
		 				misuraLAT.setData_misura(new Date());
		 				misuraLAT.setUser(utente);
		 				misuraLAT.setMisura_lat(new LatMasterDTO(Integer.parseInt(lat_master)));				
						session.save(misuraLAT);
		    		}
					if(note_obsolescenza!=null && !note_obsolescenza.equals("")) {
						ArrayList<MisuraDTO> misuraObsoleta = GestioneInterventoDAO.getMisuraObsoleta(intervento.getId(),String.valueOf(strumento.get__id()));
						
						for (MisuraDTO mis : misuraObsoleta) 
						{
							GestioneInterventoDAO.misuraObsoleta(mis,session);
						}
						
					}
					
		    		MisuraDTO misura= new MisuraDTO();
		    		misura.setIntervento(intervento);
	
		    		misura.setStrumento(strumento);
		    		misura.setDataMisura(new Date());
		    		misura.setTemperatura(new BigDecimal(20));
		    		misura.setUmidita(new BigDecimal(50) );
		    		misura.setTipoFirma(0);
		    		misura.setStatoRicezione(new StatoRicezioneStrumentoDTO(8901));
		    		misura.setObsoleto("N");
		    		misura.setnCertificato(nCertificato);
		    		misura.setInterventoDati(interventoDati);
		    		misura.setUser(utente);		    		
		    		
		    		if(lat_master!=null && !lat_master.equals("")) {
		    			misura.setMisuraLAT(misuraLAT);		
		    			misura.setLat("S");
		    		}
		    		
		    		misura.setFile_xls_ext(nomeFileExcel);
		    		misura.setNote_obsolescenza(note_obsolescenza);
		    		session.save(misura);
		    		
		    		CertificatoDTO certificato = new CertificatoDTO();
		    		certificato.setMisura(misura);
		    		if(filename_pdf!=null && !filename_pdf.equals("")) {
		    			certificato.setStato(new StatoCertificatoDTO(2));
		    		}else {
		    			certificato.setStato(new StatoCertificatoDTO(4));
		    		}	    		
		    		certificato.setUtente(misura.getUser());
		    		certificato.setNomeCertificato(nomeFilePdfCertificato);
					certificato.setDataCreazione(new Date());
		    		session.save(certificato);
		    							
					myObj.addProperty("success", true);				
					myObj.addProperty("messaggio", "Misura inserita con successo!");
					out.print(myObj);
				
				}
		}
	
			session.getTransaction().commit();
			session.close();	
		
		}catch (Exception ex) 
		{	
		  session.getTransaction().rollback();
		  ex.printStackTrace(); 
		  session.close();
		  
		  if(action==null || action=="") {
			  myObj.addProperty("success", false);
		  }
		  
		  myObj.addProperty("success", false);	
		  if(action !=null && action.equals("new")){
			  myObj.addProperty("messaggio", "Errore creazione intervento.");
		  }
		  if(action !=null && action.equals("chiudi")){
			  myObj.addProperty("messaggio", "Errore chiusura intervento.");
		  }
		  request.getSession().setAttribute("exception", ex);
		  
		  myObj=STIException.getException(ex);
		  out.print(myObj);
	   	     
		}
		
	}

	private String saveExcelPDF(FileItem item, String nomePack, int idInt, String id_strumento) {
		
		String nomeFile=nomePack+"_"+idInt+""+id_strumento+".pdf";
		
		File f= new File(Costanti.PATH_FOLDER+"//"+nomePack+"//"+nomePack+"_"+idInt+""+id_strumento+".pdf");
		
		try {
			item.write(f);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return nomeFile;
	}

	private String saveExcelFile(FileItem item, String nomePack, boolean lat) {

		String nomeFile="";
		String folder=nomePack;
		String ext1 = FilenameUtils.getExtension(item.getName());

		int index=1;
		while(true)
		{
			File file=null;
			
			if(lat) {
				file = new File(Costanti.PATH_FOLDER+"//"+folder+"//"+item.getName().substring(0, item.getName().indexOf(ext1)-1)+"_"+index+"."+ext1);
			}else {
				file = new File(Costanti.PATH_FOLDER+"//"+folder+"//"+folder+"_"+index+"."+ext1);	
			}
			

			if(file.exists()==false)
			{

				try {
					item.write(file);
					nomeFile=file.getName();
					break;

				} catch (Exception e) 
				{

					e.printStackTrace();
				}
			}
			else
			{
				index++;
			}
		}
		return nomeFile;
	}
	
	private ArrayList<StrumentoDTO> getDuplicati( InterventoDTO intervento,Session session) throws Exception {
		
		
		ArrayList<StrumentoDTO> lista_duplicati = new ArrayList<StrumentoDTO>();
		ArrayList<MisuraDTO> listaMisure = GestioneInterventoBO.getListaMirureByIntervento(intervento.getId());
		
	    for (int i = 0; i < listaMisure.size(); i++) 
	    {
	    	MisuraDTO misura = listaMisure.get(i);

	    	boolean isPresent=GestioneInterventoDAO.isPresentStrumento(intervento.getId(),misura.getStrumento(),session);
		
	    	if(isPresent==true)
	    	{
	    		lista_duplicati.add(misura.getStrumento());	
	    			    		
	    	}
	    }
	    
	    return lista_duplicati;		
	}
}
