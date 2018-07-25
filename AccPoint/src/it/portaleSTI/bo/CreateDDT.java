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
import ar.com.fdvs.dj.domain.constants.Border;
import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.FornitoreDTO;
import it.portaleSTI.DTO.MagDdtDTO;
import it.portaleSTI.DTO.MagItemPaccoDTO;
import it.portaleSTI.DTO.SedeDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.Util.Templates;
import net.sf.dynamicreports.jasper.builder.JasperReportBuilder;
import net.sf.dynamicreports.report.builder.DynamicReports;
import net.sf.dynamicreports.report.builder.component.SubreportBuilder;
import net.sf.dynamicreports.report.builder.style.BorderBuilder;
import net.sf.dynamicreports.report.constant.HorizontalTextAlignment;
import net.sf.dynamicreports.report.constant.SplitType;
import net.sf.dynamicreports.report.datasource.DRDataSource;
import net.sf.dynamicreports.report.exception.DRException;
import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JREmptyDataSource;


	public class CreateDDT {
	
	
	File file; 
	private boolean esito; 
	public CreateDDT(MagDdtDTO ddt, String cli_for,List<SedeDTO> lista_sedi, List<MagItemPaccoDTO> lista_item_pacco, Session session) throws Exception  {

			// Utility.memoryInfo();
			build(ddt,cli_for, lista_sedi, lista_item_pacco, session);
			// Utility.memoryInfo();

	}
	
	

	private void build(MagDdtDTO ddt,String cli_for, List<SedeDTO> lista_sedi, List<MagItemPaccoDTO> lista_item_pacco, Session session) throws Exception {
		
		
		InputStream is =  PivotTemplate.class.getResourceAsStream("ddt.jrxml");
		
		JasperReportBuilder report = DynamicReports.report();
		
		
//		try {
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
			//String ora_trasporto;
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
			String indirizzo="";
			String cap="";
			String citta="";
			String provincia="";
			
			ClienteDTO cliente =null;
			if(cli_for.equals("fornitore")) {				
				
			//	FornitoreDTO fornitore = GestioneAnagraficaRemotaBO.getFornitoreByID(String.valueOf(ddt.getId_destinatario()));
				cliente = GestioneAnagraficaRemotaBO.getClienteById(String.valueOf(ddt.getId_destinatario()));
				if(ddt.getId_sede_destinatario()!=0) {
										
					SedeDTO sede = GestioneAnagraficaRemotaBO.getSedeFromId(lista_sedi, ddt.getId_sede_destinatario());
					
					if(cliente.getNome()!=null) {
						
						report.addParameter("destinatario",sede.getDescrizione());
						report.addParameter("indr_destinatario",sede.getIndirizzo());
						report.addParameter("citta_destinatario", sede.getCap() +" " +sede.getComune() +" (" + sede.getSiglaProvincia()+")");
					}else {
						report.addParameter("destinatario","");
					}
					
				}else {
					
					if(cliente.getNome()!=null) {
						
						report.addParameter("destinatario",cliente.getNome());
					}else {
						report.addParameter("destinatario","");
					}
				}				
				if(ddt.getId_destinatario()!=ddt.getId_destinazione()) {
					cliente = GestioneAnagraficaRemotaBO.getClienteById(String.valueOf(ddt.getId_destinazione()));
				}				
				if(ddt.getId_sede_destinazione()!=0) {
					
					SedeDTO sede = GestioneAnagraficaRemotaBO.getSedeFromId(lista_sedi, ddt.getId_sede_destinazione());
					
					if(cliente.getNome()!=null) {
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
				
				
				}	
				else {
					report.addParameter("destinazione",cliente.getNome());
					report.addParameter("indr_destinazione", cliente.getIndirizzo());
					report.addParameter("citta_destinazione", cliente.getCap() +" " +cliente.getCitta()+" (" + cliente.getProvincia()+")");
				}

			}else {
				 cliente = GestioneAnagraficaRemotaBO.getClienteById(String.valueOf(ddt.getId_destinatario()));

				if(ddt.getId_sede_destinatario()!=0) {
										
					SedeDTO sede = GestioneAnagraficaRemotaBO.getSedeFromId(lista_sedi, ddt.getId_sede_destinatario());
					
					if(cliente.getNome()!=null) {
						
						report.addParameter("destinatario",sede.getDescrizione());
						report.addParameter("indr_destinatario",sede.getIndirizzo());
						report.addParameter("citta_destinatario", sede.getCap() +" " +sede.getComune() +" (" + sede.getSiglaProvincia()+")");
					}else {
						report.addParameter("destinatario","");
					}
					
				}else {
					
					if(cliente.getNome()!=null) {
						
						report.addParameter("destinatario",cliente.getNome());
						report.addParameter("indr_destinatario", cliente.getIndirizzo());
						report.addParameter("citta_destinatario", cliente.getCap() +" " +cliente.getCitta()+" (" + cliente.getProvincia()+")");
					}else {
						report.addParameter("destinatario","");
					}
				}				
				if(ddt.getId_destinatario()!=ddt.getId_destinazione() && ddt.getId_destinazione()!=0) {
					cliente = GestioneAnagraficaRemotaBO.getClienteById(String.valueOf(ddt.getId_destinazione()));
				}				
				if(ddt.getId_sede_destinazione()!=0) {
					
					SedeDTO sede = GestioneAnagraficaRemotaBO.getSedeFromId(lista_sedi, ddt.getId_sede_destinazione());
					
					if(cliente.getNome()!=null) {
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
					report.addParameter("destinazione",cliente.getNome());
					report.addParameter("indr_destinazione", cliente.getIndirizzo());
					report.addParameter("citta_destinazione", cliente.getCap() +" " +cliente.getCitta()+" (" + cliente.getProvincia()+")");
				}
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
			File imageHeader = new File(Costanti.PATH_FOLDER_LOGHI +"4132_header_sc.jpg");
			if(imageHeader!=null) {
				report.addParameter("logo",imageHeader);
			
				}
			
			SubreportBuilder subreport;

				subreport = cmp.subreport(getTableReport(lista_item_pacco));
				report.addDetail(subreport);

			report.setDataSource(new JREmptyDataSource());
			
			//String path = "C:\\Users\\antonio.dicivita\\Desktop\\ddt.pdf";
			String path = Costanti.PATH_FOLDER+"\\"+"Magazzino" + "\\"+ ddt.getNumero_ddt() +".pdf";
			  java.io.File file = new java.io.File(path);
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

		try {
			
//			report.setColumnStyle((Templates.boldCenteredStyle).setFontSize(9));
// 	 		report.addColumn(col.column("", "id_item", type.stringType()));
//	 		report.addColumn(col.column("", "denominazione", type.stringType()));
//	 		report.addColumn(col.column("", "quantita", type.stringType()));
//	 		report.addColumn(col.column("", "note", type.stringType()));
//			
//			report.setColumnStyle((Templates.boldCenteredStyle).setFontSize(9));
			
			report.setColumnStyle((Templates.boldCenteredStyle).setFontSize(9));
 	 		report.addColumn(col.column("id_item", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.LEFT).setFixedWidth(149));
	 		report.addColumn(col.column("denominazione", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(239));
	 		report.addColumn(col.column("quantita", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.CENTER).setFixedWidth(43));
	 		report.addColumn(col.column("note", type.stringType()).setHorizontalTextAlignment(HorizontalTextAlignment.RIGHT).setFixedWidth(120));
			
			report.setColumnStyle((Templates.boldCenteredStyle).setFontSize(9).setBorder(stl.penThin()));


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
	 				arrayPs.add(item_pacco.getItem().getDescrizione() + " Matricola: "+ item_pacco.getItem().getMatricola());
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
