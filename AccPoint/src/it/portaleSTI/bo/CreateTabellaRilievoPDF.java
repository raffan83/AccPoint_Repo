package it.portaleSTI.bo;

import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;
import static net.sf.dynamicreports.report.builder.DynamicReports.col;
import static net.sf.dynamicreports.report.builder.DynamicReports.stl;
import static net.sf.dynamicreports.report.builder.DynamicReports.type;

import java.awt.Color;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.imageio.ImageIO;

import org.apache.commons.lang3.math.NumberUtils;
import org.hibernate.HibernateException;
import org.hibernate.Session;

import TemplateReport.PivotTemplate;
import it.portaleSTI.DAO.SessionFacotryDAO;
import it.portaleSTI.DTO.RilMisuraRilievoDTO;
import it.portaleSTI.DTO.RilParticolareDTO;
import it.portaleSTI.DTO.RilPuntoQuotaDTO;
import it.portaleSTI.DTO.RilQuotaDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Templates;
import it.portaleSTI.Util.Utility;
import it.portaleSTI.action.ContextListener;
import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
import net.sf.dynamicreports.report.base.expression.AbstractSimpleExpression;
import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.dynamicreports.report.builder.component.ImageBuilder;
import net.sf.dynamicreports.report.builder.component.SubreportBuilder;
import net.sf.dynamicreports.report.builder.style.ConditionalStyleBuilder;
import net.sf.dynamicreports.report.builder.style.StyleBuilder;
import net.sf.dynamicreports.report.builder.style.Styles;
import net.sf.dynamicreports.report.constant.HorizontalImageAlignment;
import net.sf.dynamicreports.report.constant.HorizontalTextAlignment;
import net.sf.dynamicreports.report.constant.PageOrientation;
import net.sf.dynamicreports.report.constant.PageType;
import net.sf.dynamicreports.report.constant.StretchType;
import net.sf.dynamicreports.report.datasource.DRDataSource;
import net.sf.dynamicreports.report.definition.ReportParameters;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.type.StretchTypeEnum;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimplePdfExporterConfiguration;



public class CreateTabellaRilievoPDF {
	
	int max_pezzi = 3;
	public CreateTabellaRilievoPDF(ArrayList<RilQuotaDTO> lista_quote, List<SedeDTO> listaSedi, String path_simboli, String path_firme, Session session) throws Exception {
		
		build(lista_quote, listaSedi,path_simboli, path_firme, session);
	}
	
	
	
	private void build(ArrayList<RilQuotaDTO> lista_quote, List<SedeDTO> listaSedi, String path_simboli, String path_firme, Session session) throws Exception {
		InputStream is =  PivotTemplate.class.getResourceAsStream("schedaRilieviDimensionali.jrxml");
		
		JasperReportBuilder report = DynamicReports.report();
		
		report.setTemplateDesign(is);
		report.setTemplate(Templates.reportTemplate);
		report.setDataSource(new JREmptyDataSource());
		
		JasperReportBuilder report_table = DynamicReports.report();
		report_table.setDataSource(new JREmptyDataSource());
		report_table.setDataSource(new JREmptyDataSource());
		report_table.setPageFormat(PageType.A4, PageOrientation.LANDSCAPE);

		//RilParticolareDTO particolare = GestioneRilieviBO.getImprontaById(lista_quote.get(0).getImpronta().getId(), session);
		RilParticolareDTO particolare = lista_quote.get(0).getImpronta();
		RilMisuraRilievoDTO rilievo = lista_quote.get(0).getImpronta().getMisura();
		
		ArrayList<RilParticolareDTO> lista_impronte = GestioneRilieviBO.getListaImprontePerMisura(rilievo.getId(), session);
		ArrayList<RilParticolareDTO> lista_particolari = GestioneRilieviBO.getListaParticolariPerMisura(rilievo.getId(), session);
		File imageHeader = new File(Costanti.PATH_FOLDER_LOGHI +"4133_header.jpg");
		if(imageHeader!=null) {
			report.addParameter("logo",imageHeader);
		}
		
		if(rilievo.getId_cliente_util()!=0) {
			if(rilievo.getId_sede_util()!=0) {
				report.addParameter("cliente", GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, rilievo.getId_sede_util(), rilievo.getId_cliente_util()).getDescrizione());	
			}else {
				report.addParameter("cliente", GestioneAnagraficaRemotaBO.getClienteById(String.valueOf(rilievo.getId_cliente_util())).getNome());
			}
			
		}else {
			report.addParameter("cliente", "");
		}
		
