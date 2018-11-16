package it.portaleSTI.DTO;

import java.math.BigDecimal;
import java.util.Comparator;

public class RilPuntoQuotaDTO implements Comparable<RilPuntoQuotaDTO>{
	
	private int id;
	private int id_quota=0;
	private String valore_punto;
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}

	public int getId_quota() {
		return id_quota;
	}
	public void setId_quota(int id_quota) {
		this.id_quota = id_quota;
	}
	public String getValore_punto() {
		return valore_punto;
	}
	public void setValore_punto(String valore_punto) {
		this.valore_punto = valore_punto;
	}


	@Override
	public int compareTo(RilPuntoQuotaDTO obj) {
		Integer obj1 = this.getId();
    	Integer obj2 = obj.getId();
        return obj1.compareTo(obj2);
	   
	}
//	public int compare(RilPuntoQuotaDTO o1, RilPuntoQuotaDTO o2) {
//        // I'm assuming your Employee.id is an Integer not an int.
//        // If you'd like to use int, create an Integer before calling compareTo.
//    	Integer obj1 = o1.getId();
//    	Integer obj2 = o2.getId();
//        return obj1.compareTo(obj2);
//    }
//	public int compareTo(RilPuntoQuotaDTO punto) {
//		
//		int id=((RilPuntoQuotaDTO)punto).getId();
//		
//		//ascending order
//		return this.id - id;
//		
//		//descending order
//		//return compareQuantity - this.quantity;
//		
//	}
//	
//	public static Comparator<RilPuntoQuotaDTO> PuntoComparator = new Comparator<RilPuntoQuotaDTO>() {
//		public int compare(RilPuntoQuotaDTO punto1, RilPuntoQuotaDTO punto2) {
//
//			int id1 = punto1.getId();
//			int id2 = punto2.getId();
//
////ascending order
//			return id1.compareT
//
////descending order
////return fruitName2.compareTo(fruitName1);
//}
//
//};

}
