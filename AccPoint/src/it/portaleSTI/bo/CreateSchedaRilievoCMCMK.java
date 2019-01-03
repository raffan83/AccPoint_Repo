package it.portaleSTI.bo;

import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;
import static net.sf.dynamicreports.report.builder.DynamicReports.col;
import static net.sf.dynamicreports.report.builder.DynamicReports.stl;
import static net.sf.dynamicreports.report.builder.DynamicReports.type;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;

import javax.imageio.ImageIO;

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
import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.dynamicreports.report.builder.component.HorizontalListBuilder;
import net.sf.dynamicreports.report.builder.component.SubreportBuilder;
import net.sf.dynamicreports.report.builder.component.VerticalListBuilder;
import net.sf.dynamicreports.report.constant.HorizontalTextAlignment;
import net.sf.dynamicreports.report.datasource.DRDataSource;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimplePdfExporterConfiguration;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.axis.NumberAxis;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.xy.XYItemRenderer;
import org.jfree.data.xy.XYSeries;
import org.jfree.data.xy.XYSeriesCollection;
import org.apache.commons.math3.distribution.NormalDistribution;
public class CreateSchedaRilievoCMCMK {

public CreateSchedaRilievoCMCMK(RilMisuraRilievoDTO rilievo, List<SedeDTO> listaSedi, String path_simboli, Session session) throws Exception {
		
		build(rilievo, listaSedi,path_simboli, session);
		
}
	

int max_pezzi = 10;
int cifre_decimali;
private void build(RilMisuraRilievoDTO rilievo, List<SedeDTO> listaSedi, String path_simboli, Session session) throws Exception {
	
	cifre_decimali = rilievo.getCifre_decimali();
	
	InputStream is =  PivotTemplate.class.getResourceAsStream("schedaRilieviDimensionali.jrxml");

	JasperReportBuilder report = DynamicReports.report();
	
	
		report.setTemplateDesign(is);
		report.setTemplate(Templates.reportTemplate);
		
		report.setDataSource(new JREmptyDataSource());
		
		
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
		File imageCenter = null;
		if(rilievo.getImmagine_frontespizio()!= null && !rilievo.getImmagine_frontespizio().equals("")) {
			imageCenter = new File(Costanti.PATH_FOLDER+"\\RilieviDimensionali\\Allegati\\Immagini\\"+rilievo.getId()+"\\"+rilievo.getImmagine_frontespizio());
		}
		if(imageCenter!=null) {
			report.addParameter("immagine_frontespizio",imageCenter);
		
		}else {
			report.addParameter("immagine_frontespizio","");
		}
		
		List<JasperPrint> jasperPrintList = new ArrayList<JasperPrint>();
		JasperPrint jasperPrint1 = report.toJasperPrint();
		jasperPrintList.add(jasperPrint1);
		
		//HashMap<Integer, ArrayList<RilPuntoQuotaDTO>> map = new HashMap<Integer, ArrayList<RilPuntoQuotaDTO>>();
		

		for (RilParticolareDTO particolare : lista_particolari) {
			HashMap<RilPuntoQuotaDTO, Integer> map = new HashMap<RilPuntoQuotaDTO, Integer>();
			ArrayList<RilQuotaDTO> lista_quote = GestioneRilieviBO.getQuoteFromImpronta(particolare.getId(), session);
			
			ArrayList<RilQuotaDTO> lista_quote_ripetute = new ArrayList<RilQuotaDTO>();
			int rif_quota = 0;
			for(int i = 0; i<lista_quote.size();i++) {
				if(i==0 || !new Double(lista_quote.get(i).getVal_nominale()).equals(new Double(lista_quote.get(i-1).getVal_nominale())) 
						|| (lista_quote.get(i).getQuota_funzionale()!=null && lista_quote.get(i-1).getQuota_funzionale()!=null && lista_quote.get(i).getQuota_funzionale().getId()!=lista_quote.get(i-1).getQuota_funzionale().getId())
						|| !lista_quote.get(i).getCoordinata().equals(lista_quote.get(i-1).getCoordinata())
						|| (lista_quote.get(i).getSimbolo()!=null && lista_quote.get(i-1).getSimbolo()!=null && lista_quote.get(i).getSimbolo().getId()!=lista_quote.get(i-1).getSimbolo().getId())
						|| !new Double(lista_quote.get(i).getTolleranza_negativa()).equals(new Double(lista_quote.get(i-1).getTolleranza_negativa()))
						|| !new Double(lista_quote.get(i).getTolleranza_positiva()).equals(new Double(lista_quote.get(i-1).getTolleranza_positiva()))) {
					lista_quote_ripetute.add(lista_quote.get(i));		
					rif_quota++;
			
				}
				List list = new ArrayList(lista_quote.get(i).getListaPuntiQuota());		
				map.put((RilPuntoQuotaDTO) list.get(0), rif_quota);

			}
	
					int index = 0;
					VerticalListBuilder vl =  cmp.verticalList();
					JasperReportBuilder report_page = DynamicReports.report();
					
					report_page.setTemplate(Templates.reportTemplate);
					report_page.setDataSource(new JREmptyDataSource());	
				for (RilQuotaDTO quota : lista_quote_ripetute) {
					
//					
					InputStream is2 =  PivotTemplate.class.getResourceAsStream("schedaCMCMK.jrxml");
					JasperReportBuilder report_table = DynamicReports.report();
					
					report_table.setTemplate(Templates.reportTemplate);
					report_table.setTemplateDesign(is2);
					report_table.setDataSource(new JREmptyDataSource());		
					//report_table.setPageFormat(PageType.A4, PageOrientation.PORTRAIT);
					
					if(quota.getVal_nominale()!=null) {
						report_table.addParameter("val_nominale",quota.getVal_nominale());
					}else {
						report_table.addParameter("val_nominale","");
					}
					if(quota.getCapability()!=null) {
						report_table.addParameter("capability",quota.getCapability());
					}else {
						report_table.addParameter("capability","");
					}
					if(quota.getCoordinata()!=null) {
						report_table.addParameter("coordinata",quota.getCoordinata());
					}else {
						report_table.addParameter("coordinata","");
					}
					if(quota.getSimbolo()!=null) {
						
						report_table.addParameter("simbolo",quota.getSimbolo().getDescrizione());
					}else {
						report_table.addParameter("simbolo","");
					}
					if(quota.getTolleranza_negativa()!=null) {
						report_table.addParameter("tolleranza_neg",quota.getTolleranza_negativa());
					}else {
						report_table.addParameter("tolleranza_neg","");
					}
					if(quota.getTolleranza_positiva()!=null) {
						report_table.addParameter("tolleranza_pos",quota.getTolleranza_positiva());
					}else {
						report_table.addParameter("tolleranza_pos","");
					}
					if(quota.getQuota_funzionale()!=null) {
						report_table.addParameter("funzionale",quota.getQuota_funzionale().getDescrizione());
					}else {
						report_table.addParameter("funzionale","");
					}
					
					ArrayList<RilPuntoQuotaDTO> lista_punti = new ArrayList<RilPuntoQuotaDTO>();
					 for (RilPuntoQuotaDTO pt : map.keySet()) {
					      if (map.get(pt).equals(index+1)) {
					        lista_punti.add(pt);
					      }
					  }
					 
					 Collections.sort(lista_punti, new Comparator<RilPuntoQuotaDTO>() {
		 				    public int compare(RilPuntoQuotaDTO o1, RilPuntoQuotaDTO o2) {
		 				    	Integer obj1 = o1.getId_quota();
		 				    	Integer obj2 = o2.getId_quota();
		 				        return obj1.compareTo(obj2);
		 				    }
		 				});					 
					 
					 String min = getMin(lista_punti);
					 String max = getMax(lista_punti);
					 Double min_toll = new Double(quota.getVal_nominale()) - new Double(Math.abs(new Double(quota.getTolleranza_negativa())));
					 Double max_toll = new Double(quota.getVal_nominale()) + new Double(quota.getTolleranza_positiva());	
					 String media = getMedia(lista_punti);
					 String stdDev = getStdDev(lista_punti, media);
					 String cm = getCm(min_toll, max_toll,stdDev);
					 String cmk_inf = getCmkInf(media, stdDev, min_toll);
					 String cmk_sup = getCmkSup(media, stdDev, max_toll);
					 
					 if(Math.min(new Double(cmk_inf), new Double(cmk_sup))>=new Double(quota.getCapability())) {
						 report_table.addParameter("conformita","CONFORME");
					 }else {
						 report_table.addParameter("conformita","NON CONFORME");
					 }
					 
					 
					 ArrayList<Double> variabile = new ArrayList<Double>();
					 ArrayList<Double> cumulativa = new ArrayList<Double>();
					 ArrayList<Double> dens_prob = new ArrayList<Double>();
					 Double gradino = new Double(stdDev)/3;
					 
					 if(new Double(stdDev)!=0) {
					 NormalDistribution d = new NormalDistribution(new Double(media), new Double(stdDev));				 
					 
						 for(int i = 0; i<19;i++) {
							 Double val = 0.0;
							 if(i==0) {
								 val= new Double(media)-(new Double(stdDev)*3);
								 variabile.add(val);
							 }else {
								 val = variabile.get(i-1)+gradino;
								 variabile.add(val);
							 }
							 cumulativa.add(d.cumulativeProbability(val));
							 if(i>0) {
								 dens_prob.add(cumulativa.get(i)-cumulativa.get(i-1));
							 }
						 }
					 }
					 XYSeriesCollection dataset = new XYSeriesCollection();
					 XYSeries series1 = new XYSeries("Distribuzione");					 
					 XYSeries series2 = new XYSeries("Media");
					 XYSeries series3 = new XYSeries("Limite inf");
					 XYSeries series4 = new XYSeries("Limite sup");

					 for(int i = 0;i<dens_prob.size();i++) {
						 series1.add(variabile.get(i), dens_prob.get(i));
						 series2.add(new Double(media), dens_prob.get(i));
						 series3.add(min_toll, dens_prob.get(i));
						 series4.add(max_toll, dens_prob.get(i));
					 }

					    dataset.addSeries(series1);
					    dataset.addSeries(series2);
					    dataset.addSeries(series3);
					    dataset.addSeries(series4);
					  
				        final JFreeChart chart = ChartFactory.createXYLineChart(
				            "",
				            "", 
				            "", 
				            dataset,
				            PlotOrientation.HORIZONTAL,
				            true,
				            true,
				            false
				        );
				        
				        
				        chart.getPlot().setBackgroundPaint( new Color(230, 230, 230));
				        
				        NumberAxis xAxis = (NumberAxis) chart.getXYPlot().getDomainAxis();  
				        //xAxis.setTickUnit(new NumberTickUnit(10));
				        xAxis.setAutoRange(true);
				        XYItemRenderer renderer = chart.getXYPlot().getRenderer();
				        renderer.setSeriesStroke(0, new BasicStroke(4.0f));
				        renderer.setSeriesStroke(1, new BasicStroke(4.0f));
				        renderer.setSeriesStroke(2, new BasicStroke(4.0f));
				        renderer.setSeriesStroke(3, new BasicStroke(4.0f));
				        
				        renderer.setSeriesPaint(0, Color.BLUE);
				        renderer.setSeriesPaint(1, Color.CYAN);
				        renderer.setSeriesPaint(2, Color.RED);
				        renderer.setSeriesPaint(3, Color.YELLOW);
				       
				        
				        BufferedImage objBufferedImage=chart.createBufferedImage(600,800);
				        ByteArrayOutputStream bas = new ByteArrayOutputStream();				   
				        ImageIO.write(objBufferedImage, "png", bas);
				        byte[] byteArray=bas.toByteArray();
				        
				        InputStream in = new ByteArrayInputStream(byteArray);
				        BufferedImage image = ImageIO.read(in);
				        ByteArrayOutputStream os = new ByteArrayOutputStream();				        
				        
				        ImageIO.write(image,"png", os); 
				        InputStream fis = new ByteArrayInputStream(os.toByteArray());
				       
				//        File outputfile = new File("C:\\Users\\antonio.dicivita\\Desktop\\image.png");
				     //   ImageIO.write(image, "png", outputfile);
				    //    File out = new File				        
				        
				        if(fis !=null) {
				        	report_table.addParameter("grafico", fis);
				        }

					 
					 if(min!=null) {
							report_table.addParameter("minimo",min);
						}else {
							report_table.addParameter("minimo","");
					 }
					 if(max!=null) {
							report_table.addParameter("massimo",max);
						}else {
							report_table.addParameter("massimo","");
					 }
					 if(media!=null) {
							report_table.addParameter("medio",media);
						}else {
							report_table.addParameter("medio","");
					 }
					 if(stdDev!=null) {
							report_table.addParameter("dev_std",stdDev);
						}else {
							report_table.addParameter("dev_std","");
					 }
					 if(cm!=null) {
							report_table.addParameter("cm",cm);
						}else {
							report_table.addParameter("cm","");
					 }
					 if(cmk_sup!=null) {
							report_table.addParameter("cmk_sup",cmk_sup);
						}else {
							report_table.addParameter("cmk_sup","");
					 }
					 if(cmk_inf!=null) {
							report_table.addParameter("cmk_inf",cmk_inf);
						}else {
							report_table.addParameter("cmk_inf","");
					 }
					 
					 HorizontalListBuilder hl = cmp.horizontalList();
					 
					 if(lista_punti.size()>max_pezzi) {
						 int cols = lista_punti.size()/max_pezzi;
						 if(lista_punti.size()%max_pezzi==0) {
							 for(int i = 0; i<cols;i++) {
								 SubreportBuilder subreport = cmp.subreport(getTableReport(lista_punti, i, true, quota.getUm()));
								 hl.add(subreport);
							 }						 
						 }else {
							 for(int i = 0; i<cols;i++) {
								 SubreportBuilder subreport = cmp.subreport(getTableReport(lista_punti, i, true, quota.getUm()));
								 hl.add(subreport);
							 }	
							 SubreportBuilder subreport = cmp.subreport(getTableReport(lista_punti, cols, false, quota.getUm()));
							 hl.add(subreport);
						 }
					 }else {
						 SubreportBuilder subreport = cmp.subreport(getTableReport(lista_punti, 0, false, quota.getUm()));
						 hl.add(subreport);
					 }
					 report_table.addDetail(hl);
					
					 vl.add(cmp.subreport(report_table));
					//JasperPrint jasperPrint = report_table.toJasperPrint();
				
					//jasperPrintList.add(jasperPrint);
					index++;
					
			}
				
				report_page.addDetail(vl);
				//report_page.addPageHeader();
				JasperPrint jasperPrint = report_page.toJasperPrint();
				
				jasperPrintList.add(jasperPrint);
		}
		
		String path = "C:\\Users\\antonio.dicivita\\Desktop\\test.pdf";
		JRPdfExporter exporter = new JRPdfExporter();
		exporter.setExporterInput(SimpleExporterInput.getInstance(jasperPrintList));
		exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(path + "scheda_rilievo.pdf")); 
		SimplePdfExporterConfiguration configuration = new SimplePdfExporterConfiguration();
		configuration.setCreatingBatchModeBookmarks(true); 
		exporter.setConfiguration(configuration);
		exporter.exportReport();
		
		
}
	
