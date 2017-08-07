package it.portaleSTI.Util;


import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;
import static net.sf.dynamicreports.report.builder.DynamicReports.col;
 import static net.sf.dynamicreports.report.builder.DynamicReports.stl;
import static net.sf.dynamicreports.report.builder.DynamicReports.type;
import it.portaleSTI.DAO.SessionFacotryDAO;
 import it.portaleSTI.DTO.ReportPO005_DTO;

 
import java.io.File;
import java.io.InputStream;
 import java.util.ArrayList;
 import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
 import net.sf.dynamicreports.report.builder.DynamicReports;
 import net.sf.dynamicreports.report.builder.component.SubreportBuilder;
 import net.sf.dynamicreports.report.builder.style.StyleBuilder;
import net.sf.dynamicreports.report.constant.HorizontalTextAlignment;
import net.sf.dynamicreports.report.constant.SplitType;
import net.sf.dynamicreports.report.constant.VerticalTextAlignment;
 import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.data.JRMapCollectionDataSource;

import org.hibernate.HibernateException;
import org.hibernate.Session;
/**
 * @author markpagna
 */
public class TestReport2 {

	public TestReport2(LinkedHashMap<String, List<ReportPO005_DTO>> lista) {
		try {
			build(lista);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}

	private void build(LinkedHashMap<String, List<ReportPO005_DTO>> lista) throws JRException {
		
		InputStream is = null;

		Iterator<Entry<String, List<ReportPO005_DTO>>> itLista = lista.entrySet().iterator();
		while (itLista.hasNext()) {

			Map.Entry pair = (Map.Entry)itLista.next();
			String pivot = pair.getKey().toString();		
			List<ReportPO005_DTO> listItem = (List<ReportPO005_DTO>) pair.getValue();

			if(pivot.equals("1") || pivot.equals("1")){
				is = TestReport2.class.getResourceAsStream("schedaCampionamentoPO007HeaderSvt.jrxml");
			}




		}
	
		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.pen1Point()).setFontSize(8);//AGG
		


		JasperReportBuilder report = DynamicReports.report();
		
		
		StyleBuilder footerStyle = Templates.footerStyle.setFontSize(6).bold().setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE);
		StyleBuilder rootStyle = Templates.rootStyle.setFontSize(8).bold().setTextAlignment(HorizontalTextAlignment.CENTER, VerticalTextAlignment.MIDDLE);

		StyleBuilder footerStyleFormula = Templates.footerStyleFormula.setFontSize(4).bold().setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE);

		try {

	
			
			String temperatura = "20°C";
		
			Object imageHeader = new File("./WebContent/images/header.jpg");
			



			
			report.setTemplateDesign(is);
			report.setTemplate(Templates.reportTemplate);


			report.addParameter("dataPrelievo","xxxx");
			report.addParameter("codiceCommessa","yyyyy");
			report.addParameter("operatore","zzzzzzz");
			report.addParameter("titoloProcedura","PROCEDURA DI CAMPIONAMENTO PO-005");
			
 
			report.addParameter("logo",imageHeader);
			report.addParameter("logo2",imageHeader);
			
			report.setColumnStyle(textStyle); //AGG
			
			

			 Iterator<Entry<String, List<ReportPO005_DTO>>> it = lista.entrySet().iterator();
 
			while (it.hasNext()) {
				
 				
				Map.Entry pair = (Map.Entry)it.next();
				String pivot = pair.getKey().toString();
				
				List<ReportPO005_DTO> listItem = (List<ReportPO005_DTO>) pair.getValue();
				
				SubreportBuilder subreport = null;
 				subreport = cmp.subreport(getTableReport(listItem));
 
				report.detail(subreport);

 				report.detail(cmp.verticalGap(10));
				it.remove();
			}


		
			
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

	public JasperReportBuilder getTableReport(List<ReportPO005_DTO> listaReport){

		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.pen1Point()).setFontSize(7);//AGG
		
	 
		JasperReportBuilder report = DynamicReports.report();

		try {
			report.setTemplate(Templates.reportTemplate);
			report.setColumnStyle(textStyle); //AGG

 	

			  
			report.setColumnStyle(textStyle); //AGG
 			report.addColumn(col.column("Id campione", "idCampione", type.stringType()));

 			report.addColumn(col.column("Tipo Acque", "tipoAcque", type.stringType()));
 			report.addColumn(col.column("Procedura Campionamento", "proceduraCampionamento", type.stringType()));
			report.addColumn(col.column("Ora Prelievo", "oraPrelievo", type.stringType()));
			 
			report.addColumn(col.column("Quantità ", "quantitaPrelievo", type.stringType()));
			report.addColumn(col.column("Punto di Prelievo", "puntoPrelievo", type.stringType()));
			report.addColumn(col.column("PH", "ph", type.stringType()));
			report.addColumn(col.column("Conducibilità", "conducibilita", type.stringType()));
			report.addColumn(col.column("Temperatura", "temperatura", type.stringType()));
			report.addColumn(col.column("Cloro libero", "cloroLibero", type.stringType()));
			report.addColumn(col.column("Note", "note", type.stringType()));

			
			report.setDetailSplitType(SplitType.PREVENT);
			
			report.setDataSource(new JRBeanCollectionDataSource(listaReport));
	  
		} catch (Exception e) {
			e.printStackTrace();
		}
		return report;
	}
 

 
 

	public static void main(String[] args) throws HibernateException, Exception {
		
			 

		LinkedHashMap<String,List<ReportPO005_DTO>> listaTabelle = new LinkedHashMap<String, List<ReportPO005_DTO>>();
		
		 List<ReportPO005_DTO> datasource = new ArrayList<ReportPO005_DTO>();

			ReportPO005_DTO data = new ReportPO005_DTO();
			ReportPO005_DTO data2 = new ReportPO005_DTO();

		  	data.setIdCampione("23432");
		  	data.setTipoAcque("INDUSTRIALE");
		  	data.setProceduraCampionamento("procedura");
 		  	data.setOraPrelievo("ora");
 		  	data.setQuantitaPrelievo("quantità");
 		  	data.setPuntoPrelievo("puntodiprelievo");
		  	data.setPh("ph");
		  	data.setConducibilita("conducibilità");
		  	data.setTemperatura("temperatura");
		  	data.setCloroLibero("clorolibero");
		  	data.setNote("note");

		  	datasource.add(data);
		  	
		  	data2.setIdCampione("23432");
		  	data2.setTipoAcque("INDUSTRIALE");
		  	data2.setProceduraCampionamento("procedura");
 		  	data2.setOraPrelievo("ora");
 		  	data2.setQuantitaPrelievo("quantità");
 		  	data2.setPuntoPrelievo("puntodiprelievo");
		  	data2.setPh("ph");
		  	data2.setConducibilita("conducibilità");
		  	data2.setTemperatura("temperatura");
		  	data2.setCloroLibero("clorolibero");
		  	data2.setNote("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris n");
		  	
		  	
		  	datasource.add(data2);
		  	datasource.add(data2);
		  	datasource.add(data2);
		  	datasource.add(data2);
		  	datasource.add(data2);
		  	datasource.add(data2);
		  

		  	
		  	listaTabelle.put("1",datasource);	
		  	
	 
			 
		new TestReport2(listaTabelle);
	}
}
