package it.portaleSTI.DTO;

import java.sql.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;


public class StrumentoDTO {

			 private int __id = 0; 
			 private String denominazione = "";
			 private String matricola = ""; 
			 private String codice_interno = "" ; 
			 private String risoluzione = "" ; 
			 private String  campo_misura = "" ; 
			 private String reparto = "" ; 
			 private String utilizzatore = "" ; 
			 private String costruttore = "" ; 
			 private String modello = "" ; 
			 private String note = "" ;
			 private Integer  id__sede_  = 0;
			 private Integer  id_cliente = 0 ; 
			 private Integer id__template_rapporto = 0 ; 
			 private StatoStrumentoDTO stato_strumento ; 
			 private TipoStrumentoDTO tipo_strumento;
			 private Integer interpolazione = 0 ;
			 private String filename = "";
			 private ClassificazioneDTO classificazione;
			 private CompanyDTO company;
			 private LuogoVerificaDTO luogo;
			 private UtenteDTO userCreation;
			 private String creato = "";
			 private String procedura;
			 private String importato = "";
			 private Date dataModifica;
			 private UtenteDTO userModifica;
			 private MisuraDTO ultimaMisura;
			 private Date dataProssimaVerifica;
			 private Date dataUltimaVerifica;
			 private TipoRapportoDTO TipoRapporto;
			
				 
			 
			 //Parte recuperata da File SQLLite
			 private String strumentoModificato = "";
			 private int idTipoRapporto = 0;
			 private int idClassificazione = 0;
			 private int frequenza = 0;
			 private String procedureString = "";
			 
			 private String altre_matricole;
			 private String indice_prestazione;
			 
			 //------
			 
			 
			 
//			 private Set<ScadenzaDTO> listaScadenzeDTO = new HashSet<ScadenzaDTO>(0);
			
			 private Set<DocumentiEsterniStrumentoDTO> listaDocumentiEsterni = new HashSet<DocumentiEsterniStrumentoDTO>(0);
			 private Set<StrumentoNoteDTO> listaNoteStrumento = new HashSet<StrumentoNoteDTO>(0);
			 
			 
			 public StrumentoDTO() {
					super();
				}

			public String getCreato() {
				return creato;
			}


			public void setCreato(String creato) {
				this.creato = creato;
			}


			public String getImportato() {
				return importato;
			}


			public void setImportato(String importato) {
				this.importato = importato;
			}


			public LuogoVerificaDTO getLuogo() {
				return luogo;
			}


			public void setLuogo(LuogoVerificaDTO luogo) {
				this.luogo = luogo;
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

			public Integer getInterpolazione() {
				return interpolazione;
			}


			public void setInterpolazione(Integer interpolazione) {
				this.interpolazione = interpolazione;
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

		public String getProcedura() {
			return procedura;
		}

		public void setProcedura(String procedura) {
			this.procedura = procedura;
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

	

		public Integer getId__sede_() {
			return id__sede_;
		}

		public void setId__sede_(Integer id__sede_) {
			this.id__sede_ = id__sede_;
		}





		public UtenteDTO getUserCreation() {
			return userCreation;
		}


		public void setUserCreation(UtenteDTO userCreation) {
			this.userCreation = userCreation;
		}


		public Date getDataModifica() {
			return dataModifica;
		}


		public void setDataModifica(Date dataModifica) {
			this.dataModifica = dataModifica;
		}


		public UtenteDTO getUserModifica() {
			return userModifica;
		}


		public void setUserModifica(UtenteDTO userModifica) {
			this.userModifica = userModifica;
		}


		public String getStrumentoModificato() {
			return strumentoModificato;
		}


		public void setStrumentoModificato(String strumentoModificato) {
			this.strumentoModificato = strumentoModificato;
		}


		public int getIdTipoRapporto() {
			return idTipoRapporto;
		}


		public void setIdTipoRapporto(int idTipoRapporto) {
			this.idTipoRapporto = idTipoRapporto;
		}


		public int getIdClassificazione() {
			return idClassificazione;
		}


		public void setIdClassificazione(int idClassificazione) {
			this.idClassificazione = idClassificazione;
		}


		public int getFrequenza() {
			return frequenza;
		}


		public void setFrequenza(int frequenza) {
			this.frequenza = frequenza;
		}


		public String getProcedureString() {
			return procedureString;
		}


		public void setProcedureString(String procedureString) {
			this.procedureString = procedureString;
		}


		public Set<DocumentiEsterniStrumentoDTO> getListaDocumentiEsterni() {
			return listaDocumentiEsterni;
		}


		public void setListaDocumentiEsterni(Set<DocumentiEsterniStrumentoDTO> listaDocumentiEsterni) {
			this.listaDocumentiEsterni = listaDocumentiEsterni;
		}


		public MisuraDTO getUltimaMisura() {
			return ultimaMisura;
		}


		public void setUltimaMisura(MisuraDTO ultimaMisura) {
			this.ultimaMisura = ultimaMisura;
		}




		 public Date getDataProssimaVerifica() {
				return dataProssimaVerifica;
			}

			public void setDataProssimaVerifica(Date dataProssimaVerifica) {
				this.dataProssimaVerifica = dataProssimaVerifica;
			}

			public Date getDataUltimaVerifica() {
				return dataUltimaVerifica;
			}

			public void setDataUltimaVerifica(Date dataUltimaVerifica) {
				this.dataUltimaVerifica = dataUltimaVerifica;
			}

			
			public TipoRapportoDTO getTipoRapporto() {
				return TipoRapporto;
			}

			public void setTipoRapporto(TipoRapportoDTO tipoRapporto) {
				TipoRapporto = tipoRapporto;
			}

			public String getAltre_matricole() {
				return altre_matricole;
			}

			public void setAltre_matricole(String altre_matricole) {
				this.altre_matricole = altre_matricole;
			}

			public Set<StrumentoNoteDTO> getListaNoteStrumento() {
				return listaNoteStrumento;
			}

			public void setListaNoteStrumento(Set<StrumentoNoteDTO> listaNoteStrumento) {
				this.listaNoteStrumento = listaNoteStrumento;
			}

			public String getIndice_prestazione() {
				return indice_prestazione;
			}

			public void setIndice_prestazione(String indice_prestazione) {
				this.indice_prestazione = indice_prestazione;
			}

			
}