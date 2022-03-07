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
import java.util.regex.Pattern;

import javax.servlet.ServletContext;

import org.hibernate.HibernateException;
import org.hibernate.Session;

import TemplateReport.PivotTemplate;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.CompanyDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.VerInterventoDTO;
import it.portaleSTI.DTO.VerStrumentoDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.CostantiCertificato;
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

public class CreateSchedaConsegnaVerificazione {

	public CreateSchedaConsegnaVerificazione(VerInterventoDTO intervento, String consegnaDi, int checkStato, String ca, ArrayList<VerStrumentoDTO> listaStrumenti, CompanyDTO company) throws Exception {
		try {
		
			build(intervento,consegnaDi,checkStato, ca, listaStrumenti, company);
		} catch (Exception e) {
			
			e.printStackTrace();
			throw e;
		} 
	}
	private void build(VerInterventoDTO intervento, String consegnaDi, int checkStato, String ca, ArrayList<VerStrumentoDTO> listaStrumenti, CompanyDTO company) throws Exception {
		
		InputStream is = PivotTemplate.class.getResourceAsStream("schedaConsegnaMetrologiaMOD-SGI-031.jrxml");
		 
		
		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.penThin()).setFontSize(8);//AGG
		
 
		JasperReportBuilder report = DynamicReports.report();
 
