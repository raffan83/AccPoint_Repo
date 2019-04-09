package it.portaleSTI.bo;

import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;
import static net.sf.dynamicreports.report.builder.DynamicReports.col;
import static net.sf.dynamicreports.report.builder.DynamicReports.stl;
import static net.sf.dynamicreports.report.builder.DynamicReports.type;

import java.io.File;
import java.io.FileInputStream;
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
import javax.servlet.ServletOutputStream;

import org.hibernate.HibernateException;
import org.hibernate.Session;

import TemplateReport.PivotTemplate;
import it.portaleSTI.DAO.DirectMySqlDAO;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.CommessaDTO;
import it.portaleSTI.DTO.DatasetCampionamentoDTO;
import it.portaleSTI.DTO.InterventoCampionamentoDTO;
import it.portaleSTI.DTO.InterventoDTO;
import it.portaleSTI.DTO.MisuraDTO;
import it.portaleSTI.DTO.PlayloadCampionamentoDTO;
import it.portaleSTI.DTO.StatoStrumentoDTO;
import it.portaleSTI.DTO.StrumentoDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Templates;
import it.portaleSTI.Util.Utility;
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

public class CreateSchedaListaStrumenti {
	public CreateSchedaListaStrumenti( ArrayList<StrumentoDTO> listaStrumenti, String cliente, String sede, Session session, ServletContext context, UtenteDTO user) throws Exception {
		try {
		
			build(listaStrumenti,cliente, sede , context, user);
		} catch (Exception e) {
			
			e.printStackTrace();
			throw e;
		} 
	}
	private void build( ArrayList<StrumentoDTO> listaStrumenti, String cliente, String sede, ServletContext context, UtenteDTO user) throws Exception {
		
		InputStream is = PivotTemplate.class.getResourceAsStream("schedaListaStrumentiMetrologiaMOD-LAB-013V.jrxml");
		 
		
		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.pen1Point()).setFontSize(8);//AGG
		
 
		JasperReportBuilder report = DynamicReports.report();
 
