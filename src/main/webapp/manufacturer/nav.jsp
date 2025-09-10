<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <script>
        function toggleDropdown2() {
            const dropdown = document.getElementById('accountDropdown');
            dropdown.style.display = (dropdown.style.display === 'block') ? 'none' : 'block';
        }

        // Optional: close dropdown when clicking outside
        document.addEventListener('click', function (e) {
            const dropdown = document.getElementById('accountDropdown');
            if (!e.target.closest('.dropdown')) {
                dropdown.style.display = 'none';
            }
        });
    </script>


    <nav class="navbar no-print">
        <div class="logo">🛡️ AuthentiTrack</div>
        <button class="menu-toggle" onclick="toggleMenu()">☰</button>
<%
String cur_url = request.getRequestURI();%>
        <ul class="nav-links" id="navLinks">
            <li><a <%=cur_url.contains("add_new_product.jsp")?"class='nav_active'":"" %>  href="add_new_product.jsp">Add Product</a></li>
            <li><a <%=cur_url.contains("products.jsp")?"class='nav_active'":"" %> href="products.jsp">Products</a></li>
            <li><a <%=cur_url.contains("generate_product.jsp")?"class='nav_active'":"" %> href="generate_product.jsp">Generate Production</a></li>
            <li><a <%=cur_url.contains("batches.jsp")?"class='nav_active'":"" %> href="batches.jsp">Batches</a></li>
            <li><a <%=cur_url.contains("show_report.jsp")?"class='nav_active'":"" %> href="show_report.jsp">Reports</a></li>

            <!-- Dropdown Menu -->
            <li class="dropdown">
                <a href="#" onclick="toggleDropdown2()">⚙️ Account ▾</a>
                <ul class="dropdown-menu" id="accountDropdown">
                    <li><a href="logout.jsp">⏻ Logout</a></li>
                    <li style="cursor:pointer"><a onclick="changePass()">🔄 Change Password</a></li>
                </ul>
            </li>
        </ul>
    </nav>


    <script>
        function toggleMenu() {
            document.getElementById('navLinks').classList.toggle('show');
        }
    </script>
    
    <script>
       let changePass = ()=>{
    	   Swal.fire({
               title: 'Change Password',
               html:
                   '<input id="prev-pass" type="password" class="swal2-input" placeholder="Previous Password">' +
                   '<input id="new-pass" type="password" class="swal2-input" placeholder="New Password">',
               showCancelButton: true,
               confirmButtonText: 'Change',
               cancelButtonText: 'Cancel',
               confirmButtonColor: '#0078D7',
               preConfirm: () => {
                   const prevPass = document.getElementById('prev-pass').value;
                   const newPass = document.getElementById('new-pass').value;

                   if (!prevPass || !newPass) {
                       Swal.showValidationMessage('Both fields are required');
                       return false;
                   }

                   return { prevPass, newPass };
               }
           }).then((result) => {
               if (result.isConfirmed) {
                   const { prevPass, newPass } = result.value;

                   // 🔒 Send to backend (example using fetch)
                   fetch('<%=request.getContextPath()%>/ChangePassword', {
                       method: 'POST',
                       headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                       body: new URLSearchParams({ prevPass, newPass})
                   })
                       .then(res => res.text())
                       .then(data => {
                           if (data=='OK') {
                               Swal.fire('Success', 'Password changed successfully!', 'success');
                           } else {
                               Swal.fire('Error', data+' Failed to change password', 'error');
                           }
                       })
                       .catch(() => {
                           Swal.fire('Error', 'Server error occurred', 'error');
                       });
               }
           });
       }
    </script>