		StyleBuilder footerStyle = Templates.footerStyle.setFontSize(6).bold().setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE);
		StyleBuilder rootStyle = Templates.rootStyle.setFontSize(8).bold().setTextAlignment(HorizontalTextAlignment.CENTER, VerticalTextAlignment.MIDDLE);

		StyleBuilder footerStyleFormula = Templates.footerStyleFormula.setFontSize(4).bold().setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE);

		try {
 	
			CommessaDTO commessa = GestioneCommesseBO.getCommessaById(intervento.getCommessa());
		
 			report.setTemplateDesign(is);
			report.setTemplate(Templates.reportTemplate);


			String[] nomeLogo = company.getNomeLogo().split(Pattern.quote("."));
		
			File imageHeader = new File(Costanti.PATH_FOLDER_LOGHI+"/"+nomeLogo[0]+"_sc."+nomeLogo[1]);
		//	File imageHeader = new File("/Users/marcopagnanelli/Downloads/imageACC/1428_header.jpg");

			if(imageHeader!=null) {
				report.addParameter("logo",imageHeader);
			}
			//report.addParameter("cliente",commessa.getID_ANAGEN_NOME());
			report.addParameter("cliente",commessa.getNOME_UTILIZZATORE());
			String sedeCliente = "";
//			if(commessa.getANAGEN_INDR_INDIRIZZO()!=null && commessa.getANAGEN_INDR_INDIRIZZO().length()>0)
//			{
//				sedeCliente=commessa.getANAGEN_INDR_INDIRIZZO();
//			}else
//			{
//				sedeCliente=commessa.getINDIRIZZO_PRINCIPALE(); 
//			}
			if(commessa.getINDIRIZZO_UTILIZZATORE()!=null && commessa.getINDIRIZZO_UTILIZZATORE().length()>0)
			{
				sedeCliente=commessa.getINDIRIZZO_UTILIZZATORE();
			}else
			{
				sedeCliente=commessa.getINDIRIZZO_PRINCIPALE(); 
			}
			
			report.addParameter("indirizzo",sedeCliente);

			report.addParameter("codCommessa",commessa.getID_COMMESSA());
			report.addParameter("ca",ca);
			report.addParameter("consegnaDi",consegnaDi);
			report.addParameter("oggettoCommessa",commessa.getDESCR());
			if(commessa.getN_ORDINE()!=null) {
				report.addParameter("numeroOrdineCommessa",commessa.getN_ORDINE());
			}else {
				report.addParameter("numeroOrdineCommessa","");
			}
			if(checkStato == 0) {
				report.addParameter("consegnaDefinitiva",true);
				report.addParameter("statoAvanzamento",false);
			}else {
				report.addParameter("consegnaDefinitiva",false);
				report.addParameter("statoAvanzamento",true);
			}
			
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			
			report.addParameter("dataConsegna",""+sdf.format(new Date()));
			report.addParameter("company",company.getDenominazione());
			report.addParameter("nota",CostantiCertificato.NOTA_CONSEGNA);
 
			report.setColumnStyle(textStyle); //AGG

			SubreportBuilder subreport = cmp.subreport(getTableReport(listaStrumenti));
			
			report.addDetail(subreport);
		
			report.setDataSource(new JREmptyDataSource());
			
			  java.io.File file = new java.io.File(Costanti.PATH_FOLDER+"//"+intervento.getNome_pack()+"//SchedaDiConsegna.pdf");
			  FileOutputStream fos = new FileOutputStream(file);
			  report.toPdf(fos);
			  
			  fos.flush();
			  fos.close();
			 //report.show();
			  
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
			
		}
		//return report;
	}

	public JasperReportBuilder getTableReport(ArrayList<VerStrumentoDTO> listaStrumenti) throws Exception{

		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.penThin()).setFontSize(7);//AGG
		
	 
		JasperReportBuilder report = DynamicReports.report();

		try {
			report.setTemplate(Templates.reportTemplate);
			report.setColumnStyle(textStyle); //AGG

 	

			  
			report.setColumnStyle(textStyle); //AGG
			report.addColumn(col.column("N.", "progressivo", type.stringType()).setWidth(10));
 	 		report.addColumn(col.column("Denominazione", "denominazione", type.stringType()));
//	 		report.addColumn(col.column("Codice Interno", "codInterno", type.stringType()).setWidth(38));
	 		report.addColumn(col.column("Matricola", "matricola", type.stringType()).setWidth(38));
	 		report.addColumn(col.column("Data verifica", "dataVer", type.stringType()).setWidth(25));
//	 		report.addColumn(col.column("Note", "note", type.stringType()));

			report.setDetailSplitType(SplitType.PREVENT);
			
			report.setDataSource(createDataSource(listaStrumenti));
	  
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return report;
	}

	private JRDataSource createDataSource(ArrayList<VerStrumentoDTO> listaStrumenti)throws Exception {
			
		
		ArrayList<String> listaString = new ArrayList<String>();

		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		
		String[] listaCodici = new String[4];
		
		listaCodici[0]="progressivo";
		listaCodici[1]="denominazione";
//		listaCodici[2]="codInterno";
		listaCodici[2]="matricola";
		listaCodici[3]="dataVer";
//		listaCodici[5]="note";
		
		DRDataSource dataSource = new DRDataSource(listaCodici);
		
		int i=1;
			for (VerStrumentoDTO strumento : listaStrumenti) {
								
				ArrayList<String> arrayPs = new ArrayList<String>();
				
				arrayPs.add(""+i);
				arrayPs.add(strumento.getDenominazione());
//				arrayPs.add("");
				arrayPs.add(strumento.getMatricola());
				
				if(strumento.getData_ultima_verifica()!=null) {
					arrayPs.add(""+sdf.format(strumento.getData_ultima_verifica()));	
				}else {
					arrayPs.add("");	
				}
//				arrayPs.add("");
				
		         Object[] listaValori = arrayPs.toArray();
		        
		         dataSource.add(listaValori);
		         i++;
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
		String note = "wesdfgvsdzv sdfsdf vdsfp+ sd\n" + 
				"f sd\n" + 
				"fs \n" + 
				"dsf\n" + 
				" sd\n" + 
				"f \n" + 
				"sdf\n" + 
				" sdfsdxzfdsfdsf\n" + 
				"ds f\n" + 
				"sd\n" + 
				" f dsfdsf dkfnjhg vinskfjd hiusdhfiusdhiuf hdsifh iosdhf iusdhf isdilu vhdsiuf iusdhf iudslifuhdlsiufh dilsuhf ilusdhf ilusdfilusdilufh sdilu iulsdhfi lusdhiluf hdisluh ilsudhf ilusdhfil hdsiluf hdilsuf ";
		new CreateSchedaConsegnaMetrologia(intervento, note, 0 ,"ca", listaStrumenti,null,null);
	}
	
	
}
