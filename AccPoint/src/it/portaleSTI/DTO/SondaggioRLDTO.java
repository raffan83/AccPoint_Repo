package it.portaleSTI.DTO;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

public class SondaggioRLDTO {

	private String annualita;
	private String denominazione_ente;
	private String cf;
	private String tipo_acc;
	private String titolo;
	private String fonte_fin;
	private String fonte_fin_txt_1;
	private String fonte_fin_txt_2;
	private String provincia;
	private String fonte_fin_txt_3;
	private String fonte_fin_txt_4;
	private String durata;
	private String titolo_ril;
	private String tipologie_corso;
	private String eta;
	private String genere;
	private String cittadinanza;
	private String occupazione;
	private String titolo_studio;
	private String motivo_freq;
	private String dom_1;
	private String dom_2_1;
	private String dom_2_2;
	private String dom_3_1;
	private String dom_3_2;
	private String dom_3_3;
	private String dom_3_4;
	private String dom_4;
	private String dom_4_1;
	private String dom_4_2;
	private String dom_4_3;
	private String dom_5;
	private String dom_5_1;
	private String dom_5_2;
	private String dom_5_3;
	private String dom_5_4;
	private String dom_5_5;
	private String dom_6_1;
	private String dom_6_2;
	private String dom_6_3;
	private String dom_6;
	private String dom_7;
	private String dom_7_1;
	private String dom_7_2;
	private String dom_7_3;
	private String dom_7_1_1;
	private String dom_7_2_1;
	private String dom_8;
	private String dom_8_1;
	private String dom_9;
	private int count;
	

	public int getCount() { return count;}
	public void setCount(int count) {this.count = count;}
	
	public String getAnnualita() { return annualita; }
	public void setAnnualita(String annualita) { this.annualita = annualita; }

	public String getDenominazione_ente() { return denominazione_ente; }
	public void setDenominazione_ente(String denominazione_ente) { this.denominazione_ente = denominazione_ente; }

	public String getCf() { return cf; }
	public void setCf(String cf) { this.cf = cf; }

	public String getTipo_acc() { return tipo_acc; }
	public void setTipo_acc(String tipo_acc) { this.tipo_acc = tipo_acc; }

	public String getTitolo() { return titolo; }
	public void setTitolo(String titolo) { this.titolo = titolo; }

	public String getFonte_fin() { return fonte_fin; }
	public void setFonte_fin(String fonte_fin) { this.fonte_fin = fonte_fin; }

	public String getFonte_fin_txt_1() { return fonte_fin_txt_1; }
	public void setFonte_fin_txt_1(String fonte_fin_txt_1) { this.fonte_fin_txt_1 = fonte_fin_txt_1; }

	public String getFonte_fin_txt_2() { return fonte_fin_txt_2; }
	public void setFonte_fin_txt_2(String fonte_fin_txt_2) { this.fonte_fin_txt_2 = fonte_fin_txt_2; }

	public String getProvincia() { return provincia; }
	public void setProvincia(String provincia) { this.provincia = provincia; }

	public String getFonte_fin_txt_3() { return fonte_fin_txt_3; }
	public void setFonte_fin_txt_3(String fonte_fin_txt_3) { this.fonte_fin_txt_3 = fonte_fin_txt_3; }

	public String getFonte_fin_txt_4() { return fonte_fin_txt_4; }
	public void setFonte_fin_txt_4(String fonte_fin_txt_4) { this.fonte_fin_txt_4 = fonte_fin_txt_4; }

	public String getDurata() { return durata; }
	public void setDurata(String durata) { this.durata = durata; }

	public String getTitolo_ril() { return titolo_ril; }
	public void setTitolo_ril(String titolo_ril) { this.titolo_ril = titolo_ril; }

	public String getTipologie_corso() { return tipologie_corso; }
	public void setTipologie_corso(String tipologie_corso) { this.tipologie_corso = tipologie_corso; }

	public String getEta() { return eta; }
	public void setEta(String eta) { this.eta = eta; }

	public String getGenere() { return genere; }
	public void setGenere(String genere) { this.genere = genere; }

	public String getCittadinanza() { return cittadinanza; }
	public void setCittadinanza(String cittadinanza) { this.cittadinanza = cittadinanza; }

	public String getOccupazione() { return occupazione; }
	public void setOccupazione(String occupazione) { this.occupazione = occupazione; }

	public String getTitolo_studio() { return titolo_studio; }
	public void setTitolo_studio(String titolo_studio) { this.titolo_studio = titolo_studio; }

