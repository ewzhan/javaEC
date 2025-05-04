<%@page import="java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <body>
        <%  
            String header = (String) session.getAttribute("header");
            if (header != null) {%>
                <jsp:include page="<%= header %>" />
         <% }%>
        

    <div class="container mt-4" style="padding-top: 150px;">
        <div class="row">
            <div class="col-lg-3 my-lg-0 my-md-1">
                <div id="sidebar" class="bg-green">
                    <div class="h4 text-white">Account</div>
                    <ul>
                        <li class="active">
                            <a href="customerProfile.jsp" class="text-decoration-none d-flex align-items-start">
                                <div class="fas fa-box pt-2 me-3"></div>
                                <div class="d-flex flex-column">
                                    <div class="link">My Orders</div>
                                    <div class="link-desc">View & Manage orders and returns</div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a href="customerAccount.jsp" class="text-decoration-none d-flex align-items-start">
                                <div class="far fa-user pt-2 me-3"></div>
                                <div class="d-flex flex-column">
                                    <div class="link">My Profile</div>
                                    <div class="link-desc">Change your profile details & password</div>
                                </div>
                            </a>
                        </li>
                       <li>
                            <a href="customerLogout.jsp" class="text-decoration-none d-flex align-items-start">
                                <div class="far fa-user pt-2 me-3"></div>
                                <div class="d-flex flex-column">
                                    <div class="link">Log Out</div>
                                    <div class="link-desc">Decide to Log out</div>
                                </div>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="col-lg-9 my-lg-0 my-1">
                <div id="main-content" class="bg-white border">
                   <%
    List<Map<String, Object>> orderDetails = (List<Map<String, Object>>) request.getAttribute("orderDetails");
    String orderId = (String) request.getAttribute("orderId");
%>

<h2>Order Details for Order ID: <%= orderId %></h2>
<%
    String orderStatus = (String) request.getAttribute("orderStatus");
    java.util.Date orderCreateTime = (java.util.Date) request.getAttribute("orderCreateTime");
%>

<p><strong>Order Created On:</strong> <%= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(orderCreateTime) %></p>
<p><strong>Status:</strong> <%= orderStatus %></p>
<table border="1" height="400px" width="900px">
    <tr>
        <th>Product Name</th>
        <th>Quantity</th>
        <th>Price</th>
    </tr>
    <%
        if (orderDetails != null) {
            for (int i = 0; i < orderDetails.size(); i++) {
                Map<String, Object> row = orderDetails.get(i);
    %>
    <tr>
        <td><%= row.get("productName") %></td>
        <td><%= row.get("quantity") %></td>
        <td><%= row.get("price") %></td>
    </tr>
    <%
            }
        }
    %>
</table>
        </div>
    </div>
        <%
            String footer = (String) session.getAttribute("footer");
            if (footer != null) {%>
                <jsp:include page="<%= footer %>" />
         <% }%>
          <!-- Back to Top -->
        <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>   

        
    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/lightbox/js/lightbox.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="js/main.js"></script>
    </body>
</html>