		report.addParameter("numero_scheda", "SRD "+rilievo.getId());
		
		if(rilievo.getDenominazione()!=null) {
			report.addParameter("denominazione", rilievo.getDenominazione());	
		}else {
			report.addParameter("denominazione", "");
		}
					
		if(rilievo.getDisegno()!=null) {
			report.addParameter("disegno", rilievo.getDisegno());	
		}else {
			report.addParameter("disegno", "");
		}
		
		if(rilievo.getVariante()!=null){
			report.addParameter("variante", rilievo.getVariante());
		}else {
			report.addParameter("variante", "");
		}
		
		if(rilievo.getMateriale()!=null) {
			report.addParameter("materiale", rilievo.getMateriale());
		}else {
			report.addParameter("materiale", "");	
		}
					
		if(rilievo.getFornitore()!=null) {
			report.addParameter("fornitore", rilievo.getFornitore());	
		}else {
			report.addParameter("fornitore", "");
		}
		
		if(rilievo.getApparecchio()!=null) {
			report.addParameter("apparecchio", rilievo.getApparecchio());	
		}else {
			report.addParameter("apparecchio", "");
		}
		
		if(lista_impronte.size()>0) {
			report.addParameter("numero_impronte", lista_impronte.size());
		}else {
			report.addParameter("numero_impronte", "");
		}
		
		if(lista_impronte.size()>0) {
			report.addParameter("numero_pezzi", lista_impronte.get(0).getNumero_pezzi());
		}else {
			if(lista_particolari.size()>0) {
				report.addParameter("numero_pezzi", lista_particolari.get(0).getNumero_pezzi());
			}else {
				report.addParameter("numero_pezzi", "");
			}
		}
		
		if(lista_impronte.size()>0) {
			report.addParameter("numero_pezzi_totale", lista_impronte.get(0).getNumero_pezzi()*lista_impronte.size());
		}else {
			if(lista_particolari.size()>0) {
				report.addParameter("numero_pezzi_totale", lista_particolari.get(0).getNumero_pezzi());
			}else {
				report.addParameter("numero_pezzi_totale", "");
			}				
		}
		if(rilievo.getNote()!=null) {
			report.addParameter("note_rilievo", rilievo.getNote());
		}else {
			report.addParameter("note_rilievo", "");
		}
		if(rilievo.getTipo_rilievo()!=null) {
			report.addParameter("tipo_rilievo", rilievo.getTipo_rilievo().getDescrizione());
		}else {
			report.addParameter("tipo_rilievo", "");
		}
		if(rilievo.getData_consegna()!=null) {
			SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy");  
			String strDate = formatter.format(rilievo.getData_consegna());  
			report.addParameter("data_verifica", strDate);
		}else {
			report.addParameter("data_verifica", "");	
		}
		
		if(rilievo.getUtente()!=null) {
			report.addParameter("operatore", rilievo.getUtente().getNominativo());
		}else {
			report.addParameter("operatore", "");
		}
		
		File firma = new File(path_firme + rilievo.getUtente().getNominativo().replace(" ", "_").toUpperCase() + ".jpg" );
		
		if(firma.exists()) {
			report.addParameter("firma",firma);			
		}else {
			report.addParameter("firma","");
		}
		
		File imageCenter = null;
		if(rilievo.getImmagine_frontespizio()!= null && !rilievo.getImmagine_frontespizio().equals("")) {
			imageCenter = new File(Costanti.PATH_FOLDER+"\\RilieviDimensionali\\Allegati\\Immagini\\"+rilievo.getId()+"\\"+rilievo.getImmagine_frontespizio());
		}
		if(imageCenter!=null) {
			report.addParameter("immagine_frontespizio",imageCenter);
		
		}else {
			report.addParameter("immagine_frontespizio","");
		}
		
