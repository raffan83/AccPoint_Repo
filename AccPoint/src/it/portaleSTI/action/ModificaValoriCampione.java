package it.portaleSTI.action;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DAO.GestioneTLDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.PrenotazioneDTO;
import it.portaleSTI.DTO.TipoGrandezzaDTO;
import it.portaleSTI.DTO.UnitaMisuraDTO;
import it.portaleSTI.DTO.ValoreCampioneDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneCampioneBO;
import it.portaleSTI.bo.GestionePrenotazioniBO;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.reflect.TypeToken;

/**
 * Servlet implementation class DettaglioCampione
 */
@WebServlet(name="modificaValoriCampione" , urlPatterns = { "/modificaValoriCampione.do" })

public class ModificaValoriCampione extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
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
		String idC = request.getParameter("idC");

		String view = request.getParameter("view");
		
		ArrayList<CampioneDTO> listaCampioni = (ArrayList<CampioneDTO>)request.getSession().getAttribute("listaCampioni");

		CampioneDTO dettaglio =getCampione(listaCampioni,idC);	
		
		if(view.equals("edit")){

			JsonObject json = (JsonObject)request.getSession().getAttribute("myObj");

			JsonArray jsonElem = (JsonArray)json.getAsJsonArray("dataInfo");
			Gson gson = new Gson();
			
			Type listType = new TypeToken<ArrayList<ValoreCampioneDTO>>(){}.getType();
			ArrayList<ValoreCampioneDTO> listaValori = new Gson().fromJson(jsonElem, listType);
			
			JsonArray newArr = new JsonArray();
			for (int i = 0; i < jsonElem.size(); i++) {
				JsonObject objJson = jsonElem.get(i).getAsJsonObject();
				JsonObject newobjJson = new JsonObject();
				
				JsonObject umObj = objJson.get("unita_misura").getAsJsonObject();
				JsonObject tgObj = objJson.get("tipo_grandezza").getAsJsonObject();

				
				newobjJson.addProperty("unita_misura", umObj.get("id").getAsString());
				newobjJson.addProperty("tipo_grandezza", tgObj.get("id").getAsString());
				newArr.add(newobjJson);
			}
			
		        request.getSession().setAttribute("campione",dettaglio);
		        request.getSession().setAttribute("listaValoriCampione",jsonElem);
		        request.getSession().setAttribute("listaValoriCampioneJson",newArr);

		        ArrayList<TipoGrandezzaDTO> tgArr = GestioneTLDAO.getListaTipoGrandezza();
		        JsonArray tgArrJson = new JsonArray();
		        for (Iterator iterator = tgArr.iterator(); iterator.hasNext();) {
					TipoGrandezzaDTO tipoGrandezzaDTO = (TipoGrandezzaDTO) iterator.next();
					JsonObject jsObj = new JsonObject();
					jsObj.addProperty("label", tipoGrandezzaDTO.getNome().replace("'", " "));
					jsObj.addProperty("value", ""+tipoGrandezzaDTO.getId());
					tgArrJson.add(jsObj);
				}
		        
		        
		        ArrayList<UnitaMisuraDTO> umArr = GestioneTLDAO.getListaUnitaMisura();
		        JsonArray umArrJson = new JsonArray();

		        for (Iterator iterator = umArr.iterator(); iterator.hasNext();) {
					UnitaMisuraDTO unitaMisuraDTO = (UnitaMisuraDTO) iterator.next();
					JsonObject jsObj = new JsonObject();
					jsObj.addProperty("label", unitaMisuraDTO.getSimbolo().replace("'", " "));
					jsObj.addProperty("value", ""+unitaMisuraDTO.getId());
					umArrJson.add(jsObj);
				}
		        
		        
		        request.getSession().setAttribute("listaTipoGrandezza",tgArrJson);
		        request.getSession().setAttribute("listaUnitaMisura",umArrJson);

		        
				 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/modificaValoreCampione.jsp");
			     dispatcher.forward(request,response);
		}else if(view.equals("save")){

			//String result = request.getParameter("param");

			String rowOrder = request.getParameter("tblAppendGrid_rowOrder");
			
			String[] list = rowOrder.split(",");

			ArrayList<ValoreCampioneDTO> listaValoriNew = new ArrayList<ValoreCampioneDTO>();
			
			for (int i = 0; i < list.length; i++) {
				
				String valNom = request.getParameter("tblAppendGrid_valore_nominale_"+list[i]);
				String valTar = request.getParameter("tblAppendGrid_valore_taratura_"+list[i]);
				String valInAs = request.getParameter("tblAppendGrid_incertezza_assoluta_"+list[i]);
				String valInRel = request.getParameter("tblAppendGrid_incertezza_relativa_"+list[i]);
				String valPT = request.getParameter("tblAppendGrid_parametri_taratura_"+list[i]);
				String valUM = request.getParameter("tblAppendGrid_unita_misura_"+list[i]);
				String valInterp = request.getParameter("tblAppendGrid_interpolato_"+list[i]);
				String valComp = request.getParameter("tblAppendGrid_valore_composto_"+list[i]);
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
				valc.setValore_composto(Integer.parseInt(valComp));
				valc.setInterpolato(Integer.parseInt(valInterp));
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
		
		session.getTransaction().commit();
		session.close();
		
		out.println(myObj.toString());
		out.close();
	
	}catch(Exception ex)
	{
		 ex.printStackTrace();
		 session.getTransaction().rollback();
		 session.close();
		 	
		 myObj.addProperty("success", false);
		 myObj.addProperty("messaggio", "Errore modifica valori campione "+ex.getMessage());
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
