package it.portaleSTI.Util;
import static net.sf.dynamicreports.report.builder.DynamicReports.cmp;
import static net.sf.dynamicreports.report.builder.DynamicReports.col;
import static net.sf.dynamicreports.report.builder.DynamicReports.report;
import static net.sf.dynamicreports.report.builder.DynamicReports.stl;
import static net.sf.dynamicreports.report.builder.DynamicReports.type;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.GraphicsConfiguration;
import java.awt.GraphicsDevice;
import java.awt.GraphicsEnvironment;
import java.awt.Image;
import java.awt.Transparency;
import java.awt.image.BufferedImage;
import java.awt.image.ColorModel;
import java.awt.image.RenderedImage;
import java.awt.image.WritableRaster;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.MathContext;
import java.math.RoundingMode;
import java.nio.charset.Charset;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.sql.Types;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.crypto.Cipher;
import javax.crypto.spec.SecretKeySpec;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringEscapeUtils;

import com.sun.mail.smtp.SMTPMessage;
import com.sun.mail.smtp.SMTPTransport;

import it.portaleSTI.DTO.LatPuntoLivellaDTO;
import it.portaleSTI.DTO.MagItemPaccoDTO;
import it.portaleSTI.DTO.MagPaccoDTO;
import it.portaleSTI.DTO.PermessoDTO;
import it.portaleSTI.DTO.PuntoMisuraDTO;
import it.portaleSTI.DTO.RilPuntoQuotaDTO;
import it.portaleSTI.DTO.RilQuotaDTO;
import it.portaleSTI.DTO.RilSimboloDTO;
import it.portaleSTI.DTO.RuoloDTO;
import it.portaleSTI.DTO.UtenteDTO;
import it.portaleSTI.DTO.VerStrumentoDTO;
import it.portaleSTI.Exception.STIException;
import it.portaleSTI.Sec.AsymmetricCryptography;
import net.sf.dynamicreports.report.builder.column.TextColumnBuilder;
import net.sf.dynamicreports.report.builder.style.StyleBuilder;
import net.sf.dynamicreports.report.constant.HorizontalAlignment;
import net.sf.dynamicreports.report.exception.DRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;

public class Utility extends HttpServlet {

	public static String getNomeFile(String memo) {

		if(memo!=null)
		{
			int indexStart=memo.indexOf("<name>");
			int indexEnd=memo.indexOf("</name>");

			memo=memo.substring(indexStart+6,indexEnd);
			return memo;
		}
		else
		{
			return "";
		}
	}

	public static  void copiaFile(String origine, String destinazione)throws Exception
	{
		FileInputStream fis = new FileInputStream(origine);
		FileOutputStream fos = new FileOutputStream(destinazione);

		byte [] dati = new byte[fis.available()];
		fis.read(dati);
		fos.write(dati);

		fis.close();
		fos.close();
	}
	
	public static  void overwriteFile(String origine, String destinazione)throws Exception
	{
		FileInputStream fis = new FileInputStream(origine);
		FileOutputStream fos = new FileOutputStream(destinazione,false);

		byte [] dati = new byte[fis.available()];
		fis.read(dati);
		fos.write(dati);

		fis.close();
		fos.close();
	}
	
	public static void generateZipSTI(String path, String archiveName) throws Exception {
		File[] child = new File(path).listFiles();
		ZipOutputStream zip = new ZipOutputStream(new BufferedOutputStream(new FileOutputStream(Costanti.PATH_FOLDER+"\\"+archiveName)));
		
		FileInputStream fis=null;
	//	zip.putNextEntry(new ZipEntry("viewerSTI.jar"));
	//	FileInputStream fis = new FileInputStream(Costanti.PATH_SOURCE_FORM+"//viewerSTI.jar");
		byte[] readBuffer =null;//new byte[fis.available()];
		
	//	fis.read(readBuffer);
	//	zip.write(readBuffer);
	//	fis.close();
	//	for(int i = 0; i < child.length; i++)
	//	{
			
			zip.putNextEntry(new ZipEntry(child[0].getName()));
			fis = new FileInputStream(child[0]);
			readBuffer =new byte[fis.available()];
			fis.read(readBuffer);
			zip.write(readBuffer);
			fis.close();
			child[0].delete();
			
		//}
		zip.close(); 

	}

	public static boolean checkSession(HttpSession session, String att) {

		if(session.getAttribute(att)!=null)
		{
			return true;
		}
		return false;
	}

	public static boolean validateSession(HttpServletRequest request,HttpServletResponse response, ServletContext servletContext) throws ServletException, IOException {

		
		UtenteDTO utente =(UtenteDTO)request.getSession().getAttribute("userObj");
	
		if (utente == null ) 
		{
			
		RequestDispatcher dispatcher = servletContext.getRequestDispatcher("/site/sessionDown.jsp");
     	dispatcher.forward(request,response);
     	
     	return true;
		}
		
		if(checkPermesso(request.getRequestURI().toString(),utente)==false)
		{
			request.getSession().setAttribute("exception", new STIException("Errore permesso Accesso"));
			RequestDispatcher dispatcher = servletContext.getRequestDispatcher("/site/notAuthorization.jsp");
	     	dispatcher.forward(request,response);
	     	
	     	return true;
		}
		
		
		return false;
	}
	
	private static boolean checkPermesso(String pathInfo, UtenteDTO utente) {
	
		for (RuoloDTO ruolo : utente.getListaRuoli()) 
		{
			for (PermessoDTO permesso  : ruolo.getListaPermessi()) {
				
			if(permesso.getPercorso()!=null) {	

				
						if(permesso.getPercorso().indexOf("-")>0) 
						{
							String[] permessi = permesso.getPercorso().split("-");
							
							for (int i = 0; i < permessi.length; i++) {
								
								if(pathInfo.indexOf(permessi[i].trim())>=0) 	
								{
									return true;
								}						
							}
						}
						
						else if(pathInfo.indexOf(permesso.getPercorso())>=0) 	
						{
							return true;
						}
					}	
			}
		}
	
		
		return false;
	}

	public static String checkStringNull(String value) {
		
		if (value==null) {
			
			return "-";
		}
		return value;
	}
	
	public static String checkFloatNull(Float value) {
		
		if (value==null) {
			
			return "-";
		}
		return value.toString();
	}
	
	public static String checkBigDecimalNull(BigDecimal value) {
		
		if (value==null) {
			
			return "-";
		}
		return value.setScale(Costanti.CIFRE_SIGNIFICATIVE,RoundingMode.HALF_UP).toPlainString();
	}
	
	public static String checkIntegerNull(Integer value) {
		
		if (value==null) {
			
			return "-";
		}
		return value.toString();
	}
	public static String checkDateNull(Date value) {
		
		if (value==null) {
			
			return "-";
		}
		SimpleDateFormat sdf= new SimpleDateFormat("dd/MM/yyyy");
		
		return sdf.format(value);
	}

	public static String getVarchar(String string) {
		
		if(string==null)
		{
			return "";
		}
		else
		{
			string=string.replaceAll("\"", "");
			string=string.replaceAll("\'", "");
		}
		return string;
	}	
	
	public static Date getActualDateSQL()
	{
		java.sql.Date date = new java.sql.Date(new java.util.Date().getTime());
		
		return date;
	}
	
