package it.portaleSTI.DTO;

import java.io.Serializable;

public class SvtRowView implements Serializable {
  private static final long serialVersionUID = 1L;

  private String valoreNominale;
  private String pesata;
  private String valoreCorretto;
  private String valoreConvenzionale;
  private String scostPct;
  private String scostUm;
  private String incPct;
  private String incUm;
  private String um;
  private String accetabilita;

  public SvtRowView(String valoreNominale, String pesata, String valoreCorretto,
                    String valoreConvenzionale, String scostPct, String scostUm,
                    String incPct, String incUm, String um, String accetabilita) {
    this.valoreNominale = valoreNominale;
    this.pesata = pesata;
    this.valoreCorretto = valoreCorretto;
    this.valoreConvenzionale = valoreConvenzionale;
    this.scostPct = scostPct;
    this.scostUm = scostUm;
    this.incPct = incPct;
    this.incUm = incUm;
    this.um = um;
    this.accetabilita=accetabilita;
  }

  public String getValoreNominale() { return valoreNominale; }
  public String getPesata() { return pesata; }
  public String getValoreCorretto() { return valoreCorretto; }
  public String getValoreConvenzionale() { return valoreConvenzionale; }
  public String getScostPct() { return scostPct; }
  public String getScostUm() { return scostUm; }
  public String getIncPct() { return incPct; }
  public String getIncUm() { return incUm; }
  public String getUm() { return um; }
  public String getAccetabilita() { return accetabilita; }
}