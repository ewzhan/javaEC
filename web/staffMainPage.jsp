<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*, Entity.DBConnection, Entity.Staff, java.util.ArrayList,java.util.List"%>
<html>
        <%
            String header = (String) session.getAttribute("header");
            if (header != null) {%>
                <jsp:include page="<%= header %>" />
         <% }%>
<%
        HttpSession sessions = request.getSession(false);
        Staff staff = new Staff();
        staff = (Staff) session.getAttribute("staff");
        String param1 = request.getParameter("param1");

        if(param1 == null)param1 = "false";
        
        Boolean firstLogin = staff.getIsfirstlogin();
        System.out.print(firstLogin +" before try to foward");
        
        if(Boolean.TRUE.equals(firstLogin) && !param1.equalsIgnoreCase("true")){
            response.sendRedirect("staffFirstLoginEdit.jsp");
        }else{
            System.out.print("Else");
        }
         
         
        
        %>
    <body>
        <!-- Single Page Header start -->
        <div class="container-fluid page-header py-5">
            <h1 class="text-center text-white display-6">Welcome, <%= staff.getStaffname() %></h1>
            <ol class="breadcrumb justify-content-center mb-0">
                <li class="breadcrumb-item">Home</li>
            </ol>
        </div>
        <!-- Single Page Header End -->

        <div class="menu">
        <div class="dropdown">
            <a class="dropdown-btn" href="customerList.jsp">View Customer Accounts</a>
        </div>
        
        <div class="dropdown">
            <a class="dropdown-btn" href="staffEditOrder.jsp">View Order Statuses</a>
          
        </div>
        
        <div class="dropdown">
            <a class="dropdown-btn" href="replyReview.jsp">Reply Review</a>
           
        </div>
    </div>
        
        <%
            String footer = (String) session.getAttribute("footer");
            if (footer != null) {%>
                <jsp:include page="<%= footer %>" />
         <% }%>
    </body>

</html>