	public static void StampaJasper()
	throws IOException, ServletException
	{
		try{
	
			Map<String,Object> parameters = new HashMap<String,Object>(); 
			
		//	JasperDesign jasperDesign = JRXmlLoader.load("//server/captureSV/report/source/report_statistiche_1.jrxml");
		   
			  //compilazione del file e generazione del file JASPER
		//    JasperCompileManager.compileReportToFile(jasperDesign,"//server/captureSV/report/source/report_statistiche_1.jasper");
		    
		    ArrayList misure=getMisure();
		    
		    JRBeanCollectionDataSource coll = new JRBeanCollectionDataSource(misure);
		    
		    parameters.put("th1", "Tipo Verifica");
		    parameters.put("th2", "Unità di misura");
		    parameters.put("th3", "Valore Campione");
		    parameters.put("th4", "Valore medio Campione");
		    parameters.put("th5", "Valore Strumento");
		    parameters.put("th6", "Valore medio Strumento");
		    parameters.put("th7", "sc");
		    parameters.put("th8", "Accettibilità");
		    parameters.put("th9", "Incertezza U");
		    parameters.put("th10", "ESITO");
		    
		    
			 JasperDesign jasperDesign = JRXmlLoader.load("/Users/marcopagnanelli/Downloads/Jasper/report_statistiche_1.jrxml");


			 JasperCompileManager.compileReportToFile(jasperDesign,"/Users/marcopagnanelli/Downloads/Jasper/report_statistiche_1.jasper");

			
		    
		   
		    //rendering e generazione del file PDF
		    //JasperPrint jp = JasperFillManager.fillReport("/Users/marcopagnanelli/Downloads/Jasper/report_statistiche_1.jasper", parameters,coll);
						   
		    //JasperExportManager.exportReportToPdfFile(jp,"/Users/marcopagnanelli/Downloads/Jasper/report.pdf");

			 
//			 Style oddRowStyle = new Style();
//			 oddRowStyle.setBorder(Border.PEN_1_POINT());
//			 Color veryLightGrey = new Color(230,230,230);
//			 oddRowStyle.setBackgroundColor(veryLightGrey);
//			 oddRowStyle.setTransparency(Transparency.OPAQUE);
//			
//			FastReportBuilder drb = new FastReportBuilder();
//			DynamicReport dr = drb.addColumn("Tipo Verifica", "tipoVerifica", String.class.getName(),30)
//			.addColumn("Unità di misura", "um", String.class.getName(),30)
//			.addColumn("Valore Campione", "valoreCampione", String.class.getName(),50)
//			.addColumn("Valore medio Campione", "valoreMedioCampione", String.class.getName(),50,true)
//			.addColumn("Valore Strumento", "valoreStrumento", String.class.getName(),30,true)
//			.addColumn("Valore medio Strumento", "valoreMedioStrumento", String.class.getName(),60,true)
//			.addColumn("sc", "scostamento", String.class.getName(),70,true)
//			.addColumn("Accettabilità", "accettabilita", String.class.getName(),70,true)
//			.addColumn("Incertezza", "incertezza", String.class.getName(),70,true)
//			.addColumn("Esito", "esito", String.class.getName(),70,true)
//			.setTitle("November 2006 sales report")
//			.setSubtitle("This report was generated at " + new Date())
//			.setPrintBackgroundOnOddRows(true)
//			.setUseFullPageWidth(true)
//			.setOddRowBackgroundStyle(oddRowStyle)
//	        
//			.build();
//
//			JRDataSource ds = new JRBeanCollectionDataSource(misure);
//			JasperPrint jpx = DynamicJasperHelper.generateJasperPrint(dr, new ClassicLayoutManager(), ds);
			//JasperViewer.viewReport(jpx);    //finally display the report report
			 StyleBuilder textStyle = stl.style(Templates.columnStyle).setBorder(stl.pen1Point());
			 StyleBuilder boldStyle         = stl.style().bold();  
			 StyleBuilder boldCenteredStyle = stl.style(boldStyle).setHorizontalAlignment(HorizontalAlignment.CENTER);	 
			 StyleBuilder columnTitleStyle  = stl.style(boldCenteredStyle).setBorder(stl.pen1Point()).setBackgroundColor(Color.LIGHT_GRAY);
		     
			 TextColumnBuilder<String>     tipoVerifica       	= col.column("Tipo Verifica", "tipoVerifica",type.stringType());		     
		      TextColumnBuilder<String>     um       			= col.column("Unità di misura", "um",type.stringType());		     
		      TextColumnBuilder<String>     valoreCampione      = col.column("Valore Campione", "valoreCampione",type.stringType());		     
		      TextColumnBuilder<String>     valoreMedioCampione = col.column("Valore medio Campione", "valoreMedioCampione",type.stringType());		     
		      TextColumnBuilder<String>     valoreStrumento     = col.column("Valore Strumento", "valoreStrumento",type.stringType());		     
		      TextColumnBuilder<String>     valoreMedioStrumento = col.column("Valore medio Strumento", "valoreMedioStrumento",type.stringType());		     
		      TextColumnBuilder<String>     accettabilita       = col.column("Accettabilità", "accettabilita",type.stringType());		     
		      TextColumnBuilder<String>     scostamento       	= col.column("Scostamento", "scostamento",type.stringType());		     
		      TextColumnBuilder<String>     incertezza       	= col.column("Incertezza", "incertezza",type.stringType());		     
		      TextColumnBuilder<String>     esito       		= col.column("Esito", "esito",type.stringType());		     

		     // tipoVerifica.setPrintRepeatedDetailValues(false);
		      tipoVerifica.setFixedColumns(3);
			 
			 
			 try {
					         report()
					         .setTemplate(Templates.reportTemplate)
					         .setColumnStyle(textStyle)
					         .columns(tipoVerifica,um,valoreCampione,
					        		 valoreMedioCampione,valoreStrumento,
					        		 valoreMedioStrumento,accettabilita,
					        		 scostamento,incertezza,esito		 
					        )
					         
					        /* .columnGrid(
					        		grid.horizontalColumnGridList(
					        				tipoVerifica/*,
					        				grid.verticalColumnGridList(
							        		 valoreMedioCampione,um,valoreCampione),
					        				grid.verticalColumnGridList(valoreStrumento,
					        						grid.horizontalColumnGridList(valoreMedioStrumento,accettabilita),
							        		 scostamento,incertezza,esito	
					        		)))*/

					         .title(cmp.text("Ripetibilità"))//shows report title

				.setDataSource(misure)
				
				 .show();
					 } catch (DRException e) {
						 e.printStackTrace();
				 }
			 
			 
		    //JasperExportManager.exportReportToPdfFile(jp,"/Users/marcopagnanelli/Downloads/Jasper/report.pdf");

		} 
		catch(Exception ex)
		{
			if(ex instanceof IllegalStateException)
			{
				
			}
			else
			{
			ex.printStackTrace();

			}
		}  
	}
	
	
	private static ArrayList getMisure() {
		
	/*	ArrayList<MisuraDTO> listaMisure = new ArrayList<>();
		
		MisuraDTO misura = new MisuraDTO();
		misura.setTipoVerifica("Punto1");
		misura.setUm("mm");
		misura.setValoreCampione("0,5");
		misura.setValoreMedioCampione("0,5");
		misura.setValoreStrumento("0,499");
		misura.setValoreMedioStrumento("0,498");
		misura.setScostamento("0,002");
		misura.setAccettabilita("0,004");
		misura.setIncertezza("0,001");
		misura.setEsito("IDONEO");
		listaMisure.add(misura);
		
		misura.setTipoVerifica("Punto2");
		misura.setUm("mm");
		misura.setValoreCampione("0,5");
		misura.setValoreMedioCampione("0,5");
		misura.setValoreStrumento("0,497");
		misura.setValoreMedioStrumento("0,498");
		misura.setScostamento("0,002");
		misura.setAccettabilita("0,004");
		misura.setIncertezza("0,001");
		misura.setEsito("IDONEO");
		
		listaMisure.add(misura);
		
		misura.setTipoVerifica("Punto3");
		misura.setUm("mm");
		misura.setValoreCampione("0,5");
		misura.setValoreMedioCampione("0,5");
		misura.setValoreStrumento("0,498");
		misura.setValoreMedioStrumento("0,498");
		misura.setScostamento("0,002");
		misura.setAccettabilita("0,004");
		misura.setIncertezza("0,001");
		misura.setEsito("IDONEO");
		
		listaMisure.add(misura);

		return listaMisure;*/
		
		return null;
	}

