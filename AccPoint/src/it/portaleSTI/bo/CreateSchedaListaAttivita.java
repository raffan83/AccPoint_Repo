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
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.ServletContext;

import org.apache.commons.lang3.ArrayUtils;
import org.hibernate.HibernateException;
import org.hibernate.Session;

import TemplateReport.PivotTemplate;
import it.portaleSTI.DTO.AttivitaMilestoneDTO;
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

public class CreateSchedaListaAttivita {
	public CreateSchedaListaAttivita(InterventoCampionamentoDTO intervento, Session session, ServletContext context) throws Exception {
		try {
		
			build(intervento, context);
		} catch (Exception e) {
			
			e.printStackTrace();
			throw e;
		} 
	}
	private void build(InterventoCampionamentoDTO intervento, ServletContext context) throws Exception {
		
		InputStream is = PivotTemplate.class.getResourceAsStream("schedaListaAttivita.jrxml");
		 
		
		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.penThin()).setFontSize(8);//AGG
		
 
		JasperReportBuilder report = DynamicReports.report();
 
		StyleBuilder footerStyle = Templates.footerStyle.setFontSize(6).bold().setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE);
		StyleBuilder rootStyle = Templates.rootStyle.setFontSize(8).bold().setTextAlignment(HorizontalTextAlignment.CENTER, VerticalTextAlignment.MIDDLE);

		StyleBuilder footerStyleFormula = Templates.footerStyleFormula.setFontSize(4).bold().setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE);

		try {
 	
			CommessaDTO commessa = GestioneCommesseBO.getCommessaById(intervento.getID_COMMESSA());
		
 			report.setTemplateDesign(is);
			report.setTemplate(Templates.reportTemplate);

			//Object imageHeader = context.getResourceAsStream(Costanti.PATH_FOLDER_LOGHI+"/"+intervento.getUser().getCompany().getNomeLogo());
			Object imageHeader = new File(Costanti.PATH_FOLDER_LOGHI+"/"+intervento.getUser().getCompany().getNomeLogo());
			if(imageHeader!=null) {
				report.addParameter("logo",imageHeader);
			}
			report.addParameter("cliente",commessa.getID_ANAGEN_NOME());
 
			report.addParameter("codiceCommessa",commessa.getID_COMMESSA());
 
			
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			
			report.addParameter("data",""+sdf.format(new Date()));

 
			report.setColumnStyle(textStyle); //AGG

			HashMap<String, ArrayList<AttivitaMilestoneDTO>> hadshAttivita = new HashMap<String, ArrayList<AttivitaMilestoneDTO>>();
			
			String[] attivitaIntervento = intervento.getIdAttivita().split(Pattern.quote("|"));
			
			for (AttivitaMilestoneDTO attivita : commessa.getListaAttivita()) {
				if(ArrayUtils.contains(attivitaIntervento, attivita.getCodiceAggregatore())) {
					if(hadshAttivita.containsKey(attivita.getCodiceAggregatore())) {
						ArrayList<AttivitaMilestoneDTO> listaAtt = hadshAttivita.get(attivita.getCodiceAggregatore());
						listaAtt.add(attivita);
					}else {
						ArrayList<AttivitaMilestoneDTO> listaAtt = new ArrayList<AttivitaMilestoneDTO>();
						listaAtt.add(attivita);
						hadshAttivita.put(attivita.getCodiceAggregatore(), listaAtt);
					}
				}
			}
		
			Iterator it = hadshAttivita.entrySet().iterator();
		    while (it.hasNext()) {
		    	 	Map.Entry pair = (Map.Entry)it.next();
		    	 	
		    	 	ArrayList<AttivitaMilestoneDTO> listaAtt = (ArrayList<AttivitaMilestoneDTO>) pair.getValue();
		    		SubreportBuilder subreport = cmp.subreport(getTableReport(listaAtt));
		    		report.addDetail(cmp.text(" "));
		    		report.addDetail(cmp.text(""+pair.getKey()).setStyle(textStyle));
				report.addDetail(subreport);
		    }

			
		
			report.setDataSource(new JREmptyDataSource());
			
			  String nomePack=intervento.getNomePack();
			  java.io.File file = new java.io.File(Costanti.PATH_FOLDER+"//"+intervento.getNomePack()+"//listaAttivita.pdf");
			  FileOutputStream fos = new FileOutputStream(file);
			  report.toPdf(fos);
			  
			  report.show();
			  
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
			
		}
		//return report;
	}

	public JasperReportBuilder getTableReport(ArrayList<AttivitaMilestoneDTO> arrayList) throws Exception{

		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.penThin()).setFontSize(7);//AGG
		
	 
		JasperReportBuilder report = DynamicReports.report();

		try {
			report.setTemplate(Templates.reportTemplateWhite);
			report.setColumnStyle(textStyle); //AGG
 
 	 		report.addColumn(col.column("Descrizione", "descrizione", type.stringType()));
	 		report.addColumn(col.column("Codice Articolo", "codice", type.stringType()));


			report.setDetailSplitType(SplitType.PREVENT);
			
			report.setDataSource(createDataSource(arrayList));
	  
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return report;
	}

	private JRDataSource createDataSource(ArrayList<AttivitaMilestoneDTO> listaAttivitai)throws Exception {
			
		
		ArrayList<String> listaString = new ArrayList<String>();

		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		
		String[] listaCodici = new String[5];
		
		listaCodici[0]="descrizione";
		listaCodici[1]="codice";

		
		DRDataSource dataSource = new DRDataSource(listaCodici);
		
			for (AttivitaMilestoneDTO attivita : listaAttivitai) {
				
				if(attivita!=null)
				{
					ArrayList<String> arrayPs = new ArrayList<String>();
					
	 				arrayPs.add(attivita.getDescrizioneArticolo());
	 				arrayPs.add(attivita.getCodiceArticolo());

					
			         Object[] listaValori = arrayPs.toArray();
			        
			         dataSource.add(listaValori);
				}
			
			}
 		    return dataSource;
 	}
	
	public static void main(String[] args) throws HibernateException, Exception {
		
		InterventoCampionamentoDTO intervento = GestioneInterventoCampionamentoBO.getIntervento("35");
	
		new CreateSchedaListaAttivita(intervento,null,null);
	}
}
