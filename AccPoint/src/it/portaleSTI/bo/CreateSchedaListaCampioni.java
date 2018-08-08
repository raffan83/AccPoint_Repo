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

public class CreateSchedaListaCampioni {
	public CreateSchedaListaCampioni(InterventoDTO intervento, ArrayList<CampioneDTO> listaCampioni, Session session, ServletContext context) throws Exception {
		try {
		
			build(intervento, listaCampioni, context);
		} catch (Exception e) {
			
			e.printStackTrace();
			throw e;
		} 
	}
	private void build(InterventoDTO intervento, ArrayList<CampioneDTO> listaCampioni, ServletContext context) throws Exception {
		
		InputStream is = PivotTemplate.class.getResourceAsStream("schedaListaCampioniMetrologiaMOD-LAB-013V.jrxml");
		 
		
		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.pen1Point()).setFontSize(8);//AGG
		
 
		JasperReportBuilder report = DynamicReports.report();
 
		StyleBuilder footerStyle = Templates.footerStyle.setFontSize(6).bold().setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE);
		StyleBuilder rootStyle = Templates.rootStyle.setFontSize(8).bold().setTextAlignment(HorizontalTextAlignment.CENTER, VerticalTextAlignment.MIDDLE);

		StyleBuilder footerStyleFormula = Templates.footerStyleFormula.setFontSize(4).bold().setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE);

		try {
 	
			CommessaDTO commessa = GestioneCommesseBO.getCommessaById(intervento.getIdCommessa());
		
 			report.setTemplateDesign(is);
			report.setTemplate(Templates.reportTemplate);

			//Object imageHeader = context.getResourceAsStream(Costanti.PATH_FOLDER_LOGHI+"/"+intervento.getUser().getCompany().getNomeLogo());
			Object imageHeader = new File(Costanti.PATH_FOLDER_LOGHI+"/"+intervento.getCompany().getNomeLogo());
			if(imageHeader!=null) {
				report.addParameter("logo",imageHeader);
			}
			report.addParameter("cliente",commessa.getID_ANAGEN_NOME());
 
			report.addParameter("codiceCommessa",commessa.getID_COMMESSA());
 
			
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			
			report.addParameter("data",""+sdf.format(new Date()));

 
			report.setColumnStyle(textStyle); //AGG

			SubreportBuilder subreport = cmp.subreport(getTableReport(listaCampioni));
			
			report.addDetail(subreport);
		
			report.setDataSource(new JREmptyDataSource());
			
			  String nomePack=intervento.getNomePack();
			  java.io.File file = new java.io.File(Costanti.PATH_FOLDER+"//"+intervento.getNomePack()+"//SchedaListacampioni.pdf");
			  FileOutputStream fos = new FileOutputStream(file);
			  report.toPdf(fos);
			  
			//  report.show();
			  
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
			
		}
		//return report;
	}

	public JasperReportBuilder getTableReport(ArrayList<CampioneDTO> listaCampioni) throws Exception{

		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.pen1Point()).setFontSize(7);//AGG
		
	 
		JasperReportBuilder report = DynamicReports.report();

		try {
			report.setTemplate(Templates.reportTemplateVerde);
			report.setColumnStyle(textStyle); //AGG
 
 	 		report.addColumn(col.column("Codice Interno", "codInterno", type.stringType()));
	 		report.addColumn(col.column("Denominazione apparecchiatura", "denominazione", type.stringType()));
	 		report.addColumn(col.column("Matricola", "matricola", type.stringType()));
	 		report.addColumn(col.column("N° Certificato", "nCert", type.stringType()));
	 		report.addColumn(col.column("Scadenza taratura", "scadenzaTaratura", type.stringType()));


			report.setDetailSplitType(SplitType.PREVENT);
			
			report.setDataSource(createDataSource(listaCampioni));
	  
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return report;
	}

	private JRDataSource createDataSource(ArrayList<CampioneDTO> listaCampioni)throws Exception {
			
		
		ArrayList<String> listaString = new ArrayList<String>();

		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		
		String[] listaCodici = new String[5];
		
		listaCodici[0]="codInterno";
		listaCodici[1]="denominazione";
		listaCodici[2]="matricola";
		listaCodici[3]="nCert";
		listaCodici[4]="scadenzaTaratura";
		
		DRDataSource dataSource = new DRDataSource(listaCodici);
		
			for (CampioneDTO campione : listaCampioni) {
				
				if(campione!=null)
				{
					ArrayList<String> arrayPs = new ArrayList<String>();
					
					if(campione.getDataScadenza()!=null) 
					{
	 				arrayPs.add(campione.getCodice());
	 				arrayPs.add(campione.getNome());
	 				arrayPs.add(campione.getMatricola());
	 				arrayPs.add(campione.getNumeroCertificato());
	 				arrayPs.add(""+sdf.format(campione.getDataScadenza()));
					
	 				
			         Object[] listaValori = arrayPs.toArray();
			        
			         dataSource.add(listaValori);
					}     
				}
			
			}
 		    return dataSource;
 	}
	
	public static void main(String[] args) throws HibernateException, Exception {
		
		InterventoDTO intervento = GestioneInterventoBO.getIntervento("97");
	
		ArrayList<MisuraDTO> listaMisure = GestioneInterventoBO.getListaMirureByIntervento(intervento.getId());
		ArrayList<CampioneDTO> listaCampioni = new ArrayList<CampioneDTO>();
		
		for (MisuraDTO misura : listaMisure) {
		//	List<CampioneDTO> listaCampioniMisura = GestioneMisuraBO.getListaCampioni(misura.getListaPunti());
		//	listaCampioni.addAll(listaCampioniMisura);
		}
		
		
		new CreateSchedaListaCampioni(intervento, listaCampioni,null,null);
	}
}
