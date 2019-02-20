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
import java.util.List;

import org.hibernate.Session;

import TemplateReport.PivotTemplate;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.MagDdtDTO;
import it.portaleSTI.DTO.MagItemPaccoDTO;
import it.portaleSTI.DTO.MagPaccoDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Templates;
import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.dynamicreports.report.builder.component.SubreportBuilder;
import net.sf.dynamicreports.report.builder.style.StyleBuilder;
import net.sf.dynamicreports.report.builder.style.Styles;
import net.sf.dynamicreports.report.constant.HorizontalTextAlignment;
import net.sf.dynamicreports.report.constant.SplitType;
import net.sf.dynamicreports.report.datasource.DRDataSource;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;


	public class CreateDDT {
	
	
	File file; 
	private boolean esito; 
	public CreateDDT(MagDdtDTO ddt, List<SedeDTO> lista_sedi, List<MagItemPaccoDTO> lista_item_pacco, Session session) throws Exception  {

			build(ddt,lista_sedi, lista_item_pacco, session);
			
	}
	
	

	private void build(MagDdtDTO ddt, List<SedeDTO> lista_sedi, List<MagItemPaccoDTO> lista_item_pacco, Session session) throws Exception {
		
		
		InputStream is =  PivotTemplate.class.getResourceAsStream("ddt.jrxml");
		
		JasperReportBuilder report = DynamicReports.report();
		

			report.setTemplateDesign(is);
			report.setTemplate(Templates.reportTemplate);
			
			report.addParameter("numero_ddt", ddt.getNumero_ddt());
			if( ddt.getTipo_trasporto()!=null) {
				report.addParameter("tipo_trasporto", ddt.getTipo_trasporto().getDescrizione());
			}else {
				report.addParameter("tipo_trasporto", "");
			}
			if(ddt.getTipo_porto()!=null) {
				report.addParameter("tipo_porto", ddt.getTipo_porto().getDescrizione());
			}else {
				report.addParameter("tipo_porto", "");
			}
			if(ddt.getTipo_ddt()!=null) {
				report.addParameter("tipo_ddt", ddt.getTipo_ddt().getDescrizione());
			}else {
				report.addParameter("tipo_ddt", "");
			}
			if(ddt.getCausale()!=null) {
				report.addParameter("causale", ddt.getCausale().getDescrizione());
			}else {
				report.addParameter("causale", "");
			}
					
			SimpleDateFormat dt = new SimpleDateFormat("dd/MM/yyyy"); 
			
			if( ddt.getData_ddt()==null) {
				report.addParameter("data_ddt","");
			}else {
				report.addParameter("data_ddt", dt.format(ddt.getData_ddt()));
			}
			String data_trasporto;
		
			if(ddt.getData_trasporto()==null) {
				data_trasporto="";
			}else {
				data_trasporto = dt.format(ddt.getData_trasporto()); 
			}
			
			report.addParameter("data_ora_trasporto", data_trasporto);
			if(ddt.getAspetto()!=null) {
				report.addParameter("aspetto", ddt.getAspetto().getDescrizione());
			}else {
				report.addParameter("aspetto", "");
			}
			
			 ClienteDTO	 cliente = GestioneAnagraficaRemotaBO.getClienteById(String.valueOf(ddt.getId_destinatario()));

				if(ddt.getId_sede_destinatario()!=0) {
										
					SedeDTO sede = GestioneAnagraficaRemotaBO.getSedeFromId(lista_sedi, ddt.getId_sede_destinatario(), ddt.getId_destinatario());
					
					if(cliente != null && cliente.getNome()!=null) {
						String indirizzo="";
						String cap="";
						String citta="";
						String provincia="";
						
						if( sede.getIndirizzo()!=null) {
							indirizzo = sede.getIndirizzo();				
							}
							if(sede.getCap()!=null) {
								cap = sede.getCap();
							}
							if(sede.getComune()!=null) {
								citta = sede.getComune();
							}
							if(sede.getSiglaProvincia()!=null) {
								provincia = sede.getSiglaProvincia();
							}
						
						report.addParameter("destinatario",sede.getDescrizione());
						report.addParameter("indr_destinatario",indirizzo);					
						report.addParameter("citta_destinatario", cap +" " +citta +" (" + provincia+")");
					}else {
						report.addParameter("destinatario","");
					}
					
				}else {
					
					if(cliente != null && cliente.getNome()!=null) {
						String indirizzo="";
						String cap="";
						String citta="";
						String provincia="";
						
						if( cliente.getIndirizzo()!=null) {
							indirizzo = cliente.getIndirizzo();				
							}
							if(cliente.getCap()!=null) {
								cap = cliente.getCap();
							}
							if(cliente.getCitta()!=null) {
								citta = cliente.getCitta();
							}
							if(cliente.getProvincia()!=null) {
								provincia = cliente.getProvincia();
							}
						
						report.addParameter("destinatario",cliente.getNome());
						report.addParameter("indr_destinatario", indirizzo);
						report.addParameter("citta_destinatario", cap +" " +citta+" (" + provincia+")");
					}else {
						report.addParameter("destinatario","");
					}
				}				
				if(ddt.getId_destinatario()!=ddt.getId_destinazione() && ddt.getId_destinazione()!=0) {
					cliente = GestioneAnagraficaRemotaBO.getClienteById(String.valueOf(ddt.getId_destinazione()));
				}				
				if(ddt.getId_sede_destinazione()!=0) {
					
					SedeDTO sede = GestioneAnagraficaRemotaBO.getSedeFromId(lista_sedi, ddt.getId_sede_destinazione(), ddt.getId_destinazione());
					
					if(cliente.getNome()!=null) {
						String indirizzo="";
						String cap="";
						String citta="";
						String provincia="";
						
						if( sede.getIndirizzo()!=null) {
						indirizzo = sede.getIndirizzo();				
						}
						if(sede.getCap()!=null) {
							cap = sede.getCap();
						}
						if(sede.getComune()!=null) {
							citta = sede.getComune();
						}
						if(sede.getSiglaProvincia()!=null) {
							provincia = sede.getSiglaProvincia();
						}
							report.addParameter("destinazione",sede.getDescrizione());
							report.addParameter("indr_destinazione",indirizzo);
							report.addParameter("citta_destinazione", cap+ " " + citta + " (" +provincia+")");
					}else {
						
						report.addParameter("destinazione","");
						
					}
				}else {
					
					String indirizzo="";
					String cap="";
					String citta="";
					String provincia="";
					
					if( cliente.getIndirizzo()!=null) {
						indirizzo = cliente.getIndirizzo();				
						}
						if(cliente.getCap()!=null) {
							cap = cliente.getCap();
						}
						if(cliente.getCitta()!=null) {
							citta = cliente.getCitta();
						}
						if(cliente.getProvincia()!=null) {
							provincia = cliente.getProvincia();
						}
					
					report.addParameter("destinazione",cliente.getNome());
					report.addParameter("indr_destinazione", indirizzo);
					report.addParameter("citta_destinazione", cap +" " +citta+" (" + provincia+")");
				}
			
			if(ddt.getCortese_attenzione()!=null) {
				report.addParameter("ca", ddt.getCortese_attenzione());
			}else {
				report.addParameter("ca", "");
			}
				
			if(ddt.getSpedizioniere()!=null) {
				report.addParameter("spedizioniere", ddt.getSpedizioniere());
			}else {
				report.addParameter("spedizioniere", "");
			}
			if(ddt.getAccount()!=null) {
				report.addParameter("account", ddt.getAccount());
			}else {
				report.addParameter("account", "");
			}			
			if(ddt.getAnnotazioni()!=null) {
				report.addParameter("annotazioni", ddt.getAnnotazioni());
			}else {
				report.addParameter("annotazioni", "");
			}
			report.addParameter("colli", ddt.getColli());
			
			if(ddt.getNote()!=null) {
				report.addParameter("note_ddt", ddt.getNote());
			}else {
				report.addParameter("note_ddt", "");
			}
			
			if(ddt.getMagazzino()!=null) {
				report.addParameter("magazzino", ddt.getMagazzino());
			}else {
				report.addParameter("magazzino", "");
			}
			if(ddt.getPeso()!=null) {
				report.addParameter("peso", ddt.getPeso());
			}else {
				report.addParameter("peso", "");
			}
			
			if(cliente.getCf()!=null)
			{
				report.addParameter("cf",cliente.getCf());
			}else 
			{
				report.addParameter("cf", "");
			}
			
			if(cliente.get__id()!=0) {
				report.addParameter("codice_cliente", cliente.get__id());	
			}else {
				report.addParameter("codice_cliente", "");
			}
				
			if(cliente.getTelefono()!=null) {
				report.addParameter("telefono", cliente.getTelefono());
			}else {
				report.addParameter("telefono", "");
			}
			
			if(cliente.getPartita_iva()!=null) {
				report.addParameter("partita_iva", cliente.getPartita_iva());
			}else {
				report.addParameter("partita_iva", "");
			}
			
			report.addParameter("nota", "MATERIALE FRAGILE - MANEGGIARE CON CURA. Eventuali segnalazioni in merito "
					+ "alla merce/bene consegnato dovranno essere comunicate entro 8 gg dal ricevimento; "
					+ "S.T.I. Srl non si ritiene comunque responsabile di eventuali danneggiamenti che la merce/bene "
					+ "può subire a causa di improprie e/o anomale condizioni di trasporto.");
			
			//File imageHeader = new File("C:\\Users\\antonio.dicivita\\Calver\\logo.png");
			//File imageHeader = new File(Costanti.PATH_FOLDER_LOGHI +"4132_header_sc.jpg");
			File imageHeader = new File(Costanti.PATH_FOLDER_LOGHI +"logo_sti_ddt.png");
			if(imageHeader!=null) {
				report.addParameter("logo",imageHeader);
			
				}
			
			SubreportBuilder subreport = cmp.subreport(getTableReport(lista_item_pacco));
			report.addDetail(subreport);
			
			int totale = 0;
			for (MagItemPaccoDTO item_pacco : lista_item_pacco) {
				totale = totale + item_pacco.getQuantita();
			}
			report.addParameter("totale", totale);
			//report.setDetailSplitType(SplitType.PREVENT);
			
			report.setDataSource(new JREmptyDataSource());
			
			//String path = "C:\\Users\\antonio.dicivita\\Desktop\\ddt.pdf";
			MagPaccoDTO pacco = GestioneMagazzinoBO.getPaccoByDDT(ddt.getId(), session);
			String path = Costanti.PATH_FOLDER+"\\"+"Magazzino\\DDT\\PC_"+pacco.getId()+"\\";
			  java.io.File folder = new java.io.File(path);
			  if(!folder.exists()) {
				  folder.mkdirs();
			  }
			  File file = new File( path + ddt.getNumero_ddt() +".pdf");
			  FileOutputStream fos = new FileOutputStream(file);
			  report.toPdf(fos);
			
			  fos.close();
			
			  this.file = file;
			  this.setEsito(true);
			  ddt.setLink_pdf(ddt.getNumero_ddt() +".pdf");
			
			  GestioneMagazzinoBO.updateDdt(ddt, session);

	}
	
	
	
	@SuppressWarnings("deprecation")
	public JasperReportBuilder getTableReport(List<MagItemPaccoDTO> lista_item_pacco) throws Exception{

	
	 
		JasperReportBuilder report = DynamicReports.report();

		

			report.setColumnStyle((Templates.boldCenteredStyle).setFontSize(9));
 	 		
 	 		report.addColumn(col.column("Codice della merce o servizio","id_item", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setFixedWidth(149));
	 		report.addColumn(col.column("Descrizione della merce o servizio","denominazione", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(239));
	 		report.addColumn(col.column("Q.ta","quantita", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(43));
	 		report.addColumn(col.column("Note","note", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.RIGHT).setFixedWidth(120));

			report.setColumnStyle((Templates.columnStyle).setFontSize(8).setBorder(stl.penThin()));
			report.setColumnTitleStyle((Templates.boldCenteredStyle).setFontSize(9).setBorder(stl.penThin()).setBackgroundColor(new Color(204,204,204)));

			report.setDetailSplitType(SplitType.PREVENT);
			
			report.setDataSource(createDataSource(lista_item_pacco));
	  

		return report;
	}
	
	public JasperReportBuilder getTableReportTot(List<MagItemPaccoDTO> lista_item_pacco) throws Exception{

		StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.penThin()).setFontSize(10);//AGG
		
	 
		JasperReportBuilder report = DynamicReports.report();

			report.setTemplate(Templates.reportTemplate);
			report.setColumnStyle((Templates.boldCenteredStyle).setFontSize(10).setBorder(stl.penThin()));

	 		report.addColumn(col.column("Totale", "totale", type.stringType()).setFixedWidth(43));
	 		StyleBuilder st = Styles.style()
	                .bold()
	                .setFontSize(9);
			
	        		report.setColumnStyle(st);
	 		
	 		report.setColumnTitleStyle((Templates.boldCenteredStyle).setFontSize(10).setBorder(stl.penThin()));
	 		report.setDetailSplitType(SplitType.PREVENT);
			report.setDataSource(createDataSourceTot(lista_item_pacco));
		
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
	 				if(item_pacco.getItem().getMatricola()!=null && !item_pacco.getItem().getMatricola().equals("")&& !item_pacco.getItem().getMatricola().equals("-") && !item_pacco.getItem().getMatricola().equals("/")) {
	 					arrayPs.add(item_pacco.getItem().getDescrizione() + " Matr.: "+ item_pacco.getItem().getMatricola());	
	 				}else if(item_pacco.getItem().getCodice_interno()!=null && !item_pacco.getItem().getCodice_interno().equals("") && !item_pacco.getItem().getCodice_interno().equals("-") && !item_pacco.getItem().getCodice_interno().equals("/")){
	 					arrayPs.add(item_pacco.getItem().getDescrizione() + " Cod. Int.: "+ item_pacco.getItem().getCodice_interno());
	 				}else {
	 					arrayPs.add(item_pacco.getItem().getDescrizione());
	 				}
	 				arrayPs.add(String.valueOf(item_pacco.getQuantita()));
	 				arrayPs.add(item_pacco.getNote());
	 			
			         Object[] listaValori = arrayPs.toArray();
			        
			         dataSource.add(listaValori);
				}
			
			}

 		    return dataSource;
 	}



private JRDataSource createDataSourceTot(List<MagItemPaccoDTO> lista_item_pacco)throws Exception {		
	
	String[] listaCodici = new String[1];
	
	listaCodici[0]="totale";
	
	DRDataSource dataSource = new DRDataSource(listaCodici);
	int totale = 0;
	for (MagItemPaccoDTO item_pacco : lista_item_pacco) {
		totale = totale + item_pacco.getQuantita();
	}

	dataSource.add(String.valueOf(totale));
		return dataSource;
	}


public boolean isEsito() {
	return esito;
}



public void setEsito(boolean esito) {
	this.esito = esito;
}
		
	}
