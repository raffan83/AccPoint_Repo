package it.portaleSTI.bo;

import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;
import static net.sf.dynamicreports.report.builder.DynamicReports.col;
import static net.sf.dynamicreports.report.builder.DynamicReports.stl;
import static net.sf.dynamicreports.report.builder.DynamicReports.type;

import java.awt.Color;
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

import com.lowagie.text.Image;
import com.lowagie.text.pdf.BarcodeEAN;

import TemplateReport.PivotTemplate;
import it.portaleSTI.DTO.MagDdtDTO;
import it.portaleSTI.DTO.MagItemPaccoDTO;
import it.portaleSTI.DTO.MagPaccoDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Templates;
import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.dynamicreports.report.builder.component.SubreportBuilder;
import net.sf.dynamicreports.report.constant.HorizontalTextAlignment;
import net.sf.dynamicreports.report.constant.SplitType;
import net.sf.dynamicreports.report.datasource.DRDataSource;
import net.sf.dynamicreports.report.exception.DRException;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sourceforge.barbecue.Barcode;
import net.sourceforge.barbecue.BarcodeFactory;


public class CreateTestaPacco {
	
	File file; 
	private boolean esito; 
	public CreateTestaPacco(MagPaccoDTO pacco, List<MagItemPaccoDTO> lista_item_pacco, List<SedeDTO> lista_sedi, Session session) throws Exception {
		
			// Utility.memoryInfo();
			build(pacco, lista_item_pacco, lista_sedi, session);
			// Utility.memoryInfo();

	}
		
		private void build(MagPaccoDTO pacco, List<MagItemPaccoDTO> lista_item_pacco, List<SedeDTO> lista_sedi, Session session) throws Exception {
			
			
			InputStream is =  PivotTemplate.class.getResourceAsStream("testa_pacco.jrxml");
			

			JasperReportBuilder report = DynamicReports.report();
			
			
			
				report.setTemplateDesign(is);
				report.setTemplate(Templates.reportTemplate);
				
				report.addParameter("codice_pacco", pacco.getCodice_pacco());
				Barcode barcode = BarcodeFactory.createCode128B(pacco.getCodice_pacco());
				report.addParameter("barcode", barcode);
			
				//report.addParameter("cliente", pacco.getNome_cliente());
				//report.addParameter("sede", pacco.getNome_sede());
			
				report.addParameter("cliente", GestioneAnagraficaRemotaBO.getClienteById(String.valueOf(pacco.getDdt().getId_destinatario())).getNome());
				if(pacco.getDdt().getId_sede_destinatario()!=0) {
					report.addParameter("sede", GestioneAnagraficaRemotaBO.getSedeFromId(lista_sedi, pacco.getDdt().getId_sede_destinatario(), pacco.getDdt().getId_destinatario()).getDescrizione()
							+ " - " + GestioneAnagraficaRemotaBO.getSedeFromId(lista_sedi, pacco.getDdt().getId_sede_destinatario(), pacco.getDdt().getId_destinatario()).getIndirizzo());
				}else {
					report.addParameter("sede", "Non associate");
				}
				
				if(pacco.getNote_pacco()!=null) {
				report.addParameter("note_pacco", pacco.getNote_pacco());
				}else {
					report.addParameter("note_pacco", "");
				}
				
				SimpleDateFormat dt = new SimpleDateFormat("dd/MM/yyyy"); 
				String data;
				
				if( pacco.getData_arrivo()==null) {
					report.addParameter("data_lavorazione","");
					
				}else {
					data = dt.format(pacco.getData_arrivo());
					report.addParameter("data_lavorazione",data);					
				}
				if(pacco.getCommessa()!=null) {
					report.addParameter("commessa", pacco.getCommessa());
				}else {
					report.addParameter("commessa", "");
				}
				if(pacco.getDdt().getSpedizioniere()!=null) {
					report.addParameter("corriere", pacco.getDdt().getSpedizioniere());
				}else {
					report.addParameter("corriere", "");
				}
				
				//File imageHeader = new File("C:\\Users\\antonio.dicivita\\Calver\\logo.png");
				File imageHeader = new File(Costanti.PATH_FOLDER_LOGHI +"4133_header.jpg");
				if(imageHeader!=null) {
					report.addParameter("logo",imageHeader);			
					}
				
				SubreportBuilder subreport;
		
					subreport = cmp.subreport(getTableReport(lista_item_pacco));
					report.addDetail(subreport);

				report.setDataSource(new JREmptyDataSource());
				
				//String path = "C:\\Users\\antonio.dicivita\\Desktop\\testa_pacco.pdf";
				String path = Costanti.PATH_FOLDER+"\\"+"Magazzino" + "\\"+ "testa_pacco"+ "\\" +pacco.getCodice_pacco() +".pdf";
				  java.io.File file = new java.io.File(path);
				  FileOutputStream fos = new FileOutputStream(file);
				  report.toPdf(fos);
				
				  fos.close();
				 
				  this.file = file;
				  this.setEsito(true);
				 pacco.setLink_testa_pacco(pacco.getCodice_pacco() +".pdf");
				 
				 GestioneMagazzinoBO.updatePacco(pacco, session);

		}
		
		
		
		@SuppressWarnings("deprecation")
		public JasperReportBuilder getTableReport(List<MagItemPaccoDTO> lista_item_pacco) throws Exception{

		
		 
			JasperReportBuilder report = DynamicReports.report();

			try {
				
				report.setColumnStyle((Templates.boldCenteredStyle).setFontSize(9).setBorder(stl.penThin()).setBackgroundColor(Color.WHITE));
	 	 		report.addColumn(col.column("Codice della merce o servizio", "id_item", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
	 	 		report.addColumn(col.column("Matricola", "matricola", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
	 	 		report.addColumn(col.column("Cod. Interno", "codice_interno", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
		 		report.addColumn(col.column("Descrizione della merce o servizio", "denominazione", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
		 		report.addColumn(col.column("Quantità", "quantita", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(50));
		 		report.addColumn(col.column("Note", "note", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));		 	
		 		report.setColumnTitleStyle((Templates.boldCenteredStyle).setFontSize(9).setBorder(stl.penThin()));
				report.setDetailSplitType(SplitType.PREVENT);
				
				report.setDataSource(createDataSource(lista_item_pacco));
		  
			} catch (Exception e) {
				e.printStackTrace();
				throw e;
			}
			return report;
		}
		
		
		
		
	private JRDataSource createDataSource(List<MagItemPaccoDTO> lista_item_pacco)throws Exception {
				
			
			String[] listaCodici = new String[6];
			
			listaCodici[0]="id_item";
			listaCodici[1]="matricola";
			listaCodici[2]="codice_interno";
			listaCodici[3]="denominazione";	
			listaCodici[4]="quantita";
			listaCodici[5]="note";
			
			DRDataSource dataSource = new DRDataSource(listaCodici);
			
				for (MagItemPaccoDTO item_pacco : lista_item_pacco) {
					
					if(item_pacco!=null)
					{
						ArrayList<String> arrayPs = new ArrayList<String>();						
						
		 				arrayPs.add(String.valueOf(item_pacco.getItem().getId_tipo_proprio()));
		 				arrayPs.add(item_pacco.getItem().getMatricola());	 
		 				arrayPs.add(item_pacco.getItem().getCodice_interno());	 
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


