package it.arubapec.arubasignservice;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.net.URI;
import java.rmi.RemoteException;

import javax.activation.DataHandler;

import org.apache.axis2.AxisFault;
import org.apache.commons.io.FileUtils;

import com.google.gson.JsonObject;

import it.arubapec.arubasignservice.ArubaSignServiceServiceStub.Auth;
import it.arubapec.arubasignservice.ArubaSignServiceServiceStub.Pkcs7SignV2;
import it.arubapec.arubasignservice.ArubaSignServiceServiceStub.Pkcs7SignV2E;
import it.arubapec.arubasignservice.ArubaSignServiceServiceStub.Pkcs7SignV2ResponseE;
import it.arubapec.arubasignservice.ArubaSignServiceServiceStub.SignRequestV2;
import it.arubapec.arubasignservice.ArubaSignServiceServiceStub.TypeTransport;
import it.portaleSTI.DAO.GestioneCertificatoDAO;
import it.portaleSTI.DTO.CertificatoDTO;
import it.portaleSTI.Util.Costanti;
import it.portaleSTI.bo.GestioneCertificatoBO;

public class ArubaSignService {

	public static JsonObject sign(String utente, CertificatoDTO certificato) throws TypeOfTransportNotImplementedException, IOException {
	
		 
		ArubaSignServiceServiceStub stub = new ArubaSignServiceServiceStub();
		
		
		Pkcs7SignV2E request= new Pkcs7SignV2E();
		Pkcs7SignV2 pkcs = new Pkcs7SignV2();
		
		SignRequestV2  sign = new SignRequestV2();
		
		sign.setCertID("AS0");
		
		Auth identity = new Auth();
		identity.setDelegated_domain("faSTI");
		identity.setTypeOtpAuth("faSTI");
		identity.setOtpPwd("dsign");
		identity.setTypeOtpAuth("faSTI");
		
		identity.setUser(utente);
		
		identity.setDelegated_user("admin.firma");
		identity.setDelegated_password("uBFqc8YYslTG");
		
		sign.setIdentity(identity);
		//${certificato.nomeCertificato}&pack=${certificato.misura.intervento.nomePack}
		
		String nomeCert = Costanti.PATH_FOLDER+certificato.getMisura().getIntervento().getNomePack()+"/"+certificato.getNomeCertificato();
		File f = new File(nomeCert);

 		URI uri = f.toURI();
		
		javax.activation.DataHandler dh = new DataHandler(uri.toURL());
		
		sign.setBinaryinput(dh);
	//	sign.setSrcName("C:\\Users\\raffaele.fantini\\Desktop\\FirmDigitale\\Test\\test_firm.pdf");
		
	//	sign.setDstName("C:\\Users\\raffaele.fantini\\Desktop\\FirmDigitale\\Test\\TestFirm_firmato.pdf.p7m");
		
		
		sign.setTransport(TypeTransport.BYNARYNET);
		
		pkcs.setSignRequestV2(sign);
		
		request.setPkcs7SignV2(pkcs);
		
		Pkcs7SignV2ResponseE response= stub.pkcs7SignV2(request);
		JsonObject jsonObj = new JsonObject();
		

	
//	System.out.println("Status :"+response.getPkcs7SignV2Response().get_return().getStatus());
//	System.out.println("Status :"+response.getPkcs7SignV2Response().get_return().getDescription());
//	System.out.println("Status :"+response.getPkcs7SignV2Response().get_return().getReturn_code());
	
		if( response.getPkcs7SignV2Response().get_return().getStatus().equals("KO")) {
			jsonObj.addProperty("success", false);
			jsonObj.addProperty("messaggio", response.getPkcs7SignV2Response().get_return().getDescription());
		}else {
			
			jsonObj.addProperty("success", true);
			
			DataHandler fileReturn=response.getPkcs7SignV2Response().get_return().getBinaryoutput();
			File targetFile = new File(nomeCert+".p7m");
			FileUtils.copyInputStreamToFile(fileReturn.getInputStream(), targetFile);

			jsonObj.addProperty("messaggio", "Certificato firmato");
		}
		return jsonObj;
		 
	}



}
