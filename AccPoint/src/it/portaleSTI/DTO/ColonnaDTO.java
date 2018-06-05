package it.portaleSTI.DTO;

public class ColonnaDTO {
	
	private String name;
	private boolean isPKey = false;
	private boolean isFkey = false;
	private Class<?> tipo_dato;
	private int isNullable;
	private String FKTable;
	private String FKTableColumn;

	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}

	public Class<?> getTipo_dato() {
		return tipo_dato;
	}
	public void setTipo_dato(Class<?> tipo_dato) {
		this.tipo_dato = tipo_dato;
	}
	public int getIsNullable() {
		return isNullable;
	}
	public void setNullable(int isNullable) {
		this.isNullable = isNullable;
	}
	public String getFKTable() {
		return FKTable;
	}
	public void setFKTable(String fKTable) {
		FKTable = fKTable;
	}
	public String getFKTableColumn() {
		return FKTableColumn;
	}
	public void setFKTableColumn(String fKTableColumn) {
		FKTableColumn = fKTableColumn;
	}
	public boolean getIsPKey() {
		return isPKey;
	}
	public void setPKey(boolean isPKey) {
		this.isPKey = isPKey;
	}
	public boolean getIsFkey() {
		return isFkey;
	}
	public void setFkey(boolean isFkey) {
		this.isFkey = isFkey;
	}


}
