<%@page import="java.util.Optional"%>
<%@page import="dao.ProductDao"%>
<%@page import="entities.Product"%>
<%@page import="java.util.ArrayList"%>
<%@page import="helper.ConnectionProvider"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Manufacturer Dashboard</title>
<link rel="stylesheet" href="style.css">
</head>

<body>


	<%@include file="nav.jsp"%>


	<div class="mid">
		<h1>Generate Production</h1>
		<div class="container">
			<form id="generate_product_form" action="#">
				<div class="input-field">
					<label for="name">Product Name</label> <select required name="name"
						id="name">
						<%
						ArrayList<Product>pl=new ProductDao(ConnectionProvider.getCon()).getAllProduct(0,Optional.empty());
						for(Product p:pl){%>
						<option value="<%=p.getProduct_id()%>"><%=p.getProduct_name() %></option>
						<%} %>
					</select>
				</div>
				 <input readonly type="hidden"
						name="batch" id="batch">
				
				<div class="input-field">
					<label for="quantity">Quantity</label> <input required
						type="number" name="quantity" id="quantity">
				</div>
				<div class="input-field">
					<label for="expire">Expire Date</label> <input required type="date"
						name="expire" id="expire">
				</div>
				<button id="form-btn" type="submit">Generate</button>
			</form>
		</div>
	</div>
	<%@include file="footer.jsp" %>

	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	<script>
        document.getElementById('generate_product_form').addEventListener('submit', e => {
            e.preventDefault();
            let name = document.getElementById('name');
            let quantity = document.getElementById('quantity');
            let expire = document.getElementById('expire');
            let batch = document.getElementById('batch');



            const inputDate = new Date(expire.value);
            const today = new Date();
            today.setHours(0, 0, 0, 0);

            if (inputDate < today) {
                Swal.fire({
                    icon: "error",
                    title: "Invalid Date",
                    text: "Past date is not allowed!",
                    confirmButtonText: 'Understood'
                });
            } else {
                let tmp_batch = 'BA' + name.value + '-' + Date.now() + '-' + quantity.value;
                batch.value = tmp_batch;
                console.log(tmp_batch);

                const params = new URLSearchParams();
                params.append("expire", expire.value);
                params.append("batch", batch.value);
                params.append("quantity", quantity.value);
                params.append("name", name.value);

                Swal.fire({
                    title: 'Processing...',
                    text: 'Please wait while I ready your production.',
                    allowOutsideClick: false,
                    didOpen: () => {
                        Swal.showLoading();
                    }
                });


                fetch('<%=request.getContextPath()%>/GenerateProduction', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: params
                }).then(res => res.text()).then(data => {console.log(data);

                
                if(data=='OK'){
                	Swal.fire({
                		  position: "center",
                		  icon: "success",
                		  title: "Successfully Generated!",
                		  text: "Batch No. "+batch.value+" Production Genereted Successfully.",
                		  showConfirmButton: false,
                		  timer: 5000
                		});
                }else{
                	Swal.fire({
              		  position: "center",
              		  icon: "error",
              		  title: "Error Occured!",
              		  text: "Batch No. "+batch.value+" Production Not Genereted Successfully!",
              		  showConfirmButton: false,
              		  timer: 5000
              		});
                }
                	
                	
                	
                });

            }

        })


    </script>

</body>

</html>