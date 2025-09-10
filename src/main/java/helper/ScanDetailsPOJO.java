package helper;

import java.sql.Date;

public class ScanDetailsPOJO {
	private String product_code;
	private String product_name;
	private String batch_number;
	private String produce_date;
	private Date expire_date;
	private int batch_isReject;

	public String getProduct_code() {
		return product_code;
	}

	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public String getBatch_number() {
		return batch_number;
	}

	public void setBatch_number(String batch_number) {
		this.batch_number = batch_number;
	}

	public String getProduce_date() {
		return produce_date;
	}

	public void setProduce_date(String produce_date) {
		this.produce_date = produce_date;
	}

	public Date getExpire_date() {
		return expire_date;
	}

	public void setExpire_date(Date expire_date) {
		this.expire_date = expire_date;
	}

	public int getBatch_isReject() {
		return batch_isReject;
	}

	public void setBatch_isReject(int batch_isReject) {
		this.batch_isReject = batch_isReject;
	}

	@Override
	public String toString() {
		return "ScanDetailsPOJO [product_code=" + product_code + ", product_name=" + product_name + ", batch_number="
				+ batch_number + ", produce_date=" + produce_date + ", expire_date=" + expire_date + ", batch_isReject="
				+ batch_isReject + "]";
	}

}