	public String getMotivo_freq() { return motivo_freq; }
	public void setMotivo_freq(String motivo_freq) { this.motivo_freq = motivo_freq; }

	public String getDom_1() { return dom_1; }
	public void setDom_1(String dom_1) { this.dom_1 = dom_1; }

	public String getDom_2_1() { return dom_2_1; }
	public void setDom_2_1(String dom_2_1) { this.dom_2_1 = dom_2_1; }

	public String getDom_2_2() { return dom_2_2; }
	public void setDom_2_2(String dom_2_2) { this.dom_2_2 = dom_2_2; }

	public String getDom_3_1() { return dom_3_1; }
	public void setDom_3_1(String dom_3_1) { this.dom_3_1 = dom_3_1; }

	public String getDom_3_2() { return dom_3_2; }
	public void setDom_3_2(String dom_3_2) { this.dom_3_2 = dom_3_2; }

	public String getDom_3_3() { return dom_3_3; }
	public void setDom_3_3(String dom_3_3) { this.dom_3_3 = dom_3_3; }

	public String getDom_3_4() { return dom_3_4; }
	public void setDom_3_4(String dom_3_4) { this.dom_3_4 = dom_3_4; }

	public String getDom_4() { return dom_4; }
	public void setDom_4(String dom_4) { this.dom_4 = dom_4; }

	public String getDom_4_1() { return dom_4_1; }
	public void setDom_4_1(String dom_4_1) { this.dom_4_1 = dom_4_1; }

	public String getDom_4_2() { return dom_4_2; }
	public void setDom_4_2(String dom_4_2) { this.dom_4_2 = dom_4_2; }

	public String getDom_4_3() { return dom_4_3; }
	public void setDom_4_3(String dom_4_3) { this.dom_4_3 = dom_4_3; }

	public String getDom_5() { return dom_5; }
	public void setDom_5(String dom_5) { this.dom_5 = dom_5; }

	public String getDom_5_1() { return dom_5_1; }
	public void setDom_5_1(String dom_5_1) { this.dom_5_1 = dom_5_1; }

	public String getDom_5_2() { return dom_5_2; }
	public void setDom_5_2(String dom_5_2) { this.dom_5_2 = dom_5_2; }

	public String getDom_5_3() { return dom_5_3; }
	public void setDom_5_3(String dom_5_3) { this.dom_5_3 = dom_5_3; }

	public String getDom_5_4() { return dom_5_4; }
	public void setDom_5_4(String dom_5_4) { this.dom_5_4 = dom_5_4; }

	public String getDom_5_5() { return dom_5_5; }
	public void setDom_5_5(String dom_5_5) { this.dom_5_5 = dom_5_5; }

	public String getDom_6_1() { return dom_6_1; }
	public void setDom_6_1(String dom_6_1) { this.dom_6_1 = dom_6_1; }

	public String getDom_6_2() { return dom_6_2; }
	public void setDom_6_2(String dom_6_2) { this.dom_6_2 = dom_6_2; }

	public String getDom_6_3() { return dom_6_3; }
	public void setDom_6_3(String dom_6_3) { this.dom_6_3 = dom_6_3; }

	public String getDom_6() { return dom_6; }
	public void setDom_6(String dom_6) { this.dom_6 = dom_6; }

	public String getDom_7() { return dom_7; }
	public void setDom_7(String dom_7) { this.dom_7 = dom_7; }

	public String getDom_7_1() { return dom_7_1; }
	public void setDom_7_1(String dom_7_1) { this.dom_7_1 = dom_7_1; }

	public String getDom_7_2() { return dom_7_2; }
	public void setDom_7_2(String dom_7_2) { this.dom_7_2 = dom_7_2; }

	public String getDom_7_3() { return dom_7_3; }
	public void setDom_7_3(String dom_7_3) { this.dom_7_3 = dom_7_3; }

	public String getDom_7_1_1() { return dom_7_1_1; }
	public void setDom_7_1_1(String dom_7_1_1) { this.dom_7_1_1 = dom_7_1_1; }
	
	public String getDom_7_2_1() { return dom_7_2_1; }
	public void setDom_7_2_1(String dom_7_2_1) { this.dom_7_2_1 = dom_7_2_1; }

	public String getDom_8() { return dom_8; }
	public void setDom_8(String dom_8) { this.dom_8 = dom_8; }

	public String getDom_8_1() { return dom_8_1; }
	public void setDom_8_1(String dom_8_1) { this.dom_8_1 = dom_8_1; }

