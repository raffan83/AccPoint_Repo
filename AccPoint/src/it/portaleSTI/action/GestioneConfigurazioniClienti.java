package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
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
import org.apache.commons.io.FileUtils;
import org.hibernate.Session;

import com.google.gson.JsonObject;

import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.ConfigurazioneClienteDTO;
import it.portaleSTI.DTO.RilMisuraRilievoDTO;
import it.portaleSTI.DTO.RilStatoRilievoDTO;
import it.portaleSTI.DTO.RilTipoRilievoDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.DTO.TipoRapportoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneAnagraficaRemotaBO;
import it.portaleSTI.bo.GestioneConfigurazioneClienteBO;
import it.portaleSTI.bo.GestioneMagazzinoBO;
import it.portaleSTI.bo.GestioneRilieviBO;
import it.portaleSTI.bo.GestioneStrumentoBO;

/**
 * Servlet implementation class ListaConfigurazioniCliente
 */
@WebServlet("/gestioneConfigurazioniClienti.do")
public class GestioneConfigurazioniClienti extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GestioneConfigurazioniClienti() {
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
	Session session=SessionFacotryDAO.get().openSession();
	session.beginTransaction();
	boolean ajax= false;
	JsonObject myObj = new JsonObject();
	UtenteDTO utente = (UtenteDTO) request.getSession().getAttribute("userObj");
	response.setContentType("text/html");
		