	public static void main(String[] args){
		 
		try {
			//StampaJasper();
			BigDecimal incertezza= new BigDecimal("0.00615");
			incertezza = incertezza.round(new MathContext(2, RoundingMode.HALF_UP));
			System.out.println(incertezza.toPlainString());
		} catch (Exception  e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public static int getScale(BigDecimal value){
		return value.stripTrailingZeros().scale()/*+1*/;
	}

	public static String getIncertezzaNormalizzata(BigDecimal incertezza) {

		incertezza = incertezza.round(new MathContext(2, RoundingMode.HALF_UP));
		return changeDotComma(incertezza.toPlainString());

	}
	
	public static Image rotateImage(BufferedImage image, double angle, Boolean checkSize) {
	    double sin = Math.abs(Math.sin(angle)), cos = Math.abs(Math.cos(angle));
	    int w = image.getWidth(), h = image.getHeight();
	    if(w<h && checkSize) {
	    	   return image;
	    }
	    int neww = (int)Math.floor(w*cos+h*sin), newh = (int)Math.floor(h*cos+w*sin);
	    GraphicsConfiguration gc = getDefaultConfiguration();
	    BufferedImage result = gc.createCompatibleImage(neww, newh, Transparency.TRANSLUCENT);
	    Graphics2D g = result.createGraphics();
	    g.translate((neww-w)/2, (newh-h)/2);
	    g.rotate(angle, w/2, h/2);
	    g.drawRenderedImage(image, null);
	    g.dispose();
	    return result;
	}
	public static GraphicsConfiguration getDefaultConfiguration() {
	    GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
	    GraphicsDevice gd = ge.getDefaultScreenDevice();
	    return gd.getDefaultConfiguration();
	}
	public static BufferedImage convertRenderedImage(RenderedImage img) {
	    if (img instanceof BufferedImage) {
	        return (BufferedImage)img;  
	    }   
	    ColorModel cm = img.getColorModel();
	    int width = img.getWidth();
	    int height = img.getHeight();
	    WritableRaster raster = cm.createCompatibleWritableRaster(width, height);
	    boolean isAlphaPremultiplied = cm.isAlphaPremultiplied();
	    Hashtable properties = new Hashtable();
	    String[] keys = img.getPropertyNames();
	    if (keys!=null) {
	        for (int i = 0; i < keys.length; i++) {
	            properties.put(keys[i], img.getProperty(keys[i]));
	        }
	    }
	    BufferedImage result = new BufferedImage(cm, raster, isAlphaPremultiplied, properties);
	    img.copyData(raster);
	    return result;
	}
	
 	public static String changeDotComma(String value) {
		
		value = value.replace('.', ',');
		
		return value;
 	}
 	
	public static void memoryIntoTotal()
	{
		BigDecimal maxHeapSize = new BigDecimal( Runtime.getRuntime().maxMemory());
		
		BigDecimal totalHeapSize = new BigDecimal( Runtime.getRuntime().totalMemory());
		
		System.out.println("Max Heap Size : " + maxHeapSize.divide(new BigDecimal(1000000),RoundingMode.HALF_UP)+ " MB");
		
		System.out.println("Total Heap Size : " + totalHeapSize.divide(new BigDecimal(1000000),RoundingMode.HALF_UP)+ " MB");
	}
	
	public static void memoryInfo()
	{
		BigDecimal freeHeapSize = new BigDecimal( Runtime.getRuntime().freeMemory());
		
		try 
		{
			freeHeapSize	=freeHeapSize.divide(new BigDecimal(1000000),RoundingMode.HALF_UP);
		} 
		catch (Exception e) {
			freeHeapSize=BigDecimal.ZERO;
		}		
		
		System.out.println("Free Heap Size :" + freeHeapSize+ " byte");
		
	}

	public static void sendEmail(String to, String subject, String msgHtml) throws Exception {

			      
			      // Get system properties
			      Properties properties = System.getProperties();

			      // Setup mail server
			      properties.setProperty("mail.smtp.host", Costanti.HOST_MAIL_SYSTEM);
			      properties.setProperty("mail.smtp.port", Costanti.HOST_MAIL_SYSTEM_PORT);
			      properties.setProperty("mail.smtp.auth", "true");
			      properties.setProperty("mail.transport.protocol", "smtps");
			      properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			      
			      // Get the default Session object.
			      javax.mail.Session session = javax.mail.Session.getDefaultInstance(properties);
				
				  MimeMessage message = new MimeMessage(session);

		         // Set From: header field of the header.
		         message.setFrom(new InternetAddress(Costanti.HOST_MAIL_SYSTEM_SENDER));

		         // Set To: header field of the header.
		         

		 		InternetAddress[] address = InternetAddress.parse(to.trim().replace(";", ","));
		         
		         message.addRecipients(Message.RecipientType.TO, address);

		         // Set Subject: header field
		         message.setSubject(subject);
		         
		         message.setText(msgHtml, "utf-8", "html");

		         // Send message
		     	 SMTPTransport t = (SMTPTransport)session.getTransport("smtps");
	  		    
		        try {
	  			    t.connect(Costanti.HOST_MAIL_SYSTEM, Costanti.HOST_MAIL_SYSTEM_SENDER, Costanti.HOST_MAIL_SYSTEM_PWD);
	  			    t.sendMessage(message, message.getAllRecipients());
	  		    } finally {

	      			t.close();  
	  		    }
	
	}
	
	
	public static void sendEmailAllegato(String to, String subject, String msgHtml, File file) throws Exception {

	      
	      // Get system properties
	      Properties properties = System.getProperties();

	      // Setup mail server
	      properties.setProperty("mail.smtp.host", Costanti.HOST_MAIL_SYSTEM);
	      properties.setProperty("mail.smtp.port", Costanti.HOST_MAIL_SYSTEM_PORT);
	      properties.setProperty("mail.smtp.auth", "true");
	      properties.setProperty("mail.transport.protocol", "smtps");
	      properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	      
	      // Get the default Session object.
	      javax.mail.Session session = javax.mail.Session.getDefaultInstance(properties);
		
		  MimeMessage message = new MimeMessage(session);

       // Set From: header field of the header.
       message.setFrom(new InternetAddress(Costanti.HOST_MAIL_SYSTEM_SENDER));

       // Set To: header field of the header.
       message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
       
       

       // Set Subject: header field
       message.setSubject(subject);
       
	  BodyPart messageBodyPart = new MimeBodyPart();
		messageBodyPart.setContent(msgHtml,"text/html");
	
		BodyPart allegato = new MimeBodyPart();
		
		DataSource source = new FileDataSource(file);
		allegato.setDataHandler(new DataHandler(source));
		allegato.setFileName(file.getName());
		
		
		 Multipart multipart = new MimeMultipart();
		 
		 multipart.addBodyPart(messageBodyPart);
		 multipart.addBodyPart(allegato);
       
		 
		 message.setContent(multipart);
     //  message.setText(msgHtml, "utf-8", "html");

       // Send message
   	 SMTPTransport t = (SMTPTransport)session.getTransport("smtps");
	    
      try {
		    t.connect(Costanti.HOST_MAIL_SYSTEM, Costanti.HOST_MAIL_SYSTEM_SENDER, Costanti.HOST_MAIL_SYSTEM_PWD);
		    t.sendMessage(message, message.getAllRecipients());
	    } finally {

			t.close();  
	    }
      
      
}
	
	
	public static void sendEmailPEC(String username, String password, String host, String port, String to, String subject, String msgHtml, String filename) throws Exception {
		
		String protocollo = "smtps";


		Properties props = new Properties();
		 
		props.put("mail.transport.protocol", protocollo);
		props.put("mail.smtps.host", host);
		props.setProperty("mail.smtp.port", port);
		props.put("mail.smtps.auth", "true");
		props.put("mail.smtp.starttls.enable", "true");
		
		Session session = Session.getDefaultInstance(props);

		MimeMessage messaggio = new MimeMessage( session );
		
		Multipart multipart = new MimeMultipart();
		 
		// creates body part for the message
		MimeBodyPart messageBodyPart = new MimeBodyPart();
		messageBodyPart.setContent(messaggio, "text/html");
		messageBodyPart.setText(msgHtml, "utf-8", "html");
		// creates body part for the attachment
		MimeBodyPart attachPart = new MimeBodyPart();
		 
		// code to add attachment...will be revealed later
		 
		// adds parts to the multipart
		multipart.addBodyPart(messageBodyPart);
	
		 
		
	
	//	String attachFile = "C:\\Users\\antonio.dicivita\\Desktop\\test.pdf";
		String attachFile = filename;
		attachPart.attachFile(attachFile);
		multipart.addBodyPart(attachPart);
		
		// sets the multipart as message's content
		messaggio.setContent(multipart);
		
		
        // Set From: header field of the header.
		messaggio.setFrom(new InternetAddress(username));

        // Set To: header field of the header.
		messaggio.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

        // Set Subject: header field
		messaggio.setSubject(subject);
		//messaggio.setText(msgHtml, "utf-8", "html");
		
		messaggio.saveChanges();
		messaggio.removeHeader("Message-Id");
		com.sun.mail.smtp.SMTPMessage mex = new SMTPMessage(messaggio);
		com.sun.mail.smtp.SMTPSSLTransport t =(com.sun.mail.smtp.SMTPSSLTransport)session.getTransport(protocollo); // <--SMTPS
		t.setStartTLS(true); //<-- impostiamo il flag per iniziare la comunicazione sicura
		t.connect(host, username ,password);
		 
		t.sendMessage( mex, mex.getAllRecipients());
		t.close();

	}
	
	public static String encrypt(String strClearText,String strKey) throws Exception{
		String strData="";
		
		try {
			SecretKeySpec skeyspec=new SecretKeySpec(strKey.getBytes(),"Blowfish");
			//Cipher cipher=Cipher.getInstance("Blowfish");
			Cipher cipher=Cipher.getInstance("Blowfish");
		//	return base64Encoder.encode(cipher.doFinal(input.getBytes(CHARSET)));
			cipher.init(Cipher.ENCRYPT_MODE, skeyspec);
			byte[] encrypted=cipher.doFinal(strClearText.getBytes());
			strData=new String(encrypted);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e);
		}
		return strData;
	}
	
	public static String decrypt(String strEncrypted,String strKey) throws Exception{
		String strData="";
		
		try {
			SecretKeySpec skeyspec=new SecretKeySpec(strKey.getBytes(),"Blowfish");
			Cipher cipher=Cipher.getInstance("Blowfish");
			cipher.init(Cipher.DECRYPT_MODE, skeyspec);
			byte[] decrypted=cipher.doFinal(strEncrypted.getBytes(Charset.forName("ISO-8859-1")));
			strData=new String(decrypted);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e);
		}
		return strData;
	}
	

