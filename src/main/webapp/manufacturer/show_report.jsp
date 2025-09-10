<%@page import="helper.UserReportPOJO"%>
<%@page import="dao.UserReportDao"%>
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
		<h1>🗳️ Report List</h1>

		<table class="batch-table">
			<thead>
				<tr>
					<th>batch Number</th>
					<th>Product Code</th>
					<th>Product Name</th>
					<th>User Phone</th>
					<th>Report Time</th>
					<th>User Report</th>
				</tr>
			</thead>
			<tbody id="batchList">

				<%
				String offset = request.getParameter("p");
				if (offset == null)
					offset = "0";

				ArrayList<UserReportPOJO> reports = new UserReportDao().getAll(offset);
				for (UserReportPOJO r : reports) {
				%>
				<tr>
					<td><%=r.getBatch_number()%></td>
					<td><%=r.getProduct_code()%></td>
					<td><%=r.getProduct_name()%></td>
					<td><%=r.getUser_phone()%></td>
					<td><%=r.getReport_time()%></td>
					<td><button class="qr-button"
							onclick="showFeedbackModal('<%=r.getUser_phone() %>','<%=r.getUser_report()%>')">Show Report</button></td>
				

				<%} %>
				</tr>
			</tbody>
		</table>
	<%
	int count = new UserReportDao().countReports();
	int curret=Integer.parseInt(offset);
	int last = (int)Math.ceil(Double.parseDouble(count+"")/10.00);
	
	%>
		<div class="pagination" id="paginationControls">
			<button <%=offset.equals("0")?"disabled":"class='active'" %> onclick="window.location='show_report.jsp?p=<%=curret-1%>'" title="previous"><</button>
			<button <%=offset.equals((last-1)+"")?"disabled":"class='active'" %> onclick="window.location='show_report.jsp?p=<%=curret+1%>'" title="next">></button>
			<p>Page <%=curret+1 %> of <%=last %></p>
		</div>
	</div>
	<%@include file="footer.jsp" %>
	
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script>
	
	function showFeedbackModal(phone, review) {
	    var htmlContent = 
	        "<strong>Phone:</strong> " + phone + "<br>" +
	        "<strong style='margin-top: 2px;display: inline-block;'>Review:</strong>" +
	        "<div style='max-height:300px; overflow-y:auto;'>" +
	        review.replace(/\n/g, "<br>") +
	        "</div>";

	    Swal.fire({
	        title: 'User Feedback',
	        html: htmlContent,
	        icon: 'info',
	        confirmButtonText: 'Close',
	        width: 600
	    });
	}

	

	
	
	
	</script>
	
</body>
</html>