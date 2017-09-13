package it.portaleSTI.Util;


import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;
import static net.sf.dynamicreports.report.builder.DynamicReports.col;
 import static net.sf.dynamicreports.report.builder.DynamicReports.stl;
import static net.sf.dynamicreports.report.builder.DynamicReports.type;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CampionamentoDatasetDTO;
import it.portaleSTI.DTO.CampionamentoPlayloadDTO;
import it.portaleSTI.DTO.InterventoCampionamentoDTO;
import it.portaleSTI.DTO.ReportPO005_DTO;
import it.portaleSTI.action.GestioneInterventoCampionamento;
import it.portaleSTI.bo.GestioneCampionamentoBO;

import java.io.File;
import java.io.InputStream;
 import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
 import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.dynamicreports.report.builder.column.TextColumnBuilder;
import net.sf.dynamicreports.report.builder.component.SubreportBuilder;
 import net.sf.dynamicreports.report.builder.style.StyleBuilder;
import net.sf.dynamicreports.report.constant.HorizontalTextAlignment;
import net.sf.dynamicreports.report.constant.SplitType;
import net.sf.dynamicreports.report.constant.VerticalTextAlignment;
import net.sf.dynamicreports.report.datasource.DRDataSource;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.data.JRMapCollectionDataSource;

import org.apache.commons.collections.map.HashedMap;
import org.hibernate.HibernateException;
import org.hibernate.Session;
/**
 * @author markpagna
 */
public class TestReport2 {

	public TestReport2(ArrayList<CampionamentoDatasetDTO> listaDataset, HashMap<String, ArrayList<CampionamentoPlayloadDTO>> listaPayload) {
		try {
			build(listaDataset, listaPayload);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}

	private void build(ArrayList<CampionamentoDatasetDTO> listaDataset, HashMap<String, ArrayList<CampionamentoPlayloadDTO>> listaPayload) throws JRException {
		
		InputStream is = TestReport2.class.getResourceAsStream("schedaCampionamentoPO007HeaderSvt.jrxml");
		 
	
		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.pen1Point()).setFontSize(8);//AGG
		
 
		JasperReportBuilder report = DynamicReports.report();
 
		StyleBuilder footerStyle = Templates.footerStyle.setFontSize(6).bold().setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE);
		StyleBuilder rootStyle = Templates.rootStyle.setFontSize(8).bold().setTextAlignment(HorizontalTextAlignment.CENTER, VerticalTextAlignment.MIDDLE);

