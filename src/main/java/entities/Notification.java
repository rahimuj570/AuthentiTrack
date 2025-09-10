package entities;

public class Notification {
	private String notification_time;
	private String batch_number;
	private int is_success;

	public String getNotification_time() {
		return notification_time;
	}

	public void setNotification_time(String notification_time) {
		this.notification_time = notification_time;
	}

	public String getBatch_number() {
		return batch_number;
	}

	public void setBatch_number(String batch_number) {
		this.batch_number = batch_number;
	}

	public int getIs_success() {
		return is_success;
	}

	public void setIs_success(int is_success) {
		this.is_success = is_success;
	}

}
