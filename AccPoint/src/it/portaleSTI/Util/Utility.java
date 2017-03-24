package it.portaleSTI.Util;
import it.portaleSTI.DTO.MisuraDTO;

import java.awt.Color;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import ar.com.fdvs.dj.core.DynamicJasperHelper;
import ar.com.fdvs.dj.core.layout.ClassicLayoutManager;
import ar.com.fdvs.dj.domain.DynamicReport;
import ar.com.fdvs.dj.domain.Style;
import ar.com.fdvs.dj.domain.builders.FastReportBuilder;
import ar.com.fdvs.dj.domain.constants.Border;
import ar.com.fdvs.dj.domain.constants.Transparency;
import it.portaleSTI.DTO.MisuraDTO;
import net.sf.dynamicreports.report.builder.column.TextColumnBuilder;
import net.sf.dynamicreports.report.builder.style.StyleBuilder;
import net.sf.dynamicreports.report.constant.HorizontalAlignment;
import net.sf.dynamicreports.report.exception.DRException;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import net.sf.jasperreports.view.JasperViewer;
import static net.sf.dynamicreports.report.builder.DynamicReports.*;

public class Utility extends HttpServlet {

	public static String getNomeFile(String memo) {

		if(memo!=null)
		{
			int indexStart=memo.indexOf("<name>");
			int indexEnd=memo.indexOf("</name>");

			memo=memo.substring(indexStart+6,indexEnd);
			return memo;
		}
		else
		{
			return "";
		}
	}

	public static  void copiaFile(String origine, String destinazione)throws Exception
	{
		FileInputStream fis = new FileInputStream(origine);
		FileOutputStream fos = new FileOutputStream(destinazione);

		byte [] dati = new byte[fis.available()];
		fis.read(dati);
		fos.write(dati);

		fis.close();
		fos.close();
	}
	
	public static void generateZipSTI(String path, String archiveName) throws Exception {
		File[] child = new File(path).listFiles();
		ZipOutputStream zip = new ZipOutputStream(new BufferedOutputStream(new FileOutputStream(Costanti.PATH_FOLDER+"\\"+archiveName)));
		
		FileInputStream fis=null;
	//	zip.putNextEntry(new ZipEntry("viewerSTI.jar"));
	//	FileInputStream fis = new FileInputStream(Costanti.PATH_SOURCE_FORM+"//viewerSTI.jar");
		byte[] readBuffer =null;//new byte[fis.available()];
		
	//	fis.read(readBuffer);
	//	zip.write(readBuffer);
	//	fis.close();
	//	for(int i = 0; i < child.length; i++)
	//	{
			
			zip.putNextEntry(new ZipEntry(child[0].getName()));
			fis = new FileInputStream(child[0]);
			readBuffer =new byte[fis.available()];
			fis.read(readBuffer);
			zip.write(readBuffer);
			fis.close();
			child[0].delete();
			
		//}
		zip.close(); 

	}

	public static boolean checkSession(HttpSession session, String att) {

		if(session.getAttribute(att)!=null)
		{
			return true;
		}
		return false;
	}

	public static boolean validateSession(HttpServletRequest request,HttpServletResponse response, ServletContext servletContext) throws ServletException, IOException {
		
		if (request.getSession().getAttribute("userObj")==null ) {
			
		RequestDispatcher dispatcher = servletContext.getRequestDispatcher("/site/sessionDown.jsp");
     	dispatcher.forward(request,response);
     	
     	return true;
		}
		return false;
	}
	
	public static String checkStringNull(String value) {
		
		if (value==null) {
			
			return "-";
		}
		return value;
	}
	
	public static String checkFloatNull(Float value) {
		
		if (value==null) {
			
			return "-";
		}
		return value.toString();
	}
	public static String checkIntegerNull(Integer value) {
		
		if (value==null) {
			
			return "-";
		}
		return value.toString();
	}
	public static String checkDateNull(Date value) {
		
		if (value==null) {
			
			return "-";
		}
		SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy");
		
		return sdf.format(value);
	}

	public static String getVarchar(String string) {
		
		if(string==null)
		{
			return "";
		}
		else
		{
			string=string.replaceAll("\"", "");
			string=string.replaceAll("\'", "");
		}
		return string;
	}	
	
