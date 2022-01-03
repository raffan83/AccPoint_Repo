package it.portaleSTI.bo;

import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;
import static net.sf.dynamicreports.report.builder.DynamicReports.col;
import static net.sf.dynamicreports.report.builder.DynamicReports.stl;
import static net.sf.dynamicreports.report.builder.DynamicReports.type;

import java.awt.Color;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import TemplateReport.PivotTemplate;
import it.portaleSTI.DTO.AcAttivitaCampioneDTO;
import it.portaleSTI.DTO.CampioneDTO;
import it.portaleSTI.DTO.RegistroEventiDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Templates;
import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.dynamicreports.report.builder.component.SubreportBuilder;
import net.sf.dynamicreports.report.builder.component.VerticalListBuilder;
import net.sf.dynamicreports.report.builder.style.StyleBuilder;
import net.sf.dynamicreports.report.constant.HorizontalTextAlignment;
import net.sf.dynamicreports.report.constant.Markup;
import net.sf.dynamicreports.report.constant.VerticalTextAlignment;
import net.sf.dynamicreports.report.datasource.DRDataSource;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;

public class CreateSchedaTaraturaVerificaIntermedia {
	
public CreateSchedaTaraturaVerificaIntermedia(ArrayList<AcAttivitaCampioneDTO> lista_tar_ver, ArrayList<RegistroEventiDTO> lista_tarature_evento,ArrayList<AcAttivitaCampioneDTO> lista_fuori_servizio,ArrayList<RegistroEventiDTO> lista_fuori_servizio_ev,CampioneDTO campione) throws Exception {
		
		build(lista_tar_ver,lista_tarature_evento,lista_fuori_servizio,lista_fuori_servizio_ev, campione);		
	}


private void build(ArrayList<AcAttivitaCampioneDTO> lista_tar_ver, ArrayList<RegistroEventiDTO> lista_tarature_evento, ArrayList<AcAttivitaCampioneDTO> lista_fuori_servizio,ArrayList<RegistroEventiDTO> lista_fuori_servizio_ev,CampioneDTO campione) throws Exception {
	
	InputStream is =  PivotTemplate.class.getResourceAsStream("schedaManutenzioniCampione.jrxml");
		
		JasperReportBuilder report = DynamicReports.report();		
		
		report.setTemplateDesign(is);
		report.setTemplate(Templates.reportTemplate);
				
		report.setDataSource(new JREmptyDataSource());
			
		//CampioneDTO campione = lista_manutenzioni.get(0).getCampione();
		
		File imageHeader = new File(Costanti.PATH_FOLDER_LOGHI +"logo_sti.png");
		if(imageHeader!=null) {
			report.addParameter("immagine",imageHeader);
		
		}
		
		if(lista_tarature_evento!=null) {
			report.addParameter("titolo", "SCHEDA TARATURA APPARECCHIATURA (STA)");
		}else {
			report.addParameter("titolo", "SCHEDA TARATURA / CONFERMA APPARECCHIATURA (STCA)");	
		}
		if(campione.getNome()!=null) {
			report.addParameter("denominazione", campione.getNome());
		}else {
			report.addParameter("denominazione", "");
		}
		if(campione.getCodice()!=null) {
			report.addParameter("codice_interno", campione.getCodice());
		}else {
			report.addParameter("codice_interno", "");
		}
		if(campione.getMatricola()!=null) {
			report.addParameter("matricola", campione.getMatricola());
		}else {
			report.addParameter("matricola", "");
		}
		
		SubreportBuilder subreport = null;
		
		if(lista_tarature_evento!=null) {
			subreport = cmp.subreport(getTableReportEvento(lista_tarature_evento));
		}else {
			subreport = cmp.subreport(getTableReport(lista_tar_ver));	
		}		
		
		report.detail(subreport);
		
		if(lista_fuori_servizio!=null && lista_fuori_servizio.size()>0) {
			SubreportBuilder subreport_fs =	cmp.subreport(getTableReportFs(lista_fuori_servizio)); 
			
			VerticalListBuilder vl = cmp.verticalList(cmp.verticalGap(25), cmp.text("Attività fuori servizio").setHorizontalTextAlignment(HorizontalTextAlignment.CENTER), cmp.verticalGap(15), subreport_fs);
			report.addDetail(vl);
		}else if(lista_fuori_servizio_ev!=null && lista_fuori_servizio_ev.size()>0){
			SubreportBuilder subreport_fs =	cmp.subreport(getTableReportFsEv(lista_fuori_servizio_ev)); 
			
			VerticalListBuilder vl = cmp.verticalList(cmp.verticalGap(25), cmp.text("Attività fuori servizio").setHorizontalTextAlignment(HorizontalTextAlignment.CENTER), cmp.verticalGap(15), subreport_fs);
			report.addDetail(vl);
		}
		
		
		StyleBuilder footerStyle = Templates.footerStyle.setFontSize(8).setTextAlignment(HorizontalTextAlignment.LEFT, VerticalTextAlignment.MIDDLE).setMarkup(Markup.HTML);
		if(lista_tarature_evento!=null) {
			report.addPageFooter(cmp.horizontalList(
					cmp.text("MOD-PGI009-03").setStyle(footerStyle),
					cmp.horizontalGap(370),
					cmp.text("Rev. 0 del 31/07/2019").setStyle(footerStyle)
					));
		}else {
			report.addPageFooter(cmp.horizontalList(
					cmp.text("MOD-CDT-004").setStyle(footerStyle),
					cmp.horizontalGap(370),
					cmp.text("Rev. A del 20/09/2004").setStyle(footerStyle)
					));
		}
		
		
		//String path = "C:\\Users\\antonio.dicivita\\Desktop\\";
		
		String path = "";
		if(lista_tarature_evento!=null) {
			path = Costanti.PATH_FOLDER_CAMPIONI+campione.getId()+"\\RegistroEventi\\Taratura\\"; 
		}else {
			path = Costanti.PATH_FOLDER_CAMPIONI+campione.getId()+"\\SchedaVerificaIntermedia\\";
		}
		
		  java.io.File folder = new java.io.File(path);
		  if(!folder.exists()) {
			  folder.mkdirs();
			  
		  }
		
		  File file = new File(path+"stca_"+campione.getId()+".pdf");
		  FileOutputStream fos = new FileOutputStream(file);
		  report.toPdf(fos);
		
		  fos.close();
		  
	}

