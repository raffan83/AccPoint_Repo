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

import javax.servlet.ServletContext;

import org.hibernate.Session;

import TemplateReport.PivotTemplate;
import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DTO.ConfigurazioneClienteDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
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

public class CreateSchedaNoteTecnicheStrumenti {
	public CreateSchedaNoteTecnicheStrumenti( ArrayList<StrumentoDTO> listaStrumenti, String cliente, String sede, Session session, ServletContext context,UtenteDTO user, String nome_cliente, String nome_sede) throws Exception {
		try {
		
			build(listaStrumenti,cliente, sede , context, user, nome_cliente, nome_sede, session);
		} catch (Exception e) {
			
			e.printStackTrace();
			throw e;
		} 
	}
	private void build( ArrayList<StrumentoDTO> listaStrumenti, String cliente, String sede, ServletContext context, UtenteDTO user, String nome_cliente, String nome_sede, Session session) throws Exception {
		
		InputStream is = PivotTemplate.class.getResourceAsStream("SchedaListaStrumentiNoteTecniche.jrxml");
		 
		
		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.pen1Point()).setFontSize(8);//AGG
		
 
		JasperReportBuilder report = DynamicReports.report();
 
		StyleBuilder footerStyle = Templates.footerStyle.setFontSize(6).bold().setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE);
		StyleBuilder rootStyle = Templates.rootStyle.setFontSize(8).bold().setTextAlignment(HorizontalTextAlignment.CENTER, VerticalTextAlignment.MIDDLE);

 
		try {
 	
 		
 			report.setTemplateDesign(is);
			report.setTemplate(Templates.reportTemplate);
			
			Object imageHeader = new File(Costanti.PATH_FOLDER_LOGHI+user.getCompany().getNomeLogo());
	
			 
					
			//Object imageHeader = new File(Costanti.PATH_FOLDER_LOGHI+"/accpoint.jpg");
			if(imageHeader!=null) {
				report.addParameter("logo",imageHeader);
			}
 
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			
			report.addParameter("data",""+sdf.format(new Date()));

								
			report.addParameter("cliente",nome_cliente.replaceAll("Cliente", "").replaceAll("\\r", "").replaceAll("\\n", ""));
				
			report.addParameter("sede",nome_sede);
			
				
			report.addParameter("modello_lista_strumenti","MOD-LAB-010");
			report.addParameter("revisione_lista_strumenti","Rev. 0 del 19/01/2004");
			
			
 
			report.setColumnStyle(textStyle); //AGG

			SubreportBuilder subreport = cmp.subreport(getTableReport(listaStrumenti, session));
			
			report.addDetail(subreport);
		
			report.setDataSource(new JREmptyDataSource());
			
			File directory =new File(Costanti.PATH_FOLDER+"//temp//");
			
			if(directory.exists()==false)
			{
				directory.mkdir();
			}
			
		
 			  java.io.File file = new java.io.File(Costanti.PATH_FOLDER+"//temp//SchedaNoteTecnicheStrumenti.pdf");
			  FileOutputStream fos = new FileOutputStream(file);
			  report.toPdf(fos);
			  
			  
				
	
 			  if(context==null) {
			  report.show();
			  }
			  
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
			
		}
		//return report;
	}

	public JasperReportBuilder getTableReport(ArrayList<StrumentoDTO> listaStrumenti, Session session) throws Exception{

		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.pen1Point()).setFontSize(7);//AGG
		
	 
		JasperReportBuilder report = DynamicReports.report();

		try {
			report.setTemplate(Templates.reportTemplateVerde);
			report.setColumnStyle(textStyle); //AGG
 
			
			report.addColumn(col.column("Codice Interno", "codice_interno", type.stringType()).setFixedWidth(30));
			report.addColumn(col.column("Matricola", "matricola", type.stringType()).setFixedWidth(35));
			report.addColumn(col.column("Denominazione", "denominazione", type.stringType()));
			report.addColumn(col.column("Costruttore", "costruttore", type.stringType()));
			report.addColumn(col.column("Modello", "modello", type.stringType()));

			report.addColumn(col.column("Reparto", "reparto", type.stringType()));
			report.addColumn(col.column("Utilizzatore", "utilizzatore", type.stringType()));

	 		report.addColumn(col.column("Note tecniche", "note_tecniche", type.stringType()).setFixedWidth(250));

	 		
			report.setDetailSplitType(SplitType.PREVENT);
			
			report.setDataSource(createDataSource(listaStrumenti, session));
	  
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return report;
	}

	private JRDataSource createDataSource(ArrayList<StrumentoDTO> listaStrumenti, Session session)throws Exception {
			
		
		ArrayList<String> listaString = new ArrayList<String>();

		SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		
		String[] listaCodici = new String[8];
		
		
		listaCodici[0]="codice_interno";
		listaCodici[1]="matricola";
 		listaCodici[2]="denominazione";
 		listaCodici[3]="costruttore";
 		listaCodici[4]="modello";

 		listaCodici[5]="reparto";
 		listaCodici[6]="utilizzatore";	
		listaCodici[7]="note_tecniche";
		
		DRDataSource dataSource = new DRDataSource(listaCodici);
		
		HashMap<Integer,Integer> listaMisure= DirectMySqlDAO.getListaUltimaMisuraStrumento();
		
			for (StrumentoDTO strumento : listaStrumenti) {
				
				if(strumento!=null)
				{
					ArrayList<String> arrayPs = new ArrayList<String>();
					
					
				
					arrayPs.add(strumento.getCodice_interno());
					arrayPs.add(strumento.getMatricola());
 	 				arrayPs.add(strumento.getDenominazione());
 	 				arrayPs.add(strumento.getCostruttore());
 	 				arrayPs.add(strumento.getModello());
 	 
 	 			
 	 				arrayPs.add(strumento.getReparto());
 	 				arrayPs.add(strumento.getUtilizzatore());
 	 				
 	 				if(strumento.getNote_tecniche()!=null) {
 	 					arrayPs.add(strumento.getNote_tecniche());
 	 				}else {
 	 					arrayPs.add("");
 	 				}
	 				
	 				
	 			
	 				Object[] listaValori = arrayPs.toArray();
			        
			         dataSource.add(listaValori);
				}
			
			}
 		    return dataSource;
 	}
	
//	public static void main(String[] args) throws HibernateException, Exception {
//		
//		Session session=SessionFacotryDAO.get().openSession();
//	 	
// 		ArrayList<StrumentoDTO> listaStrumenti = GestioneStrumentoBO.getStrumentiByIds("59121;59117;59118;59124;59123", session);
//		
//		
//		
//		
//		new CreateSchedaListaStrumenti(listaStrumenti,"ABB","ABB Frosinone",null,null);
//		
//		session.close();
//	}

}