	public static String getStringaLavorazionePacco(MagPaccoDTO pacco) 
	{
		
		Iterator<MagItemPaccoDTO> iterator = pacco.getItem_pacco().iterator();
		
		MagItemPaccoDTO item=null;
		int lavorati = 0;
		int totali = 0;
		 while (iterator.hasNext())
		 {
			 
				 item=iterator.next();
				 if(item.getItem().getTipo_item().getId()==1) {
					 totali++;
				 }
				 if(item.getItem().getStato()!=null && item.getItem().getStato().getId()==2) {
					 lavorati++;
				 }
				 
			 
			 
		 }
		 
		 String result = String.valueOf(lavorati) +  "/" + String.valueOf(totali);
		 
		return result;
	}
	
	

	public static double getRapportoLavorati(MagPaccoDTO pacco) 
	{
		
		Iterator<MagItemPaccoDTO> iterator = pacco.getItem_pacco().iterator();
		
		MagItemPaccoDTO item=null;
		int lavorati = 0;
		int totali = 0;
		 while (iterator.hasNext())
		 {
			 
				 item=iterator.next();
				 if(item.getItem().getTipo_item().getId()==1) {
					 totali++;
				 }
				 if(item.getItem().getStato()!=null && item.getItem().getStato().getId()==2) {
					 lavorati++;
				 }
				 
			 
			 
		 }
		 double result = 0.0;
		 if(totali!=0) {
			 result = (double)lavorati/(double)totali;
		 }
		return result;
	}

	 
	public static void removeDirectory(File dir) {
		if (dir.isDirectory()) {
			File[] files = dir.listFiles();
			if (files != null && files.length > 0) {
				for (File aFile : files) {
					removeDirectory(aFile);
				}
			}
	dir.delete();
	} else 
	{
		dir.delete();
	}
	
	}

	
	public static Class<?> toClass(int type) {
        Class<?> result = Object.class;

        switch (type) {
            case Types.CHAR:
            case Types.VARCHAR:
            case Types.LONGVARCHAR:
                result = String.class;
                break;

            case Types.NUMERIC:
            case Types.DECIMAL:
                result = java.math.BigDecimal.class;
                break;

            case Types.BIT:
                result = Boolean.class;
                break;

            case Types.TINYINT:
                result = Byte.class;
                break;

            case Types.SMALLINT:
                result = Short.class;
                break;

            case Types.INTEGER:
                result = Integer.class;
                break;

            case Types.BIGINT:
                result = Long.class;
                break;

            case Types.REAL:
            case Types.FLOAT:
                result = Float.class;
                break;

            case Types.DOUBLE:
                result = Double.class;
                break;

            case Types.BINARY:
            case Types.VARBINARY:
            case Types.LONGVARBINARY:
                result = Byte[].class;
                break;

            case Types.DATE:
                result = java.sql.Date.class;
                break;

            case Types.TIME:
                result = java.sql.Time.class;
                break;

            case Types.TIMESTAMP:
                result = java.sql.Timestamp.class;
                break;
        }

        return result;
    }
	
		public static String setDecimalDigits(int digits, String number) {
			
			if(number!=null && !number.equals("")) {
				BigDecimal bd = new BigDecimal(number);
				return bd.setScale(digits, BigDecimal.ROUND_HALF_UP).toPlainString();
			}else {
				return "";
			}
			
		}
		
		
		public static String encryptData(String data) throws Exception {
			
			AsymmetricCryptography ac = new AsymmetricCryptography();
			PrivateKey privateKey = ac.getPrivate("c:\\prKey\\privateKey");				
				
			String encrypted_msg = ac.encryptText(data, privateKey);
			
			return encrypted_msg;
			
		}
		
		public static String decryptData(String data) throws Exception {

			AsymmetricCryptography ac = new AsymmetricCryptography();
			PublicKey publicKey = ac.getPublic("c:\\pKey\\publicKey");
			data = data.replaceAll(" ", "+");
			String decrypted_msg = ac.decryptText(data, publicKey);
			
			return decrypted_msg;
		}

		public static ArrayList<Integer> getYearList() {
			
			ArrayList<Integer> yearList=new ArrayList<Integer>();
			
			
			yearList.add(2017);
			yearList.add(2018);
			yearList.add(2019);
			yearList.add(2020);
			yearList.add(2021);
			yearList.add(2022);
			yearList.add(2023);
			yearList.add(2024);
			yearList.add(2025);
			
			return yearList;
		}
		