		StyleBuilder footerStyleFormula = Templates.footerStyleFormula.setFontSize(4).bold().setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE);

		try {
 	
			String temperatura = "20°C";
		
			Object imageHeader = new File("./WebContent/images/header.jpg");
 		
			InterventoCampionamentoDTO intervento =  GestioneCampionamentoBO.getIntervento("17");
			
			
			report.setTemplateDesign(is);
			report.setTemplate(Templates.reportTemplate);


			report.addParameter("dataPrelievo","21/08/2017");
			report.addParameter("codiceCommessa",intervento.getID_COMMESSA());
			report.addParameter("operatore",intervento.getUser().getNominativo());
			report.addParameter("titoloProcedura","PROCEDURA DI CAMPIONAMENTO PO-005");
			
 
			report.addParameter("logo",imageHeader);
			report.addParameter("logo2",imageHeader);
			
			report.setColumnStyle(textStyle); //AGG
			
			SubreportBuilder subreport = cmp.subreport(getTableReport(listaDataset, listaPayload));
			
			report.detail(subreport);
		
			
			report.pageFooter(cmp.verticalList(
 					cmp.horizontalList(
							
						cmp.verticalList(
							cmp.text("Temperatura trasporto campioni: "+temperatura).setStyle(footerStyle).setHeight(1),
							cmp.verticalGap(10),
							cmp.horizontalList(
									cmp.verticalList(
											cmp.text("Firma Operatore (OT)").setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT),
											cmp.text("_____________________________________________________________").setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT)


										),
									cmp.horizontalGap(100),
  									cmp.verticalList(
											cmp.text("Firma Cliente Per approvazione").setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT),
											cmp.text("_____________________________________________________________").setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT)

										)
 									),
							cmp.verticalGap(10)

							
							
							)
					),

					cmp.line().setFixedHeight(1),
					
					cmp.horizontalList(
						cmp.text("MOD-LAB-003").setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setStyle(footerStyle),
						cmp.text("Rev. A del 01/06/2011").setHorizontalTextAlignment(HorizontalTextAlignment.RIGHT).setStyle(footerStyle)
					)
					
					
					
					),
					cmp.text("")
					
				);	
		


			 // report.pageFooter(Templates.footerComponent);
			  report.setDataSource(new JREmptyDataSource());
			  report.show();
			  
		} catch (Exception e) {
			e.printStackTrace();
		}
		//return report;
	}

	public JasperReportBuilder getTableReport(ArrayList<CampionamentoDatasetDTO> listaDataset, HashMap<String, ArrayList<CampionamentoPlayloadDTO>> listaPayload){

		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.pen1Point()).setFontSize(7);//AGG
		
	 
		JasperReportBuilder report = DynamicReports.report();

		try {
			report.setTemplate(Templates.reportTemplate);
			report.setColumnStyle(textStyle); //AGG

 	

			  
			report.setColumnStyle(textStyle); //AGG


			for (CampionamentoDatasetDTO campionamentoDataset : listaDataset) {
	 			report.addColumn(col.column(campionamentoDataset.getNome_campo(), campionamentoDataset.getCodice_campo(), type.stringType()));
			}
			

			
			report.setDetailSplitType(SplitType.PREVENT);
			
			report.setDataSource(createDataSource(listaDataset, listaPayload));
	  
		} catch (Exception e) {
			e.printStackTrace();
		}
		return report;
	}
 

 
 

	public static void main(String[] args) throws HibernateException, Exception {
	
		ArrayList<CampionamentoDatasetDTO> listaDataset = new ArrayList<CampionamentoDatasetDTO>();
		LinkedHashMap<String,ArrayList<CampionamentoPlayloadDTO>> listaPayload = new LinkedHashMap<String,ArrayList<CampionamentoPlayloadDTO>>();

		ArrayList<CampionamentoPlayloadDTO> puntiArray1 = new ArrayList<CampionamentoPlayloadDTO>();

		CampionamentoDatasetDTO campDataset1 = new CampionamentoDatasetDTO();
		campDataset1.setNome_campo("Id campione");
		campDataset1.setCodice_campo("idCampione");
		listaDataset.add(campDataset1);
		
		CampionamentoPlayloadDTO pay1 = new CampionamentoPlayloadDTO();
		pay1.setDataset(campDataset1);
		pay1.setPunto_misura("Punto1");
		pay1.setValore_misurato("100");
		puntiArray1.add(pay1);

		
		CampionamentoDatasetDTO campDataset2 = new CampionamentoDatasetDTO();
		campDataset2.setNome_campo("Tipo Acque");
		campDataset2.setCodice_campo("tipoAcque");
		listaDataset.add(campDataset2);
		
		CampionamentoPlayloadDTO pay2 = new CampionamentoPlayloadDTO();
		pay2.setDataset(campDataset2);
		pay2.setPunto_misura("Punto1");
		pay2.setValore_misurato("Chiare");
		puntiArray1.add(pay2);
		
		CampionamentoDatasetDTO campDataset2b = new CampionamentoDatasetDTO();
		campDataset2b.setNome_campo("Procedura");
		campDataset2b.setCodice_campo("procedura");
		listaDataset.add(campDataset2b);
		
		CampionamentoPlayloadDTO pay2b = new CampionamentoPlayloadDTO();
		pay2b.setDataset(campDataset2b);
		pay2b.setPunto_misura("Punto1");
		pay2b.setValore_misurato("xxxxx");
		puntiArray1.add(pay2b);
		
		
		CampionamentoDatasetDTO campDataset3 = new CampionamentoDatasetDTO();
		campDataset3.setNome_campo("Ora Prelievo");
		campDataset3.setCodice_campo("oraPrelievo");
		listaDataset.add(campDataset3);
		
		CampionamentoPlayloadDTO pay3 = new CampionamentoPlayloadDTO();
		pay3.setDataset(campDataset3);
		pay3.setPunto_misura("Punto1");
		pay3.setValore_misurato("12.58");
		puntiArray1.add(pay3);
		
		
		CampionamentoDatasetDTO campDataset4 = new CampionamentoDatasetDTO();
		campDataset4.setNome_campo("Quantità");
		campDataset4.setCodice_campo("quantitaPrelievo");
		listaDataset.add(campDataset4);
		
		CampionamentoPlayloadDTO pay4 = new CampionamentoPlayloadDTO();
		pay4.setDataset(campDataset4);
		pay4.setPunto_misura("Punto1");
		pay4.setValore_misurato("12");
		puntiArray1.add(pay4);
		
		
		CampionamentoDatasetDTO campDataset5 = new CampionamentoDatasetDTO();
		campDataset5.setNome_campo("Punto di Prelievo");
		campDataset5.setCodice_campo("puntoPrelievo");
		listaDataset.add(campDataset5);
		
		CampionamentoPlayloadDTO pay5 = new CampionamentoPlayloadDTO();
		pay5.setDataset(campDataset5);
		pay5.setPunto_misura("Punto1");
		pay5.setValore_misurato("ddddddd");
		puntiArray1.add(pay5);
		
		
		CampionamentoDatasetDTO campDataset6 = new CampionamentoDatasetDTO();
		campDataset6.setNome_campo("Ph");
		campDataset6.setCodice_campo("ph");
		listaDataset.add(campDataset6);
		
		CampionamentoPlayloadDTO pay6 = new CampionamentoPlayloadDTO();
		pay6.setDataset(campDataset6);
		pay6.setPunto_misura("Punto1");
		pay6.setValore_misurato("3.5");
		puntiArray1.add(pay6);
	
		
		CampionamentoDatasetDTO campDataset7 = new CampionamentoDatasetDTO();
		campDataset7.setNome_campo("Conducibilità");
		campDataset7.setCodice_campo("conducibilita");
		listaDataset.add(campDataset7);
		
		CampionamentoPlayloadDTO pay7 = new CampionamentoPlayloadDTO();
		pay7.setDataset(campDataset7);
		pay7.setPunto_misura("Punto1");
		pay7.setValore_misurato("3.5");
		puntiArray1.add(pay7);

		
		CampionamentoDatasetDTO campDataset8 = new CampionamentoDatasetDTO();
		campDataset8.setNome_campo("Temperatura");
		campDataset8.setCodice_campo("temperatura");
		listaDataset.add(campDataset8);
		
		CampionamentoPlayloadDTO pay8 = new CampionamentoPlayloadDTO();
		pay8.setDataset(campDataset8);
		pay8.setPunto_misura("Punto1");
		pay8.setValore_misurato("3.5");
		puntiArray1.add(pay8);
		
		
		CampionamentoDatasetDTO campDataset9 = new CampionamentoDatasetDTO();
		campDataset9.setNome_campo("Cloro libero");
		campDataset9.setCodice_campo("cloroLibero");
		listaDataset.add(campDataset9);
		
		CampionamentoPlayloadDTO pay9 = new CampionamentoPlayloadDTO();
		pay9.setDataset(campDataset9);
		pay9.setPunto_misura("Punto1");
		pay9.setValore_misurato("3.5");
		puntiArray1.add(pay9);
		
		
		CampionamentoDatasetDTO campDataset10 = new CampionamentoDatasetDTO();
		campDataset10.setNome_campo("Note");
		campDataset10.setCodice_campo("note");
		listaDataset.add(campDataset10);
		
		CampionamentoPlayloadDTO pay10 = new CampionamentoPlayloadDTO();
		pay10.setDataset(campDataset10);
		pay10.setPunto_misura("Punto1");
		pay10.setValore_misurato("3.5");
		puntiArray1.add(pay10);

		
		
		listaPayload.put("Punto1", puntiArray1);
		listaPayload.put("Punto2", puntiArray1);
		listaPayload.put("Punto3", puntiArray1);
		
		new TestReport2(listaDataset, listaPayload);
	}
	
	private JRDataSource createDataSource(ArrayList<CampionamentoDatasetDTO> listaDataset, HashMap<String, ArrayList<CampionamentoPlayloadDTO>> listaPayload) {
			
		
		ArrayList<String> listaString = new ArrayList<String>();

			

			for (CampionamentoDatasetDTO dataset : listaDataset) {
				listaString.add(dataset.getCodice_campo());
				
			
			}
			
			String[] listaCodici = new String[listaString.size()];
			
			for(int j=0; j < listaString.size(); j++) {
				listaCodici[j]=listaString.get(j).toString();
			}
			
			DRDataSource dataSource = new DRDataSource(listaCodici);
			
			Iterator it = listaPayload.entrySet().iterator();
		    while (it.hasNext()) {
		        Map.Entry pair = (Map.Entry)it.next();
		        
		        System.out.println(pair.getKey() + " = " + pair.getValue());
		        
		        ArrayList<CampionamentoPlayloadDTO> arrayPay = (ArrayList<CampionamentoPlayloadDTO>) pair.getValue();
		        ArrayList<String> arrayPs = new ArrayList<String>();
		        for (CampionamentoPlayloadDTO campionamentoPlayloadDTO : arrayPay) {
		        		arrayPs.add(campionamentoPlayloadDTO.getValore_misurato());

				}
		       
		         Object[] listaValori = arrayPs.toArray();
		        dataSource.add(listaValori);
		        it.remove(); // avoids a ConcurrentModificationException
		    }

 		      return dataSource;
 	}

}
