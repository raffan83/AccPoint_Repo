package it.portaleSTI.DTO;

import java.util.List;

public class MabbaBlockView {
    private int idTabella;
    private String scostamento;     // già pronto (stringa o number)
    private String valoreConvenzionale;
    private String incertezza;
    
    private List<MabbaRowView> rows;

    public MabbaBlockView(int idTabella, String scostamento, List<MabbaRowView> rows) {
        this.idTabella = idTabella;
        this.scostamento = scostamento;
        this.rows = rows;
    }
    public int getIdTabella() { return idTabella; }
    public String getScostamento() { return scostamento; }
    public List<MabbaRowView> getRows() { return rows; }
	public String getValoreConvenzionale() {
		return valoreConvenzionale;
	}
	public void setValoreConvenzionale(String valoreConvenzionale) {
		this.valoreConvenzionale = valoreConvenzionale;
	}
	public String getIncertezza() {
		return incertezza;
	}
	public void setIncertezza(String incertezza) {
		this.incertezza = incertezza;
	}
	public void setIdTabella(int idTabella) {
		this.idTabella = idTabella;
	}
	public void setScostamento(String scostamento) {
		this.scostamento = scostamento;
	}
	public void setRows(List<MabbaRowView> rows) {
		this.rows = rows;
	}
    
    
}
