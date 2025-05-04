<%@page import="java.util.*,Entity.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="customer" scope="session" class="Entity.Customer"/>
<!DOCTYPE html>
<html>
    <head>
        <link href="css/profile.css" rel="stylesheet" type="text/css"/>
    </head>
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
                        <li >
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
                        <li class="active">
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
                    <p id="error-message" style="color: red;">
  <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>
</p><p id="confirm-message" style="color: green;">
  <%= request.getAttribute("confirmMessage") != null ? request.getAttribute("confirmMessage") : "" %>
</p>
<form id="form" method="post" action="customerLogout">
        <input type="hidden" name="logout" value="logout">
        Confirm Your Log Out,<br>
                <button type="submit" style="border:1px solid;">Log Out</button>
          
        
    
</form>
                </div>
            </div>
        </div>

    </div>
     <%
            String footer = (String) session.getAttribute("footer");
            if (footer != null) {%>
                <jsp:include page="<%= footer %>" />
         <% }%>

</html>


