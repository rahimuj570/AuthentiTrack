package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import dao.ProductDao;
import entities.Product;
import helper.ConnectionProvider;

/**
 * Servlet implementation class AddProductController
 */
@WebServlet("/AddProductController")
public class AddProductController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddProductController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Product product = new Product();
		product.setProduct_name(request.getParameter("name"));
		product.setProduct_price(Integer.parseInt(request.getParameter("price")));
		product.setSize(request.getParameter("size")+"-"+request.getParameter("unit"));
		
		int f = new ProductDao(ConnectionProvider.getCon()).addProduct(product);
		HttpSession sc = request.getSession();
		if(f==1) {
			sc.setAttribute("add_product_ok", "Product Added Successfully!");
		}else {
			sc.setAttribute("add_product_bad", "Something Went Wrong!");
		}
		response.sendRedirect(request.getHeader("referer"));
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
