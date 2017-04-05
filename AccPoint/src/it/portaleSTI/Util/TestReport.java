package it.portaleSTI.Util;


import static net.sf.dynamicreports.report.builder.DynamicReports.*;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.net.URL;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.ReportSVT_DTO;
import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
import net.sf.dynamicreports.report.base.expression.AbstractSimpleExpression;
import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.dynamicreports.report.builder.component.Components;
import net.sf.dynamicreports.report.builder.component.ImageBuilder;
import net.sf.dynamicreports.report.builder.component.SubreportBuilder;
import net.sf.dynamicreports.report.builder.component.TextFieldBuilder;
import net.sf.dynamicreports.report.builder.style.StyleBuilder;
import net.sf.dynamicreports.report.constant.HorizontalAlignment;
import net.sf.dynamicreports.report.constant.HorizontalTextAlignment;
import net.sf.dynamicreports.report.constant.ImageScale;
import net.sf.dynamicreports.report.constant.LineDirection;
import net.sf.dynamicreports.report.constant.SplitType;
import net.sf.dynamicreports.report.constant.VerticalTextAlignment;
import net.sf.dynamicreports.report.datasource.DRDataSource;
import net.sf.dynamicreports.report.definition.ReportParameters;
import net.sf.dynamicreports.report.exception.DRException;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.data.JRMapCollectionDataSource;

import it.portaleSTI.Util.Costanti;
/**
 * @author Ricardo Mariaca (r.mariaca@dynamicreports.org)
 */
public class TestReport {

	public TestReport(HashMap<String, List<ReportSVT_DTO>> lista, List<CampioneDTO> listaCampioni, DRDataSource listaProcedure) {
		try {
			build(lista, listaCampioni, listaProcedure);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}

	private void build(HashMap<String, List<ReportSVT_DTO>> lista, List<CampioneDTO> listaCampioni, DRDataSource listaProcedure) throws JRException {
		
		
		
		

	
		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.pen1Point()).setFontSize(8);//AGG
		


		JasperReportBuilder report = DynamicReports.report();
		InputStream is = TestReport.class.getResourceAsStream("schedaVerificaHeaderSvt.jrxml");
		
		SubreportBuilder campioniSubreport = cmp.subreport(getTableCampioni(listaCampioni));
		
		SubreportBuilder procedureSubreport = cmp.subreport(getTableProcedure(listaProcedure));
	
		StyleBuilder styleTitleBold = Templates.rootStyle.setFontSize(10).bold().setTextAlignment(HorizontalTextAlignment.CENTER, VerticalTextAlignment.MIDDLE);


		TextFieldBuilder rifTextfield = cmp.text("Riferimenti Utilizzati e Metodo di Taratura");
		rifTextfield.setStyle(styleTitleBold);
	
		TextFieldBuilder ristTextfield = cmp.text("RISULTATI DELLA VERIFICA DI TARATURA");
		ristTextfield.setStyle(styleTitleBold);
		
		StyleBuilder footerStyle = Templates.footerStyle.setFontSize(6).bold().setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE);
		StyleBuilder rootStyle = Templates.rootStyle.setFontSize(8).bold().setTextAlignment(HorizontalTextAlignment.CENTER, VerticalTextAlignment.MIDDLE);

