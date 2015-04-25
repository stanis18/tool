package util;

import java.util.Date;

@SuppressWarnings("serial")
public class DataFormato extends Date {

	int tag = 0;
	
	public DataFormato(long s) {
		super(s);
	}
	
	public DataFormato(int i) {
		this.tag = i;
	}
	
 	public DataFormato() {}

	@SuppressWarnings("deprecation")
	public String toString() {
		if(tag == 1) {
			String temp = super.toLocaleString();
			return temp;
		} else {		
			String temp = super.toLocaleString().substring(0, 10);
			//System.out.println(temp);
			return temp;
		}
	}
	
}
