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
import java.util.Map;

import javax.servlet.ServletContext;

import org.hibernate.HibernateException;
import org.hibernate.Session;

import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.DatasetCampionamentoDTO;
import it.portaleSTI.DTO.InterventoCampionamentoDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.PlayloadCampionamentoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Templates;
import it.portaleSTI.Util.TestReport2;
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

public class CreateSchedaConsegnaMetrologia {
	public CreateSchedaConsegnaMetrologia(InterventoDTO intervento, String consegnaDi, int checkStato, String ca, ArrayList<StrumentoDTO> listaStrumenti, Session session, ServletContext context) throws Exception {
		try {
		
			build(intervento,consegnaDi,checkStato, ca, listaStrumenti, context);
		} catch (Exception e) {
			
			e.printStackTrace();
			throw e;
		} 
	}
	private void build(InterventoDTO intervento, String consegnaDi, int checkStato, String ca, ArrayList<StrumentoDTO> listaStrumenti, ServletContext context) throws Exception {
		
		InputStream is = CreateSchedaConsegnaMetrologia.class.getResourceAsStream("schedaConsegnaMetrologiaMOD-SGI-031.jrxml");
		 
		
		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.pen1Point()).setFontSize(8);//AGG
		
 
		JasperReportBuilder report = DynamicReports.report();
 
		StyleBuilder footerStyle = Templates.footerStyle.setFontSize(6).bold().setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE);
		StyleBuilder rootStyle = Templates.rootStyle.setFontSize(8).bold().setTextAlignment(HorizontalTextAlignment.CENTER, VerticalTextAlignment.MIDDLE);

		StyleBuilder footerStyleFormula = Templates.footerStyleFormula.setFontSize(4).bold().setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE);

		try {
 	
			CommessaDTO commessa = GestioneCommesseBO.getCommessaById(intervento.getIdCommessa());
		
 			report.setTemplateDesign(is);
			report.setTemplate(Templates.reportTemplate);

			report.addParameter("cliente",intervento.getNome_sede());
			//report.addParameter("indirizzo",commessa.getANAGEN_INDR_INDIRIZZO());
			report.addParameter("indirizzo","sss");
			report.addParameter("codCommessa",commessa.getID_COMMESSA());
			report.addParameter("ca",ca);
			report.addParameter("consegnaDi",consegnaDi);
			report.addParameter("oggettoCommessa",commessa.getDESCR());
			report.addParameter("numeroOrdineCommessa",commessa.getN_ORDINE());
			if(checkStato == 0) {
				report.addParameter("consegnaDefinitiva",true);
				report.addParameter("statoAvenzamento",false);
			}else {
				report.addParameter("consegnaDefinitiva",false);
				report.addParameter("statoAvenzamento",true);
			}
			
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			
			report.addParameter("dataConsegna",""+sdf.format(new Date()));
			report.addParameter("company",intervento.getCompany().getDenominazione());
			report.addParameter("nota","Nota");
 
			report.setColumnStyle(textStyle); //AGG

			SubreportBuilder subreport = cmp.subreport(getTableReport(listaStrumenti));
			
			report.addDetail(subreport);
		
			
			
			  String nomePack=intervento.getNomePack();
			  java.io.File file = new java.io.File(Costanti.PATH_FOLDER+"//"+intervento.getNomePack()+"//SchedaDiConsegna.pdf");
			  FileOutputStream fos = new FileOutputStream(file);
			  report.toPdf(fos);
			  
			//  report.show();
			  
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
			
		}
		//return report;
	}

	public JasperReportBuilder getTableReport(ArrayList<StrumentoDTO> listaStrumenti) throws Exception{

		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.pen1Point()).setFontSize(7);//AGG
		
	 
		JasperReportBuilder report = DynamicReports.report();

		try {
			report.setTemplate(Templates.reportTemplate);
			report.setColumnStyle(textStyle); //AGG

 	

			  
			report.setColumnStyle(textStyle); //AGG
 
 	 		report.addColumn(col.column("Denominazoione", "denominazione", type.stringType()));
	 		report.addColumn(col.column("Codice Interno", "codInterno", type.stringType()));
	 		report.addColumn(col.column("Data prossima verifica", "dataPorsVer", type.stringType()));

			report.setDetailSplitType(SplitType.PREVENT);
			
			report.setDataSource(createDataSource(listaStrumenti));
	  
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return report;
	}

	private JRDataSource createDataSource(ArrayList<StrumentoDTO> listaStrumenti)throws Exception {
			
		
		ArrayList<String> listaString = new ArrayList<String>();

		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		
		String[] listaCodici = new String[3];
		
		listaCodici[0]="denominazione";
		listaCodici[1]="codInterno";
		listaCodici[2]="dataPorsVer";
		
		DRDataSource dataSource = new DRDataSource(listaCodici);
		
			for (StrumentoDTO strumento : listaStrumenti) {
				ArrayList<String> arrayPs = new ArrayList<String>();
				
				arrayPs.add(strumento.getDenominazione());
				arrayPs.add(strumento.getCodice_interno());
				arrayPs.add(""+sdf.format(strumento.getScadenzaDTO().getDataProssimaVerifica()));
				
		         Object[] listaValori = arrayPs.toArray();
		        
		         dataSource.add(listaValori);
			
			}
 		    return dataSource;
 	}
	
	public static void main(String[] args) throws HibernateException, Exception {
		
		InterventoDTO intervento = GestioneInterventoBO.getIntervento("97");
	
		ArrayList<MisuraDTO> listaMisure = GestioneInterventoBO.getListaMirureByIntervento(intervento.getId());
		ArrayList<StrumentoDTO> listaStrumenti = new ArrayList<StrumentoDTO>();
		
		for (MisuraDTO misura : listaMisure) {
			listaStrumenti.add(misura.getStrumento());
		}
		
		new CreateSchedaConsegnaMetrologia(intervento, "as", 0 ,"ca", listaStrumenti,null,null);
	}
}