		if(rilievo.getTipo_rilievo().getId()!=3) {
		int indice_particolare = 1;
		
			SubreportBuilder subreport; 
			
		if(lista_quote!=null && lista_quote.size()>0) {
			if(lista_quote.get(0).getListaPuntiQuota().size()>max_pezzi) {
				
				int index = lista_quote.get(0).getListaPuntiQuota().size()/max_pezzi;
				if(lista_quote.get(0).getListaPuntiQuota().size()%max_pezzi!=0) {
					for (int j = 0;j<index;j++) {
						if(particolare.getNome_impronta()!=null && !particolare.getNome_impronta().equals("")) {
							subreport = cmp.subreport(getTableReport(lista_quote,j+1, "Impronta " + particolare.getNome_impronta(), particolare.getNote(), listaSedi, particolare.getMisura().getId(), path_simboli, particolare.getMisura().getCifre_decimali()));								
						}else {
							subreport = cmp.subreport(getTableReport(lista_quote,j+1, "Particolare "+indice_particolare, particolare.getNote(), listaSedi, particolare.getMisura().getId(), path_simboli, particolare.getMisura().getCifre_decimali()));
						}							
						//report.addDetail(subreport);						
						//report.detail(cmp.pageBreak());		
						report_table.addDetail(subreport);
						report_table.detail(cmp.pageBreak());
					}
					if(lista_quote.get(0).getImpronta().getNome_impronta()!=null && lista_quote.get(0).getImpronta().getNome_impronta().equals("")) {
						subreport = cmp.subreport(getTableReport2(lista_quote, index,"Impronta " +  particolare.getNome_impronta(),particolare.getNote(), listaSedi, particolare.getMisura().getId(), path_simboli, particolare.getMisura().getCifre_decimali()));	
					}else {
						subreport = cmp.subreport(getTableReport2(lista_quote, index,"Particolare "+indice_particolare, particolare.getNote(), listaSedi, particolare.getMisura().getId(), path_simboli, particolare.getMisura().getCifre_decimali()));
						
					}		
					report_table.addDetail(subreport);
					report_table.detail(cmp.pageBreak());	
					indice_particolare++;
				}else {
					for (int j = 0;j<index;j++) {
						if(particolare.getNome_impronta()!=null && !particolare.getNome_impronta().equals("")) {
							subreport = cmp.subreport(getTableReport(lista_quote,j+1,"Impronta " + particolare.getNome_impronta(), particolare.getNote(), listaSedi, particolare.getMisura().getId(), path_simboli, particolare.getMisura().getCifre_decimali()));	
						}else {
							subreport = cmp.subreport(getTableReport(lista_quote,j+1,"Particolare "+indice_particolare, particolare.getNote(), listaSedi, particolare.getMisura().getId(), path_simboli, particolare.getMisura().getCifre_decimali()));
							indice_particolare++;
						}						
						report_table.addDetail(subreport);
						report_table.detail(cmp.pageBreak());
					}
				}
			}else {
				
				if(particolare.getNome_impronta()!=null && !particolare.getNome_impronta().equals("")) {
					subreport = cmp.subreport(getTableReport2(lista_quote, 0,"Impronta " + particolare.getNome_impronta(), particolare.getNote(), listaSedi, particolare.getMisura().getId(), path_simboli, particolare.getMisura().getCifre_decimali()));	
				}else {
					subreport = cmp.subreport(getTableReport2(lista_quote, 0,"Particolare "+indice_particolare, particolare.getNote(), listaSedi, particolare.getMisura().getId(), path_simboli, particolare.getMisura().getCifre_decimali()));
					indice_particolare++;
				}						
				
				report_table.addDetail(subreport);
				report_table.detail(cmp.pageBreak());					
			}
		
			}
		
		
		report_table.pageFooter(cmp.verticalList(
				cmp.line().setFixedHeight(1),
				cmp.horizontalList(cmp.pageXslashY()))
				);
		}
		List<JasperPrint> jasperPrintList = new ArrayList<JasperPrint>();
		JasperPrint jasperPrint1 = report.toJasperPrint();
		jasperPrintList.add(jasperPrint1);
		if(rilievo.getTipo_rilievo().getId()!=3) {
			JasperPrint jasperPrint2 = report_table.toJasperPrint();
			jasperPrintList.add(jasperPrint2);
		}
		//String path = "C:\\Users\\antonio.dicivita\\Desktop\\";
		String path = Costanti.PATH_FOLDER + "RilieviDimensionali\\Schede\\" + particolare.getMisura().getId() + "\\Temp\\";
	
		if(!new File(path).exists()) {
			new File(path).mkdirs();
		}
		JRPdfExporter exporter = new JRPdfExporter();
		exporter.setExporterInput(SimpleExporterInput.getInstance(jasperPrintList)); 
		exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(path + "scheda_temp.pdf")); 
		SimplePdfExporterConfiguration configuration = new SimplePdfExporterConfiguration();
		configuration.setCreatingBatchModeBookmarks(true); 
		exporter.setConfiguration(configuration);
		exporter.exportReport();
	}
	
