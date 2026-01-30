package it.portaleSTI.DTO;

public class MabbaRowView {
    private String mabba; // A o B
    private String diff;  // già formattato con virgola
    private String um;

    public MabbaRowView(String mabba, String diff, String um) {
        this.mabba = mabba;
        this.diff = diff;
        this.um = um;
    }
    public String getMabba() { return mabba; }
    public String getDiff() { return diff; }
    public String getUm() { return um; }
}