private String getCmkSup(String media, String stdDev, Double max_toll) {

	Double toRet = (max_toll - new Double(media))/(new Double(stdDev)*3);
	if(new Double(stdDev)!=0) {
		return Utility.setDecimalDigits(cifre_decimali,toRet.toString());
	}else {
		return "0";
	}
	//return Utility.setDecimalDigits(cifre_decimali,toRet.toString());
}



private String getCmkInf(String media, String stdDev, Double min_toll) {	

	Double toRet = (new Double(media) - min_toll)/(new Double(stdDev)*3);
	if(new Double(stdDev)!=0) {
		return Utility.setDecimalDigits(cifre_decimali,toRet.toString());
	}else {
		return "0";
	}
	
	
}



private String getCm(Double min_toll,Double max_toll, String stdDev) {
	
	Double toRet = (max_toll - min_toll)/(new Double(stdDev)*6);
	if(new Double(stdDev)!=0) {
		return Utility.setDecimalDigits(cifre_decimali,toRet.toString());
	}else {
		return "0";
	}
}



private String getStdDev(ArrayList<RilPuntoQuotaDTO> lista_punti, String media) {
	
    Double temp = 0.0;
    for (RilPuntoQuotaDTO punto : lista_punti) {
    	temp += (new Double(punto.getValore_punto()) - new Double(media)) * (new Double(punto.getValore_punto()) - new Double(media));
	}
    
    //Double toRet = (Math.sqrt(temp/(lista_punti.size()-1)));
    Double toRet = (Math.sqrt(temp/(lista_punti.size())));
    return Utility.setDecimalDigits(cifre_decimali, toRet.toString());   
}