//	public static void main(String[] args) throws HibernateException, Exception {
//		new ContextListener().configCostantApplication();
//		Session session=SessionFacotryDAO.get().openSession();
//		session.beginTransaction();
//		List<SedeDTO> listaSedi = GestioneAnagraficaRemotaBO.getListaSedi();
//			RilMisuraRilievoDTO rilievo = GestioneRilieviBO.getMisuraRilieviFromId(27, session);
//			
//			String path_simboli = "C:\\Users\\antonio.dicivita\\eclipse-workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\AccPoint\\images\\simboli_rilievi\\";
//		
//			new CreateTabellaRilievoPDF(rilievo,listaSedi, path_simboli, session);
//			session.close();
//			System.out.println("FINITO");
//	}





private JRDataSource createDataSource(ArrayList<RilQuotaDTO> lista_quote, int index_start, int cifre_decimali)throws Exception {
	DRDataSource dataSource = null;
	String[] listaCodici = null;
		
		listaCodici = new String[3*lista_quote.get(0).getListaPuntiQuota().size()+9];
		
		listaCodici[0]="Coordinata";
		listaCodici[1]="image";
		listaCodici[2]="Quota Nominale";
		listaCodici[3]="Funzionale";
		listaCodici[4]="U.M.";
		listaCodici[5]="Tolleranza";	
		
		int h=0;
		for(int j = (index_start-1)*max_pezzi; j<(index_start*max_pezzi);j++) {				
			listaCodici[6+h] = "Pezzo "+(j+1);
			h++;
		}
		//listaCodici[6+ (index_start*max_pezzi) - (index_start-1)*max_pezzi]="Note";	
		
//		for(int j = (index_start-1)*max_pezzi; j<(index_start*max_pezzi);j++) {				
//			listaCodici[7+h] = "Δ "+(j+1);
//			h++;
//			listaCodici[7+h] = "Δ "+(j+1) +" %";
//			h++;
//		}
//
//		listaCodici[7+h]="Max Dev";	
//		listaCodici[8+h]="Max Dev %";
		for(int j = (index_start-1)*max_pezzi; j<(index_start*max_pezzi);j++) {				
			listaCodici[6+h] = "Δ "+(j+1);
			h++;
			listaCodici[6+h] = "Δ "+(j+1) +" %";
			h++;
		}

		listaCodici[6+h]="Max Dev";	
		listaCodici[7+h]="Max Dev %";
		
		//listaCodici[8+ (index_start*max_pezzi) - (index_start-1)*max_pezzi]="Note";
		
		listaCodici[8+ h]="Note";
		dataSource = new DRDataSource(listaCodici);
		
			for (RilQuotaDTO quota : lista_quote) {
				
				if(quota!=null)
				{
					ArrayList<String> arrayPs = new ArrayList<String>();
					arrayPs.add(quota.getCoordinata());
					if(quota.getSimbolo()!=null) {
						arrayPs.add(quota.getSimbolo().getDescrizione());
					}else {
						arrayPs.add("");
					}
					if(quota.getVal_nominale()!=null) {
						if(NumberUtils.isNumber(quota.getVal_nominale())){
							arrayPs.add(Utility.setDecimalDigits(cifre_decimali, String.valueOf(quota.getVal_nominale())));	
						}else {
							arrayPs.add(quota.getVal_nominale());
						}
	 						
	 				}else {
	 					arrayPs.add("");
	 				}	
					if(quota.getQuota_funzionale()!=null) {
	 					arrayPs.add(quota.getQuota_funzionale().getDescrizione());
	 				}else {
	 					arrayPs.add("");
	 				}
	 				arrayPs.add(quota.getUm());		 				
					if(quota.getTolleranza_negativa()!=null && quota.getTolleranza_positiva()!=null) {
						if(NumberUtils.isNumber(quota.getTolleranza_negativa())&&NumberUtils.isNumber(quota.getTolleranza_positiva())) {
							if(Math.abs(new Double(quota.getTolleranza_negativa())) == Math.abs(new Double(quota.getTolleranza_positiva()))) {
								arrayPs.add("±" + Utility.setDecimalDigits(cifre_decimali, String.valueOf(Math.abs(new Double(quota.getTolleranza_negativa())))));
							}else {
								arrayPs.add(Utility.setDecimalDigits(cifre_decimali, String.valueOf(quota.getTolleranza_negativa())) + " ÷ " + Utility.setDecimalDigits(cifre_decimali, String.valueOf(new Double(quota.getTolleranza_positiva()))));
							}
						}else {
							arrayPs.add("/");
						}							
									
					}else {
						arrayPs.add("");	 		
					}
	 				
	 				List list = new ArrayList(quota.getListaPuntiQuota());
	 				Collections.sort(list, new Comparator<RilPuntoQuotaDTO>() {
	 				    public int compare(RilPuntoQuotaDTO o1, RilPuntoQuotaDTO o2) {
	 				    	Integer obj1 = o1.getId();
	 				    	Integer obj2 = o2.getId();
	 				        return obj1.compareTo(obj2);
	 				    }
	 				});
	 				for(int k = (index_start-1)*max_pezzi; k<(index_start*max_pezzi);k++) {
	 					
 						if(((RilPuntoQuotaDTO) list.get(k)).getValore_punto()!=null) {
 							if(NumberUtils.isNumber(((RilPuntoQuotaDTO) list.get(k)).getValore_punto())) {
 								arrayPs.add(Utility.setDecimalDigits(cifre_decimali, String.valueOf(((RilPuntoQuotaDTO) list.get(k)).getValore_punto())));	
 							}else {
 								arrayPs.add(((RilPuntoQuotaDTO) list.get(k)).getValore_punto());
 							}
	 						
	 					}else {
	 						arrayPs.add("");
	 					}
	 				}
	 					 				
	 				for(int k = (index_start-1)*max_pezzi; k<(index_start*max_pezzi);k++) {
	 					
 						if(((RilPuntoQuotaDTO) list.get(k)).getDelta()!=null) {
 							arrayPs.add(((RilPuntoQuotaDTO) list.get(k)).getDelta());
	 						
	 					}else {
	 						arrayPs.add("");
	 					}
 						
 						if(((RilPuntoQuotaDTO) list.get(k)).getDelta_perc()!=null) {
 							arrayPs.add(((RilPuntoQuotaDTO) list.get(k)).getDelta_perc());
	 						
	 					}else {
	 						arrayPs.add("");
	 					}

				}
	 				arrayPs.add(Utility.setDecimalDigits(cifre_decimali, Utility.getMaxDelta(quota, false)));
	 				arrayPs.add(Utility.setDecimalDigits(cifre_decimali, Utility.getMaxDelta(quota, true)));
	 				
	 				if(quota.getNote()!=null) {
	 					arrayPs.add(quota.getNote());	
	 				}else {
	 					arrayPs.add("");
	 				}
	 				
	 				Object[] listaValori = arrayPs.toArray();

			         dataSource.add(listaValori);				   
				}				
			}
 		    return dataSource;
 	}


