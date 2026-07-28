package it.portaleSTI.bo;

import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;
import static net.sf.dynamicreports.report.builder.DynamicReports.col;
import static net.sf.dynamicreports.report.builder.DynamicReports.stl;
import static net.sf.dynamicreports.report.builder.DynamicReports.type;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.hibernate.HibernateException;
import org.hibernate.Session;

import TemplateReport.PivotTemplate;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.DatasetCampionamentoDTO;
import it.portaleSTI.DTO.InterventoCampionamentoDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.PlayloadCampionamentoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Templates;
import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.dynamicreports.report.builder.component.SubreportBuilder;
import net.sf.dynamicreports.report.builder.style.StyleBuilder;
import net.sf.dynamicreports.report.constant.HorizontalTextAlignment;
import net.sf.dynamicreports.report.constant.SplitType;
import net.sf.dynamicreports.report.constant.VerticalTextAlignment;
import net.sf.dynamicreports.report.datasource.DRDataSource;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;

public class CreateReportSegnalazioneAuto {
	public CreateReportSegnalazioneAuto(String id_segnalazione, String targa, String modello, String data, String note) throws Exception {
		try {
		
			build(id_segnalazione, targa,modello,data,note);
		} catch (Exception e) {
			
			e.printStackTrace();
			throw e;
		} 
	}
	private void build(String id_segnalzione, String targa, String modello, String data, String note) throws Exception {
		
		InputStream is = PivotTemplate.class.getResourceAsStream("schedaReportSegnalazioneAuto.jrxml");
		 
		
		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.pen1Point()).setFontSize(8);//AGG
		
 
		JasperReportBuilder report = DynamicReports.report();
 
		StyleBuilder footerStyle = Templates.footerStyle.setFontSize(6).bold().setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE);
		StyleBuilder rootStyle = Templates.rootStyle.setFontSize(8).bold().setTextAlignment(HorizontalTextAlignment.CENTER, VerticalTextAlignment.MIDDLE);

		StyleBuilder footerStyleFormula = Templates.footerStyleFormula.setFontSize(4).bold().setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE);

		try {
 	
		
		
 			report.setTemplateDesign(is);
			report.setTemplate(Templates.reportTemplate);

			//Object imageHeader = context.getResourceAsStream(Costanti.PATH_FOLDER_LOGHI+"/"+intervento.getUser().getCompany().getNomeLogo());
			Object imageHeader = new File(Costanti.PATH_FOLDER_LOGHI+"/"+"4132_header.jpg");
			if(imageHeader!=null) {
				report.addParameter("logo",imageHeader);
			}
		
			report.addParameter("targa",targa);
			report.addParameter("modello",modello);
 
			
		//	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		//	report.addParameter("data",""+sdf.format(data));
			

			

			    report.addParameter("data", data);
					
			report.addParameter("note",note);
 
			report.setColumnStyle(textStyle); 
			
			 
			  java.io.File file = new java.io.File(Costanti.PATH_FOLDER+"//temp"+"//SchedaReportSegnalazioneAuto_" +id_segnalzione + ".pdf");
			  FileOutputStream fos = new FileOutputStream(file);
			  report.toPdf(fos);
			  fos.close();
			//  report.show();
			  
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
			
		}
		//return report;
	}



	
	
//	public static void main(String[] args) throws HibernateException, Exception {
//		
//		InterventoDTO intervento = GestioneInterventoBO.getIntervento("97");
//	
//		ArrayList<MisuraDTO> listaMisure = GestioneInterventoBO.getListaMirureByIntervento(intervento.getId());
//		ArrayList<CampioneDTO> listaCampioni = new ArrayList<CampioneDTO>();
//		
//		for (MisuraDTO misura : listaMisure) {
//		//	List<CampioneDTO> listaCampioniMisura = GestioneMisuraBO.getListaCampioni(misura.getListaPunti());
//		//	listaCampioni.addAll(listaCampioniMisura);
//		}
//		
//		
//		new CreateSchedaListaCampioni(intervento, listaCampioni,null,null);
//	}
}
