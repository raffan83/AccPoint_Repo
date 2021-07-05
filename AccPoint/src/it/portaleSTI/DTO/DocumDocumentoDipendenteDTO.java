package it.portaleSTI.DTO;

import java.io.Serializable;

public class DocumDocumentoDipendenteDTO implements Serializable{

	private DocumTLDocumentoDTO documento;
	private DocumDipendenteFornDTO dipendente;
	public DocumTLDocumentoDTO getDocumento() {
		return documento;
	}
	public void setDocumento(DocumTLDocumentoDTO documento) {
		this.documento = documento;
	}
	public DocumDipendenteFornDTO getDipendente() {
		return dipendente;
	}
	public void setDipendente(DocumDipendenteFornDTO dipendente) {
		this.dipendente = dipendente;
	}
	
	
}
