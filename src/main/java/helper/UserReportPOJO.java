package helper;

import java.sql.Date;

public class UserReportPOJO {

	private String batch_number;
	private String product_code;
	private String report_time;
	private String product_name;
	private String user_report;
	private String user_phone;

	public String getBatch_number() {
		return batch_number;
	}

	public void setBatch_number(String batch_number) {
		this.batch_number = batch_number;
	}

	public String getProduct_code() {
		return product_code;
	}

	public void setProduct_code(String product_code) {
		this.product_code = product_code;
	}

	public String getReport_time() {
		return report_time;
	}

	public void setReport_time(String report_time) {
		this.report_time = report_time;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public String getUser_report() {
		return user_report;
	}

	public void setUser_report(String user_report) {
		this.user_report = user_report;
	}

	public String getUser_phone() {
		return user_phone;
	}

	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}

}