		try 
		{
			List<ClienteDTO> listaClienti = new ArrayList<ClienteDTO>();
			String action = request.getParameter("action");
			
			if(action.equals("lista")) {
				//String id_cliente = request.getParameter("id_cliente");
				//String id_sede = request.getParameter("id_sede");
				
				ajax=false;
				if(request.getSession().getAttribute("listaClientiAll")==null) 
				{
					request.getSession().setAttribute("listaClientiAll",GestioneAnagraficaRemotaBO.getListaClientiAll());
				}	
				
				if(request.getSession().getAttribute("listaSediAll")==null) 
				{				
						request.getSession().setAttribute("listaSediAll",GestioneAnagraficaRemotaBO.getListaSediAll());				
				}			
		
				listaClienti = (List<ClienteDTO>)request.getSession().getAttribute("lista_clienti");
				if(listaClienti==null) {
					listaClienti = GestioneAnagraficaRemotaBO.getListaClienti(String.valueOf(utente.getCompany().getId()));							
				}
				
				List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
				if(listaSedi== null) {
					listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();	
				}
				
				ArrayList<ConfigurazioneClienteDTO> lista_configurazioni = GestioneConfigurazioneClienteBO.getListaConfigurazioniCliente(session);
				List<TipoRapportoDTO> lista_tipo_rapporto = GestioneStrumentoBO.getListaTipoRapporto();
				
				request.getSession().setAttribute("lista_configurazioni", lista_configurazioni);
				request.getSession().setAttribute("lista_clienti", listaClienti);				
				request.getSession().setAttribute("lista_sedi", listaSedi);
				request.getSession().setAttribute("lista_tipo_rapporto", lista_tipo_rapporto);
				
				session.close();
				
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaConfigurazioniClienti.jsp");
		     	dispatcher.forward(request,response);
			}
			else if(action.equals("nuovo")) {
				
				ajax = true;
				ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
				
				response.setContentType("application/json");
	
				
				List<FileItem> items;
			
					items = uploadHandler.parseRequest(request);
					String cliente = null;
					String seleziona_tutte = null;
					String sede = null;
					String tipo_rapporto = null;
					String firma = null;
					String filename = null;
					FileItem file = null;
					
					for (FileItem item : items) {
						if (item.isFormField()) {
							if(item.getFieldName().equals("cliente")) {
								cliente = item.getString();
							}						
							else if(item.getFieldName().equals("seleziona_tutte")) {
								seleziona_tutte = item.getString();
							}
							else if(item.getFieldName().equals("sede")) {
								sede = item.getString();
							}
							else if(item.getFieldName().equals("tipo_rapporto")) {
								tipo_rapporto = item.getString();
							}
							else if(item.getFieldName().equals("firma")) {
								firma = item.getString();
							}							
						}
						else {
							file = item;
							filename = item.getName();
						}
					}
					
					
					List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
					if(listaSedi== null) {
						listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();						
					}
					
					if(seleziona_tutte.equals("YES")) {
						ArrayList<SedeDTO> lista_sedi_cliente = GestioneAnagraficaRemotaBO.getSediFromCliente(listaSedi, Integer.parseInt(cliente.split("_")[0]));
						ArrayList<String> lista_id_sedi_esistenti = new ArrayList<String>(); 
						if(lista_sedi_cliente.size()>0) {			
							int j = 0;
							for (SedeDTO s : lista_sedi_cliente) {
								if(s.getId__cliente_()==Integer.parseInt(cliente.split("_")[0])) {
									if(GestioneConfigurazioneClienteBO.checkPresente(s.getId__cliente_(), s.get__id(), Integer.parseInt(tipo_rapporto), session)) {
										lista_id_sedi_esistenti.add(s.getDescrizione());
									}else {
										
										ConfigurazioneClienteDTO configurazione = new ConfigurazioneClienteDTO();
										configurazione.setId_cliente(Integer.parseInt(cliente.split("_")[0]));
										configurazione.setNome_cliente(cliente.split("_")[1]);
										configurazione.setId_sede(s.get__id());
										
										configurazione.setNome_sede(s.getDescrizione()+ " - " +s.getIndirizzo());
									
										configurazione.setTipo_rapporto(new TipoRapportoDTO(Integer.parseInt(tipo_rapporto),""));
										configurazione.setId_firma(Integer.parseInt(firma));
										
										if(j==0) {
											GestioneConfigurazioneClienteBO.uploadFile(file, s.getId__cliente_(), s.get__id());
											//GestioneConfigurazioneBO.uploadFile(file, lista_sedi_cliente.get(j).getId__cliente_(), lista_sedi_cliente.get(j).get__id());
										}else{
											String filePath = Costanti.PATH_FOLDER+"\\"+"LoghiCompany\\ConfigurazioneClienti\\";
											FileUtils.copyFile(new File(filePath + lista_sedi_cliente.get(j-1).getId__cliente_()+"\\"+lista_sedi_cliente.get(j-1).get__id()+"\\"+filename),
													new File(filePath + lista_sedi_cliente.get(j).getId__cliente_()+"\\"+lista_sedi_cliente.get(j).get__id()+"\\"+filename));
										}									
										configurazione.setNome_file_logo(filename);
										session.save(configurazione);
										j++;
									}
										
									
									if(lista_id_sedi_esistenti.size()>0 && lista_id_sedi_esistenti.size()!=lista_sedi_cliente.size()) {
										String str = "";
										for(int i= 0; i<lista_id_sedi_esistenti.size();i++) {
											if(i!=lista_id_sedi_esistenti.size()-1) {
												str = str + lista_id_sedi_esistenti.get(i) + ", ";
											}else {
												str = str + lista_id_sedi_esistenti.get(i);
											}
										}
										myObj.addProperty("success", true);	
										myObj.addProperty("warning", true);	
										myObj.addProperty("messaggio", "La configurazione per le sedi "+str+" esiste già! Per le altre è stata inserita correttamente");
										
									}
									else if(lista_id_sedi_esistenti.size()>0 && lista_id_sedi_esistenti.size()==lista_sedi_cliente.size()) {
										myObj.addProperty("success", false);	
										myObj.addProperty("messaggio", "Esistono già configurazioni per le sedi selezionate!");
									}
									else {
										myObj.addProperty("success", true);	
										myObj.addProperty("messaggio", "Le configurazioni sono state inserite correttamente");
									}
									
								}
							}
						}else {
							ConfigurazioneClienteDTO configurazione = new ConfigurazioneClienteDTO();
							configurazione.setId_cliente(Integer.parseInt(cliente.split("_")[0]));
							configurazione.setNome_cliente(cliente.split("_")[1]);
							configurazione.setId_sede(0);
							
							configurazione.setTipo_rapporto(new TipoRapportoDTO(Integer.parseInt(tipo_rapporto),""));
							configurazione.setId_firma(Integer.parseInt(firma));
							GestioneConfigurazioneClienteBO.uploadFile(file, Integer.parseInt(cliente.split("_")[0]), 0);
							configurazione.setNome_file_logo(filename);
							session.save(configurazione);
							myObj.addProperty("success", true);
							myObj.addProperty("messaggio", "Configurazione inserita con successo!");
						}
					}else {
						
						if(GestioneConfigurazioneClienteBO.checkPresente(Integer.parseInt(cliente.split("_")[0]), Integer.parseInt(sede.split("_")[0]), Integer.parseInt(tipo_rapporto), session)) {
							myObj.addProperty("success", false);
							myObj.addProperty("messaggio", "Attenzione! La configurazione è stata già inserita!");
				        	
						}else {
							ConfigurazioneClienteDTO configurazione = new ConfigurazioneClienteDTO();
							configurazione.setId_cliente(Integer.parseInt(cliente.split("_")[0]));
							configurazione.setNome_cliente(cliente.split("_")[1]);
							configurazione.setId_sede(Integer.parseInt(sede.split("_")[0]));
							if(!sede.equals("0")) {
								configurazione.setNome_sede(sede.split("__")[1]);
							}
							configurazione.setTipo_rapporto(new TipoRapportoDTO(Integer.parseInt(tipo_rapporto),""));
							configurazione.setId_firma(Integer.parseInt(firma));
							GestioneConfigurazioneClienteBO.uploadFile(file,Integer.parseInt(cliente.split("_")[0]), Integer.parseInt(sede.split("_")[0]));
							
							configurazione.setNome_file_logo(filename);
							session.save(configurazione);
							myObj.addProperty("success", true);
							myObj.addProperty("messaggio", "Configurazione inserita con successo!");
						}
					}
					
					session.getTransaction().commit();
					
					ArrayList<ConfigurazioneClienteDTO> lista_configurazioni = GestioneConfigurazioneClienteBO.getListaConfigurazioniCliente(session);
					request.getSession().setAttribute("lista_configurazioni", lista_configurazioni);
					session.close();
					PrintWriter out = response.getWriter();
					
		        	out.print(myObj);
			}
			else if(action.equals("modifica")) {
				
				ajax = true;
				ServletFileUpload uploadHandler = new ServletFileUpload(new DiskFileItemFactory());
				
				response.setContentType("application/json");
	
				List<FileItem> items;
			
					items = uploadHandler.parseRequest(request);
					String cliente = null;
					String seleziona_tutte = null;
					String sede = null;
					String tipo_rapporto = null;
					String firma = null;
					String filename = null;
					FileItem file = null;
					
					String cliente_old = null;
					String sede_old = null;
					String tipo_rapporto_old = null;
					
					for (FileItem item : items) {
						if (item.isFormField()) {
							if(item.getFieldName().equals("mod_cliente")) {
								cliente = item.getString();
							}						
							else if(item.getFieldName().equals("mod_seleziona_tutte")) {
								seleziona_tutte = item.getString();
							}
							else if(item.getFieldName().equals("mod_sede")) {
								sede = item.getString();
							}
							else if(item.getFieldName().equals("mod_tipo_rapporto")) {
								tipo_rapporto = item.getString();
							}
							else if(item.getFieldName().equals("mod_firma")) {
								firma = item.getString();
							}	
							else if(item.getFieldName().equals("cliente_old")) {
								cliente_old = item.getString();
							}	
							else if(item.getFieldName().equals("sede_old")) {
								sede_old = item.getString();
							}	
							else if(item.getFieldName().equals("tipo_rapporto_old")) {
								tipo_rapporto_old = item.getString();
							}	
						}
						else {
							file = item;
							filename = item.getName();
						}
					}
					
										
					List<SedeDTO> listaSedi =(List<SedeDTO>)request.getSession().getAttribute("lista_sedi");
					if(listaSedi== null) {
						listaSedi= GestioneAnagraficaRemotaBO.getListaSedi();						
					}
					
					if(seleziona_tutte.equals("YES")) {
						ArrayList<SedeDTO> lista_sedi_cliente = GestioneAnagraficaRemotaBO.getSediFromCliente(listaSedi, Integer.parseInt(cliente.split("_")[0]));

						if(lista_sedi_cliente.size()>0) {			
							
							for (int i=0;i<lista_sedi_cliente.size();i++) {
								if(lista_sedi_cliente.get(i).getId__cliente_()==Integer.parseInt(cliente_old.split("_")[0])) {
										
										ConfigurazioneClienteDTO configurazione = GestioneConfigurazioneClienteBO.getConfigurazioneClienteFromId(lista_sedi_cliente.get(i).getId__cliente_(),lista_sedi_cliente.get(i).get__id(), Integer.parseInt(tipo_rapporto_old), session);
										configurazione.setId_cliente(Integer.parseInt(cliente.split("_")[0]));
										configurazione.setNome_cliente(cliente.split("_")[1]);
										configurazione.setId_sede(lista_sedi_cliente.get(i).get__id());										
										configurazione.setNome_sede(lista_sedi_cliente.get(i).getDescrizione()+ " - " +lista_sedi_cliente.get(i).getIndirizzo());									
										configurazione.setTipo_rapporto(new TipoRapportoDTO(Integer.parseInt(tipo_rapporto),""));
										configurazione.setId_firma(Integer.parseInt(firma));
										if(filename!=null && !filename.equals("")) {
											if(i==0) {
												GestioneConfigurazioneClienteBO.uploadFile(file, lista_sedi_cliente.get(i).getId__cliente_(), lista_sedi_cliente.get(i).get__id());
											}else{
												String filePath = Costanti.PATH_FOLDER+"\\"+"LoghiCompany\\ConfigurazioneClienti\\";
												FileUtils.copyFile(new File(filePath + lista_sedi_cliente.get(i-1).getId__cliente_()+"\\"+lista_sedi_cliente.get(i-1).get__id()+"\\"+filename),
														new File(filePath + lista_sedi_cliente.get(i).getId__cliente_()+"\\"+lista_sedi_cliente.get(i).get__id()+"\\"+filename));
											}											
											configurazione.setNome_file_logo(filename);
										}										
										session.update(configurazione);										
								}
							}
							myObj.addProperty("success", true);	
							myObj.addProperty("messaggio", "Le configurazioni sono state modificate correttamente");
						}else {
							ConfigurazioneClienteDTO configurazione = GestioneConfigurazioneClienteBO.getConfigurazioneClienteFromId(Integer.parseInt(cliente_old.split("_")[0]),0, Integer.parseInt(tipo_rapporto_old), session);
							configurazione.setId_cliente(Integer.parseInt(cliente.split("_")[0]));
							configurazione.setNome_cliente(cliente.split("_")[1]);
							configurazione.setId_sede(0);

							configurazione.setTipo_rapporto(new TipoRapportoDTO(Integer.parseInt(tipo_rapporto),""));
							configurazione.setId_firma(Integer.parseInt(firma));
							if(filename!=null && !filename.equals("")) {
								GestioneConfigurazioneClienteBO.uploadFile(file, Integer.parseInt(cliente.split("_")[0]), 0);
								configurazione.setNome_file_logo(filename);
							}							
							session.update(configurazione);
							myObj.addProperty("success", true);
							myObj.addProperty("messaggio", "Configurazione modificata con successo!");
						}
					}else {
											
							ConfigurazioneClienteDTO configurazione = GestioneConfigurazioneClienteBO.getConfigurazioneClienteFromId(Integer.parseInt(cliente_old.split("_")[0]),Integer.parseInt(sede_old.split("_")[0]), Integer.parseInt(tipo_rapporto_old), session);
							configurazione.setId_cliente(Integer.parseInt(cliente.split("_")[0]));
							configurazione.setNome_cliente(cliente.split("_")[1]);
							configurazione.setId_sede(Integer.parseInt(sede.split("_")[0]));
							if(!sede.equals("0")) {
								configurazione.setNome_sede(sede.split("__")[1]);
							}
							configurazione.setTipo_rapporto(new TipoRapportoDTO(Integer.parseInt(tipo_rapporto),""));
							configurazione.setId_firma(Integer.parseInt(firma));
							if(filename!=null && !filename.equals("")) {
								GestioneConfigurazioneClienteBO.uploadFile(file,Integer.parseInt(cliente.split("_")[0]), Integer.parseInt(sede.split("_")[0]));
								configurazione.setNome_file_logo(filename);
							}
							
							session.update(configurazione);
							myObj.addProperty("success", true);
							myObj.addProperty("messaggio", "Configurazione modificata con successo!");
						
					}
					
					session.getTransaction().commit();
					
					ArrayList<ConfigurazioneClienteDTO> lista_configurazioni = GestioneConfigurazioneClienteBO.getListaConfigurazioniCliente(session);
					request.getSession().setAttribute("lista_configurazioni", lista_configurazioni);
					session.close();
					PrintWriter out = response.getWriter();
					
		        	out.print(myObj);
				
			}
			else if(action.equals("download_logo")) {
				
				ajax = false;
				
				String id_cliente= request.getParameter("id_cliente");
				String id_sede = request.getParameter("id_sede");
				String tipo_rapporto = request.getParameter("tipo_rapporto");				
				
				id_cliente = Utility.decryptData(id_cliente);
				id_sede = Utility.decryptData(id_sede);
				tipo_rapporto = Utility.decryptData(tipo_rapporto);
				
				ConfigurazioneClienteDTO configurazione = GestioneConfigurazioneClienteBO.getConfigurazioneClienteFromId(Integer.parseInt(id_cliente), Integer.parseInt(id_sede), Integer.parseInt(tipo_rapporto), session);
				
				String filePath = Costanti.PATH_FOLDER+"\\"+"LoghiCompany\\ConfigurazioneClienti\\"+id_cliente+"\\"+id_sede+"\\"+configurazione.getNome_file_logo();
				
				File file = new File(filePath);
				
				FileInputStream fileIn = new FileInputStream(file);
				 
				 response.setContentType("application/octet-stream");
				  
				 response.setHeader("Content-Disposition","attachment;filename="+ file.getName());
				 
				 ServletOutputStream outp = response.getOutputStream();
				     
				    byte[] outputByte = new byte[1];
				    
				    while(fileIn.read(outputByte, 0, 1) != -1)
				    {
				    	outp.write(outputByte, 0, 1);
				    }
				    
				    session.close();
				    fileIn.close();
				    outp.flush();
				    outp.close();
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
