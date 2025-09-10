package dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import entities.Batch;
import helper.ConnectionProvider;

public class BatchDao {
	Connection con;

	public BatchDao(Connection con) {
		// TODO Auto-generated constructor stub
		this.con = con;
	}

	public int generateBatchProduction(Batch b) {

		con = ConnectionProvider.getCon();
		int f = 0;
		try {
			CallableStatement cst = con.prepareCall("begin generate_batch_production(?,?,?,?); end;");
//			PreparedStatement pst = con.prepareStatement("insert into batches (batch_number,expire_date,lock_batch) values(?,?,?)");
			cst.setString(1, b.getBatch_number());
			cst.setDate(2, b.getExpire_date());
			cst.setInt(3, b.getProduct_quantity());
			cst.setInt(4, b.getProduct_id());
			cst.execute();
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

	public ArrayList<Batch> getAll(String offset, String search) {
		search = search==null?"":"b.batch_number='"+search+"' and";
		System.out.println(search);
		con = ConnectionProvider.getCon();
		ArrayList<Batch> bl = new ArrayList<Batch>();
		try {
			PreparedStatement pst = con.prepareStatement("select b.*, pd.product_name from batches b, products pd where "+search+" b.product_id =pd.product_id order by produce_date desc offset "+offset+" rows fetch next 10 rows only");
			ResultSet res = pst.executeQuery();
			while (res.next()) {
				Batch tmp = new Batch();
				tmp.setBatch_number(res.getString(1));
				Timestamp ts = res.getTimestamp(2);
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss a");
				String formatted = sdf.format(ts);
				tmp.setProduce_date(formatted);
				tmp.setExpire_date(res.getDate(3));
				tmp.setIs_ready(res.getInt(5));
				tmp.setIs_reject(res.getInt(6));
				tmp.setProduct_id(res.getInt(7));
				tmp.setProduct_name(res.getString(8));
				bl.add(tmp);
				
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

		return bl;
	}

	public int countBatches() {
		int f = 0;
		con = ConnectionProvider.getCon();
		try {
			ResultSet res = con.prepareStatement("select count(*) from batches").executeQuery();
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
	
	
	public void rejectbatch(String b) {
		con = ConnectionProvider.getCon();
		try {
			con.prepareStatement("update batches set batch_isreject=1 where batch_number='"+b+"'").executeUpdate();
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
	}

}
