<%@page import="helper.ConnectionProvider"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- manufacturer-dashboard.html -->
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Manufacturer Dashboard</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>


   <%@include file="nav.jsp" %>

    <div class="mid">
        <h1>Add New Product</h1>
        <div class="container">
        <%
        if(session.getAttribute("add_product_ok")!=null){%>
        	<p class="toast-success"><%=session.getAttribute("add_product_ok") %></p>
        <%
        session.removeAttribute("add_product_ok");
        }%>
        <%
        if(session.getAttribute("add_product_bad")!=null){%>
        	<p class="toast-danger"><%=session.getAttribute("add_product_bad") %></p>
        <%
        session.removeAttribute("add_product_bad");
        }%>
            <form action="AddProductController" method="post">
                <div class="input-field">
                    <label for="name">Product Name</label>
                    <input required="required" type="text" name="name" id="name">
                </div>
                <div class="input-field">
                    <label for="price">Product Price</label>
                    <input required="required" type="number" name="price" id="price">
                </div>
                <div class="input-field">
                    <label for="size">Product Size</label>
                    <div style="display:flex; gap:5px">                    
                    <input required="required" type="number" name="size" id="size">
                      <select required="required" name="unit" id="name">
                        <option value="kg">kg</option>
                        <option value="g">g</option>
                        <option value="l">L</option>
                        <option value="ml">ml</option>
                    </select>
                    </div>
                </div>

                <button id="form-btn" type="submit">Add</button>
            </form>
        </div>
    </div>
 <%@include file="footer.jsp" %>
</body>

</html>