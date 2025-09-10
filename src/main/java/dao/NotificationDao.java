package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import entities.Notification;
import helper.ConnectionProvider;

public class NotificationDao {
	
	Connection con;
	
	public ArrayList<Notification> getAllNotification() {
		con = ConnectionProvider.getCon();
		ArrayList<Notification>nl = new ArrayList<Notification>();
		
		try {
			ResultSet res = con.prepareStatement("select * from notification_log where isseen=0 order by notify_time desc").executeQuery();
			while(res.next()) {
				Notification n = new Notification();
				n.setBatch_number(res.getString(3));
				n.setIs_success(res.getInt(6));
				Timestamp ts = res.getTimestamp(2);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss a");
				String formatted = sdf.format(ts);
				n.setNotification_time(formatted);
				nl.add(n);
			}
			con.prepareStatement("update notification_log set isseen=1").executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return nl;
		
	}
	
	
	public int countNotification() {
		con = ConnectionProvider.getCon();
		int f=0;
		try {
			ResultSet res = con.prepareStatement("select count(*) from notification_log where isseen=0").executeQuery();
			f = res.next()?res.getInt(1):0;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		 
		
		return f;
	}
	
}