		public static Double[] calcolaTolleranze(Double nominale, RilSimboloDTO ril_simbolo, String classe_tolleranza) {
			Double[] tolleranza =  {0.0,0.0};
			int simbolo = 0;
			if(ril_simbolo!=null) {
				simbolo = ril_simbolo.getId();
			}
			if(classe_tolleranza.equals("ISO 130 DIN 16901 A")){
				 if(nominale >=0 && nominale<=1){
					 tolleranza[0] = 0.18;
					 tolleranza[1] = -0.18;
				 }
				 if(nominale >1 && nominale<=3){
					 tolleranza[0] = 0.19;
					 tolleranza[1] = -0.19;
				 }
				 if(nominale >3 && nominale<=6){
					 tolleranza[0] = 0.20;
					 tolleranza[1] = -0.20;
				 }
				 if(nominale >6 && nominale<=10){
					 tolleranza[0] = 0.21;
					 tolleranza[1] = -0.21;
				 }
				 if(nominale >10 && nominale<=15){
					 tolleranza[0] = 0.23;
					 tolleranza[1] = -0.23;
				 }
				 if(nominale >15 && nominale<=22){
					 tolleranza[0] = 0.25;
					 tolleranza[1] = -0.25;
				 }
				 if(nominale >22 && nominale<=30){
					 tolleranza[0] = 0.27;
					 tolleranza[1] = -0.27;
				 }
				 if(nominale >30 && nominale<=40){
					 tolleranza[0] = 0.30;
					 tolleranza[1] = -0.30;
				 }
				 if(nominale >40 && nominale<=53){
					 tolleranza[0] = 0.34;
					 tolleranza[1] = -0.34;
				 }
				 if(nominale >55 && nominale<=70){
					 tolleranza[0] = 0.38;
					 tolleranza[1] = -0.38;
				 }
				 if(nominale >70 && nominale<=90){
					 tolleranza[0] = 0.44;
					 tolleranza[1] = -0.44;
				 }
				 if(nominale >90 && nominale<=120){
					 tolleranza[0] = 0.51;
					 tolleranza[1] = -0.51;
				 }
				 if(nominale >120 && nominale<=160){
					 tolleranza[0] = 0.60;
					 tolleranza[1] = -0.60;
				 }
				 if(nominale >160 && nominale<=200){
					 tolleranza[0] = 0.70;
					 tolleranza[1] = -0.70;
				 }
				 if(nominale >200 && nominale<=250){
					 tolleranza[0] = 0.90;
					 tolleranza[1] = -0.90;
				 }
				 if(nominale >250 && nominale<=315){
					 tolleranza[0] = 1.10;
					 tolleranza[1] = -1.10;
				 }
				 if(nominale >3150 && nominale<=400){
					 tolleranza[0] = 1.30;
					 tolleranza[1] = -1.30;
				 }
				 if(nominale >400 && nominale<=500){
					 tolleranza[0] = 1.60;
					 tolleranza[1] = -1.60;
				 }
				 if(nominale >500 && nominale<=630){
					 tolleranza[0] = 2.00;
					 tolleranza[1] = -2.00;
				 }
				 if(nominale >630 && nominale<=800){
					 tolleranza[0] = 2.50;
					 tolleranza[1] = -2.50;
				 }		 
				 if(nominale >800 && nominale<=1000){
					 tolleranza[0] = 3.00;
					 tolleranza[1] = -3.00;
				 }
			 }
			 else if(classe_tolleranza.equals("ISO 130 DIN 16901 B")){
				 if(nominale >=0 && nominale<=1){
					 tolleranza[0] = 0.08;
					 tolleranza[1] = -0.08;
				 }
				 if(nominale >1 && nominale<=3){
					 tolleranza[0] = 0.09;
					 tolleranza[1] = -0.09;
				 }
				 if(nominale >3 && nominale<=6){
					 tolleranza[0] = 0.10;
					 tolleranza[1] = -0.10;
				 }
				 if(nominale >6 && nominale<=10){
					 tolleranza[0] = 0.11;
					 tolleranza[1] = -0.11;
				 }
				 if(nominale >10 && nominale<=15){
					 tolleranza[0] = 0.13;
					 tolleranza[1] = -0.13;
				 }
				 if(nominale >15 && nominale<=22){
					 tolleranza[0] = 0.15;
					 tolleranza[1] = -0.15;
				 }
				 if(nominale >22 && nominale<=30){
					 tolleranza[0] = 0.17;
					 tolleranza[1] = -0.17;
				 }
				 if(nominale >30 && nominale<=40){
					 tolleranza[0] = 0.20;
					 tolleranza[1] = -0.20;
				 }
				 if(nominale >40 && nominale<=53){
					 tolleranza[0] = 0.24;
					 tolleranza[1] = -0.24;
				 }
				 if(nominale >55 && nominale<=70){
					 tolleranza[0] = 0.28;
					 tolleranza[1] = -0.28;
				 }
				 if(nominale >70 && nominale<=90){
					 tolleranza[0] = 0.34;
					 tolleranza[1] = -0.34;
				 }
				 if(nominale >90 && nominale<=120){
					 tolleranza[0] = 0.41;
					 tolleranza[1] = -0.41;
				 }
				 if(nominale >120 && nominale<=160){
					 tolleranza[0] = 0.50;
					 tolleranza[1] = -0.50;
				 }
				 if(nominale >160 && nominale<=200){
					 tolleranza[0] = 0.60;
					 tolleranza[1] = -0.60;
				 }
				 if(nominale >200 && nominale<=250){
					 tolleranza[0] = 0.80;
					 tolleranza[1] = -0.80;
				 }
				 if(nominale >250 && nominale<=315){
					 tolleranza[0] = 1.00;
					 tolleranza[1] = -1.00;
				 }
				 if(nominale >3150 && nominale<=400){
					 tolleranza[0] = 1.20;
					 tolleranza[1] = -1.20;
				 }
				 if(nominale >400 && nominale<=500){
					 tolleranza[0] = 1.50;
					 tolleranza[1] = -1.50;
				 }
				 if(nominale >500 && nominale<=630){
					 tolleranza[0] = 1.90;
					 tolleranza[1] = -1.90;
				 }
				 if(nominale >630 && nominale<=800){
					 tolleranza[0] = 2.40;
					 tolleranza[1] = -2.40;
				 }		 
				 if(nominale >800 && nominale<=1000){
					 tolleranza[0] = 2.90;
					 tolleranza[1] = -2.90;
				 }
			 }
			 else {
				
				 if(ril_simbolo==null || simbolo == 6 || simbolo == 20){
					 if(classe_tolleranza.equals("f")){
						 if(nominale>=0 && nominale<=6){
							 tolleranza[0] = 0.05;
							 tolleranza[1] = -0.05;
						 }
						 if(nominale>6 && nominale<=30){
							 tolleranza[0] = 0.1;
							 tolleranza[1] = -0.1;
						 }
						 else if(nominale>30 && nominale<=120){
							 tolleranza[0] = 0.15;
							 tolleranza[1] = -0.15;
						 }
						 else if(nominale>120 && nominale<=400){
							 tolleranza[0] = 0.2;
							 tolleranza[1] = -0.2;
						 }
						 else if(nominale>400 && nominale<=1000){
							 tolleranza[0] = 0.3;
							 tolleranza[1] = -0.3;
						 }
						 else if(nominale>1000 && nominale<=2000){
							 tolleranza[0] = 0.5;
							 tolleranza[1] = -0.5;
						 }		
					 }
					 else if(classe_tolleranza.equals("m")){
						 if(nominale>=0 && nominale<=6){
							 tolleranza[0] = 0.1;
							 tolleranza[1] = -0.1;
						 }
						 if(nominale>6 && nominale<=30){
							 tolleranza[0] = 0.2;
							 tolleranza[1] = -0.2;
						 }
						 else if(nominale>30 && nominale<=120){
							 tolleranza[0] = 0.3;
							 tolleranza[1] = -0.3;
						 }
						 else if(nominale>120 && nominale<=400){
							 tolleranza[0] = 0.5;
							 tolleranza[1] = -0.5;
						 }
						 else if(nominale>400 && nominale<=1000){
							 tolleranza[0] = 0.8;
							 tolleranza[1] = -0.8;
						 }
						 else if(nominale>1000 && nominale<=2000){
							 tolleranza[0] = 1.2;
							 tolleranza[1] = -1.2;
						 }
						 else if(nominale>2000 && nominale<=4000){
							 tolleranza[0] = 2.0;
							 tolleranza[1] = -2.0;
						 }					 	
					 }
					 else if(classe_tolleranza.equals("c")){
						 if(nominale>=0 && nominale<=3){
							 tolleranza[0] = 0.2;
							 tolleranza[1] = -0.2;
						 }
						 if(nominale>3 && nominale<=6){
							 tolleranza[0] = 0.3;
							 tolleranza[1] = -0.3;
						 }
						 if(nominale>6 && nominale<=30){
							 tolleranza[0] = 0.5;
							 tolleranza[1] = -0.5;
						 }
						 else if(nominale>30 && nominale<=120){
							 tolleranza[0] = 0.8;
							 tolleranza[1] = -0.8;
						 }
						 else if(nominale>120 && nominale<=400){
							 tolleranza[0] = 1.2;
							 tolleranza[1] = -1.2;
						 }
						 else if(nominale>400 && nominale<=1000){
							 tolleranza[0] = 2.0;
							 tolleranza[1] = -2.0;
						 }
						 else if(nominale>1000 && nominale<=2000){
							 tolleranza[0] = 3.0;
							 tolleranza[1] = -3.0;
						 }
						 else if(nominale>2000 && nominale<=4000){
							 tolleranza[0] = 4.0;
							 tolleranza[1] = -4.0;
						 }					 	
					 }		 
					 else if(classe_tolleranza.equals("v")){
						 if(nominale>=3 && nominale<=6){
							 tolleranza[0] = 0.5;
							 tolleranza[1] = -0.5;
						 }
						 if(nominale>6 && nominale<=30){
							 tolleranza[0] = 1.0;
							 tolleranza[1] = -1.0;
						 }
						 else if(nominale>30 && nominale<=120){
							 tolleranza[0] = 1.5;
							 tolleranza[1] = -1.5;
						 }
						 else if(nominale>120 && nominale<=400){
							 tolleranza[0] = 2.5;
							 tolleranza[1] = -2.5;
						 }
						 else if(nominale>400 && nominale<=1000){
							 tolleranza[0] = 4.0;
							 tolleranza[1] = -4.0;
						 }
						 else if(nominale>1000 && nominale<=2000){
							 tolleranza[0] = 6.0;
							 tolleranza[1] = -6.0;
						 }
						 else if(nominale>2000 && nominale<=4000){
							 tolleranza[0] = 8.0;
							 tolleranza[1] = -8.0;
						 }					 		
					 }
				 }
				 else if(simbolo==21){
					 if(classe_tolleranza.equals("f") || classe_tolleranza.equals("m")){
						 if(nominale>=0 && nominale<=3){
							 tolleranza[0] = 0.2;
							 tolleranza[1] = -0.2;
						 }
						 else if(nominale>3 && nominale<=6){
							 tolleranza[0] = 0.5;
							 tolleranza[1] = -0.5;
						 }
						 else if(nominale>6){
							 tolleranza[0] = 1.0;
							 tolleranza[1] = -1.0;
						 }			 
					 }
					 else if(classe_tolleranza.equals("c") || classe_tolleranza.equals("v")){
						 if(nominale>=0 && nominale<=3){
							 tolleranza[0] = 0.4;
							 tolleranza[1] = -0.4;
						 }
						 else if(nominale>3 && nominale<=6){
							 tolleranza[0] = 1.0;
							 tolleranza[1] = -1.0;
						 }
						 else if(nominale>6){
							 tolleranza[0] = 2.0;
							 tolleranza[1] = -2.0;
						 }
					 }		
				 }
			 }
			return tolleranza;
		}

