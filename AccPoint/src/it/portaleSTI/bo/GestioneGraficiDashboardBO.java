package it.portaleSTI.bo;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
		
		  List<String> listaCertificatiMese = new ArrayList<>();
		  List<Integer> listaCertificatiLATs = new ArrayList<>();
		  List<Integer> listaCertificatiSVTs = new ArrayList<>();
			List<Integer> listaCertificatiRDTs = new ArrayList<>();
			List<Integer> listaCertificatiRDPs = new ArrayList<>();
			List<Integer> listaCertificatiSEs = new ArrayList<>();
			List<Integer> listaCertificatiAltro = new ArrayList<>();
		
			for (int i = 0; i > -6; i--) {

			    listaCertificatiMese =DirectMySqlDAO.getListaCertificatiString(i, con);

			    int countLAT = 0;
			    int countSVT = 0;
			    int countRDP = 0;
			    int countRDT = 0;
			    int countSE = 0;
			    int countAltro = 0;

			    for (String s : listaCertificatiMese) {

			        if (s.contains("LAT")) {

			            countLAT++;

			        } else if (s.contains("SVT")) {

			            countSVT++;

			        } else if (s.contains("RDT")) {

			            countRDT++;

			        } else if (s.contains("RDP")) {

			            countRDP++;

			        } else if (s.contains("SSEE")) {

			            countSE++;

			        } else {

			            countAltro++;
			        }
			    }

			    listaCertificatiLATs.add(countLAT);
			    listaCertificatiSVTs.add(countSVT);
			    listaCertificatiRDTs.add(countRDT);
			    listaCertificatiRDPs.add(countRDP);
			    listaCertificatiSEs.add(countSE);
			    listaCertificatiAltro.add(countAltro);
			}
			
			graficoDash.setListaCertificatiLAT(listaCertificatiLATs);
			graficoDash.setListaCertificatiSVT(listaCertificatiSVTs);
			graficoDash.setListaCertificatiRDT(listaCertificatiRDTs);
			graficoDash.setListaCertificatiRDP(listaCertificatiRDPs);
			graficoDash.setListaCertificatiSE(listaCertificatiSEs);
			graficoDash.setListaCertificatiAltro(listaCertificatiAltro);

			
		
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
