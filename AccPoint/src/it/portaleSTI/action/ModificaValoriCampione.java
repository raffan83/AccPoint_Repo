package it.portaleSTI.action;

import it.portaleSTI.DAO.GestioneCampioneDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.PrenotazioneDTO;
import it.portaleSTI.DTO.TipoGrandezzaDTO;
import it.portaleSTI.DTO.UnitaMisuraDTO;
import it.portaleSTI.DTO.ValoreCampioneDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestionePrenotazioniBO;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
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
		
	try{	
		String idC = request.getParameter("idC");


		System.out.println("*********************"+idC);

		String view = request.getParameter("view");
		
		if(view.equals("edit")){
			
			ArrayList<CampioneDTO> listaCampioni = (ArrayList<CampioneDTO>)request.getSession().getAttribute("listaCampioni");
			
			

			CampioneDTO dettaglio =getCampione(listaCampioni,idC);	

			
			
			JsonObject json = (JsonObject)request.getSession().getAttribute("myObj");

			JsonArray jsonElem = (JsonArray)json.getAsJsonArray("dataInfo");
			Gson gson = new Gson();
			
			Type listType = new TypeToken<ArrayList<ValoreCampioneDTO>>(){}.getType();
			ArrayList<ValoreCampioneDTO> listaValori = new Gson().fromJson(jsonElem, listType);
			
			JsonArray newArr = new JsonArray();
			for (int i = 0; i < jsonElem.size(); i++) {
				JsonObject objJson = jsonElem.get(i).getAsJsonObject();
				JsonObject newobjJson = new JsonObject();
				
				newobjJson.addProperty("unita_misura", objJson.get("unita_misura").getAsString());
				newobjJson.addProperty("tipo_grandezza", objJson.get("tipo_grandezza").getAsString());
				newArr.add(newobjJson);
			}
			
		        request.getSession().setAttribute("campione",dettaglio);
		        request.getSession().setAttribute("listaValoriCampione",jsonElem);
		        request.getSession().setAttribute("listaValoriCampioneJson",newArr);

		        
		        
				 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/modificaValoreCampione.jsp");
			     dispatcher.forward(request,response);
		}else if(view.equals("save")){

			String result = request.getParameter("param");
			
			PrintWriter out = response.getWriter();

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
				valc.setValore_nominale(Float.parseFloat(valNom));
				valc.setValore_taratura(Float.parseFloat(valTar));
				if(valInAs.length()>0){
					valc.setIncertezza_assoluta(Float.parseFloat(valInAs));
				}
				if(valInRel.length()>0){
					valc.setIncertezza_relativa(Float.parseFloat(valInRel));
				}
				
				UnitaMisuraDTO um = new UnitaMisuraDTO();
				um.setId(Integer.parseInt(valUM));
				
				TipoGrandezzaDTO tipoGrandezzaDTO = new TipoGrandezzaDTO();
				tipoGrandezzaDTO.setId(Integer.parseInt(valTipoG));
				valc.setParametri_taratura(valPT);
				valc.setUnita_misura(um);
				valc.setValore_composto(Integer.parseInt(valComp));
				valc.setInterpolato(Integer.parseInt(valInterp));
				valc.setDivisione_UM(Float.parseFloat(valDivUM));
				valc.setTipo_grandezza(tipoGrandezzaDTO);
				
				
				/*/
				 *  Inserire campione
				 */
				listaValoriNew.add(valc);
			}
			
			 JsonObject myObj = new JsonObject();

					myObj.addProperty("success", true);
			        out.println(myObj.toString());
			        
			        //"tblAppendGrid_valore_nominale_1=asdasd&tblAppendGrid_valore_taratura_1=asdasd&tblAppendGrid_incertezza_assoluta_1=asdasdas&tblAppendGrid_parametri_taratura_1=dasdasd&
			        //tblAppendGrid_unita_misura_1=Milli+Metro&tblAppendGrid_interpolato_1=asdasd&tblAppendGrid_divisione_UM_1=asdasdas&tblAppendGrid_tipo_grandezza_1=Lunghezza&
			        //tblAppendGrid_id_1=&tblAppendGrid_valore_nominale_11=1111&tblAppendGrid_valore_taratura_11=1111&
			        //tblAppendGrid_incertezza_assoluta_11=111&tblAppendGrid_parametri_taratura_11=11&tblAppendGrid_unita_misura_11=1111&tblAppendGrid_interpolato_11=1111&tblAppendGrid_divisione_UM_11=1111&tblAppendGrid_tipo_grandezza_11=1111&tblAppendGrid_id_11=0&tblAppendGrid_rowOrder=1%2C11"
		
		}
		


	
	}catch(Exception ex)
	{
		
		 ex.printStackTrace();
	     request.setAttribute("error",STIException.callException(ex));
		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
	     dispatcher.forward(request,response);
		
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
