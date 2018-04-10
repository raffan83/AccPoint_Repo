package it.portaleSTI.bo;

import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;
import static net.sf.dynamicreports.report.builder.DynamicReports.col;
import static net.sf.dynamicreports.report.builder.DynamicReports.stl;
import static net.sf.dynamicreports.report.builder.DynamicReports.type;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;

import org.hibernate.Session;

import TemplateReport.PivotTemplate;
import it.portaleSTI.DTO.MagDdtDTO;
import it.portaleSTI.DTO.MagItemPaccoDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Templates;
import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.dynamicreports.report.builder.component.SubreportBuilder;
import net.sf.dynamicreports.report.constant.SplitType;
import net.sf.dynamicreports.report.datasource.DRDataSource;
import net.sf.dynamicreports.report.exception.DRException;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;


	public class CreateDDT {
	
	
	File file; 
	private boolean esito; 
	public CreateDDT(MagDdtDTO ddt, List<MagItemPaccoDTO> lista_item_pacco, Session session) throws Exception {
		try {
			// Utility.memoryInfo();
			build(ddt, lista_item_pacco, session);
			// Utility.memoryInfo();
		} catch (Exception e) {
			
			e.printStackTrace();
			throw e;
		} 
	}
	
	

	private void build(MagDdtDTO ddt, List<MagItemPaccoDTO> lista_item_pacco, Session session) {
		
		
		InputStream is =  PivotTemplate.class.getResourceAsStream("ddt_test.jrxml");
		

		JasperReportBuilder report = DynamicReports.report();
		
		
		try {
			report.setTemplateDesign(is);
			report.setTemplate(Templates.reportTemplate);
			
			report.addParameter("numero_ddt", ddt.getNumero_ddt());
			report.addParameter("tipo_trasporto", ddt.getTipo_trasporto().getDescrizione());
			report.addParameter("tipo_porto", ddt.getTipo_porto().getDescrizione());
			report.addParameter("tipo_ddt", ddt.getTipo_ddt().getDescrizione());
			report.addParameter("causale", ddt.getCausale_ddt());
			report.addParameter("codice_cliente", ddt.getCliente().get__id());			
			report.addParameter("telefono", ddt.getCliente().getTelefono());
			if(ddt.getCliente().getPartita_iva()!=null) {
				report.addParameter("partita_iva", ddt.getCliente().getPartita_iva());
			}else {
				report.addParameter("partita_iva", "");
			}
			
			
			SimpleDateFormat dt = new SimpleDateFormat("dd/MM/yyyy"); 
			
			if( ddt.getData_ddt()==null) {
				report.addParameter("data_ddt","");
			}else {
				report.addParameter("data_ddt", dt.format(ddt.getData_ddt()));
			}
			String data_trasporto;
			String ora_trasporto;
			if(ddt.getData_trasporto()==null) {
				data_trasporto="";
			}else {
				data_trasporto = dt.format(ddt.getData_trasporto()); 
			}
			if(ddt.getOra_trasporto()==null) {
				ora_trasporto="";
			}else {
				ora_trasporto=ddt.getOra_trasporto().toString();
			}
			
			report.addParameter("data_ora_trasporto", data_trasporto+" "+ora_trasporto);
			report.addParameter("aspetto", ddt.getAspetto().getDescrizione());
			report.addParameter("destinatario", ddt.getNome_destinazione());
			report.addParameter("destinazione", ddt.getIndirizzo_destinazione()+" "+ ddt.getCap_destinazione()+" "+ddt.getCitta_destinazione()+" "+ddt.getProvincia_destinazione()+" "+ddt.getPaese_destinazione());
			report.addParameter("spedizioniere", ddt.getSpedizioniere().getDenominazione());
			report.addParameter("annotazioni", ddt.getAnnotazioni());
			
			//File imageHeader = new File("C:\\Users\\antonio.dicivita\\Calver\\logo.png");
			File imageHeader = new File(Costanti.PATH_FOLDER_LOGHI +"4132_header_sc.jpg");
			if(imageHeader!=null) {
				report.addParameter("logo",imageHeader);
			
				}
			
			SubreportBuilder subreport;
			try {
				subreport = cmp.subreport(getTableReport(lista_item_pacco));
				report.addDetail(subreport);

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			

			report.setDataSource(new JREmptyDataSource());
			
			//String path = "C:\\Users\\antonio.dicivita\\Desktop\\ddt.pdf";
			String path = Costanti.PATH_FOLDER+"//"+"Magazzino" + "//"+ ddt.getNumero_ddt() +".pdf";
			  java.io.File file = new java.io.File(path);
			  FileOutputStream fos = new FileOutputStream(file);
			  report.toPdf(fos);
			
			  fos.close();
			 
			  this.file = file;
			  this.setEsito(true);
			  ddt.setLink_pdf(path);
			
			  GestioneMagazzinoBO.updateDdt(ddt, session);
			
			
		} catch (DRException e) {

			this.setEsito(false);
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			
			this.setEsito(false);
			e.printStackTrace();

		} catch (IOException e) {

			this.setEsito(false);
			e.printStackTrace();
		}
		
	}
	
	
	
	@SuppressWarnings("deprecation")
	public JasperReportBuilder getTableReport(List<MagItemPaccoDTO> lista_item_pacco) throws Exception{

	
	 
		JasperReportBuilder report = DynamicReports.report();

		try {
			
			report.setColumnStyle((Templates.boldCenteredStyle).setFontSize(9));
 	 		report.addColumn(col.column("", "id_item", type.stringType()));
	 		report.addColumn(col.column("", "denominazione", type.stringType()));
	 		report.addColumn(col.column("", "quantita", type.stringType()));
	 		report.addColumn(col.column("", "note", type.stringType()));
	 	

			report.setDetailSplitType(SplitType.PREVENT);
			
			report.setDataSource(createDataSource(lista_item_pacco));
	  
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return report;
	}
	
	
	
	
private JRDataSource createDataSource(List<MagItemPaccoDTO> lista_item_pacco)throws Exception {
			
		
		String[] listaCodici = new String[4];
		
		listaCodici[0]="id_item";		
		listaCodici[1]="denominazione";	
		listaCodici[2]="quantita";
		listaCodici[3]="note";
		
		DRDataSource dataSource = new DRDataSource(listaCodici);
		
			for (MagItemPaccoDTO item_pacco : lista_item_pacco) {
				
				if(item_pacco!=null)
				{
					ArrayList<String> arrayPs = new ArrayList<String>();
					
					
	 				arrayPs.add(String.valueOf(item_pacco.getItem().getId_tipo_proprio()));	 		
	 				arrayPs.add(item_pacco.getItem().getDescrizione());
	 				arrayPs.add(String.valueOf(item_pacco.getQuantita()));
	 				arrayPs.add(item_pacco.getNote());
	 			
			         Object[] listaValori = arrayPs.toArray();
			        
			         dataSource.add(listaValori);
				}
			
			}
 		    return dataSource;
 	}



public boolean isEsito() {
	return esito;
}



public void setEsito(boolean esito) {
	this.esito = esito;
}
		
	}
