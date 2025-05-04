<!DOCTYPE html>
<html>
    <body>
        <%
            String header = (String) session.getAttribute("header");
            if (header != null) {%>
                <jsp:include page="<%= header %>" />
         <% }%>
         
        <!-- Single Page Header start -->
        <div class="container-fluid page-header py-5">
            <h1 class="text-center text-white display-6">Welcome, Admin</h1>
            <ol class="breadcrumb justify-content-center mb-0">
                <li class="breadcrumb-item">Home</li>
               
               
            </ol>
        </div>
        <!-- Single Page Header End -->

    <div class="menu">
  <div class="dropdown">
      <a class="dropdown-btn" href="staffList.jsp">Manage staff Accounts</a>
    <div class="dropdown-content" id="dropdownLi">
        <div class="dropdownLitem"><a href="admCreateStaff.jsp">Create staff Account</a></div>
      
    </div>
  </div>

        <div class="dropdown">
            <a class="dropdown-btn" href="admCreateUser.jsp">Manage Customer Accounts</a>
        </div>
        
    <div class="dropdown">
      <a class="dropdown-btn" href="salesRecord.jsp">View Sales Record</a>
  </div>
        
        <div class="dropdown">
      <a class="dropdown-btn" href="admEditOrder.jsp">View Order Statuses</a>
   
      
    </div>
        
         <div class="dropdown">
      <a class="dropdown-btn" href="replyReview.jsp">Reply Review</a>

  </div>
  </div>
<jsp:include page="staffFooter.jsp" />
</body>
</html>
