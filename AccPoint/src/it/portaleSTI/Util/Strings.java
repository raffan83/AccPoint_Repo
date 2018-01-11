package it.portaleSTI.Util;

public class Strings {
	
	public static final String CARICA_PACCHETTO_ESITO_2 = "Il file risulta ancora aperto in misurazione, finalizzare la chiusura in DASM TAR";
			
	public static String CARICA_PACCHETTO_ESITO_1(int misurati, int nuovi) {
		return "Sono stati salvati "+misurati+" \n"+"Nuovi Strumenti: "+nuovi;
	}

}