		public static String calcolaDelta(String tolleranza_negativa, String tolleranza_positiva, String val_nominale, String pezzo) {
			Double result = null;
			Double toll_neg = null;
			Double toll_pos = null;
			Double nominale = null;
			Double pz = null;
			if(tolleranza_negativa!=null && !tolleranza_negativa.equals("/") && !tolleranza_negativa.equals("")) {
				toll_neg = new Double(tolleranza_negativa);
			}else {
				return null;
			}
			if(tolleranza_positiva!=null && !tolleranza_positiva.equals("/") && !tolleranza_positiva.equals("")) {
				toll_pos = new Double(tolleranza_positiva);
			}else {
				return null;
			}
			if(val_nominale!=null && !val_nominale.contains("M") && !val_nominale.contains("/")) {
				nominale = new Double(val_nominale);
			}else {
				return null;
			}
			
			if(pezzo!=null && !pezzo.equals("") && !pezzo.equals("KO")&& !pezzo.equals("OK") && !pezzo.equals("/")) {
				pz = new Double(pezzo);
			}else {
				return null;
			}
			
			if(pz>nominale+ toll_pos || pz<nominale + toll_neg) {
				if(pz > nominale + toll_pos) {
					result = pz - (nominale+toll_pos);				
				}else{
					if(toll_neg<=0) {
						result = pz - (nominale - Math.abs(toll_neg));
					}else {
						result = pz - (nominale + Math.abs(toll_neg));
					}
				}			
			}else {
				return null;
			}
			return String.valueOf(result);
		}
		
		public static String calcolaDeltaPerc(String tolleranza_negativa, String tolleranza_positiva, String delta) {
			Double result = null;
			Double toll_neg = null;
			Double toll_pos = null;
					
			if(tolleranza_negativa!=null && !tolleranza_negativa.equals("/") && !tolleranza_negativa.equals("")) {
				toll_neg = new Double(tolleranza_negativa);
			}else {
				return null;
			}
			if(tolleranza_positiva!=null && !tolleranza_positiva.equals("/") && !tolleranza_positiva.equals("")) {
				toll_pos = new Double(tolleranza_positiva);
			}else {
				return null;
			}
			if(delta!=null && !delta.equals("")  && (Math.abs(toll_neg)+Math.abs(toll_pos))!=0) {
				Double dlt = new Double(delta);
				result = dlt/((Math.abs(toll_neg) + Math.abs(toll_pos))/2)*100;
			}else {
				return null;
			}
			
			return String.valueOf(result);
			
		}
		
		public static String getMaxDelta(RilQuotaDTO quota, boolean percentuale) {

			List<RilPuntoQuotaDTO>  lista_punti = new ArrayList(quota.getListaPuntiQuota());
			Double max = 0.0;
			for (RilPuntoQuotaDTO punto : lista_punti) {
				Double val = null;
				if(percentuale) {
					if(punto.getDelta_perc()!=null && !punto.getDelta_perc().equals("")) {
						val = Math.abs(new Double(punto.getDelta_perc()));	
					}else {
						val = new Double(0);
					}										
				}else {
					if(punto.getDelta()!=null && !punto.getDelta().equals("")) {
						val = Math.abs(new Double(punto.getDelta()));
					}else {
						val = new Double(0);	
					}							
				}
				if(val>max) {
					max=val;
				}
			}			
			if(max!=0) {
				return String.valueOf(max);
			}else {
				return "";	
			}
			
			
		}
		
		
		public static BigDecimal getAverageLivella(ArrayList<LatPuntoLivellaDTO> listaPuntiDX,ArrayList<LatPuntoLivellaDTO> listaPuntiSX, int type) {
			
			BigDecimal media=BigDecimal.ZERO;
			int index=0;
			
			if(type==2) 
			{
				for (LatPuntoLivellaDTO puntoDX : listaPuntiDX) 
				{
					if(puntoDX.getDiv_dex()!=null && puntoDX.getDiv_dex().compareTo(BigDecimal.ZERO)!=0) 
					{
						media=media.add(puntoDX.getDiv_dex().abs());
						index++;
					}
				}
				for (LatPuntoLivellaDTO puntoSX : listaPuntiSX ) 
				{
					if(puntoSX.getDiv_dex()!=null && puntoSX.getDiv_dex().compareTo(BigDecimal.ZERO)!=0) 
					{
						media=media.add(puntoSX.getDiv_dex().abs());
						index++;
					}
				}
				
				
			}
			
			if(type==1) 
			{
				for (LatPuntoLivellaDTO puntoSX : listaPuntiSX) 
				{
					if(puntoSX.getDiv_dex()!=null && puntoSX.getDiv_dex().compareTo(BigDecimal.ZERO)!=0) 
					{
						media=media.add(puntoSX.getDiv_dex());
						index++;
					}
				}
				
				
			}
			
			if(type==0) 
			{
			for (LatPuntoLivellaDTO puntoDX : listaPuntiDX) 
			{
				if(puntoDX.getDiv_dex()!=null && puntoDX.getDiv_dex().compareTo(BigDecimal.ZERO)!=0) 
				{
					media=media.add(puntoDX.getDiv_dex().abs());
					index++;
				}
			}
			}
			if(media.compareTo(BigDecimal.ZERO)!=0 && index>0)
			{
				return media.divide(new BigDecimal(index), RoundingMode.HALF_UP);			
			}
			else 
			{
				return BigDecimal.ZERO;
			}
		}
		
		
		
		public static BigDecimal getDevStdLivella(ArrayList<LatPuntoLivellaDTO> listaPuntiDX, ArrayList<LatPuntoLivellaDTO> listaPuntiSX, int type) {
			
			BigDecimal mediaGlobale = getAverageLivella(listaPuntiDX, listaPuntiSX,type);
			
			BigDecimal media=BigDecimal.ZERO;
			
			int index=0;
			
			if(type==2) 
			{
				for (LatPuntoLivellaDTO puntoDX : listaPuntiDX) 
				{
					if(puntoDX.getDiv_dex()!=null && puntoDX.getDiv_dex().compareTo(BigDecimal.ZERO)!=0) 
					{
						 double val = Math.pow(puntoDX.getDiv_dex().abs().subtract(mediaGlobale).doubleValue(), 2D);
		                 media = media.add(new BigDecimal(val));
		                 index++;
		                    
						
					}
				}
				for (LatPuntoLivellaDTO puntoSX : listaPuntiSX ) 
				{
					if(puntoSX.getDiv_dex()!=null && puntoSX.getDiv_dex().compareTo(BigDecimal.ZERO)!=0) 
					{
						double val = Math.pow(puntoSX.getDiv_dex().abs().subtract(mediaGlobale).doubleValue(), 2D);
		                media = media.add(new BigDecimal(val));
		                index++;
					}
				}
				
				
			}
			
			if(type==1) 
			{
				for (LatPuntoLivellaDTO puntoSX : listaPuntiSX) 
				{
					if(puntoSX.getDiv_dex()!=null && puntoSX.getDiv_dex().compareTo(BigDecimal.ZERO)!=0) 
					{
						double val = Math.pow(puntoSX.getDiv_dex().subtract(mediaGlobale).doubleValue(), 2D);
		                 media = media.add(new BigDecimal(val));
		                 index++;
					}
				}
				
				
			}
			
			if(type==0) 
			{
			for (LatPuntoLivellaDTO puntoDX : listaPuntiDX) 
			{
				if(puntoDX.getDiv_dex()!=null && puntoDX.getDiv_dex().compareTo(BigDecimal.ZERO)!=0) 
				{
					double val = Math.pow(puntoDX.getDiv_dex().abs().subtract(mediaGlobale).doubleValue(), 2D);
	                media = media.add(new BigDecimal(val));
	                index++;
				}
			}
			}
			
			if(media.compareTo(BigDecimal.ZERO)!=0  && index>1)
			{
				
				BigDecimal d=new BigDecimal(1).setScale(10, RoundingMode.HALF_UP).divide(new BigDecimal(index-1).setScale(10, RoundingMode.HALF_UP),RoundingMode.HALF_DOWN);
				
				BigDecimal  b = media.multiply(d);
			
				Double d1=b.doubleValue();
				
				d1=Math.sqrt(d1);
				return  new BigDecimal(d1);
			}
			else 
			{
				return BigDecimal.ZERO;
			}
			
		}
		
		
		public static BigDecimal getScMaxLivella(ArrayList<LatPuntoLivellaDTO> listaPuntiDX,ArrayList<LatPuntoLivellaDTO> listaPuntiSX) {
			
			BigDecimal mediaGlobale =getAverageLivella(listaPuntiDX, listaPuntiSX,2);
			
			BigDecimal max=BigDecimal.ZERO;
			
			
				for (LatPuntoLivellaDTO puntoDX : listaPuntiDX) 
				{
					if(puntoDX.getDiv_dex()!=null && puntoDX.getDiv_dex().compareTo(BigDecimal.ZERO)!=0) 
					{
						BigDecimal tmp=puntoDX.getDiv_dex().abs().subtract(mediaGlobale).abs();
		               
						if(tmp.compareTo(max)>=1) 
						{
							max=tmp;
						}
		                
		                    
						
					}
				}
				for (LatPuntoLivellaDTO puntoSX : listaPuntiSX ) 
				{
					if(puntoSX.getDiv_dex()!=null && puntoSX.getDiv_dex().compareTo(BigDecimal.ZERO)!=0) 
					{
						BigDecimal tmp=puntoSX.getDiv_dex().abs().subtract(mediaGlobale).abs();
			               
						if(tmp.compareTo(max)>=1) 
						{
							max=tmp;
						}
					}
				}
				
			
			
			return max;
		}
		
		
		
