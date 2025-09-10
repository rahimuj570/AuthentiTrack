<%@page import="java.sql.Date"%>
<%@page import="java.util.Map"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Locale"%>
<%@page import="java.time.ZoneId"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.temporal.ChronoUnit"%>
<%@page import="helper.ScanDetailsPOJO"%>
<%@page import="helper.ConnectionProvider"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

  <%@ page errorPage="fake.jsp" %>
  
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Verification</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            /*margin: 30px;*/
            background-color: #f9f9f9;
            height:100vh;
            align-content:center;
        }

        .container {
            max-width: 600px;
            margin: auto;
            background: white;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            margin-bottom: 20px;
        }

        .info {
            margin-bottom: 15px;
        }

        .authentic {
            color: green;
            font-weight: bold;
        }

        .fake {
            color: red;
            font-weight: bold;
        }

        textarea {
            width: 100%;
            height: 80px;
            margin-top: 10px;
        }

        button {
            margin-top: 10px;
            padding: 8px 16px;
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
        }

        button:hover {
            background-color: #0056b3;
        }

        .status {
            margin-top: 10px;
            font-size: 14px;
            color: gray;
        }
           .logo {
            font-weight: bold;
            font-size: 25px;
            text-align: center;
  margin-bottom: 20px;
  margin-top: 20px;
        }
         input[type="tel"] {
            padding: 10px;
            width: 300px;
            margin-top: 10px;
        }

        .note {
            font-size: 14px;
            color: #555;
        }
    </style>
</head>

<body>


<%
ResultSet isScanned = ConnectionProvider.getCon().prepareStatement("select product_code, expire_date, expire_date-30 from product_scan where product_code like '"+request.getParameter("pc")+"'").executeQuery();
Date scanExpire=null;
Date firstScan=null;
if(isScanned.next()){
	scanExpire=isScanned.getDate(2);
	firstScan=isScanned.getDate(3);
}else{
	ConnectionProvider.getCon().prepareStatement("insert into product_scan (product_code) values ('"+request.getParameter("pc")+"')").executeUpdate();
}

ResultSet res = ConnectionProvider.getCon().prepareStatement("select p.product_code, pd.product_name, b.batch_number, TO_CHAR(b.produce_date, 'DD-MON-YYYY') as produce_date  , b.expire_date, b.batch_isreject  from produces p, batches b, products pd where p.product_code like '"+request.getParameter("pc")+"' and p.batch_number=b.batch_number and p.product_id=pd.product_id").executeQuery();
ScanDetailsPOJO sp = new ScanDetailsPOJO();
if(res.next()){
	sp.setProduct_code(res.getString(1));
	sp.setProduct_name(res.getString(2));
	sp.setBatch_number(res.getString(3));
	sp.setProduce_date(res.getString(4));
	sp.setExpire_date(res.getDate(5));
	sp.setBatch_isReject(res.getInt(6));
}
long leftDays; 
if(scanExpire!=null){	
leftDays= ChronoUnit.DAYS.between(LocalDate.now(), scanExpire.toLocalDate()); 
}else{
	leftDays=30;
}
%>



    <div class="logo">🛡️ AuthentiTrack</div>
    <div class="container">
        <h2>🔍 Product Verification</h2>

        <div class="info"><strong>Product Code:</strong> <span id="productCode"><%=sp.getProduct_code() %></span></div>
        <div class="info"><strong>Batch Number:</strong> <span id="batchNumber"><%=sp.getBatch_number() %></span></div>
        <div class="info"><strong>Product Name:</strong> <span id="productName"><%=sp.getProduct_name() %></span></div>
        <div class="info"><strong>Manufacture Date:</strong> <span id="produceDate"><%=sp.getProduce_date() %></span></div>
        <div class="info"><strong>Expiry Date:</strong> <span id="expireDate"><%=new SimpleDateFormat("dd-MMM-yyyy").format(sp.getExpire_date()).toUpperCase()%></span></div>
        <div class="info"><strong>Authenticity:</strong> <span id="authStatus" <%=sp.getBatch_isReject()==0?"class='authentic'":"class='fake'"%>><%=sp.getBatch_isReject()==0?"✔️ (This product belong to us)":"❌ (We suggest not to use this product)" %></span></div>
        <div class="info"><strong>First Scan:</strong> <span id="expireDate"><%=firstScan!=null? new SimpleDateFormat("dd-MMM-yyyy").format(firstScan).toUpperCase():new java.util.Date()%></span></div>
<%
ResultSet resIsSent = ConnectionProvider.getCon().prepareStatement("select count(*) from user_reports where product_code like '"+request.getParameter("pc")+"'").executeQuery();
int isReqSent = resIsSent.next()?resIsSent.getInt(1):0;
if(isReqSent<1){
if(leftDays>0){ %>
        <hr>

        <h3>📝 Submit Your Review</h3>
        <small style="color:red">You have <%=leftDays%> days left to write a review</small>
        <br><input type="tel" id="phone" name="phone" pattern="^01[3-9][0-9]{8}$" placeholder="Your mobile. e.g. 01626404956" required>
        <p style="font-size: 14px; color: #555;">
            Format: 01XXXXXXXXX (starts with 013–019, total 11 digits)
        </p>
        <textarea id="reviewText" placeholder="Write your feedback..."></textarea>
        <button id="feedback_btn" onclick="submitReview()">Submit Review</button>
        <div class="status" id="reviewStatus"></div>
        <%} %>
    </div>
<%

if(leftDays>0){ %>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	
    <script>

        // Submit review
        function submitReview() {
        	  Swal.fire({
                  title: 'Processing...',
                  text: 'Please wait while I ready your request.',
                  allowOutsideClick: false,
                  didOpen: () => {
                      Swal.showLoading();
                  }
              });
        	
            const review = document.getElementById('reviewText').value;
            const phone = document.getElementById('phone').value;
            const pc = location.search.split('=')[1];
            const params = new URLSearchParams();
            params.append('phone', phone);
            params.append('review', review);
            params.append('pc', pc);
            
            fetch('SendReport', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded'},
                body: params
            })
                .then(res => res.text())
                .then(msg => {
                	Swal.close();
                	if(msg=='OK'){
                		Swal.fire({
                  		  position: "center",
                  		  icon: "success",
                  		  title: "Successfully Sent!",
                  		  text: "Feedback for product No. "+pc+" is sent Successfully.",
                  		  showConfirmButton: false,
                  		  timer: 5000
                  		});
                  }else{
                  	Swal.fire({
                		  position: "center",
                		  icon: "error",
                		  title: "Error Occured!",
                		  text: "Feedback for product No. "+pc+" is sent.",
                		  showConfirmButton: false,
                		  timer: 5000
                		});
                  }
                	
                   
                    document.getElementById('reviewText').readOnly=true;
                    document.getElementById('phone').readOnly=true;
                    document.getElementById('feedback_btn').style.display='none';
                });
        }
    </script>
<%}}else{ %>
	<h2 style="color: #0091e8;">Feedback for this product is already sent</h2>
<%} %>
</body>

</html>