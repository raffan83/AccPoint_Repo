package it.portaleSTI.DTO;

import java.sql.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;


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
			 private Integer  id_cliente ; 
			 private Integer id__template_rapporto ; 
			 private StatoStrumentoDTO stato_strumento ; 
			 private TipoStrumentoDTO tipo_strumento;
			 private Integer id__luogo_verifica_ ; 
			 private Integer interpolazione ;
			 private String filename;
			 private ClassificazioneDTO classificazione;
			 private CompanyDTO company;
			 private Set<ScadenzaDTO> listaScadenzeDTO = new HashSet<ScadenzaDTO>(0);
			 
			 
			 
		
				public StrumentoDTO() {
					super();
				}
			

			public Integer getId__template_rapporto() {
				return id__template_rapporto;
			}


			public void setId__template_rapporto(Integer id__template_rapporto) {
				this.id__template_rapporto = id__template_rapporto;
			}


			public StatoStrumentoDTO getStato_strumento() {
				return stato_strumento;
			}


			public void setStato_strumento(StatoStrumentoDTO stato_strumento) {
				this.stato_strumento = stato_strumento;
			}


			public TipoStrumentoDTO getTipo_strumento() {
				return tipo_strumento;
			}


			public void setTipo_strumento(TipoStrumentoDTO tipo_strumento) {
				this.tipo_strumento = tipo_strumento;
			}


			public Integer getId__luogo_verifica_() {
				return id__luogo_verifica_;
			}


			public void setId__luogo_verifica_(Integer id__luogo_verifica_) {
				this.id__luogo_verifica_ = id__luogo_verifica_;
			}


			public Integer getInterpolazione() {
				return interpolazione;
			}


			public void setInterpolazione(Integer interpolazione) {
				this.interpolazione = interpolazione;
			}


			public Set<ScadenzaDTO> getListaScadenzeDTO() {
				return listaScadenzeDTO;
			}


			public void setListaScadenzeDTO(Set<ScadenzaDTO> listaScadenzeDTO) {
				this.listaScadenzeDTO = listaScadenzeDTO;
			}




		public Integer getId_cliente() {
				return id_cliente;
			}


			public void setId_cliente(Integer id_cliente) {
				this.id_cliente = id_cliente;
			}


		public CompanyDTO getCompany() {
				return company;
			}

			public void setCompany(CompanyDTO company) {
				this.company = company;
			}

		public ClassificazioneDTO getClassificazione() {
				return classificazione;
			}

			public void setClassificazione(ClassificazioneDTO classificazione) {
				this.classificazione = classificazione;
			}

	
		public String getFilename() {
			return filename;
		}

		public void setFilename(String filename) {
			this.filename = filename;
		}


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



		public ScadenzaDTO getScadenzaDTO()
		{
			ScadenzaDTO scadenza=null;
			ScadenzaDTO nuovaScadenza=null; 
			Iterator<ScadenzaDTO> iterator = listaScadenzeDTO.iterator();
			 
			 
			 while (iterator.hasNext())
			 {
				 if(scadenza==null)
				 {
					 scadenza=iterator.next();
					
					 
				 }else
				 {
					 nuovaScadenza=iterator.next();
					 if(nuovaScadenza.getId()>scadenza.getId())
					 {
						 scadenza=nuovaScadenza;
					 }
					 
				 }
			 }
			 return scadenza;
		}

}