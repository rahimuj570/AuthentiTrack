package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import helper.ConnectionProvider;
import helper.UserReportPOJO;

public class UserReportDao {
	Connection con;

	public ArrayList<UserReportPOJO> getAll(String offset) {
		ArrayList<UserReportPOJO> sl = new ArrayList<UserReportPOJO>();
		con = ConnectionProvider.getCon();
		try {
			ResultSet res = con.prepareStatement("select p.batch_number, p.product_code,pd.product_name,ur.user_phone, ur.report_time, ur.user_report  from user_reports ur, produces p, products pd where p.product_code=ur.product_code and pd.product_id=p.product_id  order by report_time desc offset "+offset+" rows fetch next 10 rows only").executeQuery();
			while (res.next()) {
				UserReportPOJO s = new UserReportPOJO();
				s.setBatch_number(res.getString(1));
				s.setProduct_code(res.getString(2));
				s.setProduct_name(res.getString(3));
				s.setUser_phone(res.getString(4));
				s.setUser_report(res.getString(6));
				Timestamp ts = res.getTimestamp(5);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss a");
				String formatted = sdf.format(ts);
				s.setReport_time(formatted);
				sl.add(s);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		return sl;
	}
	
	
	
	public int countReports() {
		int f = 0;
		con = ConnectionProvider.getCon();
		try {
			ResultSet res = con.prepareStatement("select count(*) from user_reports").executeQuery();
			f = res.next() ? res.getInt(1) : 0;
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

	public int createReport(String pd, String phone, String report) {
		int f = 0;
		con = ConnectionProvider.getCon();
		try {
			f = con.prepareStatement("insert into user_reports (product_code, user_phone,user_report) values('" + pd
					+ "','" + phone + "','" + report + "')").executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
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
