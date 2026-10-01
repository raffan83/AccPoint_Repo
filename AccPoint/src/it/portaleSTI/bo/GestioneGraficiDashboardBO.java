package it.portaleSTI.bo;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DTO.GraficoDashboardDTO;

public class GestioneGraficiDashboardBO {


	public static GraficoDashboardDTO getGraficiDash() throws Exception {
		Connection con=null;
	 GraficoDashboardDTO graficoDash = new GraficoDashboardDTO();
			 try {
			 con = DirectMySqlDAO.getConnection();
		
			 graficoDash.setItemInLavorazione(DirectMySqlDAO.getListaItemInLavorazioneMag(1,con));
			
		   graficoDash.setItemFornitori(DirectMySqlDAO.getListaItemFornitori(con));

		   graficoDash.setItemLavoratiInIngresso(DirectMySqlDAO.getListaItemLavorati(2,con));
		
		   graficoDash.setItemLavoratiInSpedizione(DirectMySqlDAO.getListaItemLavoratiInSpedizione(2,con));
		
		  

			List<Integer> listaCertificatiLAT = new ArrayList<>();
			List<Integer> listaCertificatiSVT = new ArrayList<>();
			List<Integer> listaCertificatiRDT = new ArrayList<>();
			List<Integer> listaCertificatiRDP = new ArrayList<>();
			List<Integer> listaCertificatiSE = new ArrayList<>();
		
		for(int i=0; i>-6; i--) {
			int certificatiLAT = DirectMySqlDAO.getListaCertificatiLATSE("S",i,con);
			listaCertificatiLAT.add(certificatiLAT);
			int certificatiSVT = DirectMySqlDAO.getListaCertificatiRap("SVT",i,con);
			listaCertificatiSVT.add(certificatiSVT);
			int certificatiRDT = DirectMySqlDAO.getListaCertificatiRap("RDT",i,con);		
			listaCertificatiRDT.add(certificatiRDT);
			int certificatiRDP = DirectMySqlDAO.getListaCertificatiRap("RDP",i,con);
			listaCertificatiRDP.add(certificatiRDP);
			int certificatiSE = DirectMySqlDAO.getListaCertificatiLATSE("E",i,con);
			listaCertificatiSE.add(certificatiSE);
		}
		
		graficoDash.setListaCertificatiLAT(listaCertificatiLAT);
		graficoDash.setListaCertificatiSVT(listaCertificatiSVT);
		graficoDash.setListaCertificatiRDT(listaCertificatiRDT);
		graficoDash.setListaCertificatiRDP(listaCertificatiRDP);
		graficoDash.setListaCertificatiSE(listaCertificatiSE);
		
		}  catch (Exception e) {
			  e.printStackTrace();
		        throw e;
		}finally {

	        if (con != null)
	            con.close();
		}
		
		return graficoDash;
	}

}