		public static ArrayList<LatPuntoLivellaDTO> ordinaPuntiLivella(ArrayList<LatPuntoLivellaDTO> lista_punti) {
			if(lista_punti.get(0).getRif_tacca()==0) {
				lista_punti.remove(0);
			}
			ArrayList<LatPuntoLivellaDTO> lista_ordinata = (ArrayList<LatPuntoLivellaDTO>) lista_punti.clone();
			
			int centro = (lista_punti.size()/2);
			int index = 1;
			
			for(int i = 0;i<lista_punti.size();i++) {
				if(lista_punti.get(i).getRif_tacca()==0) {
					lista_ordinata.set(centro, lista_punti.get(i));
				}else {
					if(index<=centro) {
						if(lista_punti.get(i).getSemisc().equals("SX")) {
							lista_ordinata.set(centro - index, lista_punti.get(i));
						}else {
							lista_ordinata.set(centro + index, lista_punti.get(i));
						} 
						if(i%2==0) {
							index++;
						}
					}else {
						break;
					}
				}
			}
						
			return lista_ordinata;
		}
		
		
		
		public static int getIndexMax(ArrayList<RilQuotaDTO> lista_quote) {		
			
			int max = 0;
			int result = 0;
			for (int i= 0; i<lista_quote.size();i++) {
				if(lista_quote.get(i).getListaPuntiQuota().size()>max) {
					max= lista_quote.get(i).getListaPuntiQuota().size();
					result= i;
				}		
			}
		
			return result;
		}
		
		public static int getMaxIdPuntoQuota(ArrayList<RilPuntoQuotaDTO> lista_punti) {		
			
			int max = 0;
			int result = 0;
			for (int i= 0; i<lista_punti.size();i++) {
				if(lista_punti.get(i).getId()>max) {
					max = lista_punti.get(i).getId();	
					result = i;
				}		
			}	
			return result;
		}

		public static String getCurrentYear(int format) {
			
			Date date= new Date(); 
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			int year = cal.get(Calendar.YEAR);
			
			String toRet=(""+year).substring(format, 4);
			
			return toRet;
		}
		
		
		public static String getYearFromDate(Date date, int numero_cifre) {			
			
			Calendar cal = Calendar.getInstance();
			cal.setTime(date);
			int year = cal.get(Calendar.YEAR);
			
			numero_cifre = 4 - numero_cifre;
			String toRet=(""+year).substring(numero_cifre, 4);
			
			return toRet;
		}
		
		public static String returnEsit(String r_SL, String r_SL_GW ,int i) {
			/*
			 * 0 - confronto limite>valore
			 * 1 - confronto limite<valore 
			 */
				
				Double valore=null;
				Double limite = null;
				if(r_SL!=null && r_SL.length()>0 && r_SL_GW!=null && r_SL_GW.length()>0 ) 
				{
					
					 valore = getNumber(r_SL);
					 limite = getNumber(r_SL_GW);
				
				
				if(i==0) 
				{
					if(r_SL.indexOf("µ")>1) 
					{
						valore=valore/1000;
					}
					if(valore<=limite) 
					{
						return "OK";
					}else 
					{
						return "KO";
					}
				}else 
				{
					if(valore>limite) 
					{
						return "OK";
					}else 
					{
						return "KO";
					}
				}
			 }
				return "-";
			
		}
		
		
		private static Double getNumber(String test) {
			try {
				Pattern p = Pattern.compile("(-?[0-9]+(?:[,.][0-9]+)?)");
				Matcher m = p.matcher(test);
				while (m.find()) {
				  return Double.parseDouble(m.group());
				}
			}
				catch (Exception e) {
					e.printStackTrace();
					return null;
				}
				return null;
			}

		public static String LeftPaddingZero(String string, int i) {
		
			
			int size=string.length();
		
			if(size<i) 
			{
				String padding="";
				for (int j = 0; j < i-size; j++) {
					
					padding=padding+"0";
				}
			return padding.concat(string);
			}
			else 
			{
				return string.substring(0,i);
			}
		}

		public static String maxChar(String str, int maxChar) {
			
			if(str!=null && str.length()> maxChar) {
				str = str.substring(0, maxChar)+"...";
			}
			return str;
		}
		
		
		
		public static BigDecimal getScostamentoMaxDecentramento(ArrayList<PuntoMisuraDTO> listaMisure) {
			
			BigDecimal max=null;
			BigDecimal min=null;
			
			for (PuntoMisuraDTO misura : listaMisure) {
			
				BigDecimal scostamento=misura.getScostamento();
				
				if(max==null && min==null && scostamento!=null) 
				{
					max=scostamento;
					min=scostamento;
				}
				
				if(scostamento!=null && scostamento.doubleValue()>max.doubleValue()) 
				{
					max=scostamento;
				} 
				
				if(scostamento!=null && scostamento.doubleValue()<min.doubleValue()) 
				{
					min=scostamento;
				} 
			}
			
			if(max!=null) 
			{
				return max.subtract(min);
			}else 
			{
				return BigDecimal.ZERO;
			}
		}
		
		

		    public static String escapeHTML(String value) {
		        return StringEscapeUtils.escapeHtml4(value);
		    }
		    
		    public static String escapeJS(String value) {
		        return StringEscapeUtils.escapeEcmaScript(StringEscapeUtils.escapeHtml4(value));
		    }
		    
		    
			public static boolean isNumber(String nPunti) {
				boolean flag=true;
				
				try 
				{
				 Integer.parseInt(nPunti);		
				} 
				catch (NumberFormatException e) 
				{
					return false;
				}
				
				
				return flag;
			}
		
			
			public static BigDecimal getE(int campo, VerStrumentoDTO strumento, BigDecimal carico)
			{

				BigDecimal e = BigDecimal.ZERO;
				
				int id_tipo_strumento = strumento.getTipo().getId();
				
				if(id_tipo_strumento==1 || id_tipo_strumento==4 || id_tipo_strumento == 5) 
				{
					e=strumento.getDiv_rel_C1().stripTrailingZeros();
				}


				if(id_tipo_strumento==2 ) 
				{
					if(carico.doubleValue()>=0 && carico.doubleValue() <=strumento.getPortata_max_C1().doubleValue()) 
					{
						e=strumento.getDiv_rel_C1().stripTrailingZeros();
						return e;
					}
					if( strumento.getPortata_min_C2().doubleValue()!=0 && carico.doubleValue()>=strumento.getPortata_min_C2().doubleValue() && carico.doubleValue() <=strumento.getPortata_max_C2().doubleValue()) 
					{
						e=strumento.getDiv_rel_C2().stripTrailingZeros();
						return e;
					}
					if(strumento.getPortata_min_C3().doubleValue()!=0 && carico.doubleValue()>strumento.getPortata_min_C3().doubleValue() && carico.doubleValue() <=strumento.getPortata_max_C3().doubleValue()) 
					{
						e=strumento.getDiv_rel_C3().stripTrailingZeros();
						return e;
					}
				}

				if(id_tipo_strumento==3) 
				{
					if(campo==1) 
					{
						e=strumento.getDiv_rel_C1().stripTrailingZeros();
					}
					if(campo==2) 
					{
						e=strumento.getDiv_rel_C2().stripTrailingZeros();
					}
					if(campo==3) 
					{
						e=strumento.getDiv_rel_C3().stripTrailingZeros();
					}
				}


				return e;
			}
			