private String getMedia(ArrayList<RilPuntoQuotaDTO> lista_punti) {

	Double media = 0.0;
	Double somma = 0.0;
	for (RilPuntoQuotaDTO punto : lista_punti) {
		somma = somma + new Double(punto.getValore_punto());		
	}
	media = somma/lista_punti.size();
	return Utility.setDecimalDigits(cifre_decimali,media.toString());
}



private String getMax(ArrayList<RilPuntoQuotaDTO> lista_punti) {
	
	Double max = 0.0;
	for (RilPuntoQuotaDTO punto : lista_punti) {
		Double curr = new Double(punto.getValore_punto());
		if(curr > max) {
			max = curr;
		}
	}
	return Utility.setDecimalDigits(cifre_decimali,max.toString());
}



private String getMin(ArrayList<RilPuntoQuotaDTO> lista_punti) {

	Double min = new Double(lista_punti.get(0).getValore_punto());
	for (RilPuntoQuotaDTO punto : lista_punti) {
		Double curr = new Double(punto.getValore_punto());
		if(curr < min) {
			min = curr;
		}
	}
	return Utility.setDecimalDigits(cifre_decimali,min.toString());
}



private JasperReportBuilder getTableReport(ArrayList<RilPuntoQuotaDTO> lista_punti, int i, boolean resto_zero, String um) throws Exception {

	JasperReportBuilder report = DynamicReports.report();

	report.setColumnStyle((Templates.boldCenteredStyle).setFontSize(4));
	report.addColumn(col.column("Punto","numero", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(28));
	report.addColumn(col.column("Valore","valore", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(45));
	report.setColumnTitleStyle((Templates.boldCenteredStyle).setFontSize(4).setBorder(stl.penThin()));
	
	report.setDataSource(createDataSource(lista_punti, i+1, resto_zero, um));
	
	
	return report;
}


private JRDataSource createDataSource(ArrayList<RilPuntoQuotaDTO> lista_punti, int index_start, boolean resto_zero, String um)throws Exception {
	DRDataSource dataSource = null;

	String[] listaCodici = null;
		
		listaCodici = new String[2];			
					
		listaCodici[0]="numero";
		listaCodici[1]="valore";										

		dataSource = new DRDataSource(listaCodici);
		
		int start = 0;
		int end = 0;
		int indice_pezzo = ((index_start-1)*max_pezzi)+1;
		
		if(resto_zero) {			
			start = (index_start-1)*max_pezzi;
			end = (index_start*max_pezzi);
		}else {			
			start = (index_start-1)*max_pezzi;
			end = lista_punti.size();
		}
		
		for(int k = start; k<end;k++) {
				ArrayList<String> arrayPs = new ArrayList<String>();
				arrayPs.add(String.valueOf(indice_pezzo));
				
				if(lista_punti.get(k).getValore_punto()!=null) {
					arrayPs.add(Utility.setDecimalDigits(cifre_decimali, lista_punti.get(k).getValore_punto()) +" " + um);
				}else {
					arrayPs.add("");
				}				
				
	 			Object[] listaValori2 = arrayPs.toArray();	
	 				
	 			dataSource.add(listaValori2);	
	 			indice_pezzo++;
				}
							
 		    return dataSource;	 
 	}


public static void main(String[] args) throws HibernateException, Exception {
	new ContextListener().configCostantApplication();
	Session session=SessionFacotryDAO.get().openSession();
	session.beginTransaction();
	List<SedeDTO> listaSedi = GestioneAnagraficaRemotaBO.getListaSedi();
		RilMisuraRilievoDTO rilievo = GestioneRilieviBO.getMisuraRilieviFromId(29, session);
		
		String path_simboli = "C:\\Users\\antonio.dicivita\\eclipse-workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\AccPoint\\images\\simboli_rilievi\\";
	
		new CreateSchedaRilievoCMCMK(rilievo,listaSedi, path_simboli, session);
		session.close();
		System.out.println("FINITO");
}


}