private JRDataSource createDataSource2(ArrayList<RilQuotaDTO> lista_quote,int index_start, int cifre_decimali)throws Exception {
	DRDataSource dataSource = null;

	String[] listaCodici = null;		

		listaCodici = new String[3*lista_quote.get(0).getListaPuntiQuota().size()+9];

		listaCodici[0]="Coordinata";
		listaCodici[1]="image";
		listaCodici[2]="Quota Nominale";
		listaCodici[3]="Funzionale";
		listaCodici[4]="U.M.";
		listaCodici[5]="Tolleranza";	
		
		int h=0;
		
		for(int j = (index_start*max_pezzi); j<lista_quote.get(0).getListaPuntiQuota().size();j++) {
			
			listaCodici[6+h] = "Pezzo "+(j+1);
			h++;
		}
//		listaCodici[6+ h+(index_start*max_pezzi)]="Note";	
//		
//		for(int j = (index_start*max_pezzi); j<lista_quote.get(0).getListaPuntiQuota().size();j++) {			
//			listaCodici[7+h] = "Δ "+(j+1);		
//			h++;
//			listaCodici[7+h] = "Δ "+(j+1) +" %";
//			h++;
//		}
//		listaCodici[7+h]="Max Dev";	
//		listaCodici[8+h]="Max Dev %";	

		
		for(int j = (index_start*max_pezzi); j<lista_quote.get(0).getListaPuntiQuota().size();j++) {			
			listaCodici[6+h] = "Δ "+(j+1);		
			h++;
			listaCodici[6+h] = "Δ "+(j+1) +" %";
			h++;
		}
		listaCodici[6+h]="Max Dev";	
		listaCodici[7+h]="Max Dev %";	
		
		//listaCodici[8+ h+(index_start*max_pezzi)]="Note";	
		listaCodici[8+ h]="Note";	
		dataSource = new DRDataSource(listaCodici);

			for (RilQuotaDTO quota : lista_quote) {
				
				if(quota!=null)
				{		
					ArrayList<String> arrayPs2 = new ArrayList<String>();
					arrayPs2.add(quota.getCoordinata());
					if(quota.getSimbolo()!=null) {
						arrayPs2.add(quota.getSimbolo().getDescrizione());
					}else {
						arrayPs2.add("");
					}
					if(quota.getVal_nominale()!=null) {
						if(NumberUtils.isNumber(quota.getVal_nominale())){
							arrayPs2.add(Utility.setDecimalDigits(cifre_decimali, String.valueOf(quota.getVal_nominale())));	
						}else {
							arrayPs2.add(quota.getVal_nominale());
						}		 					
	 				}else {
	 					arrayPs2.add("");
	 				}	
					if(quota.getQuota_funzionale()!=null) {
	 					arrayPs2.add(quota.getQuota_funzionale().getDescrizione());
	 				}else {
	 					arrayPs2.add("");
	 				}
	 				arrayPs2.add(quota.getUm());		 				
					if(quota.getTolleranza_negativa()!=null && quota.getTolleranza_positiva()!=null) {														
						if(NumberUtils.isNumber((quota.getTolleranza_negativa()))&&NumberUtils.isNumber(quota.getTolleranza_positiva().replace(",", "."))) {
							if(Math.abs(new Double(quota.getTolleranza_negativa())) == Math.abs(new Double(quota.getTolleranza_positiva()))) {
								arrayPs2.add("±" + Utility.setDecimalDigits(cifre_decimali, String.valueOf(Math.abs(new Double(quota.getTolleranza_negativa())))));
							}else {
								arrayPs2.add(Utility.setDecimalDigits(cifre_decimali, String.valueOf(quota.getTolleranza_negativa())) + " ÷ " + Utility.setDecimalDigits(cifre_decimali, String.valueOf(new Double(quota.getTolleranza_positiva()))));
							}
						}else {
							arrayPs2.add("/");
						}
															
					}else {
						arrayPs2.add("");	 		
					}
 						 				
	 				List list = new ArrayList(quota.getListaPuntiQuota());
	 				Collections.sort(list, new Comparator<RilPuntoQuotaDTO>() {
	 				    public int compare(RilPuntoQuotaDTO o1, RilPuntoQuotaDTO o2) {
	 				    	Integer obj1 = o1.getId();
	 				    	Integer obj2 = o2.getId();
	 				        return obj1.compareTo(obj2);
	 				    }
	 				});
	 				for(int i = (index_start*max_pezzi); i<list.size();i++) {
	 					
	 						if(((RilPuntoQuotaDTO) list.get(i)).getValore_punto()!=null) {
	 							if(NumberUtils.isNumber(((RilPuntoQuotaDTO) list.get(i)).getValore_punto())){
	 								arrayPs2.add(Utility.setDecimalDigits(cifre_decimali, String.valueOf(((RilPuntoQuotaDTO) list.get(i)).getValore_punto())));
	 							}else {
	 								arrayPs2.add(((RilPuntoQuotaDTO) list.get(i)).getValore_punto());
	 							}
		 						
		 					}else {
		 						arrayPs2.add("");
		 					}
					}
	 			
	 				
	 				for(int k = (index_start)*max_pezzi; k<list.size();k++) {
	 					
 						if(((RilPuntoQuotaDTO) list.get(k)).getDelta()!=null) {
 							arrayPs2.add(((RilPuntoQuotaDTO) list.get(k)).getDelta());
	 						
	 					}else {
	 						arrayPs2.add("");
	 					}
 						
 						if(((RilPuntoQuotaDTO) list.get(k)).getDelta_perc()!=null) {
 							arrayPs2.add(((RilPuntoQuotaDTO) list.get(k)).getDelta_perc());
	 						
	 					}else {
	 						arrayPs2.add("");
	 					}

				}
	 				arrayPs2.add(Utility.setDecimalDigits(cifre_decimali, Utility.getMaxDelta(quota, false)));
	 				arrayPs2.add(Utility.setDecimalDigits(cifre_decimali, Utility.getMaxDelta(quota, true)));
	 				if(quota.getNote()!=null) {
	 					arrayPs2.add(quota.getNote());	
	 				}else {
	 					arrayPs2.add("");
	 				}
	 				
	 				Object[] listaValori2 = arrayPs2.toArray();	
	 				
	 				dataSource.add(listaValori2);	
				}
			}				
 		    return dataSource;	 
 	}



	@SuppressWarnings("deprecation")
	public JasperReportBuilder getTableReport(ArrayList<RilQuotaDTO> lista_quote, int index_start, String nome_impronta, String note, List<SedeDTO> listaSedi, int id_rilievo, String path_simboli, int cifre_decimali) throws Exception{
	
		JasperReportBuilder report = DynamicReports.report();
	
		try {			
	
			report.setColumnStyle((Templates.boldCenteredStyle).setFontSize(9));
			report.addColumn(col.column("Coord","Coordinata", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(30));
			ImageBuilder image = cmp.image(new ImageExpression(path_simboli));
	 		if(image!=null) {
	 			image.setHorizontalImageAlignment(HorizontalImageAlignment.CENTER).setFixedDimension(15, 15).setStretchType(StretchType.NO_STRETCH);
	 			report.addField("image", String.class).addColumn(col.componentColumn("Simbolo", image).setFixedWidth(40)); 
	 		}
	 		report.addColumn(col.column("Quota Nominale","Quota Nominale", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(50));
	 		report.addColumn(col.column("Funz","Funzionale", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(25));
	 		report.addColumn(col.column("U.M.","U.M.", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(25));
	 		report.addColumn(col.column("Tolleranza","Tolleranza", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(70));
	 		
	 		applyStyle(report,(index_start-1)*max_pezzi, index_start*max_pezzi);
	
	 	
	 		for(int i = (index_start-1)*max_pezzi; i<index_start*max_pezzi; i++) {
	 			report.addColumn(col.column("Δ "+(i+1) ,"Δ "+(i+1), type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(45));
	 			report.addColumn(col.column("Δ "+(i+1) + " %","Δ "+(i+1)+ " %", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(45));
	 		}
	 		
	 		report.addColumn(col.column("Max Dev","Max Dev", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(45));
	 		report.addColumn(col.column("Max Dev %","Max Dev %", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(45));
	 		
	 		report.addColumn(col.column("Note","Note", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setMinWidth(87));
			report.setColumnTitleStyle((Templates.boldCenteredStyle).setFontSize(9).setBorder(stl.penThin()));
		
	 		report.setDataSource(createDataSource(lista_quote, index_start, cifre_decimali));
	 		
	 		report.highlightDetailEvenRows();
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		int pezzo_start = (index_start-1)*max_pezzi+1;
		int pezzo_end = index_start*max_pezzi;
		String cliente = null;
		if(lista_quote.get(0).getImpronta().getMisura().getId_sede_util()!=0) {
			cliente = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, lista_quote.get(0).getImpronta().getMisura().getId_sede_util(), lista_quote.get(0).getImpronta().getMisura().getId_cliente_util()).getDescrizione();
		}else {
			cliente = GestioneAnagraficaRemotaBO.getClienteById(String.valueOf(lista_quote.get(0).getImpronta().getMisura().getId_cliente_util())).getNome();
		}
					
		insertHeader(report, nome_impronta, pezzo_start, pezzo_end, cliente, note, id_rilievo);
		
		return report;
	}

	

	@SuppressWarnings("deprecation")
	public JasperReportBuilder getTableReport2(ArrayList<RilQuotaDTO> lista_quote, int index_start, String nome_impronta, String note, List<SedeDTO> listaSedi, int id_rilievo, String path_simboli, int cifre_decimali) throws Exception{
	
		JasperReportBuilder report = DynamicReports.report();
	
		try {								
	
			report.setColumnStyle((Templates.boldCenteredStyle).setFontSize(9).setBorder(stl.penThin()));
	 		report.addColumn(col.column("Coord","Coordinata", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(30));
	 		ImageBuilder image = cmp.image(new ImageExpression(path_simboli));
	 		
	 		if(image!=null) {	 		
	 			image.setHorizontalImageAlignment(HorizontalImageAlignment.CENTER).setFixedDimension(15, 15).setStretchType(StretchType.NO_STRETCH);
	 			report.addField("image", String.class).addColumn(col.componentColumn("Simbolo", image).setFixedWidth(40));
	 		}
	 		report.addColumn(col.column("Quota Nominale","Quota Nominale", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(50));
	 		report.addColumn(col.column("Funz","Funzionale", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(25));
	 		report.addColumn(col.column("U.M.","U.M.", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(25));
	 		report.addColumn(col.column("Tolleranza","Tolleranza", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(70));
	 		
	 		applyStyle(report, (index_start)*max_pezzi, lista_quote.get(0).getListaPuntiQuota().size());
	 		
	 		//report.addColumn(col.column("Note","Note", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(55));	 			 
	 		
	 		for(int i = (index_start)*max_pezzi; i<lista_quote.get(0).getListaPuntiQuota().size(); i++) {
	 			report.addColumn(col.column("Δ "+(i+1) ,"Δ "+(i+1), type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(45));
	 			report.addColumn(col.column("Δ "+(i+1) + " %","Δ "+(i+1)+ " %", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(45));
	 		}
	 		
	 		report.addColumn(col.column("Max Dev","Max Dev", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(45));
	 		report.addColumn(col.column("Max Dev %","Max Dev %", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(45));
	 		
	 		report.addColumn(col.column("Note","Note", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setMinWidth(87));
	 		
	 		report.setColumnTitleStyle((Templates.boldCenteredStyle).setFontSize(9).setBorder(stl.penThin()));
	 		
	 		report.setDataSource(createDataSource2(lista_quote, index_start, cifre_decimali));
	 		
	 		report.highlightDetailEvenRows();
	 		
	 		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		int pezzo_start = (index_start*max_pezzi) +1;
		int pezzo_end = lista_quote.get(0).getListaPuntiQuota().size();
		
		String cliente = null;
		if(lista_quote.get(0).getImpronta().getMisura().getId_sede_util()!=0) {
			cliente = GestioneAnagraficaRemotaBO.getSedeFromId(listaSedi, lista_quote.get(0).getImpronta().getMisura().getId_sede_util(), lista_quote.get(0).getImpronta().getMisura().getId_cliente_util()).getDescrizione();
		}else {
			cliente = GestioneAnagraficaRemotaBO.getClienteById(String.valueOf(lista_quote.get(0).getImpronta().getMisura().getId_cliente_util())).getNome();
		}
		
		insertHeader(report, nome_impronta, pezzo_start, pezzo_end,cliente, note, id_rilievo);
		return report;
	}




	private void applyStyle(JasperReportBuilder report,int start, int size) {
		
		for(int i =start; i< size; i++) {	
			ConditionalStyleBuilder condColumnStyleRed = Styles.conditionalStyle(new ConditionRed(i+1))
	                .bold()
	                .setBackgroundColor(Color.RED)
	                .setBorder(stl.penThin());
			
			ConditionalStyleBuilder condColumnStyleWhite = Styles.conditionalStyle(new ConditionWhite(i+1))
	                .bold()
	                .setBackgroundColor(Color.WHITE)
	                .setBorder(stl.penThin());
	
			
			StyleBuilder colStyle = Styles.style().conditionalStyles(condColumnStyleRed);
			colStyle.addConditionalStyle(condColumnStyleWhite);
	
		 report.addColumn(col.column("Pezzo "+(i+1) ,"Pezzo "+(i+1), type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setStyle(colStyle).setMinWidth(45));
		}
		
		
	}


	private void insertHeader(JasperReportBuilder report, String particolare, int pezzo_start, int pezzo_end,String cliente, String note, int id_rilievo) {
		if(note==null) {
			note="";
		}
		report.pageHeader(cmp.line().setFixedHeight(1),
		cmp.verticalGap(1),
		cmp.horizontalList(cmp.text(particolare).setStyle((Templates.boldStyle).setFontSize(9)).setFixedHeight(10),
				cmp.text("Pezzi " +pezzo_start + " - " + pezzo_end).setStyle((Templates.boldStyle).setFontSize(9)).setFixedHeight(10),
				cmp.text(cliente).setStyle((Templates.boldStyle).setFontSize(9)).setFixedHeight(10),
				cmp.text("Numero scheda: SRD " + id_rilievo).setStyle((Templates.boldStyle).setFontSize(9)).setFixedHeight(10)
		),		
		cmp.verticalGap(1),
		cmp.line().setFixedHeight(1),
		cmp.horizontalList(cmp.text("Note: "+ note).setStyle((Templates.boldStyle).setFontSize(9)).setFixedHeight(10)),
		cmp.line().setFixedHeight(1),
		cmp.horizontalList(cmp.text("SCHEDA RILIEVI DIMENSIONALI").setStyle((Templates.boldCenteredStyle).setFontSize(9)).setFixedHeight(10)));
		
	}


}
