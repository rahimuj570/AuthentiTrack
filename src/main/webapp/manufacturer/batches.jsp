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
<style type="text/css">
 input[type="text"] {
            padding: 0.75rem;
            margin-bottom: 1rem;
            border: 1px solid #ccc;
            border-radius: 4px;
        }


        button:hover {
            background-color: #0056b3;
        }
</style>
<link rel="stylesheet" href="style.css">
</head>
<body>

	<%@include file="nav.jsp"%>

	<div
		style="margin-top: 30px; display: grid; align-self: center; align-content: center; justify-items: center; justify-content: center;">
		<h1>📦 Batch List</h1>
		<form action="batches.jsp">
		<input type="text" name="s" placeholder="Search Batch Number"/>
		<button style="padding: 0.75rem;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;">Search</button>
		</form>
		
	<%if(request.getParameter("s")!=null){ %>
		<p>Search result for batch number "<%=request.getParameter("s") %>"</p>
		<%} %>
		
  <%
        if(session.getAttribute("reject_ok")!=null){%>
        	<p class="toast-success"><%=session.getAttribute("reject_ok") %></p>
        <%
        session.removeAttribute("reject_ok");
        }%>
		<table class="batch-table">
			<thead>
				<tr>
					<th>Batch Number</th>
					<th>Product</th>
					<th>Produce Date</th>
					<th>Expire Date</th>
					<th>Status</th>
					<th>QR Code</th>
					<th>Reject</th>
				</tr>
			</thead>
			<tbody id="batchList">

				<%
				String offset = request.getParameter("p");
				String search = request.getParameter("s");
				if (offset == null)
					offset = "0";

				ArrayList<Batch> batches = new BatchDao(ConnectionProvider.getCon()).getAll((Integer.parseInt(offset)*10)+"",search);
				for (Batch b : batches) {
				%>
				<tr>
					<td><%=b.getBatch_number()%></td>
					<td><%="ID"+b.getProduct_id()+" - "+b.getProduct_name()%></td>
					<td><%=b.getProduce_date()%></td>
					<td><%=b.getExpire_date()%></td>
					<td><%=b.getIs_ready() == 1 ? "✔️" : "❌"%></td>
					<%
					if(b.getIs_ready()==1){
					
					if(b.getIs_reject()==1){%>
					<td>Rejected Batch</td>
					<%}else{ %>
					<td><button class="qr-button"
							onclick="window.location='qr_codes.jsp?b=<%=b.getBatch_number()%>'">Get QR Code</button></td>
				<%} %>
				<td><button <%=b.getIs_reject()==1?" disabled style='background: gray'":"style='background: red'" %>  class="qr-button"
							onclick="reject('<%=b.getBatch_number()%>')">Reject Batch</button></td>
				<%} %>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	<%
	int count = new BatchDao(ConnectionProvider.getCon()).countBatches();
	int curret=Integer.parseInt(offset);
	int last = (int)Math.ceil(Double.parseDouble(count+"")/10.00);
	
	%>
		<div class="pagination" id="paginationControls">
			<button <%=offset.equals("0")?"disabled":"class='active'" %> onclick="window.location='batches.jsp?p=<%=curret-1%>'" title="previous"><</button>
			<button <%=offset.equals((last-1)+"")?"disabled":"class='active'" %> onclick="window.location='batches.jsp?p=<%=curret+1%>'" title="next">></button>
			<p>Page <%=curret+1 %> of <%=last %></p>
		</div>
	</div>
	<%@include file="footer.jsp" %>
	
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script>
	
	let reject=(b)=>{
	Swal.fire({
		  title: "Are you sure?",
		  text: "You won't be able to revert this!",
		  icon: "warning",
		  showCancelButton: true,
		  confirmButtonColor: "#3085d6",
		  cancelButtonColor: "#d33",
		  confirmButtonText: "Yes, reject it!"
		}).then((result) => {
		  if (result.isConfirmed) {
			  window.location='<%=request.getContextPath()%>/RejectBatch?b='+b;
		  }
		});
	}
	
	</script>
	
</body>
</html>