		StyleBuilder footerStyle = Templates.footerStyle.setFontSize(6).bold().setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE);
		StyleBuilder rootStyle = Templates.rootStyle.setFontSize(8).bold().setTextAlignment(HorizontalTextAlignment.CENTER, VerticalTextAlignment.MIDDLE);

 
		try {
 	
 		
 			report.setTemplateDesign(is);
			report.setTemplate(Templates.reportTemplate);

			Object imageHeader = context.getResourceAsStream(Costanti.PATH_FOLDER_LOGHI+"/"+user.getCompany().getNomeLogo());
			//Object imageHeader = new File(Costanti.PATH_FOLDER_LOGHI+"/accpoint.jpg");
			if(imageHeader!=null) {
				report.addParameter("logo",imageHeader);
			}
 
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
			
			report.addParameter("data",""+sdf.format(new Date()));
			report.addParameter("cliente",cliente);
			report.addParameter("sede",sede);
 
			report.setColumnStyle(textStyle); //AGG

			SubreportBuilder subreport = cmp.subreport(getTableReport(listaStrumenti));
			
			report.addDetail(subreport);
		
			report.setDataSource(new JREmptyDataSource());
			
			File directory =new File(Costanti.PATH_FOLDER+"//temp//");
			
			if(directory.exists()==false)
			{
				directory.mkdir();
			}
			
		
 			  java.io.File file = new java.io.File(Costanti.PATH_FOLDER+"//temp//SchedaListastrumenti.pdf");
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

	public JasperReportBuilder getTableReport(ArrayList<StrumentoDTO> listaStrumenti) throws Exception{

		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.pen1Point()).setFontSize(7);//AGG
		
	 
		JasperReportBuilder report = DynamicReports.report();

		try {
			report.setTemplate(Templates.reportTemplateVerde);
			report.setColumnStyle(textStyle); //AGG
 
			report.addColumn(col.column("Stato", "stato", type.stringType()));
			report.addColumn(col.column("Codice Interno", "codice_interno", type.stringType()));
			report.addColumn(col.column("Matricola", "matricola", type.stringType()));
			report.addColumn(col.column("Denominazione", "denominazione", type.stringType()));
			report.addColumn(col.column("Costurttore", "costruttore", type.stringType()));
			report.addColumn(col.column("Modello", "modello", type.stringType()));
			report.addColumn(col.column("Campo Misura", "campo_misura", type.stringType()));
			report.addColumn(col.column("Divisione", "risoluzione", type.stringType()));
			report.addColumn(col.column("Reparto", "reparto", type.stringType()));
			report.addColumn(col.column("Utilizzatore", "utilizzatore", type.stringType()));
			report.addColumn(col.column("Freq", "frequenza", type.stringType())); 
	 		report.addColumn(col.column("Data Ultima Verifica", "data_ultima_modifica", type.stringType()));
	 		report.addColumn(col.column("Data Prossima Verifica", "data_prossima_modifica", type.stringType()));
	 		report.addColumn(col.column("Note", "note", type.stringType()));
	 		report.addColumn(col.column("N° Scheda", "n_scheda", type.stringType()));
 
	 		
	 		
	 		
	 		
	 		
	 		
	 		
	 		
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
		
		String[] listaCodici = new String[15];
		
		listaCodici[0]="stato";
		listaCodici[1]="codice_interno";
		listaCodici[2]="matricola";
 		listaCodici[3]="denominazione";
 		listaCodici[4]="costruttore";
 		listaCodici[5]="modello";
 		listaCodici[6]="campo_misura";
 		listaCodici[7]="risoluzione";
 		listaCodici[8]="reparto";
 		listaCodici[9]="utilizzatore";	
		listaCodici[10]="frequenza";
		listaCodici[11]="data_ultima_modifica";
		listaCodici[12]="data_prossima_modifica";
		listaCodici[13]="note";
		listaCodici[14]="n_scheda";
		
		DRDataSource dataSource = new DRDataSource(listaCodici);
		
		HashMap<Integer,Integer> listaMisure= DirectMySqlDAO.getListaUltimaMisuraStrumento();
		
			for (StrumentoDTO strumento : listaStrumenti) {
				
				if(strumento!=null)
				{
					ArrayList<String> arrayPs = new ArrayList<String>();
					
					
					arrayPs.add(strumento.getStato_strumento().getNome());
					arrayPs.add(strumento.getCodice_interno());
					arrayPs.add(strumento.getMatricola());
 	 				arrayPs.add(strumento.getDenominazione());
 	 				arrayPs.add(strumento.getCostruttore());
 	 				arrayPs.add(strumento.getModello());
 	 				arrayPs.add(strumento.getCampo_misura());
 	 				arrayPs.add(strumento.getRisoluzione());
 	 				arrayPs.add(strumento.getReparto());
 	 				arrayPs.add(strumento.getUtilizzatore());
 	 				if(strumento.getScadenzaDTO()!=null) 
 	 				{
 	 					arrayPs.add(""+strumento.getScadenzaDTO().getFreq_mesi());
 	 				}else 
 	 				{
 	 					arrayPs.add("/");
 	 				}
 	 				
	 				if(strumento.getScadenzaDTO().getDataUltimaVerifica() != null){
	 					arrayPs.add(sdf.format(strumento.getScadenzaDTO().getDataUltimaVerifica()));
	 				}else {
	 					arrayPs.add("/");
	 				}
	 				if(strumento.getScadenzaDTO().getDataProssimaVerifica() != null){
	 					arrayPs.add(sdf.format(strumento.getScadenzaDTO().getDataProssimaVerifica()));
	 				}else {
	 					arrayPs.add("/");
	 				}
	 				arrayPs.add(strumento.getNote());
	 				
	 				if(listaMisure.containsKey(strumento.get__id())) {
	 					int idMisura = listaMisure.get(strumento.get__id());
	 					
	 					
	 					MisuraDTO misura = GestioneMisuraBO.getMiruraByID(idMisura);
	 					if(misura!=null) 
	 					{
	 						arrayPs.add(misura.getnCertificato());
	 					}
	 				}else {
	 					arrayPs.add("/");
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
