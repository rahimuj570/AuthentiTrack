package dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import entities.User;
import helper.ConnectionProvider;

public class UsersDao {
	Connection con;

	public int getUser(User u) {
		int f = 0;

		con = ConnectionProvider.getCon();

		try {
			ResultSet res = con.prepareStatement("select count(*) from users where username like '" + u.getUsername()
					+ "' and password like '" + u.getPassword() + "'").executeQuery();
			f = res.next() ? res.getInt(1) : 0;
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return f;

	}

}