			public static  String getMemorySpace() 
			{
				long freeMemory=Runtime.getRuntime().freeMemory();
				
				long totalMemory=Runtime.getRuntime().totalMemory();
				
				long maxMemory=Runtime.getRuntime().maxMemory();
				
				String fM="0 Mb";
				
				String tM="0 Mb";
				
				String mM="0 Mb";
						
					if(freeMemory>0) 
					{
						fM=""+freeMemory/1000000+" Mb";
					}	
					
					if(totalMemory>0) 
					{
						tM=""+totalMemory/1000000+" Mb";
					}
					
					if(maxMemory>0) 
					{
						mM=""+maxMemory/1000000+" Mb";
					}
					
				return "[FM "+fM+"] - [TM "+tM+"] - [MM "+mM+"]";	
			}
			
			
			
			public static BigDecimal getArcosec(String value) {
				
				Double val =new Double(value);
				Double arc=Math.asin(val/1000);
				arc=Math.toDegrees(arc);
				Double toRet=arc*3600;
				return new BigDecimal(toRet)/*.setScale(Costanti.RISOLUZIONE_LIVELLA_BOLLA, RoundingMode.HALF_UP)*/;
			}

			public static BigDecimal getArcosecInv(String value) {
				Double val=new Double(value);
				
				val=val/3600;
				val=Math.toRadians(val);
				val=1000*Math.sin(val);
				return new BigDecimal(val)/*.setScale(Costanti.RISOLUZIONE_LIVELLA_BOLLA+2, RoundingMode.HALF_UP)*/;
			}
			
			   public static LocalDate calculatePasqua(int year) {
			        int a = year % 19;
			        int b = year / 100;
			        int c = year % 100;
			        int d = b / 4;
			        int e = b % 4;
			        int f = (b + 8) / 25;
			        int g = (b - f + 1) / 3;
			        int h = (19 * a + b - d - g + 15) % 30;
			        int i = c / 4;
			        int k = c % 4;
			        int L = (32 + 2 * e + 2 * i - h - k) % 7;
			        int m = (a + 11 * h + 22 * L) / 451;
			        int month = (h + L - 7 * m + 114) / 31;
			        int day = ((h + L - 7 * m + 114) % 31) + 1;

			        return LocalDate.of(year, month, day);
			    }
			   
			   
			   public static LocalDate sommaGiorniLavorativi(LocalDate dataIniziale, int giorniLavorativi) {
			        LocalDate dataCorrente = dataIniziale;

			        for (int i = 0; i < giorniLavorativi; ) {
			            // Aggiungi un giorno alla data corrente
			            dataCorrente = dataCorrente.plusDays(1);

			            // Verifica se il giorno è lavorativo (dal lunedì al venerdì e non festivo)
			            if (isGiornoLavorativo(dataCorrente) && !isFestivitaItaliana(dataCorrente)) {
			                i++; // Incrementa solo se il giorno è lavorativo e non festivo
			            }
			        }

			        return dataCorrente;
			    }

			    public static boolean isGiornoLavorativo(LocalDate data) {
			        // Verifica se il giorno è dal lunedì al venerdì
			        DayOfWeek dayOfWeek = data.getDayOfWeek();
			        return dayOfWeek != DayOfWeek.SATURDAY && dayOfWeek != DayOfWeek.SUNDAY;
			    }

			    public static boolean isFestivitaItaliana(LocalDate data) {
			        // Elenco delle festività italiane
			    	ArrayList<LocalDate> festivitaItaliane = new ArrayList<>();
				    festivitaItaliane.add(LocalDate.of(data.getYear(), 1, 1));
				    festivitaItaliane.add(LocalDate.of(data.getYear(), 1, 6));

				 // Pasqua - data variabile (calcolata tramite algoritmo)
				   LocalDate pasqua = calculatePasqua(data.getYear());
				    festivitaItaliane.add(pasqua);
				    
				 // Lunedì di Pasqua
				 festivitaItaliane.add(pasqua.plusDays(1));

				 // Festa della Liberazione - 25 aprile
				 festivitaItaliane.add(LocalDate.of(data.getYear(), 4, 25));

				 // Festa dei Lavoratori - 1 maggio
				 festivitaItaliane.add(LocalDate.of(data.getYear(), 5, 1));

				 // Festa della Repubblica - 2 giugno
				 festivitaItaliane.add(LocalDate.of(data.getYear(), 6, 2));

				 // Ferragosto - 15 agosto
				 festivitaItaliane.add(LocalDate.of(data.getYear(), 8, 15));

				 // Tutti i Santi - 1 novembre
				 festivitaItaliane.add(LocalDate.of(data.getYear(), 11, 1));

				 // Immacolata Concezione - 8 dicembre
				 festivitaItaliane.add(LocalDate.of(data.getYear(), 12, 8));

				 // Natale - 25 dicembre
				 festivitaItaliane.add(LocalDate.of(data.getYear(), 12, 25));

				 // Santo Stefano - 26 dicembre
				 festivitaItaliane.add(LocalDate.of(data.getYear(), 12, 26));

			        // Verifica se il giorno è una festività italiana
			        return festivitaItaliane.contains(data);
			    }
			    
			    
			    public static Date getFirstDayOfMonth(String month, int year) throws ParseException {
			        Calendar calendar = Calendar.getInstance();
			        
			        calendar.setTime(new SimpleDateFormat("MMMM").parse(month));
			        calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMinimum(Calendar.DAY_OF_MONTH));
			        calendar.set(Calendar.YEAR, year);
			        setToBeginningOfDay(calendar);
			        return calendar.getTime();
			    }

			    public static Date getLastDayOfMonth(String month, int year) throws ParseException {
			        Calendar calendar = Calendar.getInstance();
			        
			        calendar.setTime(new SimpleDateFormat("MMMM").parse(month));
			        calendar.set(Calendar.DAY_OF_MONTH, calendar.getActualMaximum(Calendar.DAY_OF_MONTH));
			        calendar.set(Calendar.YEAR, year);
			        setToEndOfDay(calendar);
			        return calendar.getTime();
			    }

			    private static void setToBeginningOfDay(Calendar calendar) {
			        calendar.set(Calendar.HOUR_OF_DAY, 0);
			        calendar.set(Calendar.MINUTE, 0);
			        calendar.set(Calendar.SECOND, 0);
			        calendar.set(Calendar.MILLISECOND, 0);
			    }

			    private static void setToEndOfDay(Calendar calendar) {
			        calendar.set(Calendar.HOUR_OF_DAY, 23);
			        calendar.set(Calendar.MINUTE, 59);
			        calendar.set(Calendar.SECOND, 59);
			        calendar.set(Calendar.MILLISECOND, 999);
			    }
			    
			    
			    public static long giorniLavorativiTraDate(LocalDate startDate, LocalDate endDate) {
			        long giorniLavorativi = 0;
			  		        
			        int segno = 1;
			        if (startDate.isAfter(endDate)) {
			            // Inverti le date se la data di inizio è successiva alla data di fine
			            LocalDate temp = startDate;
			            startDate = endDate;
			            endDate = temp;
			            segno = -1;
			        }
			        LocalDate dataCorrente = startDate;

			        while (!dataCorrente.isAfter(endDate) && !dataCorrente.equals(endDate)) {
			            if (dataCorrente.getDayOfWeek() != DayOfWeek.SATURDAY && dataCorrente.getDayOfWeek() != DayOfWeek.SUNDAY && !isFestivitaItaliana(dataCorrente)) {
			                giorniLavorativi++;
			            }
			            dataCorrente = dataCorrente.plus(1, ChronoUnit.DAYS);
			        }

			        return giorniLavorativi*segno;
			    }
			
			    
			    public static boolean isNumberDouble(String value) {
					boolean flag=true;
					
					try 
					{
					 Double.parseDouble(value);		
					} 
					catch (NumberFormatException e) 
					{
						return false;
					}
					
					
					return flag;
				}
			    
			    
			    
			    public static String capitalize(String str) {
			        if (str == null || str.isEmpty()) {
			            return str;
			        }
			        return str.substring(0, 1).toUpperCase() + str.substring(1);
			    }
}
