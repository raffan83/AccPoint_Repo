package it.portaleSTI.Util;


import static net.sf.dynamicreports.report.builder.DynamicReports.*;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
import net.sf.dynamicreports.report.base.expression.AbstractSimpleExpression;
import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.dynamicreports.report.builder.component.SubreportBuilder;
import net.sf.dynamicreports.report.builder.style.StyleBuilder;
import net.sf.dynamicreports.report.definition.ReportParameters;
import net.sf.dynamicreports.report.exception.DRException;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.data.JRMapCollectionDataSource;

/**
 * @author Ricardo Mariaca (r.mariaca@dynamicreports.org)
 */
public class TestReport {

	public TestReport() {
		try {
			build();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private void build() throws JRException {
	//	public JasperReportBuilder build() throws Exception {

	
		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.pen1Point());//AGG
		
		SubreportBuilder subreport = cmp.subreport(getTableReport()).setDataSource(new SubreportData());

		SubreportBuilder subreport1 = cmp.subreport(new SubreportDesign()).setDataSource(new SubreportData());

		JasperReportBuilder report = DynamicReports.report();

		try {
			report.setTemplate(Templates.reportTemplate);
			report.title(Templates.createTitleComponent("JasperSubreport"),cmp.subreport(getJasperTitleSubreport()));
			report.fields(field("comments", List.class));
			  
			report.setColumnStyle(textStyle); //AGG
			  
//			report.columns(
//			  	col.column("Item", "item", type.stringType()),
//			  	col.column("Quantity", "quantity", type.integerType()),
//			  	col.componentColumn("Comments", subreport));
			report.detailFooter(cmp.verticalList(cmp.verticalGap(100),subreport,cmp.verticalGap(100),subreport1,cmp.verticalGap(100)));
			//report.detailFooter(cmp.horizontalList(cmp.horizontalGap(100),subreport,cmp.horizontalGap(100)));

			  //report.title(Templates.createTitleComponent("ColumnSubreportData"));
			  report.pageFooter(Templates.footerComponent);
			  report.setDataSource(createDataSource());
			  report.show();
			  
		} catch (Exception e) {
			e.printStackTrace();
		}
		//return report;
	}

	public JasperReportBuilder getTableReport(){

		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.pen1Point());//AGG
		
		SubreportBuilder subreport = cmp.subreport(new SubreportDesign()).setDataSource(new SubreportData());
		JasperReportBuilder report = DynamicReports.report();

		try {
			report.setTemplate(Templates.reportTemplate);
			//report.title(Templates.createTitleComponent("JasperSubreport"),cmp.subreport(getJasperTitleSubreport()));
			report.fields(field("comments", List.class));
			  
			report.setColumnStyle(textStyle); //AGG
			  
			report.columns(
			  	col.column("Item", "item", type.stringType()),
			  	col.column("Quantity", "quantity", type.integerType()),
			  	col.componentColumn("Comments", subreport));
			
			report.detailFooter(cmp.horizontalList(cmp.horizontalGap(10),subreport,cmp.horizontalGap(10)));
			
			  //report.title(Templates.createTitleComponent("ColumnSubreportData"));
			//  report.pageFooter(Templates.footerComponent);
			  report.setDataSource(createDataSource());
			  //report.show();
			  
		} catch (Exception e) {
			e.printStackTrace();
		}
		return report;
	}
	
	private class SubreportDesign extends AbstractSimpleExpression<JasperReportBuilder> {
		private static final long serialVersionUID = 1L;

		@Override
		public JasperReportBuilder evaluate(ReportParameters reportParameters) {
			JasperReportBuilder report = report()
				.columns(col.column("comment", type.stringType()).setStyle(stl.style(stl.pen1Point())));
			return report;
		}
	}

	private class SubreportData extends AbstractSimpleExpression<JRDataSource> {
		private static final long serialVersionUID = 1L;

		@Override
		public JRDataSource evaluate(ReportParameters reportParameters) {
			Collection<Map<String, ?>> value = reportParameters.getValue("comments");
			return new JRMapCollectionDataSource(value);
		}
	}

	private JasperReport getJasperTitleSubreport() throws JRException {
		InputStream is = TestReport.class.getResourceAsStream("schedaVerificaHeaderSvt_.jrxml");
		return JasperCompileManager.compileReport(is);
		
	}
  private JRDataSource createDataSource() {
  	List<ReportData> datasource = new ArrayList<ReportData>();

  	ReportData data = new ReportData();
  	List<Map<String, Object>> comments = new ArrayList<Map<String, Object>>();
  	Map<String, Object> values = new HashMap<String, Object>();
  	values.put("comment", "comment1");
  	comments.add(values);
  	values = new HashMap<String, Object>();
  	values.put("comment", "comment2");
  	comments.add(values);
  	values = new HashMap<String, Object>();
  	values.put("comment", "comment3");
  	comments.add(values);
  	data.setItem("Book");
  	data.setQuantity(new Integer(10));
  	data.setComments(comments);
  	datasource.add(data);

  	data = new ReportData();
  	comments = new ArrayList<Map<String, Object>>();
  	values = new HashMap<String, Object>();
  	values.put("comment", "comment1");
  	comments.add(values);
  	values = new HashMap<String, Object>();
  	values.put("comment", "comment2");
  	comments.add(values);
  	data.setItem("Notebook");
  	data.setQuantity(new Integer(20));
  	data.setComments(comments);
  	datasource.add(data);

		return new JRBeanCollectionDataSource(datasource);
	}

	public class ReportData {
		private String item;
		private Integer quantity;
		private List<Map<String, Object>> comments;

		public String getItem() {
			return item;
		}

		public void setItem(String item) {
			this.item = item;
		}

		public Integer getQuantity() {
			return quantity;
		}

		public void setQuantity(Integer quantity) {
			this.quantity = quantity;
		}

		public List<Map<String, Object>> getComments() {
			return comments;
		}

		public void setComments(List<Map<String, Object>> comments) {
			this.comments = comments;
		}
	}

	public static void main(String[] args) {
		new TestReport();
	}
}