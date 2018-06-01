package it.portaleSTI.DTO;

public class ColonnaDTO {
	
	private String name;
	private boolean isKey = false;
	private Class<?> tipo_dato;
	private int isNullable;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public boolean getIsKey() {
		return isKey;
	}
	public void setIsKey(boolean isKey) {
		this.isKey = isKey;
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

}
