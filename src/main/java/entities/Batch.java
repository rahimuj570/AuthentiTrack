package entities;

import java.sql.Date;

public class Batch {
	private String batch_number;
	private String produce_date;
	private Date expire_date;
	private int lock_batch;
	private int is_ready;
	private int is_reject;
	// extra
	private int product_quantity;
	private int product_id;
	private String product_name;

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public int getProduct_quantity() {
		return product_quantity;
	}

	public void setProduct_quantity(int product_quantity) {
		this.product_quantity = product_quantity;
	}

	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
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

	public int getLock_batch() {
		return lock_batch;
	}

	public void setLock_batch(int lock_batch) {
		this.lock_batch = lock_batch;
	}

	public int getIs_ready() {
		return is_ready;
	}

	public void setIs_ready(int is_ready) {
		this.is_ready = is_ready;
	}

	public int getIs_reject() {
		return is_reject;
	}

	public void setIs_reject(int is_reject) {
		this.is_reject = is_reject;
	}

	@Override
	public String toString() {
		return "Batch [batch_number=" + batch_number + ", produce_date=" + produce_date + ", expire_date=" + expire_date
				+ ", lock_batch=" + lock_batch + "]";
	}

}
