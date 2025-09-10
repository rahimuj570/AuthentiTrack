package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Optional;

import entities.Product;
import helper.ConnectionProvider;

public class ProductDao {

	private Connection con;

	public ProductDao(Connection con) {
		this.con = con;
	}

	public int addProduct(Product p) {
		int f = 0;

		try {
			PreparedStatement pst = con.prepareStatement("insert into products(product_name, product_price, product_size) values (?,?,?)");
			pst.setString(1, p.getProduct_name());
			pst.setInt(2, p.getProduct_price());
			pst.setString(3, p.getSize());
			f = pst.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				System.out.println("poductdao=>addproduct");
				e.printStackTrace();
			}
		}

		return f;
	}
	
	//-1=all; 1=discontinued; 0= not discontinued
	public ArrayList<Product>getAllProduct(int query_type, Optional<String>offset){
		ArrayList<Product>pl = new ArrayList<Product>();
		con = ConnectionProvider.getCon();
		
		try {
			ResultSet res;
			if(query_type==-1)res= con.prepareStatement("select * from products"+(offset.isPresent()?" offset "+offset.get()+" rows fetch next 10 rows only":"")).executeQuery();
			else res= con.prepareStatement("select * from products where discontinued="+query_type).executeQuery();
		
			while(res.next()) {
				Product p = new Product();
				p.setProduct_id(res.getInt(1));
				p.setProduct_name(res.getString(2));
				p.setProduct_price(res.getInt(3));
				p.setSize(res.getString(4));
				p.setIs_discontinued(res.getInt(5));
				pl.add(p);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return pl;
	}
	
	public int countProducts() {
		int f = 0;
		con = ConnectionProvider.getCon();
		try {
			ResultSet res = con.prepareStatement("select count(*) from products").executeQuery();
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
	
	public void discontinueProduct(String pid) {
		con = ConnectionProvider.getCon();
		try {
			con.prepareStatement("update products set discontinued=1 where product_id="+pid).executeUpdate();
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
