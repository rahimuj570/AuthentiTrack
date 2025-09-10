<%@page import="entities.Product"%>
<%@page import="java.util.Optional"%>
<%@page import="dao.ProductDao"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="dao.BatchDao"%>
<%@page import="entities.Batch"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Manufacturer Dashboard</title>
<link rel="stylesheet" href="style.css">
</head>
<body>

	<%@include file="nav.jsp"%>

	<div
		style="margin-top: 30px; display: grid; align-self: center; align-content: center; justify-items: center; justify-content: center;">
		<h1>📦 Product List</h1>
  <%
        if(session.getAttribute("reject_ok")!=null){%>
        	<p class="toast-success"><%=session.getAttribute("reject_ok") %></p>
        <%
        session.removeAttribute("reject_ok");
        }%>
		<table class="batch-table">
			<thead>
				<tr>
					<th>Product ID</th>
					<th>Product Name</th>
					<th>Product Price</th>
					<th>Product Size</th>
					<th>Status</th>
					<th>Discontinue</th>
				</tr>
			</thead>
			<tbody id="batchList">

				<%
				String offset = request.getParameter("p");
				if (offset == null)
					offset = "0";

				ArrayList<Product> products = new ProductDao(ConnectionProvider.getCon()).getAllProduct(-1,Optional.of((Integer.parseInt(offset)*10)+""));
				for (Product p : products) {
				%>
				<tr>
					<td><%=p.getProduct_id()%></td>
					<td><%=p.getProduct_name()%></td>
					<td><%=p.getProduct_price()%></td>
					<td><%=p.getSize().toUpperCase()%></td>
					<td><%=p.getIs_discontinued() == 0 ? "✔️" : "❌"%></td>
					<%
					
					if(p.getIs_discontinued()==1){%>
					<td>Discontinued Product</td>
					<%}else{ %>
					<td><button <%=p.getIs_discontinued()==1?" disabled style='background: gray'":"style='background: red'" %>  class="qr-button"
							onclick="reject('<%=p.getProduct_id()%>')">Discontinue Product</button></td>
				
					<%} %>
				<%} %>
				</tr>
			</tbody>
		</table>
	<%
	int count = new ProductDao(ConnectionProvider.getCon()).countProducts();
	int curret=Integer.parseInt(offset);
	int last = (int)Math.ceil(Double.parseDouble(count+"")/10.00);
	
	
	%>
		<div class="pagination" id="paginationControls">
			<button <%=offset.equals("0")?"disabled":"class='active'" %> onclick="window.location='products.jsp?p=<%=curret-1%>'" title="previous"><</button>
			<button <%=offset.equals((last-1)+"")?"disabled":"class='active'" %> onclick="window.location='products.jsp?p=<%=curret+1%>'" title="next">></button>
			<p>Page <%=curret+1 %> of <%=last %></p>
		</div>
	</div>
	<%@include file="footer.jsp" %>
	
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script>
	
	let reject=(p)=>{
	Swal.fire({
		  title: "Are you sure?",
		  text: "You won't be able to revert this!",
		  icon: "warning",
		  showCancelButton: true,
		  confirmButtonColor: "#3085d6",
		  cancelButtonColor: "#d33",
		  confirmButtonText: "Yes, discontinue it!"
		}).then((result) => {
		  if (result.isConfirmed) {
			  window.location='<%=request.getContextPath()%>/DiscontinueProduct?p='+p;
		  }
		});
	}
	
	</script>
	
</body>
</html>