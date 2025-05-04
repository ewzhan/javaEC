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
                        <li class="active">
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
                    <p id="error-message" style="color: red;">
  <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>
</p><p id="confirm-message" style="color: green;">
  <%= request.getAttribute("confirmMessage") != null ? request.getAttribute("confirmMessage") : "" %>
</p>
<form id="form" method="post" action="customerAccount" enctype="multipart/form-data">
        <input type="hidden" name="confirm" value="<%= request.getAttribute("confirming") != null ? "yes" : "no" %>">
    
        
    <table>
        <tr>
            <th><label for="image-input"> <img src="${empty customer.profileImage ?'img/avatar.jpg':customer.profileImage}" alt="user" width="150" height="150"/></label></th>
            <td>
                Select image to upload:
                <input type="file" name="imageFile" ><br>
            </td>
        </tr>
        
        <tr>
            <th><label for="email-input">Email @ :</label></th>
            <td>
                <input type="text" name="email" id="email-input" placeholder="Email@email.com"
                       value="${empty customer.email ? 'User' : customer.email}" readonly>
            </td>
        </tr>
        <tr>
            <th><label for="name-input">Username :</label></th>
            <td>
                <input type="text" name="name" id="name-input" placeholder="Username" value="${empty customer.customername ? 'User' : customer.customername}">
            </td>
        </tr>
        <tr>
            <th><label for="ic-input">IC :</label></th>
            <td>
                <input type="text" name="ic" id="ic-input" placeholder="123456-07-8910"
                       value="${empty customer.ic ? '' : customer.ic}">
            </td>
        </tr>
        <tr>
            <th><label for="phone-input">Phone No. :</label></th>
            <td>
                <input type="tel" name="phone" id="phone-input" placeholder="011-12345678"
                       value="${empty customer.phoneno ? '' : customer.phoneno}">
            </td>
        </tr>
        <tr>
            <th><label for="address-input">Home Address :</label></th>
            <td>
                <input type="text" name="address" id="address-input" placeholder="Home Address"
                       value="${empty customer.homeaddress ? '' : customer.homeaddress}">
            </td>
        </tr>
        <tr>
            <td colspan="2" style="text-align: center;">
                <button type="submit">Edit</button>
            </td>
        </tr>
    </table>
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

