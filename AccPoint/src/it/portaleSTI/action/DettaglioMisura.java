package it.portaleSTI.action;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.apache.log4j.Logger;
import org.hibernate.Session;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

import it.portaleSTI.DAO.GestioneCertificatoDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.LatMisuraDTO;
import it.portaleSTI.DTO.LatPuntoLivellaDTO;
import it.portaleSTI.DTO.LatPuntoLivellaElettronicaDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.PuntoMisuraDTO;

import it.portaleSTI.DTO.SicurezzaElettricaDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.bo.GestioneLivellaBollaBO;
import it.portaleSTI.bo.GestioneLivellaElettronicaBO;
import it.portaleSTI.bo.GestioneMisuraBO;
import it.portaleSTI.bo.GestioneSicurezzaElettricaBO;
import it.portaleSTI.bo.GestioneStrumentoBO;
import it.portaleSTI.bo.GestioneVerCertificatoBO;

/**
 * Servlet implementation class GestioneIntervento
 */
@WebServlet(name = "dettaglioMisura", urlPatterns = { "/dettaglioMisura.do" })
public class DettaglioMisura extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static final Logger logger = Logger.getLogger(DettaglioMisura.class);
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DettaglioMisura() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		/*
		 * CHIAMATA LINK PROVENIENTE DA STRUMENTI
		 * BISOGNA CONTROLLARE SE L'UTENTE HA I PERMESSI PER ACCEDERE ALLA MISURA
		 */
		
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(Utility.validateSession(request,response,getServletContext()))return;
		Session session=SessionFacotryDAO.get().openSession();
		session.beginTransaction();
		try 
		{
			
			
			String idMisura=request.getParameter("idMisura");
			String action = request.getParameter("action");
			
			logger.error(Utility.getMemorySpace()+" Action: "+action +" - Utente: "+((UtenteDTO)request.getSession().getAttribute("userObj")).getNominativo());
			
			if(action==null || action.equals("")) {
				
			idMisura = Utility.decryptData(idMisura);
			MisuraDTO misura = GestioneMisuraBO.getMiruraByID(Integer.parseInt(idMisura), session);	
			CertificatoDTO certificato = GestioneCertificatoDAO.getCertificatoByMisura(misura, session);
			
//			Set<ScadenzaDTO> listaScadenzeDTO= new HashSet<>();
//			ScadenzaDTO scadenza = new ScadenzaDTO();
//			scadenza.setDataEmissione(new Date(System.currentTimeMillis()));
//			scadenza.setDataProssimaVerifica(new Date(System.currentTimeMillis()));
//			scadenza.setDataUltimaVerifica(new Date(System.currentTimeMillis()));
//			listaScadenzeDTO.add(scadenza);
//			misura.getStrumento().setListaScadenzeDTO(listaScadenzeDTO);
			
			request.getSession().setAttribute("misura", misura);
			request.setAttribute("cert", certificato);
			
				if(misura.getLat().equals("N")) {
					int numeroTabelle = GestioneMisuraBO.getMaxTabellePerMisura(misura.getListaPunti());
					
					ArrayList<ArrayList<PuntoMisuraDTO>> arrayPunti = new ArrayList<ArrayList<PuntoMisuraDTO>>();
					
					for(int i = 0; i < numeroTabelle; i++){
						ArrayList<PuntoMisuraDTO> punti = GestioneMisuraBO.getListaPuntiByIdTabella(misura.getListaPunti(), i+1);
						
						if(punti.size()>0)
						{
							
							arrayPunti.add(punti);
						}
					}
					
					request.getSession().setAttribute("arrayPunti", arrayPunti);
	
					Gson gson = new Gson();
					JsonArray listaPuntJson = gson.toJsonTree(arrayPunti).getAsJsonArray();
					request.setAttribute("listaPuntJson", listaPuntJson);
					
					
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioMisura.jsp");
			     	dispatcher.forward(request,response);
					
				}
				else if(misura.getLat().equals("E")) {
					
					SicurezzaElettricaDTO misura_se = GestioneSicurezzaElettricaBO.getMisuraSeFormIdMisura(Integer.parseInt(idMisura), session);

					request.setAttribute("misura_se", misura_se);
					
					session.close();

					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioMisuraSE.jsp");
			     	dispatcher.forward(request,response);
					
				}
		
				else {
					
					
					if(misura.getMisuraLAT().getMisura_lat().getId()==1) {
					
						LatMisuraDTO misuraLat = GestioneLivellaBollaBO.getMisuraLivellaById(misura.getMisuraLAT().getId(), session);
						ArrayList<LatPuntoLivellaDTO> lista_pos = new ArrayList<LatPuntoLivellaDTO>();
						ArrayList<LatPuntoLivellaDTO> lista_neg = new ArrayList<LatPuntoLivellaDTO>();
						if(misuraLat!=null) {
							for (LatPuntoLivellaDTO punto : misuraLat.getListaPunti()) {
								if(punto.getSemisc()!=null && punto.getSemisc().equals("SX")) {
									lista_neg.add(punto);
								}else {
									lista_pos.add(punto);
								}
							}
						}
						request.setAttribute("scala", 2);
						request.setAttribute("lista_pos", lista_pos);
						request.setAttribute("lista_neg", lista_neg);
						request.setAttribute("misura_lat", misuraLat);
						
						session.close();
						
						RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioMisuraLATLivella.jsp");
				     	dispatcher.forward(request,response);
				     	
					}
					else if(misura.getMisuraLAT().getMisura_lat().getId()==2) {
						
						ArrayList<LatPuntoLivellaElettronicaDTO> lista_punti = GestioneLivellaElettronicaBO.getListaPuntiLivellaTutti(misura.getMisuraLAT().getId(), session);
						ArrayList<LatPuntoLivellaElettronicaDTO> lista_punti_L = new ArrayList<LatPuntoLivellaElettronicaDTO>();
						ArrayList<ArrayList<LatPuntoLivellaElettronicaDTO>> lista_punti_R = new ArrayList<ArrayList<LatPuntoLivellaElettronicaDTO>>();
						ArrayList<LatPuntoLivellaElettronicaDTO> lista_punti_I = new ArrayList<LatPuntoLivellaElettronicaDTO>();
						
						
						ArrayList<LatPuntoLivellaElettronicaDTO> lista_punti_colonna = null;
						if(lista_punti!=null) {
							//for (LatPuntoLivellaElettronicaDTO punto : lista_punti) {
							for (int i =0;i<lista_punti.size();i++) {
								if(lista_punti.get(i).getTipo_prova().equals("L")) {
									lista_punti_L.add(lista_punti.get(i));
								}
								else if(lista_punti.get(i).getTipo_prova().equals("R")) {				
									if(i==0 || lista_punti.get(i).getNumero_prova()>lista_punti.get(i-1).getNumero_prova()) {
										lista_punti_colonna=  new ArrayList<LatPuntoLivellaElettronicaDTO>();
										if(i!=0) {
											lista_punti_R.add(lista_punti_colonna);
										}
									}
									
									lista_punti_colonna.add(lista_punti.get(i));
									
								}
								else {
									lista_punti_I.add(lista_punti.get(i));
								}
							}
						}
						
						ArrayList<BigDecimal> scostA = new ArrayList<BigDecimal>();
						ArrayList<BigDecimal> scostB = new ArrayList<BigDecimal>();
						ArrayList<BigDecimal> scostM = new ArrayList<BigDecimal>();
						ArrayList<BigDecimal> valori_nominali = new ArrayList<BigDecimal>();
						if(lista_punti_L!=null && lista_punti_L.size()>0) {
							for (LatPuntoLivellaElettronicaDTO punto : lista_punti_L) {
								scostA.add(punto.getScostamentoA());
								scostB.add(punto.getScostamentoB());
								scostM.add(punto.getScostamentoMed());
								valori_nominali.add(punto.getValore_nominale());
							}
						}
						
						 Gson gson = new Gson(); 
					     JsonObject myObj = new JsonObject();
					     JsonElement obj1 = gson.toJsonTree(scostA);
					     JsonElement obj2 = gson.toJsonTree(scostB);
					     JsonElement obj3 = gson.toJsonTree(scostM);
					     JsonElement obj4 = gson.toJsonTree(valori_nominali);
					     
					     myObj.add("scostA", obj1);
					     myObj.add("scostB", obj2);
					     myObj.add("scostM", obj3);
					     myObj.add("valori_nominali", obj4);
					        
					     request.getSession().setAttribute("dati_grafico",myObj);						

						request.setAttribute("lista_punti", lista_punti);
						request.setAttribute("lista_punti_L", lista_punti_L);
						request.setAttribute("lista_punti_R", lista_punti_R);
						request.setAttribute("lista_punti_I", lista_punti_I);
						
						session.close();
						
						RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioMisuraLATLivellaElettronica.jsp");
				     	dispatcher.forward(request,response);
						
					}
					else {
						RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/dettaglioMisuraLATGenerico.jsp");
				     	dispatcher.forward(request,response);
					}
				}
			
			}
			
			
			else if(action.equals("andamento_temporale")) {
				
				String id_strumento = request.getParameter("id_strumento");
				
				id_strumento = Utility.decryptData(id_strumento);
					
				ArrayList<MisuraDTO> lista_misure = GestioneStrumentoBO.getListaMisureByStrumento(Integer.parseInt(id_strumento), session);
				
				request.setAttribute("lista_misure", lista_misure);
				Gson g = new Gson();
				
				request.setAttribute("lista_punti_misure", g.toJsonTree(lista_misure));
				

				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/graficoAndamentoTemporale.jsp");
		     	dispatcher.forward(request,response);
				
				
				session.getTransaction().commit();
				session.close();
			}
			else if(action.equals("select_tabella")) {
				
				String id = request.getParameter("id_misura");
				MisuraDTO misura = GestioneMisuraBO.getMiruraByID(Integer.parseInt(id), session);	
				
				
					int numeroTabelle = GestioneMisuraBO.getMaxTabellePerMisura(misura.getListaPunti());
					
					ArrayList<ArrayList<PuntoMisuraDTO>> arrayPunti = new ArrayList<ArrayList<PuntoMisuraDTO>>();
					
					for(int i = 0; i < numeroTabelle; i++){
						ArrayList<PuntoMisuraDTO> punti = GestioneMisuraBO.getListaPuntiByIdTabella(misura.getListaPunti(), i+1);
						
						if(punti.size()>0)
						{
							
							arrayPunti.add(punti);
						}
					}
					
	
				request.getSession().setAttribute("arrayPunti", arrayPunti);
				
				Gson gson = new Gson();
				JsonArray listaPuntiJson = gson.toJsonTree(arrayPunti).getAsJsonArray();
				
				PrintWriter out = response.getWriter();
				
				JsonObject myObj = new JsonObject();
				myObj.addProperty("success", true);
				myObj.add("listaPuntiJson", listaPuntiJson);
				
				out.print(myObj);
				
				session.getTransaction().commit();
				session.close();
				
			}
			else if(action.equals("download")) {
				
				String id_punto = request.getParameter("id_punto");
				
				id_punto = Utility.decryptData(id_punto);
				
				byte[] blob = GestioneMisuraBO.getFileBlob(Integer.parseInt(id_punto));

				response.setContentType("application/pdf");
				 
			//	response.setHeader("Content-Disposition","attachment;filename=allegato.pdf");
				
				ServletOutputStream outp = response.getOutputStream();
	          
	              ByteArrayInputStream bis = new ByteArrayInputStream(blob);
	              
	              IOUtils.copy(bis, outp);

	              outp.close();
	              
	              session.getTransaction().commit();
					session.close();

			}     
		
		}catch (Exception ex) {
			session.getTransaction().rollback();
			session.close();
			 ex.printStackTrace();
	   	     request.setAttribute("error",STIException.callException(ex));
	   	     request.getSession().setAttribute("exception",ex);
	   		 RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/site/error.jsp");
	   	     dispatcher.forward(request,response);	
		}
		
	}

	private CommessaDTO getCommessa(ArrayList<CommessaDTO> listaCommesse,String idCommessa) {

		for (CommessaDTO comm : listaCommesse)
		{
			if(comm.getID_COMMESSA().equals(idCommessa))
			return comm;
		}
			
		
		return null;
	}

}