		StyleBuilder footerStyleFormula = Templates.footerStyleFormula.setFontSize(4).bold().setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE);

		try {

			FileInputStream stream1 = new FileInputStream(new File("/Users/marcopagnanelli/gitSite/AccPoint/AccPoint/WebContent/images/libri.jpg"));
			FileInputStream stream2 = new FileInputStream(new File("/Users/marcopagnanelli/gitSite/AccPoint/AccPoint/WebContent/images/libri.jpg"));
			
			FileInputStream streamFormula = new FileInputStream(new File("/Users/marcopagnanelli/gitSite/AccPoint/AccPoint/WebContent/images/libri.jpg"));

			
			report.setTemplateDesign(is);
			report.setTemplate(Templates.reportTemplate);
			//report.pageHeader(Templates.createTitleComponent("JasperSubreport"),cmp.subreport(getJasperTitleSubreport()));

			report.addParameter("denominazione","BOHH");
			report.addParameter("logo",stream1);
			report.addParameter("logo2",stream2);
			
			report.setColumnStyle(textStyle); //AGG
			
			
			/*
			 * Dettaglio Campioni Utilizzati
			 */
			report.detail(rifTextfield);
			report.detail(cmp.verticalGap(5));
			
			report.detail(cmp.horizontalList(cmp.horizontalGap(20),campioniSubreport,cmp.horizontalGap(20),procedureSubreport,cmp.horizontalGap(20)));
			report.detail(cmp.verticalGap(5));

			/*
			 * Dettaglio Procedure
			 */
			
//			report.detail(procedureSubreport);
			report.detail(cmp.verticalGap(10));
			report.detail(cmp.line());
			report.detail(cmp.verticalGap(1));
			report.detail(cmp.line());
			report.detail(cmp.verticalGap(10));
			
			report.detail(ristTextfield);
			report.detail(cmp.verticalGap(10));
			
			 Iterator it = lista.entrySet().iterator();
			while (it.hasNext()) {
				Map.Entry pair = (Map.Entry)it.next();
				String pivot = pair.getKey().toString();
				
				List<ReportSVT_DTO> listItem = (List<ReportSVT_DTO>) pair.getValue();
				
				SubreportBuilder subreport = null;
				if(pivot.equals("R_S")){
					subreport = cmp.subreport(getTableReportRip(listItem, "SVT"));
				}
				if(pivot.equals("R_R")){
					subreport = cmp.subreport(getTableReportRip(listItem, "RDT"));
				}
				if(pivot.equals("L_S")){
					subreport = cmp.subreport(getTableReportLin(listItem, "SVT"));
				}
				if(pivot.equals("L_R")){
					subreport = cmp.subreport(getTableReportLin(listItem, "RDT"));
				}
				report.detail(subreport);
				report.detail(cmp.verticalGap(10));
				it.remove();
			}


			report.pageFooter(cmp.verticalList(
					cmp.line(),
					cmp.horizontalList(
							cmp.text("MOD-LAB-003").setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setFixedWidth(100).setStyle(footerStyle),
							cmp.pageXslashY(),
							cmp.text("Rev. A del 01/06/2011").setHorizontalTextAlignment(HorizontalTextAlignment.RIGHT).setFixedWidth(100).setStyle(footerStyle)
							)
					)
				);
			
			report.lastPageFooter(cmp.verticalList(
					cmp.line(),	
					cmp.verticalGap(1),
					cmp.line(),	
					cmp.horizontalList(
							
						cmp.verticalList(
							cmp.text("Incertezza associata allo strumento").setStyle(footerStyle),
							cmp.horizontalList(
									cmp.image("/Users/marcopagnanelli/gitSite/AccPoint/AccPoint/WebContent/images/logo_acc_bg.jpg"),
									cmp.text("3,47 um").setHorizontalTextAlignment(HorizontalTextAlignment.CENTER)
								),
							cmp.text("L'incertezze di misura dichiarate in questo documento sono espresse come due volte lo scarto tipo (corrispondente, nel caso di distribuzione normale, ad un livellodi confidenza di circa 95%)").setStyle(footerStyleFormula),
							cmp.line(),	
							cmp.horizontalList(
									cmp.verticalList(
											cmp.text("Esito della verifica:").setStyle(footerStyle),
											cmp.text("(U < Accettabilità)").setStyle(footerStyle)
									),
									cmp.text("IDONEO").setStyle(footerStyle))
							)
						,
						cmp.line(),	
						cmp.verticalList(
							cmp.text("Note:").setStyle(footerStyle),
							cmp.text("Lorem ipsum dolor sitLorem ipsum dolor sit amet,  elit, sed do eiusmod tempor iLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor iLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor iLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor iLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor i amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut la cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum").setStyle(footerStyleFormula),
							cmp.line().setDirection(LineDirection.TOP_DOWN),
							cmp.horizontalList(
									cmp.verticalList(cmp.text("Operatore (OT)").setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),cmp.text("Sig. Stefano Lucarelli").setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER)),
									cmp.line(),
									cmp.verticalList(cmp.text("Responsabile Laboratorio (RL)").setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER),cmp.text("Sig. Terenzio Fantauzzi").setStyle(footerStyle).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER))
									)
							
							)
					),

					cmp.line(),
					
					cmp.horizontalList(
						cmp.text("MOD-LAB-003").setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setFixedWidth(100).setStyle(footerStyle),
						cmp.pageXslashY(),
						cmp.text("Rev. A del 01/06/2011").setHorizontalTextAlignment(HorizontalTextAlignment.RIGHT).setFixedWidth(100).setStyle(footerStyle)
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

	public JasperReportBuilder getTableReportRip(List<ReportSVT_DTO> listaReport, String tipoProva){

		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.pen1Point()).setFontSize(8);//AGG
		
		SubreportBuilder subreport = cmp.subreport(new SubreportDesign("tv")).setDataSource(new SubreportData("tipoVerifica"));
		SubreportBuilder subreportUM = cmp.subreport(new SubreportDesign("um")).setDataSource(new SubreportData("unitaDiMisura"));
		SubreportBuilder subreportVC = cmp.subreport(new SubreportDesign("vc")).setDataSource(new SubreportData("valoreCampione"));
		SubreportBuilder subreportVS = cmp.subreport(new SubreportDesign("vs")).setDataSource(new SubreportData("valoreStrumento"));

		JasperReportBuilder report = DynamicReports.report();

		try {
			report.setTemplate(Templates.reportTemplate);
			report.setColumnStyle(textStyle); //AGG

			report.fields(field("tipoVerifica", List.class),field("unitaDiMisura", List.class),field("valoreCampione", List.class),field("valoreStrumento", List.class));
			  
			report.setColumnStyle(textStyle); //AGG
		
			report.addColumn(col.componentColumn("Tipo Verifica", subreport));
			report.addColumn(col.componentColumn("UM", subreportUM));
			report.addColumn(col.componentColumn("Valore Campione", subreportVC));
			report.addColumn(col.column("Valore Medio Campione", "valoreMedioCampione", type.stringType()));
			report.addColumn(col.componentColumn("Valore Strumento", subreportVS));
			report.addColumn(col.column("Valore Medio Strumento", "valoreMedioStrumento", type.stringType()));
			if(tipoProva.equals("SVT")){
				report.addColumn(col.column("sc", "scostamento_correzione", type.stringType()));

			}else{
				report.addColumn(col.column("corr", "scostamento_correzione", type.stringType()));
			}
			report.addColumn(col.column("Accettabilità", "accettabilita", type.stringType()));
			report.addColumn(col.column("Incertezza U", "incertezza", type.stringType()));
			report.addColumn(col.column("ESITO", "esito", type.stringType()));

			report.setDataSource(new JRBeanCollectionDataSource(listaReport));
	  
		} catch (Exception e) {
			e.printStackTrace();
		}
		return report;
	}
	public JasperReportBuilder getTableReportLin(List<ReportSVT_DTO> listaReport, String tipoProva){

		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.pen1Point()).setFontSize(8);//AGG
		
		SubreportBuilder subreport = cmp.subreport(new SubreportDesign("tv")).setDataSource(new SubreportData("tipoVerifica"));
		SubreportBuilder subreportUM = cmp.subreport(new SubreportDesign("um")).setDataSource(new SubreportData("unitaDiMisura"));
		SubreportBuilder subreportVC = cmp.subreport(new SubreportDesign("vc")).setDataSource(new SubreportData("valoreCampione"));
		SubreportBuilder subreportVS = cmp.subreport(new SubreportDesign("vs")).setDataSource(new SubreportData("valoreStrumento"));

		JasperReportBuilder report = DynamicReports.report();

		try {
			report.setTemplate(Templates.reportTemplate);
			report.setColumnStyle(textStyle); //AGG

			report.fields(field("tipoVerifica", List.class),field("unitaDiMisura", List.class),field("valoreCampione", List.class),field("valoreStrumento", List.class));
			  
			report.setColumnStyle(textStyle); //AGG
		
			report.addColumn(col.componentColumn("Tipo Verifica", subreport));
			report.addColumn(col.componentColumn("UM", subreportUM));
			report.addColumn(col.componentColumn("Valore Campione", subreportVC));
			report.addColumn(col.column("Valore Medio Campione", "valoreMedioCampione", type.stringType()));
			report.addColumn(col.componentColumn("Valore Strumento", subreportVS));
			report.addColumn(col.column("Valore Medio Strumento", "valoreMedioStrumento", type.stringType()));
			if(tipoProva.equals("SVT")){
				report.addColumn(col.column("sc", "scostamento_correzione", type.stringType()));

			}else{
				report.addColumn(col.column("corr", "scostamento_correzione", type.stringType()));
			}
			report.addColumn(col.column("Accettabilità", "accettabilita", type.stringType()));
			report.addColumn(col.column("Incertezza U", "incertezza", type.stringType()));
			report.addColumn(col.column("ESITO", "esito", type.stringType()));

			report.setDataSource(new JRBeanCollectionDataSource(listaReport));
	  
		} catch (Exception e) {
			e.printStackTrace();
		}
		return report;
	}

	public JasperReportBuilder getTableCampioni(List<CampioneDTO> listaCampioni){

		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.pen1Point()).setFontSize(8);//AGG
	
		JasperReportBuilder report = DynamicReports.report();

		try {
			report.setTemplate(Templates.reportTemplate);

			  
			report.setColumnStyle(textStyle); //AGG
		
			report.addColumn(col.column("Campione", "codice", type.stringType()));
			report.addColumn(col.column("Data Scandenza", "dataScadenza", type.dateType()));
		

			report.setDataSource(new JRBeanCollectionDataSource(listaCampioni));
	  
		} catch (Exception e) {
			e.printStackTrace();
		}
		return report;
	}

	public JasperReportBuilder getTableProcedure(DRDataSource listaProcedure){

		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.pen1Point()).setFontSize(8);//AGG
	
		JasperReportBuilder report = DynamicReports.report();

		try {
			report.setTemplate(Templates.reportTemplate);

			  
			report.setColumnStyle(textStyle); //AGG


			report.addColumn(col.column("Procedura di Taratura","listaProcedure", type.stringType()));

			
			report.setDataSource(listaProcedure);
	  
		} catch (Exception e) {
			e.printStackTrace();
		}
		return report;
	}
	

	
	private class SubreportDesign extends AbstractSimpleExpression<JasperReportBuilder> {
		private static final long serialVersionUID = 1L;
		private String _tipo;
		public SubreportDesign(String tipo) {
			_tipo = tipo;
		}

		@Override
		public JasperReportBuilder evaluate(ReportParameters reportParameters) {
			JasperReportBuilder report = report()
				.columns(col.column(_tipo, type.stringType()).setStyle(stl.style(stl.pen1Point()).setFontSize(8).setPadding(2)));
			return report;
		}
	}
	

	private class SubreportData extends AbstractSimpleExpression<JRDataSource> {
		private static final long serialVersionUID = 1L;
		private String _tipo;
		public SubreportData(String tipo) {
			_tipo = tipo;
		}

		@Override
		public JRDataSource evaluate(ReportParameters reportParameters) {
			Collection<Map<String, ?>> value = reportParameters.getValue(_tipo);
			return new JRMapCollectionDataSource(value);
		}
	}


	  private JRDataSource createDataSourceAll() {
		  List<Object> datasource = new ArrayList<Object>();
		  	datasource.add(new ReportSVT_DTO());

		//return new JRBeanCollectionDataSource(datasource);
		
		 return new JREmptyDataSource(2);
	  }



	public static void main(String[] args) {
		
		HashMap<String,List<ReportSVT_DTO>> listaTabelle = new HashMap<String, List<ReportSVT_DTO>>();
		
		 List<ReportSVT_DTO> datasource = new ArrayList<ReportSVT_DTO>();
		  	
			Map<String, Object> values = new HashMap<String, Object>();



			ReportSVT_DTO data = new ReportSVT_DTO();
		  	
			List<Map<String, Object>> comments = new ArrayList<Map<String, Object>>();
		  	values.put("tv", "comment1");
		  	comments.add(values);
		  	values = new HashMap<String, Object>();
		  	values.put("tv", "comment2");
		  	comments.add(values);
		  	values = new HashMap<String, Object>();
		  	values.put("tv", "comment3");
		  	comments.add(values);

		  	
		  	
		  	List<Map<String, Object>> ums = new ArrayList<Map<String, Object>>();
		  	values = new HashMap<String, Object>();
		  	
		  	values.put("um", "um1");
		  	ums.add(values);
		  	values = new HashMap<String, Object>();
		  	values.put("um", "um2");
		  	ums.add(values);
		  	values = new HashMap<String, Object>();
		  	values.put("um", "um3");
		  	ums.add(values);
		  	
		  	
		  	List<Map<String, Object>> vcs = new ArrayList<Map<String, Object>>();
		  	values = new HashMap<String, Object>();
		  	
		  	values.put("vc", "0,5");
		  	vcs.add(values);
		  	values = new HashMap<String, Object>();
		  	values.put("vc", "0,5");
		  	vcs.add(values);
		  	values = new HashMap<String, Object>();
		  	values.put("vc", "0,5");
		  	vcs.add(values);
		  	
		  	
		  	List<Map<String, Object>> vss = new ArrayList<Map<String, Object>>();
		  	values = new HashMap<String, Object>();
		  	
		  	values.put("vs", "0,5");
		  	vss.add(values);
		  	values = new HashMap<String, Object>();
		  	values.put("vs", "0,5");
		  	vss.add(values);
		  	values = new HashMap<String, Object>();
		  	values.put("vs", "0,5");
		  	vss.add(values);
		  	
		  	
		  	data.setTipoVerifica(comments);
		  	data.setUnitaDiMisura(ums);
		  	data.setValoreCampione(vcs);
		  	data.setValoreMedioCampione("0,5");
		  	data.setValoreStrumento(vss);
		  	data.setValoreMedioStrumento("0,498");
		  	data.setScostamento_correzione("0,002");
		  	data.setAccettabilita("0,004");
		  	data.setIncertezza("0,001");
		  	data.setEsito("IDONEO");
		  	
		  	datasource.add(data);
		  	datasource.add(data);
		  	datasource.add(data);
		  	datasource.add(data);
		  	datasource.add(data);
		  	datasource.add(data);
		  	
		  	listaTabelle.put("R_S",datasource);
			listaTabelle.put("L_S",datasource);


			
			
			List<CampioneDTO> listaCampioni = new ArrayList<CampioneDTO>();

			CampioneDTO campione = new CampioneDTO();
			campione.setCodice("Campione 1");
			campione.setDataScadenza(new Date());
			listaCampioni.add(campione);
			campione = new CampioneDTO();
			campione.setCodice("Campione 2");
			campione.setDataScadenza(new Date());
			listaCampioni.add(campione);
			

			
			  DRDataSource listaProcedure = new DRDataSource("listaProcedure");
				 
			  listaProcedure.add("Procedura1");
			  listaProcedure.add("Procedura2");
			  listaProcedure.add("Procedura3");
			
		new TestReport(listaTabelle, listaCampioni, listaProcedure);
	}
}