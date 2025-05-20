package it.portaleSTI.DTO;

public class AMOggettoProvaAllegatoDTO {
	
	private int id;
	private AMOggettoProvaDTO strumento;
	private String filename;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public AMOggettoProvaDTO getStrumento() {
		return strumento;
	}
	public void setStrumento(AMOggettoProvaDTO strumento) {
		this.strumento = strumento;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	
	
}
