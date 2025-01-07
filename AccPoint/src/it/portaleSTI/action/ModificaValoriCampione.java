package it.portaleSTI.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.GestioneTLDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.TipoGrandezzaDTO;
import it.portaleSTI.DTO.UnitaMisuraDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.ValoreCampioneDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneCampioneBO;

/**
 * Servlet implementation class DettaglioCampione
 */
@WebServlet(name="modificaValoriCampione" , urlPatterns = { "/modificaValoriCampione.do" })

public class ModificaValoriCampione extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final Logger logger = Logger.getLogger(ModificaValoriCampione.class);
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ModificaValoriCampione() {
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
		
		Session session =SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		
		PrintWriter out = response.getWriter();
		JsonObject myObj = new JsonObject();
		
	try{	
		
		
		logger.error(Utility.getMemorySpace()+" Action: "+"ModificaValoriCampione" +" - Utente: "+((UtenteDTO)request.getSession().getAttribute("userObj")).getNominativo());
		
		String idC = request.getParameter("idC");

		String view = request.getParameter("view");
		
		ArrayList<CampioneDTO> listaCampioni = (ArrayList<CampioneDTO>)request.getSession().getAttribute("listaCampioni");

		CampioneDTO dettaglio =getCampione(listaCampioni,idC);	
		
		dettaglio.getCompany().setPwd_pec("");
		dettaglio.getCompany().setEmail_pec("");
		dettaglio.getCompany().setHost_pec("");
		if(view.equals("edit")){
			
			String idInterpolato="0";

			JsonObject json = (JsonObject)request.getSession().getAttribute("myObjValoriCampione");

			JsonArray jsonElem = (JsonArray)json.getAsJsonArray("dataInfo");
		//	Gson gson = new Gson();
			
		//	Type listType = new TypeToken<ArrayList<ValoreCampioneDTO>>(){}.getType();
	//		ArrayList<ValoreCampioneDTO> listaValori = new Gson().fromJson(jsonElem, listType);
			
			JsonArray newArr = new JsonArray();
			for (int i = 0; i < jsonElem.size(); i++) {
				JsonObject objJson = jsonElem.get(i).getAsJsonObject();
				JsonObject newobjJson = new JsonObject();
				jsonElem.get(i).getAsJsonObject().remove("campione");
				//jsonElem.get(i).getAsJsonObject().get("campione").getAsJsonObject().remove("descrizione_manutenzione");
				
				JsonObject umObj = objJson.get("unita_misura").getAsJsonObject();
				JsonObject tgObj = objJson.get("tipo_grandezza").getAsJsonObject();
				
				
				 idInterpolato=objJson.get("interpolato").getAsString();
				
				
				//newobjJson.addProperty("unita_misura", umObj.get("id").getAsString());
				//newobjJson.addProperty("tipo_grandezza", tgObj.get("id").getAsString());
				newArr.add(newobjJson);
			}
			
		        request.getSession().setAttribute("campione",dettaglio);
		        request.getSession().setAttribute("listaValoriCampione",jsonElem);
		       // request.getSession().setAttribute("listaValoriCampioneJson",newArr);
		        request.getSession().setAttribute("listaValoriCampioneJson",jsonElem);

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
		        
				
//		        ArrayList<UnitaMisuraDTO> umArr = GestioneTLDAO.getListaUnitaMisura();
//		        JsonArray umArrJson = new JsonArray();
//
//		        for (Iterator iterator = umArr.iterator(); iterator.hasNext();) {
//					UnitaMisuraDTO unitaMisuraDTO = (UnitaMisuraDTO) iterator.next();
//					JsonObject jsObj = new JsonObject();
//					jsObj.addProperty("label", unitaMisuraDTO.getNome().replace("'", " "));
//					jsObj.addProperty("value", ""+unitaMisuraDTO.getId());
//					umArrJson.add(jsObj);
//				}
		        
		        request.getSession().setAttribute("interpolato",idInterpolato);
		        request.getSession().setAttribute("listaTipoGrandezza",tgArrJson);
		        request.getSession().setAttribute("listaUnitaMisura",umArrJson);

		        
				 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/modificaValoreCampione.jsp");
			     dispatcher.forward(request,response);
		}
		
		else if(view.equals("single_edit")) {
			
			
			String idInterpolato="0";

			String id_val_cam = request.getParameter("id_val_cam");
			JsonObject json = (JsonObject)request.getSession().getAttribute("myObjValoriCampione");

			JsonArray jsonElem = (JsonArray)json.getAsJsonArray("dataInfo");
	
			JsonArray newArr = new JsonArray();
			for (int i = 0; i < jsonElem.size(); i++) {
				
				JsonObject objJson = jsonElem.get(i).getAsJsonObject();
				if(objJson.get("id").getAsString().equals(id_val_cam)) {
					JsonObject newobjJson = new JsonObject();
					
					JsonObject umObj = objJson.get("unita_misura").getAsJsonObject();
					JsonObject tgObj = objJson.get("tipo_grandezza").getAsJsonObject();
					jsonElem.get(i).getAsJsonObject().get("campione").getAsJsonObject().remove("descrizione_manutenzione");
					
					 idInterpolato=objJson.get("interpolato").getAsString();
					
					
					newArr.add(objJson);
					break;
				}
				
			}
			
		        request.getSession().setAttribute("campione",dettaglio);
		        request.getSession().setAttribute("listaValoriCampione",newArr);
		        request.getSession().setAttribute("listaValoriCampioneJson",newArr);

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
		        

		        
		        request.getSession().setAttribute("interpolato",idInterpolato);
		        request.getSession().setAttribute("listaTipoGrandezza",tgArrJson);
		        request.getSession().setAttribute("listaUnitaMisura",umArrJson);

		        
				 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/modificaSingoloValoreCampione.jsp");
			     dispatcher.forward(request,response);
			
			
		}
		
		
		else if(view.equals("save")){

			//String result = request.getParameter("param");

			String rowOrder = request.getParameter("tblAppendGrid_rowOrder");
			
			String[] list = rowOrder.split(",");

			ArrayList<ValoreCampioneDTO> listaValoriNew = new ArrayList<ValoreCampioneDTO>();
			
			int interpolato=Integer.parseInt(request.getParameter("interpolato"));
			String z = request.getParameter("tblAppendGrid_tipo_grandezza_2");
			for (int i = 0; i < list.length; i++) {
				
				String valPT=request.getParameter("tblAppendGrid_parametri_taratura_"+list[i]);
				String valNom = request.getParameter("tblAppendGrid_valore_nominale_"+list[i]);
				String valTar = request.getParameter("tblAppendGrid_valore_taratura_"+list[i]);
				String valInAs = request.getParameter("tblAppendGrid_incertezza_assoluta_"+list[i]);
				String valInRel = request.getParameter("tblAppendGrid_incertezza_relativa_"+list[i]);
				
				String valUM = request.getParameter("tblAppendGrid_unita_misura_"+list[i]);
			//	String valInterp = request.getParameter("tblAppendGrid_interpolato_"+list[i]);
			//	String valComp = request.getParameter("tblAppendGrid_valore_composto_"+list[i]);
				String valDivUM = request.getParameter("tblAppendGrid_divisione_UM_"+list[i]);
				String valTipoG = request.getParameter("tblAppendGrid_tipo_grandezza_"+list[i]);
				
				
				ValoreCampioneDTO valc = new ValoreCampioneDTO();
				valc.setValore_nominale(new BigDecimal(valNom));
				valc.setValore_taratura(new BigDecimal(valTar));
				if(valInAs.length()>0){
					valc.setIncertezza_assoluta(new BigDecimal(valInAs));
				}
				if(valInRel.length()>0){
					valc.setIncertezza_relativa(new BigDecimal(valInRel));
				}
				
				UnitaMisuraDTO um = new UnitaMisuraDTO();
				um.setId(Integer.parseInt(valUM));
				
				TipoGrandezzaDTO tipoGrandezzaDTO = new TipoGrandezzaDTO();
				tipoGrandezzaDTO.setId(Integer.parseInt(valTipoG));
				valc.setParametri_taratura(valPT);
				valc.setUnita_misura(um);
				//valc.setValore_composto(Integer.parseInt(valComp));
				valc.setInterpolato(interpolato);
				valc.setDivisione_UM(new BigDecimal(valDivUM));
				valc.setTipo_grandezza(tipoGrandezzaDTO);
				
				valc.setCampione(dettaglio);
				
				listaValoriNew.add(valc);
			}

			GestioneCampioneBO.rendiObsoletiValoriCampione(session,dettaglio.getId());
			
			for (int i = 0; i < listaValoriNew.size(); i++) {
				
				
				GestioneCampioneBO.saveValoreCampione(session,listaValoriNew.get(i));
			}

			myObj.addProperty("success", true);
		}
		
		
		else if (view.equals("salva_singolo_valore")){
			
			String id_val_cam = request.getParameter("id_val_cam");
			
			ValoreCampioneDTO valc = GestioneCampioneDAO.getValoreFromId(id_val_cam);
			
			String valPT=request.getParameter("tblAppendGrid_parametri_taratura_1");
			String valNom = request.getParameter("tblAppendGrid_valore_nominale_1");
			String valTar = request.getParameter("tblAppendGrid_valore_taratura_1");
			String valInAs = request.getParameter("tblAppendGrid_incertezza_assoluta_1");
			String valInRel = request.getParameter("tblAppendGrid_incertezza_relativa_1");
			
			String valUM = request.getParameter("tblAppendGrid_unita_misura_1");
		//	String valInterp = request.getParameter("tblAppendGrid_interpolato_"+list[i]);
		//	String valComp = request.getParameter("tblAppendGrid_valore_composto_"+list[i]);
			String valDivUM = request.getParameter("tblAppendGrid_divisione_UM_1");
			String valTipoG = request.getParameter("tblAppendGrid_tipo_grandezza_1");
			
			
			
			valc.setValore_nominale(new BigDecimal(valNom));
			valc.setValore_taratura(new BigDecimal(valTar));
			if(valInAs.length()>0){
				valc.setIncertezza_assoluta(new BigDecimal(valInAs));
			}
			if(valInRel.length()>0){
				valc.setIncertezza_relativa(new BigDecimal(valInRel));
			}
			
			UnitaMisuraDTO um = new UnitaMisuraDTO();
			um.setId(Integer.parseInt(valUM));
			
			TipoGrandezzaDTO tipoGrandezzaDTO = new TipoGrandezzaDTO();
			tipoGrandezzaDTO.setId(Integer.parseInt(valTipoG));
			valc.setParametri_taratura(valPT);
			valc.setUnita_misura(um);
			//valc.setValore_composto(Integer.parseInt(valComp));
			
			valc.setDivisione_UM(new BigDecimal(valDivUM));
			valc.setTipo_grandezza(tipoGrandezzaDTO);
			
			valc.setCampione(dettaglio);
			
			
			session.update(valc);
			
			myObj.addProperty("success", true);
			myObj.addProperty("messaggio", "Valore campione modificato con successo!");
		}
		
		session.getTransaction().commit();
		session.close();
		
		out.println(myObj.toString());
		out.close();
	
	}catch(Exception ex)
	{
		 ex.printStackTrace();
		 session.getTransaction().rollback();
		 session.close();
		  request.getSession().setAttribute("exception", ex);
		// myObj.addProperty("success", false);
		// myObj.addProperty("messaggio", "Errore modifica valori campione "+ex.getMessage());
			myObj = STIException.getException(ex);
		 out.println(myObj.toString());
		 out.close();
		 
	//     request.setAttribute("error",STIException.callException(ex));
	//	 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
	 //    dispatcher.forward(request,response);
	     
	}  
	
	}
	
	static CampioneDTO getCampione(ArrayList<CampioneDTO> listaCampioni,String idC) {
		CampioneDTO campione =null;
		
		try
		{		
		for (int i = 0; i < listaCampioni.size(); i++) {
			
			if(listaCampioni.get(i).getId()==Integer.parseInt(idC))
			{
				return listaCampioni.get(i);
			}
		}
		}
		catch(Exception ex)
		{
			ex.printStackTrace();
			campione=null;
			throw ex;
		}
		return campione;
	}

}
