package it.portaleSTI.DTO;

public class SedeDTO {

	private int  __id = 0;
	private String  indirizzo  = "";
	private String  comune = "";
	private String  cap = "";
	private Integer  id__cliente_ = 0;
	private Integer  id__provincia_ = 0 ;
	private String siglaProvincia;
	private String descrizione = "";
	private String n_REA="";
	private String id_encrypted;

	public String getSiglaProvincia() {
		return siglaProvincia;
	}

	public void setSiglaProvincia(String siglaProvincia) {
		this.siglaProvincia = siglaProvincia;
	}

	public SedeDTO(){}

	public SedeDTO(int __id, String indirizzo, String comune, String cap,
			Integer id__cliente_, Integer id__provincia_, String _desc,String _siglaProvincia,String _nREA) {
		super();
		this.__id = __id;
		this.indirizzo = indirizzo;
		this.comune = comune;
		this.cap = cap;
		this.id__cliente_ = id__cliente_;
		this.id__provincia_ = id__provincia_;
		this.descrizione=_desc;
		this.siglaProvincia=_siglaProvincia;
		this.n_REA=_nREA;
	
	}

	public int get__id() {
		return __id;
	}

	public void set__id(int __id) {
		this.__id = __id;
	}

	public String getIndirizzo() {
		return indirizzo;
	}

	public void setIndirizzo(String indirizzo) {
		this.indirizzo = indirizzo;
	}

	public String getComune() {
		return comune;
	}

	public void setComune(String comune) {
		this.comune = comune;
	}

	public String getCap() {
		return cap;
	}

	public void setCap(String cap) {
		this.cap = cap;
	}

	public Integer getId__cliente_() {
		return id__cliente_;
	}

	public void setId__cliente_(Integer id__cliente_) {
		this.id__cliente_ = id__cliente_;
	}

	public Integer getId__provincia_() {
		return id__provincia_;
	}

	public void setId__provincia_(Integer id__provincia_) {
		this.id__provincia_ = id__provincia_;
	}

	public String getDescrizione() {
		return descrizione;
	}

	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}

	public String getN_REA() {
		return n_REA;
	}

	public void setN_REA(String n_REA) {
		this.n_REA = n_REA;
	}

	public String getId_encrypted() {
		return id_encrypted;
	}

	public void setId_encrypted(String id_encrypted) {
		this.id_encrypted = id_encrypted;
	}


}
