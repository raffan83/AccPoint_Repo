package it.portaleSTI.DTO;

public class RilParticolareDTO {
	
	private int id;
	private RilMisuraRilievoDTO misura;
	private int numero_pezzi;
	private String nome_impronta;
	private String note;
	
	
	public RilParticolareDTO(int id) {
		this.id = id;
	}

	public RilParticolareDTO() {
		super();
	}
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public RilMisuraRilievoDTO getMisura() {
		return misura;
	}
	public void setMisura(RilMisuraRilievoDTO misura) {
		this.misura = misura;
	}
	public int getNumero_pezzi() {
		return numero_pezzi;
	}
	public void setNumero_pezzi(int numero_pezzi) {
		this.numero_pezzi = numero_pezzi;
	}
	public String getNome_impronta() {
		return nome_impronta;
	}
	public void setNome_impronta(String nome_impronta) {
		this.nome_impronta = nome_impronta;
	}

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

}