	public static void StampaJasper()
	throws IOException, ServletException
	{
		try{
	
			Map<String,Object> parameters = new HashMap<String,Object>(); 
			
		//	JasperDesign jasperDesign = JRXmlLoader.load("//server/captureSV/report/source/report_statistiche_1.jrxml");
		   
			  //compilazione del file e generazione del file JASPER
		//    JasperCompileManager.compileReportToFile(jasperDesign,"//server/captureSV/report/source/report_statistiche_1.jasper");
		    
		    ArrayList misure=getMisure();
		    
		    JRBeanCollectionDataSource coll = new JRBeanCollectionDataSource(misure);
		    
		    parameters.put("th1", "Tipo Verifica");
		    parameters.put("th2", "Unità di misura");
		    parameters.put("th3", "Valore Campione");
		    parameters.put("th4", "Valore medio Campione");
		    parameters.put("th5", "Valore Strumento");
		    parameters.put("th6", "Valore medio Strumento");
		    parameters.put("th7", "sc");
		    parameters.put("th8", "Accettibilità");
		    parameters.put("th9", "Incertezza U");
		    parameters.put("th10", "ESITO");
		    
		    
			 JasperDesign jasperDesign = JRXmlLoader.load("/Users/marcopagnanelli/Downloads/Jasper/report_statistiche_1.jrxml");


			 JasperCompileManager.compileReportToFile(jasperDesign,"/Users/marcopagnanelli/Downloads/Jasper/report_statistiche_1.jasper");

			
		    
		   
		    //rendering e generazione del file PDF
		    //JasperPrint jp = JasperFillManager.fillReport("/Users/marcopagnanelli/Downloads/Jasper/report_statistiche_1.jasper", parameters,coll);
						   
		    //JasperExportManager.exportReportToPdfFile(jp,"/Users/marcopagnanelli/Downloads/Jasper/report.pdf");

			 
//			 Style oddRowStyle = new Style();
//			 oddRowStyle.setBorder(Border.PEN_1_POINT());
//			 Color veryLightGrey = new Color(230,230,230);
//			 oddRowStyle.setBackgroundColor(veryLightGrey);
//			 oddRowStyle.setTransparency(Transparency.OPAQUE);
//			
//			FastReportBuilder drb = new FastReportBuilder();
//			DynamicReport dr = drb.addColumn("Tipo Verifica", "tipoVerifica", String.class.getName(),30)
//			.addColumn("Unità di misura", "um", String.class.getName(),30)
//			.addColumn("Valore Campione", "valoreCampione", String.class.getName(),50)
//			.addColumn("Valore medio Campione", "valoreMedioCampione", String.class.getName(),50,true)
//			.addColumn("Valore Strumento", "valoreStrumento", String.class.getName(),30,true)
//			.addColumn("Valore medio Strumento", "valoreMedioStrumento", String.class.getName(),60,true)
//			.addColumn("sc", "scostamento", String.class.getName(),70,true)
//			.addColumn("Accettabilità", "accettabilita", String.class.getName(),70,true)
//			.addColumn("Incertezza", "incertezza", String.class.getName(),70,true)
//			.addColumn("Esito", "esito", String.class.getName(),70,true)
//			.setTitle("November 2006 sales report")
//			.setSubtitle("This report was generated at " + new Date())
//			.setPrintBackgroundOnOddRows(true)
//			.setUseFullPageWidth(true)
//			.setOddRowBackgroundStyle(oddRowStyle)
//	        
//			.build();
//
//			JRDataSource ds = new JRBeanCollectionDataSource(misure);
//			JasperPrint jpx = DynamicJasperHelper.generateJasperPrint(dr, new ClassicLayoutManager(), ds);
			//JasperViewer.viewReport(jpx);    //finally display the report report
			 StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.pen1Point());
			 StyleBuilder boldStyle         = stl.style().bold();  
			 StyleBuilder boldCenteredStyle = stl.style(boldStyle).setHorizontalAlignment(HorizontalAlignment.CENTER);	 
			 StyleBuilder columnTitleStyle  = stl.style(boldCenteredStyle).setBorder(stl.pen1Point()).setBackgroundColor(Color.LIGHT_GRAY);
		     
			 TextColumnBuilder<String>     tipoVerifica       	= col.column("Tipo Verifica", "tipoVerifica",type.stringType());		     
		      TextColumnBuilder<String>     um       			= col.column("Unità di misura", "um",type.stringType());		     
		      TextColumnBuilder<String>     valoreCampione      = col.column("Valore Campione", "valoreCampione",type.stringType());		     
		      TextColumnBuilder<String>     valoreMedioCampione = col.column("Valore medio Campione", "valoreMedioCampione",type.stringType());		     
		      TextColumnBuilder<String>     valoreStrumento     = col.column("Valore Strumento", "valoreStrumento",type.stringType());		     
		      TextColumnBuilder<String>     valoreMedioStrumento = col.column("Valore medio Strumento", "valoreMedioStrumento",type.stringType());		     
		      TextColumnBuilder<String>     accettabilita       = col.column("Accettabilità", "accettabilita",type.stringType());		     
		      TextColumnBuilder<String>     scostamento       	= col.column("Scostamento", "scostamento",type.stringType());		     
		      TextColumnBuilder<String>     incertezza       	= col.column("Incertezza", "incertezza",type.stringType());		     
		      TextColumnBuilder<String>     esito       		= col.column("Esito", "esito",type.stringType());		     

		     // tipoVerifica.setPrintRepeatedDetailValues(false);
		      tipoVerifica.setFixedColumns(3);
			 
			 
			 try {
					         report()
					         .setTemplate(Templates.reportTemplate)
					         .setColumnStyle(textStyle)
					         .columns(tipoVerifica,um,valoreCampione,
					        		 valoreMedioCampione,valoreStrumento,
					        		 valoreMedioStrumento,accettabilita,
					        		 scostamento,incertezza,esito		 
					        )
					         
					        /* .columnGrid(
					        		grid.horizontalColumnGridList(
					        				tipoVerifica/*,
					        				grid.verticalColumnGridList(
							        		 valoreMedioCampione,um,valoreCampione),
					        				grid.verticalColumnGridList(valoreStrumento,
					        						grid.horizontalColumnGridList(valoreMedioStrumento,accettabilita),
							        		 scostamento,incertezza,esito	
					        		)))*/

					         .title(cmp.text("Ripetibilità"))//shows report title

				.setDataSource(misure)
				
				 .show();
					 } catch (DRException e) {
						 e.printStackTrace();
				 }
			 
			 
		    //JasperExportManager.exportReportToPdfFile(jp,"/Users/marcopagnanelli/Downloads/Jasper/report.pdf");

		} 
		catch(Exception ex)
		{
			if(ex instanceof IllegalStateException)
			{
				
			}
			else
			{
			ex.printStackTrace();

			}
		}  
	}
	
	
	private static ArrayList getMisure() {
		
		ArrayList<MisuraDTO> listaMisure = new ArrayList<>();
		
		MisuraDTO misura = new MisuraDTO();
		misura.setTipoVerifica("Punto1");
		misura.setUm("mm");
		misura.setValoreCampione("0,5");
		misura.setValoreMedioCampione("0,5");
		misura.setValoreStrumento("0,499");
		misura.setValoreMedioStrumento("0,498");
		misura.setScostamento("0,002");
		misura.setAccettabilita("0,004");
		misura.setIncertezza("0,001");
		misura.setEsito("IDONEO");
		listaMisure.add(misura);
		
		misura.setTipoVerifica("Punto2");
		misura.setUm("mm");
		misura.setValoreCampione("0,5");
		misura.setValoreMedioCampione("0,5");
		misura.setValoreStrumento("0,497");
		misura.setValoreMedioStrumento("0,498");
		misura.setScostamento("0,002");
		misura.setAccettabilita("0,004");
		misura.setIncertezza("0,001");
		misura.setEsito("IDONEO");
		
		listaMisure.add(misura);
		
		misura.setTipoVerifica("Punto3");
		misura.setUm("mm");
		misura.setValoreCampione("0,5");
		misura.setValoreMedioCampione("0,5");
		misura.setValoreStrumento("0,498");
		misura.setValoreMedioStrumento("0,498");
		misura.setScostamento("0,002");
		misura.setAccettabilita("0,004");
		misura.setIncertezza("0,001");
		misura.setEsito("IDONEO");
		
		listaMisure.add(misura);

		return listaMisure;
	}

	public static void main(String[] args){
		 
		try {
			StampaJasper();
		} catch (IOException | ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
