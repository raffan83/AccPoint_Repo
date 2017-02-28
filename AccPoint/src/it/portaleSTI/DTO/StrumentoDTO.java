package it.portaleSTI.DTO;

import java.sql.Date;

public class StrumentoDTO {

			 private int __id; 
			 private String denominazione;
			 private String matricola ; 
			 private String codice_interno ; 
			 private String risoluzione ; 
			 private String  campo_misura ; 
			 private String reparto ; 
			 private String utilizzatore ; 
			 private String costruttore ; 
			 private String modello ; 
			 private String note ;
			 private Date data_emissione; 
			 private Integer  id__sede_ ; 
			 private Integer id__template_rapporto_ ; 
			 private Integer id__stato_strumento_ ; 
			 private Integer id__tipo_strumento_ ;
			 private String ref_stato_strumento;
			 private String ref_tipo_strumento;
			 private Integer id__luogo_verifica_ ; 
			 private Integer id__classificazione_ ; 
			 private Integer interpolazione ;
			 private String filename;
			 private ScadenzaDTO scadenzaDto;
			 
	
		public StrumentoDTO(int __id, String denominazione,
					String matricola, String codice_interno,
					String risoluzione, String campo_misura, String reparto,
					String utilizzatore, String costruttore, String modello,
					String note, Date data_emissione, Integer id__sede_,
					Integer id__template_rapporto_,
					Integer id__stato_strumento_, Integer id__tipo_strumento_,
					Integer id__luogo_verifica_, Integer id__classificazione_,
					Integer interpolazione,String filename) {
				super();
				this.__id = __id;
				this.denominazione = denominazione;
				this.matricola = matricola;
				this.codice_interno = codice_interno;
				this.risoluzione = risoluzione;
				this.campo_misura = campo_misura;
				this.reparto = reparto;
				this.utilizzatore = utilizzatore;
				this.costruttore = costruttore;
				this.modello = modello;
				this.note = note;
				this.data_emissione = data_emissione;
				this.id__sede_ = id__sede_;
				this.id__template_rapporto_ = id__template_rapporto_;
				this.id__stato_strumento_ = id__stato_strumento_;
				this.id__tipo_strumento_ = id__tipo_strumento_;
				this.id__luogo_verifica_ = id__luogo_verifica_;
				this.id__classificazione_ = id__classificazione_;
				this.interpolazione = interpolazione;
			}

		public String getFilename() {
			return filename;
		}

		public void setFilename(String filename) {
			this.filename = filename;
		}

		public StrumentoDTO(){}

		public int get__id() {
			return __id;
		}

		public void set__id(int __id) {
			this.__id = __id;
		}

		public String getDenominazione() {
			return denominazione;
		}

		public void setDenominazione(String denominazione) {
			this.denominazione = denominazione;
		}

		public String getMatricola() {
			return matricola;
		}

		public void setMatricola(String matricola) {
			this.matricola = matricola;
		}

		public String getCodice_interno() {
			return codice_interno;
		}

		public void setCodice_interno(String codice_interno) {
			this.codice_interno = codice_interno;
		}

		public String getRisoluzione() {
			return risoluzione;
		}

		public void setRisoluzione(String risoluzione) {
			this.risoluzione = risoluzione;
		}

		public String getCampo_misura() {
			return campo_misura;
		}

		public void setCampo_misura(String campo_misura) {
			this.campo_misura = campo_misura;
		}

		public String getReparto() {
			return reparto;
		}

		public void setReparto(String reparto) {
			this.reparto = reparto;
		}

		public String getUtilizzatore() {
			return utilizzatore;
		}

		public void setUtilizzatore(String utilizzatore) {
			this.utilizzatore = utilizzatore;
		}

		public String getCostruttore() {
			return costruttore;
		}

		public void setCostruttore(String costruttore) {
			this.costruttore = costruttore;
		}

		public String getModello() {
			return modello;
		}

		public void setModello(String modello) {
			this.modello = modello;
		}

		public String getNote() {
			return note;
		}

		public void setNote(String note) {
			this.note = note;
		}

		public Date getData_emissione() {
			return data_emissione;
		}

		public void setData_emissione(Date data_emissione) {
			this.data_emissione = data_emissione;
		}

		public Integer getId__sede_() {
			return id__sede_;
		}

		public void setId__sede_(Integer id__sede_) {
			this.id__sede_ = id__sede_;
		}

		public Integer getId__template_rapporto_() {
			return id__template_rapporto_;
		}

		public void setId__template_rapporto_(Integer id__template_rapporto_) {
			this.id__template_rapporto_ = id__template_rapporto_;
		}

		public Integer getId__stato_strumento_() {
			return id__stato_strumento_;
		}

		public void setId__stato_strumento_(Integer id__stato_strumento_) {
			this.id__stato_strumento_ = id__stato_strumento_;
		}

		public Integer getId__tipo_strumento_() {
			return id__tipo_strumento_;
		}

		public void setId__tipo_strumento_(Integer id__tipo_strumento_) {
			this.id__tipo_strumento_ = id__tipo_strumento_;
		}

		public String getRef_tipo_strumento() {
			return ref_tipo_strumento;
		}

		public void setRef_tipo_strumento(String ref_tipo_strumento) {
			this.ref_tipo_strumento = ref_tipo_strumento;
		}

		public Integer getId__luogo_verifica_() {
			return id__luogo_verifica_;
		}

		public void setId__luogo_verifica_(Integer id__luogo_verifica_) {
			this.id__luogo_verifica_ = id__luogo_verifica_;
		}

		public Integer getId__classificazione_() {
			return id__classificazione_;
		}

		public void setId__classificazione_(Integer id__classificazione_) {
			this.id__classificazione_ = id__classificazione_;
		}

		public Integer getInterpolazione() {
			return interpolazione;
		}

		public void setInterpolazione(Integer interpolazione) {
			this.interpolazione = interpolazione;
		};
		
		public ScadenzaDTO getScadenzaDto() {
			return scadenzaDto;
		}

		public void setScadenzaDto(ScadenzaDTO scadenzaDto) {
			this.scadenzaDto = scadenzaDto;
		}
		 public String getRef_stato_strumento() {
				return ref_stato_strumento;
			}

			public void setRef_stato_strumento(String ref_stato_strumento) {
				this.ref_stato_strumento = ref_stato_strumento;
			}

}