	private JasperReportBuilder getTableReport(ArrayList<AcAttivitaCampioneDTO> lista_tar_ver) throws Exception {
		
		JasperReportBuilder report = DynamicReports.report();

		report.setColumnStyle((Templates.boldCenteredStyle).setBackgroundColor(Color.WHITE).setFontSize(9));
		//report.addColumn(col.column("Data","data", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(60));	
		report.addColumn(col.column("Tipo Attività", "tipo", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
		report.addColumn(col.column("Ente", "ente", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
		report.addColumn(col.column("Data", "data", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
	 	report.addColumn(col.column("Certificato di taratura","certificato", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
	 	report.addColumn(col.column("Data scadenza","data_scadenza", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
	 	report.addColumn(col.column("Etichettatura di conferma","etichettatura", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
	 	report.addColumn(col.column("Stato","stato", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
	 	report.addColumn(col.column("Note","campo_sospesi", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
	 	report.addColumn(col.column("Operatore","operatore", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
	 	
		report.setColumnTitleStyle((Templates.boldCenteredStyle).setBackgroundColor(Color.WHITE).setFontSize(9).setBorder(stl.penThin()));
		
	 	report.setDataSource(createDataSource(lista_tar_ver));
		report.highlightDetailEvenRows();
		return report;
	}
	
private JasperReportBuilder getTableReportFs(ArrayList<AcAttivitaCampioneDTO> lista_fuori_servizio) throws Exception {
		
		JasperReportBuilder report = DynamicReports.report();

		report.setColumnStyle((Templates.boldCenteredStyle).setBackgroundColor(Color.WHITE).setFontSize(9));
		report.addColumn(col.column("Data","data", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(60));	
		
	 	report.addColumn(col.column("Descrizione attività","descrizione", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
	 	report.addColumn(col.column("Operatore","operatore", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(120));
	 	
		report.setColumnTitleStyle((Templates.boldCenteredStyle).setBackgroundColor(Color.WHITE).setFontSize(9).setBorder(stl.penThin()));
		
	 	report.setDataSource(createDataSourceFs(lista_fuori_servizio));
	 	report.highlightDetailEvenRows();
		return report;
	}

private JasperReportBuilder getTableReportFsEv(ArrayList<RegistroEventiDTO> lista_fuori_servizio) throws Exception {
	
	JasperReportBuilder report = DynamicReports.report();

	report.setColumnStyle((Templates.boldCenteredStyle).setBackgroundColor(Color.WHITE).setFontSize(9));
	report.addColumn(col.column("Data","data", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(60));	
	
 	report.addColumn(col.column("Descrizione attività","descrizione", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
 	report.addColumn(col.column("Operatore","operatore", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(120));
 	
	report.setColumnTitleStyle((Templates.boldCenteredStyle).setBackgroundColor(Color.WHITE).setFontSize(9).setBorder(stl.penThin()));
	
 	report.setDataSource(createDataSourceFsEv(lista_fuori_servizio));
 	report.highlightDetailEvenRows();
	return report;
}


	
	private JasperReportBuilder getTableReportEvento(ArrayList<RegistroEventiDTO> lista_tarature_evento) throws Exception {
		
		JasperReportBuilder report = DynamicReports.report();

		report.setColumnStyle((Templates.boldCenteredStyle).setBackgroundColor(Color.WHITE).setFontSize(9));
		
		report.addColumn(col.column("Tipo evento", "tipo", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
		report.addColumn(col.column("Data", "data", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
		report.addColumn(col.column("Data prossima", "data_scadenza", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
		report.addColumn(col.column("Centro LAT","laboratorio", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
	 	report.addColumn(col.column("Certificato","certificato", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
	 	report.addColumn(col.column("Stato","stato", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
	 	report.addColumn(col.column("Operatore","operatore", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER));
	 	
		report.setColumnTitleStyle((Templates.boldCenteredStyle).setBackgroundColor(Color.WHITE).setFontSize(9).setBorder(stl.penThin()));
		
	 	report.setDataSource(createDataSourceEvento(lista_tarature_evento));
		report.highlightDetailEvenRows();
		return report;
	}
	
	private JRDataSource createDataSource(ArrayList<AcAttivitaCampioneDTO> lista_tar_ver)throws Exception {
		DRDataSource dataSource = null;
		String[] listaCodici = null;
			
			listaCodici = new String[9];
					
			listaCodici[0]="tipo";
			listaCodici[1]="ente";
			listaCodici[2]="data";
			listaCodici[3]="certificato";
			listaCodici[4]="data_scadenza";
			listaCodici[5]="etichettatura";
			listaCodici[6]="stato";
			listaCodici[7]="campo_sospesi";
			listaCodici[8]="operatore";
			
			dataSource = new DRDataSource(listaCodici);
			
			SimpleDateFormat dt = new SimpleDateFormat("yyyy-MM-dd");
			if(lista_tar_ver.size()>0) {
				for (AcAttivitaCampioneDTO attivita : lista_tar_ver) {						
					if(attivita!=null){
						ArrayList<String> arrayPs = new ArrayList<String>();
						
						arrayPs.add(attivita.getTipo_attivita().getDescrizione());
						if(attivita.getEnte()!=null) {
							arrayPs.add(attivita.getEnte());	
						}else {
							arrayPs.add("");
						}											
						arrayPs.add(dt.format(attivita.getData()));
						if(attivita.getCertificato()!=null) {
							arrayPs.add(attivita.getCertificato().getMisura().getnCertificato());	
						}else {
							arrayPs.add("");
						}
						arrayPs.add(dt.format(attivita.getData_scadenza()));
						arrayPs.add(attivita.getEtichettatura());
						arrayPs.add(attivita.getStato());
						arrayPs.add(attivita.getCampo_sospesi());
						
						if(attivita.getOperatore()!=null) {
							arrayPs.add(attivita.getOperatore().getNominativo());	
						}else {
							arrayPs.add("");
						}						
						
			 			Object[] listaValori = arrayPs.toArray();
						
					    dataSource.add(listaValori);				   
					}				
				}
			}else {
				dataSource.add("","","","","","","","","");
			}
				
		 		    return dataSource;
		 	}
		
	
	private JRDataSource createDataSourceEvento(ArrayList<RegistroEventiDTO> lista_tarature_evento)throws Exception {
		DRDataSource dataSource = null;
		String[] listaCodici = null;
			
			listaCodici = new String[7];
					
			listaCodici[0]="tipo";
			listaCodici[1]="data";
			listaCodici[2]="data_scadenza";
			listaCodici[3]="laboratorio";
			listaCodici[4]="certificato";
			listaCodici[5]="stato";
			listaCodici[6]="operatore";
			
			dataSource = new DRDataSource(listaCodici);
			
			SimpleDateFormat dt = new SimpleDateFormat("yyyy-MM-dd");
			if(lista_tarature_evento.size()>0) {
				for (RegistroEventiDTO evento : lista_tarature_evento) {						
					if(evento!=null){
						ArrayList<String> arrayPs = new ArrayList<String>();						
														
						
						if(evento.getTipo_evento().getId()==2) {
							arrayPs.add("Taratura");
						}else {
							arrayPs.add("Verifica intermedia");
						}
						arrayPs.add(dt.format(evento.getData_evento()));
						if(evento.getStato().equals("Idonea")) {
							arrayPs.add(dt.format(evento.getData_scadenza()));	
						}else {
							arrayPs.add("");
						}
						if(evento.getLaboratorio()!=null) {
							arrayPs.add(evento.getLaboratorio());	
						}else {
							arrayPs.add("");
						}
						
						if(evento.getNumero_certificato()!=null) {
							arrayPs.add(evento.getNumero_certificato());	
						}else {
							arrayPs.add("");
						}
						if(evento.getStato()!=null) {
							arrayPs.add(evento.getStato());
						}else {
							arrayPs.add("");
						}
						if(evento.getOperatore()!=null) {
							arrayPs.add(evento.getOperatore().getNominativo());	
						}else {
							arrayPs.add("");
						}						
						
			 			Object[] listaValori = arrayPs.toArray();
						
					    dataSource.add(listaValori);				   
					}				
				}
			}else {
				dataSource.add("","","","","","");
			}
				
		 		    return dataSource;
		 	}
	
	
	
	private JRDataSource createDataSourceFs(ArrayList<AcAttivitaCampioneDTO> lista_fuori_servizio)throws Exception {
		DRDataSource dataSource = null;
		String[] listaCodici = null;
			
			listaCodici = new String[3];
					
			listaCodici[0]="data";
			listaCodici[1]="descrizione";
			listaCodici[2]="operatore";
			
			dataSource = new DRDataSource(listaCodici);
			
			SimpleDateFormat dt = new SimpleDateFormat("yyyy-MM-dd");
			if(lista_fuori_servizio.size()>0) {
				for (AcAttivitaCampioneDTO manutenzione : lista_fuori_servizio) {						
					if(manutenzione!=null){
						ArrayList<String> arrayPs = new ArrayList<String>();
							
						arrayPs.add(dt.format(manutenzione.getData()));
						arrayPs.add(manutenzione.getDescrizione_attivita());
						if(manutenzione.getOperatore()!=null) {
							arrayPs.add(manutenzione.getOperatore().getNominativo());	
						}else {
							arrayPs.add("");
						}						
						
			 			Object[] listaValori = arrayPs.toArray();
						
					    dataSource.add(listaValori);				   
					}				
				}
			}else {
				dataSource.add("","","");
			}
				
		 		    return dataSource;
		 	}
	
	
	private JRDataSource createDataSourceFsEv(ArrayList<RegistroEventiDTO> lista_fuori_servizio)throws Exception {
		DRDataSource dataSource = null;
		String[] listaCodici = null;
			
			listaCodici = new String[3];
					
			listaCodici[0]="data";
			listaCodici[1]="descrizione";
			listaCodici[2]="operatore";
			
			dataSource = new DRDataSource(listaCodici);
			
			SimpleDateFormat dt = new SimpleDateFormat("yyyy-MM-dd");
			if(lista_fuori_servizio.size()>0) {
				for (RegistroEventiDTO evento : lista_fuori_servizio) {						
					if(evento!=null){
						ArrayList<String> arrayPs = new ArrayList<String>();
							
						arrayPs.add(dt.format(evento.getData_evento()));
						arrayPs.add(evento.getDescrizione());
						if(evento.getOperatore()!=null) {
							arrayPs.add(evento.getOperatore().getNominativo());	
						}else {
							arrayPs.add("");
						}						
						
			 			Object[] listaValori = arrayPs.toArray();
						
					    dataSource.add(listaValori);				   
					}				
				}
			}else {
				dataSource.add("","","");
			}
				
		 		    return dataSource;
		 	}
	
//	public static void main(String[] args) throws Exception {
//		new ContextListener().configCostantApplication();
//		Session session=SessionFacotryDAO.get().openSession();
//		session.beginTransaction();
//		
//		ArrayList<AcAttivitaCampioneDTO> lista_manutenzioni = GestioneAttivitaCampioneBO.getListaManutenzioniCampione(54800, session);
//		new CreateSchedaManutenzioniCampione(lista_manutenzioni);
//		
//		session.close();
//		System.out.println("FINITO");
//	}

}
