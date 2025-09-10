package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

import entities.User;
import helper.ConnectionProvider;

/**
 * Servlet implementation class ChangePassword
 */
@WebServlet("/ChangePassword")
public class ChangePassword extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ChangePassword() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String prevPass = request.getParameter("prevPass");
		String newPass = request.getParameter("newPass");

		HttpSession sc = request.getSession();
		User u = (User) sc.getAttribute("current_user");

		if (u.getPassword().equals(prevPass)) {
			if (newPass.length() < 5) {
				response.getWriter().append("New passowrd must atleast 5 character.");
			} else {
				Connection con = ConnectionProvider.getCon();
				try {
					int f = con
							.prepareStatement(
									"update users set password='" + newPass + "' where username='" + u.getUsername()+"'")
							.executeUpdate();
					if (f == 1)
						response.getWriter().append("OK");
					else
						response.getWriter().append("Something went wrong!");
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
			}
		} else {
			response.getWriter().append("Previous password is not matched");
		}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
