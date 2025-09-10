package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import org.apache.tomcat.dbcp.dbcp2.ConnectionFactory;

import dao.BatchDao;
import entities.Batch;
import helper.ConnectionProvider;

/**
 * Servlet implementation class GenerateProduction
 */
@WebServlet("/GenerateProduction")
public class GenerateProduction extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public GenerateProduction() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
//
//		response.setHeader("Access-Control-Allow-Origin", "*"); // Or specify your frontend origin
//		response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS");
//		response.setHeader("Access-Control-Allow-Headers", "Content-Type");

		Batch batch = new Batch();
		batch.setBatch_number(request.getParameter("batch"));
		batch.setLock_batch(0);
		System.out.println(request.getParameter("quantity"));
		batch.setProduct_quantity(Integer.parseInt(request.getParameter("quantity")));
		batch.setProduct_id(Integer.parseInt(request.getParameter("name")));

		LocalDate localDate = LocalDate.parse(request.getParameter("expire"), DateTimeFormatter.ISO_LOCAL_DATE);

		batch.setExpire_date(Date.valueOf(localDate));

		System.out.println(batch);

		new BatchDao(ConnectionProvider.getCon()).generateBatchProduction(batch);

		Connection con = ConnectionProvider.getCon();
		try {
			ResultSet res = con.prepareStatement("select count(*) from batches where batch_number='"+batch.getBatch_number()+"'").executeQuery();
			if(res.next()) {
				if(res.getInt(1)==1)
					response.getWriter().append("OK");
				else
					response.getWriter().append("BAD");	
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
