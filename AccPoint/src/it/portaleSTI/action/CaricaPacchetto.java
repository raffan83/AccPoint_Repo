package it.portaleSTI.action;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.CopyOption;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.GestioneInterventoDAO;
import it.portaleSTI.DAO.SQLLiteDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ConfigurazioneClienteDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.ObjSavePackDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Strings;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneConfigurazioneClienteBO;
import it.portaleSTI.bo.GestioneInterventoBO;
import it.portaleSTI.bo.GestioneMisuraBO;
import it.portaleSTI.bo.GestioneStrumentoBO;



/**
 * Servlet implementation class ScaricaStrumento
 */
@WebServlet(name= "/caricaPacchetto", urlPatterns = { "/caricaPacchetto.do" })

public class CaricaPacchetto extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final Logger logger = Logger.getLogger(CaricaPacchetto.class);
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CaricaPacchetto() {
		super();
		// TODO Auto-generated constructor stub
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		if(Utility.validateSession(request,response,getServletContext()))return;

		ObjSavePackDTO esito=null;
		JsonObject jsono = new JsonObject();
		PrintWriter writer = response.getWriter();
		
		ArrayList<ConfigurazioneClienteDTO> configurazioneCliente= null;
		InterventoDTO interv= (InterventoDTO)request.getSession().getAttribute("intervento");
		UtenteDTO utente =(UtenteDTO)request.getSession().getAttribute("userObj");
		
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();

		ArrayList<MisuraDTO> listaMisureNonDuplicate = null;
		ArrayList<MisuraDTO> listaMisureDuplicate = null;
		writer = response.getWriter();
		response.setContentType("application/json");
		String action = request.getParameter("action");
		try {
			
			logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+utente.getNominativo());
			
			InterventoDTO intervento= (InterventoDTO) session.get(InterventoDTO.class, interv.getId()); 
			
			if(action==null) {
				try {
				ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
				List<FileItem> items = uploadHandler.parseRequest(request);
				for (FileItem item : items) {
					if (!item.isFormField()) {

						 esito =GestioneInterventoBO.savePackUpload(item,intervento.getNomePack());
						 boolean firma_cliente = false;
						if(esito.getEsito()==0)
						{
							jsono.addProperty("success", false);
							jsono.addProperty("messaggio", esito.getErrorMsg());
						}

						if(esito.getEsito()==1)
						{

							if(!esito.isLAT()) 
							{
								/*Controllo dati Sicurezza Elettrica*/
							
								boolean isElectric =GestioneInterventoBO.isElectric(esito);
								
								if(!isElectric)
								{
									String nomeDB=esito.getPackNameAssigned().getPath();
									Connection con =SQLLiteDAO.getConnection(nomeDB);
									
									/*Recupero lista misura dal file .db*/
									ArrayList<MisuraDTO> listaMisure=SQLLiteDAO.getListaMisure(con,intervento);
									
									listaMisureNonDuplicate = getListaMisureNonDuplicate(listaMisure, intervento, session);
									listaMisureDuplicate = getListaMisureDuplicate(listaMisure, intervento, session);
									
									
									
									esito = GestioneInterventoBO.saveDataDB(listaMisureNonDuplicate,esito,intervento,utente,false,false,session);
									
																	
									configurazioneCliente=GestioneConfigurazioneClienteBO.getConfigurazioneClienteFromIdCliente_idSede(intervento.getId_cliente(), intervento.getIdSede(), session);
									
									for (MisuraDTO mis : listaMisure) 
									{
										if((mis.getTipoFirma()==2 || mis.getTipoFirma()==3) && (configurazioneCliente==null || configurazioneCliente.size()==0)) {
											firma_cliente = true;
										}
									}
									
									
									
								}else 
								{
									esito = GestioneInterventoBO.saveDataDBSicurezzaElettrica(esito,intervento,utente,session);
								}
							}
							else 
							{
								esito = GestioneInterventoBO.saveDataDB_LAT(esito,intervento,utente,session);
							}
							
							if(esito.getEsito()==0)
							{
								jsono.addProperty("success", false);
								jsono.addProperty("messaggio", esito.getErrorMsg());
							}

							if(esito.getEsito()==1 && listaMisureDuplicate.size()==0)
							{

								jsono.addProperty("success", true);
								jsono.addProperty("messaggio", Strings.CARICA_PACCHETTO_ESITO_1(esito.getInterventoDati().getNumStrMis(), esito.getInterventoDati().getNumStrNuovi()));
								
								GestioneInterventoBO.setControllato(intervento.getId(), utente.getId(), 0, session);

							}
							Gson gson = new Gson();
							
							if(esito.getEsito()==1 && listaMisureDuplicate.size()>0)
							{
								
								ArrayList<StrumentoDTO> listaStrumentiDuplicati = new ArrayList<StrumentoDTO>();
								for (int i = 0; i < listaMisureDuplicate.size(); i++) 
								{
									StrumentoDTO strumento =GestioneStrumentoBO.getStrumentoById(""+listaMisureDuplicate.get(i).getStrumento().get__id(),session);
									//esito.getListaStrumentiDuplicati().set(i,strumento);
									
									listaStrumentiDuplicati.add(strumento);
								}
								
								
								String jsonInString = gson.toJson(listaStrumentiDuplicati);
								
								jsono.addProperty("success", true);                      				
								jsono.addProperty("duplicate",jsonInString);
								
								request.getSession().setAttribute("listaMisureDuplicate", listaMisureDuplicate);
							}
							
							if(esito.getEsito() == 1 && firma_cliente) 
							{
								jsono.addProperty("success", true);
								jsono.addProperty("hasFirmaCliente", true);
					
							}
							
							
							
						}
						
						if(esito.getEsito()==2)
						{
							jsono.addProperty("success", false);
							jsono.addProperty("messaggio",Strings.CARICA_PACCHETTO_ESITO_2);

						}

					}
				}

				request.getSession().setAttribute("esito", esito);
				
				session.getTransaction().commit();
				session.close();	
				
				if(esito.getInterventoDati()!=null) 
				{
					GestioneInterventoDati.updateNStrumenti(esito.getInterventoDati().getId(),esito.getInterventoDati().getNumStrMis());
				}
				writer.write(jsono.toString());
				writer.close();}catch(Exception ex) 
				{
					logger.error(ex);
					
					ex.printStackTrace();
					session.getTransaction().rollback();
					session.close();
					
				    FileOutputStream outFile = new FileOutputStream(esito.getPackNameAssigned());
				    outFile.flush();
				    outFile.close();
					esito.getPackNameAssigned().delete();
				
					jsono= STIException.getException(ex);
					request.getSession().setAttribute("exception", ex);
					writer.println(jsono.toString());
					writer.close();
				}
			}
			else if(action!=null && action.equals("firma_cliente")) {
				
				ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
				
				response.setContentType("application/json");
				
				List<FileItem> items = null;
			
			//		items = uploadHandler.parseRequest(request);
					
					 if (request.getContentType() != null && request.getContentType().toLowerCase().indexOf("multipart/form-data") > -1 ) {

			        		items = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
			        	}
					
					String nome_cliente = "";		
					String filename_firma = "";	
					String nome_pack = "";
					String check = "";
					FileItem file = null;
					for (FileItem item : items) {
						if (item.isFormField()) {
							if(item.getFieldName().equals("nome_cliente_firma")) {
								nome_cliente = item.getString();
							}	
							else if(item.getFieldName().equals("nome_pack")) {
								nome_pack = item.getString();
							}
							else if(item.getFieldName().startsWith("check")) {
								check= check +item.getFieldName();
							}
						}
						else {
							if(item.getFieldName().equals("fileupload_firma")) {
								file = item;
								filename_firma = item.getName();
							}				
						}
					}
					
					
					ConfigurazioneClienteDTO firma = null;
					if(!check.equals("")) {
						
						String id = check.split("_")[1];
					//	firma= GestioneConfigurazioneClienteBO.get.getFirmaCliente(Integer.parseInt(id), session);
					//	filename_firma = firma.getNome_file();
						nome_cliente = firma.getNominativo_firma();
					}
					
					if(!filename_firma.equals("")) {
						File folder = new File(Costanti.PATH_FOLDER+"\\"+nome_pack+"\\FileFirmaCliente\\");
						
						if(!folder.exists()) {
							folder.mkdirs();
						}
						
						

						if(!check.equals("")){
						//	Files.copy(Paths.get(Costanti.PATH_FOLDER+"\\FirmeCliente\\"+firma.getId_cliente()+"\\"+firma.getId_sede()+"\\"+firma.getNome_file()), Paths.get(folder.getPath() +"\\"+ filename_firma), StandardCopyOption.REPLACE_EXISTING);
						}else {
							File f = new File(folder.getPath() +"\\"+ filename_firma);
							while(true) {		
								try {
									file.write(f);
									
									break;
								} catch (Exception e) {
									// TODO Auto-generated catch block
									e.printStackTrace();
									break;
								}
								
						
							}
						}
								
						
					}
					
					
					ArrayList<MisuraDTO> listaMisure= GestioneInterventoBO.getListaMirureByIntervento(intervento.getId(), session);
					for (MisuraDTO misura : listaMisure) {
						if(misura.getTipoFirma()==2 || misura.getTipoFirma()==3) {
							misura.setNome_firma(nome_cliente);
							misura.setFile_firma(filename_firma);
							session.update(misura);
						}
					}
					session.getTransaction().commit();
					session.close();
					
					jsono.addProperty("success", true);
					jsono.addProperty("messaggio", "Firma caricata con successo!");
					writer.write(jsono.toString());
					writer.close();
			}
		}
		catch (Exception e)
		{ 
			e.printStackTrace();
			session.getTransaction().rollback();
			session.close();
			
		    FileOutputStream outFile = new FileOutputStream(esito.getPackNameAssigned());
		    outFile.flush();
		    outFile.close();
			esito.getPackNameAssigned().delete();
		
			jsono= STIException.getException(e);
			request.getSession().setAttribute("exception", e);
			writer.println(jsono.toString());
			writer.close();

		} 

	}

	private ArrayList<MisuraDTO> getListaMisureDuplicate(ArrayList<MisuraDTO> listaMisure, InterventoDTO intervento, Session session) {

		ArrayList<MisuraDTO> lista = new ArrayList<MisuraDTO>();
		for (MisuraDTO misuraDTO : listaMisure) {
			 boolean isPresent=GestioneInterventoDAO.isPresentStrumento(intervento.getId(),misuraDTO.getStrumento(),session);
			 if(isPresent) {
				 lista.add(misuraDTO);
			 }
		}
		
		return lista;
	}

	private ArrayList<MisuraDTO> getListaMisureNonDuplicate(ArrayList<MisuraDTO> listaMisure, InterventoDTO intervento, Session session) {
		ArrayList<MisuraDTO> lista = new ArrayList<MisuraDTO>();
		for (MisuraDTO misuraDTO : listaMisure) {
			 boolean isPresent=GestioneInterventoDAO.isPresentStrumento(intervento.getId(),misuraDTO.getStrumento(),session);
			 if(!isPresent) {
				 lista.add(misuraDTO);
			 }
		}
		
		return lista;
	}

}
