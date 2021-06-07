package it.portaleSTI.action;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.GestioneTLDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.TipoCampioneDTO;
import it.portaleSTI.DTO.TipoGrandezzaDTO;
import it.portaleSTI.DTO.UnitaMisuraDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.CreateSchedaScadenzarioCampioni;
import it.portaleSTI.bo.GestioneAttivitaCampioneBO;
import it.portaleSTI.bo.GestioneCampioneBO;
import it.portaleSTI.bo.GestioneCompanyBO;

/**
 * Servlet implementation class listaCampioni
 */
@WebServlet(name="listaCampioni" , urlPatterns = { "/listaCampioni.do" })

public class ListaCampioni extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ListaCampioni() {
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

		Session session = SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		response.setContentType("text/html");
		
		JsonObject myObj = new JsonObject();
		boolean ajax = false;
		
		String action = request.getParameter("action");
		int idCompany=0;
		
		CompanyDTO cmp=(CompanyDTO)request.getSession().getAttribute("usrCompany");

		if(cmp.getId()==4132) 
		{ 

			idCompany=0;
		}
		else 
		{
			idCompany=cmp.getId();
		}
		try 
		{
			//	String myCMP =  request.getParameter("p");
			if(action==null) {
	
				String date =request.getParameter("date");
				String tipo_data_lat =request.getParameter("tipo_data_lat");
				String manutenzione =request.getParameter("manutenzione");
	
				ArrayList<CampioneDTO> listaCampioni=new ArrayList<CampioneDTO>();
	
				if(date==null || date.equals(""))
				{
					listaCampioni =GestioneCampioneDAO.getListaCampioni(null,idCompany, session);
				}
				else
				{
					if(tipo_data_lat!=null) {
						if(date.length()>=10)
						{
//							boolean manutenzione = false;
//							if(tipo_data_lat.equals("1")) {
//								manutenzione = true;
//							}
							listaCampioni =GestioneAttivitaCampioneBO.getListaCampioniPerData(date.substring(0,10), tipo_data_lat);
						}
					}else if(manutenzione!= null) {
						if(date.length()>=10)
						{						
							listaCampioni =GestioneAttivitaCampioneBO.getListaCampioniPerData(date.substring(0,10), null);
						}
					}
					else {
						if(date.length()>=10)
						{
							listaCampioni =GestioneCampioneDAO.getListaCampioni(date.substring(0,10),idCompany, session);
						}
					}
					
				}
				
				
				Integer[] max_codici = GestioneCampioneBO.getProgressivoCampione();

				ArrayList<CompanyDTO> lista_company = GestioneCompanyBO.getAllCompany(session);

				 ArrayList<TipoGrandezzaDTO> tgArr = GestioneTLDAO.getListaTipoGrandezza(session);
			        JsonArray tgArrJson = new JsonArray();
			        JsonObject umArrJson = new JsonObject();
			        JsonObject jsObjDefault = new JsonObject();
			        jsObjDefault.addProperty("label", "Seleziona");
			        jsObjDefault.addProperty("value", "0");
					tgArrJson.add(jsObjDefault);
			        for (Iterator iterator = tgArr.iterator(); iterator.hasNext();) {
						TipoGrandezzaDTO tipoGrandezzaDTO = (TipoGrandezzaDTO) iterator.next();
						JsonObject jsObj = new JsonObject();
						jsObj.addProperty("label", tipoGrandezzaDTO.getNome().replace("'", " "));
						jsObj.addProperty("value", ""+tipoGrandezzaDTO.getId());
	
						JsonArray umArrJsonChild = new JsonArray();
						ArrayList<UnitaMisuraDTO> list = new ArrayList<UnitaMisuraDTO>(tipoGrandezzaDTO.getListaUM());
						Collections.sort( list, new Comparator<UnitaMisuraDTO>() {
				            public int compare(UnitaMisuraDTO v1, UnitaMisuraDTO v2) {
				                return v1.getNome().compareTo(v2.getNome());
				            }
				        });
				        for (Iterator iterator2 = list.iterator(); iterator2.hasNext();) {
							UnitaMisuraDTO unitaMisuraDTO = (UnitaMisuraDTO) iterator2.next();
							JsonObject jsObj2 = new JsonObject();
							jsObj2.addProperty("label", unitaMisuraDTO.getNome().replace("'", " "));
							jsObj2.addProperty("value", ""+unitaMisuraDTO.getId());
							umArrJsonChild.add(jsObj2);
						}
					        
				        umArrJson.add(""+tipoGrandezzaDTO.getId(), umArrJsonChild);
					     tgArrJson.add(jsObj);
					}
			        
			        
		
			        request.getSession().setAttribute("listaTipoGrandezza",tgArrJson);
			        request.getSession().setAttribute("listaUnitaMisura",umArrJson);
			        request.getSession().setAttribute("max_codice_sti",max_codici[0]);
			        request.getSession().setAttribute("max_codice_cdt",max_codici[1]);
			        request.getSession().setAttribute("lista_company", lista_company);
	
	
				SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
				ArrayList<TipoCampioneDTO> listaTipoCampione= GestioneTLDAO.getListaTipoCampione(session);
				request.getSession().setAttribute("listaTipoCampione",listaTipoCampione);
				request.getSession().setAttribute("listaCampioni",listaCampioni);
	
				String rilievi = request.getParameter("rilievi");
				
				session.getTransaction().commit();
				session.close();
				
				if(rilievi != null && rilievi.equals("true")) {
					String id_rilievo = request.getParameter("id_rilievo");
					request.getSession().setAttribute("id_rilievo",id_rilievo);
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaCampioniRilievi.jsp");
			     	dispatcher.forward(request,response);
				}else {
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/listaCampioni.jsp");
			     	dispatcher.forward(request,response);
				}
			}
			
			else if(action!=null && action.equals("campioni_scadenza")) {
				
				ajax = true;
				
				String data_start = request.getParameter("data_start");
				String data_end = request.getParameter("data_end");
				String tipo = request.getParameter("tipo");
				
				boolean lat = false;
				if(tipo!=null && tipo.equals("1")) {
					lat = true;
				}
				PrintWriter out = response.getWriter();
							
				JsonArray listaCampioni = GestioneCampioneBO.getCampioniScadenzaDate(data_start, data_end, lat, cmp.getId());
			
				JsonArray campioni = (JsonArray) listaCampioni.get(0);
				JsonArray descrizioni = (JsonArray)listaCampioni.get(1);
				JsonArray date = (JsonArray)listaCampioni.get(2);
				
				if(campioni.size()>0) {
					Type listType = new TypeToken<ArrayList<CampioneDTO>>(){}.getType();
					ArrayList<CampioneDTO> listaCamp = new Gson().fromJson(campioni, listType);
					
					listType = new TypeToken<ArrayList<Integer>>(){}.getType();
					ArrayList<Integer> listaDesc = new Gson().fromJson(descrizioni, listType);
					
					listType = new TypeToken<ArrayList<String>>(){}.getType();
					ArrayList<String> listaDate = new Gson().fromJson(date, listType);				
					
					new CreateSchedaScadenzarioCampioni(listaCamp, listaDesc, listaDate, data_start, data_end);
					
					myObj.addProperty("success", true);
					out.print(myObj);
					
				}else {
					
					myObj.addProperty("success", false);
					myObj.addProperty("messaggio", "Nessun campione in scadenza nel periodo selezionato!");
					out.print(myObj);
				}
				
				session.getTransaction().commit();
				session.close();
			}
			else if(action.equals("download_scadenzario")) {
				
				File file = new File(Costanti.PATH_FOLDER+"//ScadenzarioCampioni//SchedaListacampioni.pdf");
				
				FileInputStream fileIn = new FileInputStream(file);
				
				response.setContentType("application/octet-stream");				
				  
				 response.setHeader("Content-Disposition","attachment;filename="+ file.getName());
				 
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
		} 
		catch (Exception ex) {
			session.getTransaction().rollback();
			session.close();
			ex.printStackTrace();
			
			if(ajax) {
				
				PrintWriter out = response.getWriter();
				ex.printStackTrace();
	        	
	        	request.getSession().setAttribute("exception", ex);
	        	myObj = STIException.getException(ex);
	        	out.print(myObj);
        	}else {
		     request.setAttribute("error",STIException.callException(ex));
		     request.getSession().setAttribute("exception", ex);
			 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
			 dispatcher.forward(request,response);
        	}
		}
		 
	}

}
