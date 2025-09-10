package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import entities.Produce;
import helper.ConnectionProvider;

public class ProductionDao {
	Connection con;

	public ProductionDao(Connection con) {
		// TODO Auto-generated constructor stub
		this.con = con;
	}

	public ArrayList<Produce> getAllProduction(String batch_number) {
		con = ConnectionProvider.getCon();
		ArrayList<Produce> pl = new ArrayList<Produce>();

		try {
			ResultSet res = con
					.prepareStatement("select * from produces where batch_number like '" + batch_number + "'")
					.executeQuery();
			while (res.next()) {
				Produce p = new Produce();
				p.setBatch_number(res.getString(3));
				p.setProduct_code(res.getString(1));
				p.setProduct_id(res.getInt(2));
				pl.add(p);
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

		return pl;

	}
}