	public String getDom_9() { return dom_9; }
	public void setDom_9(String dom_9) { this.dom_9 = dom_9; }

	
	public void setByIndex(int i, String value) {
	    switch (i) {
	        case 0: annualita = value; break;
	        case 1: denominazione_ente = value; break;
	        case 2: cf = value; break;
	        case 3: tipo_acc = value; break;
	        case 4: titolo = value; break;
	        case 5: fonte_fin = value; break;
	        case 6: fonte_fin_txt_1 = value; break;
	        case 7: fonte_fin_txt_2 = value; break;
	        case 8: provincia = value; break;
	        case 9: fonte_fin_txt_3 = value; break;
	        case 10: fonte_fin_txt_4 = value; break;
	        case 11: durata = value; break;
	        case 12: titolo_ril = value; break;
	        case 13: tipologie_corso = value; break;
	        case 14: eta = value; break;
	        case 15: genere = value; break;
	        case 16: cittadinanza = value; break;
	        case 17: occupazione = value; break;
	        case 18: titolo_studio = value; break;
	        case 19: motivo_freq = value;

	        case 20: dom_1 = value; break;
	        case 21: dom_2_1 = value; break;
	        case 22: dom_2_2 = value; break;
	        case 23: dom_3_1 = value; break;
	        case 24: dom_3_2 = value; break;
	        case 25: dom_3_3 = value; break;
	        case 26: dom_3_4 = value; break;
	        case 27: dom_4 = value; break;
	        case 28: dom_4_1 = value; break;
	        case 29: dom_4_2 = value; break;
	        case 30: dom_4_3 = value; break;
	        case 31: dom_5 = value; break;
	        case 32: dom_5_1 = value; break;
	        case 33: dom_5_2 = value; break;
	        case 34: dom_5_3 = value; break;
	        case 35: dom_5_4 = value; break;
	        case 36: dom_5_5 = value; break;
	      
	        case 37: dom_6_1 = value; break;
	        case 38: dom_6_2 = value; break;
	        case 39: dom_6_3 = value; break;
	        case 40: dom_6 = value; break;
	        case 41: dom_7 = value; break;
	        case 42: dom_7_1 = value; break;
	        case 43: dom_7_2 = value; break;
	        case 44: dom_7_3 = value; break;
	        case 45: dom_7_1_1 = value; break;
	        case 46: dom_8 = value; break;
	        case 47: dom_8_1 = value; break;
	        case 48: dom_9 = value; break;
	        case 49: dom_7_2_1 = value; break; //è ultima
	       

	        default:
	            throw new IllegalArgumentException("Indice non valido: " + i);
	    }
	}
	    
	    public String getByIndex(int j) {
	        switch (j) {
	            case 0: return annualita;
	            case 1: return denominazione_ente;
	            case 2: return cf;
	            case 3: return tipo_acc;
	            case 4: return titolo;
	            case 5: return fonte_fin;
	            case 6: return fonte_fin_txt_1;
	            case 7: return fonte_fin_txt_2;
	            case 8: return provincia;
	            case 9: return fonte_fin_txt_3;
	            case 10: return fonte_fin_txt_4;
	            case 11: return durata;
	            case 12: return titolo_ril;
	            case 13: return tipologie_corso;
	            case 14: return eta;
	            case 15: return genere;
	            case 16: return cittadinanza;
	            case 17: return occupazione;
	            case 18: return titolo_studio;
	            case 19: return motivo_freq;
	            case 20: return dom_1;
	            case 21: return dom_2_1;
	            case 22: return dom_2_2;
	            case 23: return dom_3_1;
	            case 24: return dom_3_2;
	            case 25: return dom_3_3;
	            case 26: return dom_3_4;
	            case 27: return dom_4;
	            case 28: return dom_4_1;
	            case 29: return dom_4_2;
	            case 30: return dom_4_3;
	            case 31: return dom_5;
	            case 32: return dom_5_1;
	            case 33: return dom_5_2;
	            case 34: return dom_5_3;
	            case 35: return dom_5_4;
	            case 36: return dom_5_5;
	         
	            case 37: return dom_6_1;
	            case 38: return dom_6_2;
	            case 39: return dom_6_3;
	            case 40: return dom_6;
	            case 41: return dom_7;
	            case 42: return dom_7_1;
	            case 43: return dom_7_2;
	            case 44: return dom_7_3;
	            case 45: return dom_7_1_1;
	            case 46: return dom_7_2_1; //è ultima
	            case 47: return dom_8;
	            case 48: return dom_8_1;
	            case 49: return dom_9;
	         
	            default:
	                throw new IllegalArgumentException("Indice non valido: " + j);
	        }
	    }
	
}
