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
import java.net.Authenticator;
import java.nio.charset.Charset;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.sql.Types;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.crypto.Cipher;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.SecretKeySpec;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
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

import com.google.gson.Gson;
import com.sun.mail.smtp.SMTPMessage;
import com.sun.mail.smtp.SMTPTransport;

import it.portaleSTI.DTO.ClienteDTO;
import it.portaleSTI.DTO.MagItemPaccoDTO;
import it.portaleSTI.DTO.MagPaccoDTO;
import it.portaleSTI.DTO.RilPuntoQuotaDTO;
import it.portaleSTI.DTO.RilQuotaDTO;
import it.portaleSTI.DTO.RilSimboloDTO;
import it.portaleSTI.DTO.ScadenzaDTO;
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

		
		if (request.getSession().getAttribute("userObj")==null ) {
			
		RequestDispatcher dispatcher = servletContext.getRequestDispatcher("/site/sessionDown.jsp");
     	dispatcher.forward(request,response);
     	
     	return true;
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

		
		    	// Sender's email ID needs to be mentioned
			      String from = "system@ncsnetwork.it";

			      // Assuming you are sending email from localhost
			      String host = "smtps.aruba.it";
			      String password = "iXBh89d3ka";
			      String port = "465";
			      
			      // Get system properties
			      Properties properties = System.getProperties();

			      // Setup mail server
			      properties.setProperty("mail.smtp.host", host);
			      properties.setProperty("mail.smtp.port", port);
			      properties.setProperty("mail.smtp.auth", "true");
			      properties.setProperty("mail.transport.protocol", "smtps");
			      properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			      
			      // Get the default Session object.
			      javax.mail.Session session = javax.mail.Session.getDefaultInstance(properties);
				
				  MimeMessage message = new MimeMessage(session);

		         // Set From: header field of the header.
		         message.setFrom(new InternetAddress(from));

		         // Set To: header field of the header.
		         message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

		         // Set Subject: header field
		         message.setSubject(subject);
		         
		         message.setText(msgHtml, "utf-8", "html");

		         // Send message
		     	 SMTPTransport t = (SMTPTransport)session.getTransport("smtps");
	  		    
		        try {
	  			    t.connect(host, from, password);
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
				 if(item.getItem().getStato().getId()==2) {
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
				 if(item.getItem().getStato().getId()==2) {
					 lavorati++;
				 }
				 
			 
			 
		 }
		 double result = 0;
		 if(totali!=0) {
			 result = lavorati/totali;
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
			
			yearList.add(2015);
			yearList.add(2016);
			yearList.add(2017);
			yearList.add(2018);
			yearList.add(2019);
			
			return yearList;
		}
		
		public static Double[] calcolaTolleranze(Double nominale, RilSimboloDTO ril_simbolo, String classe_tolleranza) {
			Double[] tolleranza =  {0.0,0.0};
			int simbolo = 0;
			if(ril_simbolo!=null) {
				simbolo = ril_simbolo.getId();
			}
				
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
			
			if(pezzo!=null && !pezzo.equals("") && !pezzo.equals("KO")&& !pezzo.equals("OK")) {
				pz = new Double(pezzo);
			}else {
				return null;
			}
			
			if(pz>nominale+Math.abs(toll_pos) || pz<nominale-Math.abs(toll_neg)) {
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
			if(delta!=null && !delta.equals("")) {
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
}
