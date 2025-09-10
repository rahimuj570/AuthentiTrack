<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <title>Product QR Labels</title>
    <script src="https://cdn.jsdelivr.net/npm/qrious/dist/qrious.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        .label {
            border: 1px solid #ccc;
            /*padding: 10px;
            margin: 10px;*/
            display: inline-block;
            width: fit-content;
            text-align: center;
            background: #fff;
        }

        .print-button {
            margin: 20px;
            padding: 10px 20px;
            background: #007bff;
            color: white;
            border: none;
            cursor: pointer;
        }
    </style>
    
<link rel="stylesheet" href="style.css">
</head>

<body>

<%@include file="nav.jsp" %>
<div
		style="margin-top: 30px; display: grid; align-self: center; align-content: center; justify-items: center; justify-content: center;">
		
    <h1>🧾 Product QR Labels</h1>
    <p>Batch: <%=request.getParameter("b") %> || Quantity: <span id='quantity'><%=request.getParameter("b") %></span> </p>
    <div style="text-align:center" id="labelContainer"></div>
    <button class="no-print print-button" onclick="window.print()">🖨️ Print Labels</button>
</div>
    <script>
    Swal.fire({
        title: 'Processing...',
        text: 'Please wait while I generate your QR codes.',
        allowOutsideClick: false,
        didOpen: () => {
            Swal.showLoading();
        }
    });
    const params = new URLSearchParams();
    params.append("b", '<%=request.getParameter("b")%>');
         fetch('<%=request.getContextPath()%>/GetAllProduction',{
        	 method: 'POST',
             headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
             body: params
         })
             .then(res => res.json())
             .then(data => {console.log(data);
         
        const container = document.getElementById('labelContainer');

		let count=0;
        data.forEach(item => {
        	count++;
            const div = document.createElement('div');
            div.className = 'label';

            const canvas = document.createElement('canvas');
            const qr = new QRious({
                element: canvas,
                value: window.location.origin + window.location.pathname.split('/').slice(0,2).join('/') + "/"+"/scan.jsp?pc="+item['product_code'],
                size: 100
            });

            div.innerHTML = ``;
            div.appendChild(canvas);
            container.appendChild(div);
        });
        document.getElementById('quantity').innerText=count;
         Swal.close()});
    </script>

</body>

</html>