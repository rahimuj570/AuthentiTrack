<%@page import="dao.NotificationDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<footer>

	<%
	int notificaton_count = new NotificationDao().countNotification();
	%>

	<div class="notification-bar" onclick="toggleDropdown()">
		🔔 Notifications<sup id="cnt"
			style="background: white; height: 13px; width: 13px; display: inline-block; margin-left: 2px; color: blue; text-align: center; border-radius: 50%; font-size: 10px; padding: 1px;"><%=notificaton_count%></sup>
	</div>

	<div id="notificationDropdown" class="notification-dropdown">
	</div>

	<script>
		function toggleDropdown() {
			const dropdown = document.getElementById('notificationDropdown');
			dropdown.classList.toggle('open');
			
			
			if (dropdown.classList.contains('open')) {
			    fetchNotifications();}
			if (!dropdown.classList.contains('open')) {
			    document.getElementById('cnt').innerText='0';
			    }
		}
		
		
		
		//function of fetch notif
		 function fetchNotifications() {
    fetch('<%=request.getContextPath()%>/GetAllNotification')
      .then(res => res.json())
      .then(data => {
    	  //console.log(data);
    	  
    	  
     
    //data=[];
        const container = document.getElementById('notificationDropdown');
        container.innerHTML = '';

        if(data.length==0){
            container.innerHTML = '<div class="notification-item">📭 No Notification</div>';   	
        }
        
        data.forEach(item => {
          const div = document.createElement('div');
          div.className = 'notification-item';
          console.log(item['notification_time']);
          div.innerHTML = 
        	  "<strong>" + ((item.is_success==1) ? "✅" : "❌") + " " + (item.batch_number) + "</strong> — " +
        	  ((item.is_success==1) ? "Successfully generated!" : "Could not generate!") +
        	  "<br><small>" + (item.notification_time) + "</small>";

          div.style.color = (item.is_success == 1) ? 'lightgreen' : 'orange';
          container.appendChild(div);
        });
      });
  }
		
		
		
	</script>
</footer>