<%@ page import="Entity.Customer" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Information Details</title>
  <link rel="stylesheet" href="css/loginStyle.css">
</head>
<body>
  <div class="wrapper" style="border-radius: 20px;margin: 5vh auto;height: 90vh;">
    <h2>Information Details</h2>
    <p id="error-message" style="color: red;">
      <%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %>
    </p>
    <p id="confirm-message" style="color: green;">
      <%= request.getAttribute("confirmMessage") != null ? request.getAttribute("confirmMessage") : "" %>
    </p>
    
    <form id="form" method="post" action="detailSignup">
        <input type="hidden" name="formType" value="detailSignup">
        <input type="hidden" name="confirm" value="<%= request.getAttribute("confirming") != null ? "yes" : "no" %>">

        <%
            // Retrieve the customer object from the session
            Customer customer = (Customer) session.getAttribute("customer");
            // Default values in case customer is null
            String email = (customer != null && customer.getEmail() != null) ? customer.getEmail() : "";
            String ic = (customer != null && customer.getIc() != null) ? customer.getIc() : "";
            String phone = (customer != null && customer.getPhoneno() != null) ? customer.getPhoneno() : "";
            String address = (customer != null && customer.getHomeaddress() != null) ? customer.getHomeaddress() : "";
        %>

        <div>
            <label for="email-input">
              <span>@</span>
            </label>
            <input type="text" name="email" id="email-input" placeholder="Email@email.com" value="<%= email %>" readonly>
        </div>
        
        <div>
            <label for="ic-input">
              <span>IC</span>
            </label>
            <input type="text" name="ic" id="ic-input" placeholder="123456-07-8910" value="<%= ic %>">
        </div>
        
        <div>
            <label for="firstname-input">
              <svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 -960 960 960" width="24"><path d="M480-480q-66 0-113-47t-47-113q0-66 47-113t113-47q66 0 113 47t47 113q0 66-47 113t-113 47ZM160-160v-112q0-34 17.5-62.5T224-378q62-31 126-46.5T480-440q66 0 130 15.5T736-378q29 15 46.5 43.5T800-272v112H160Z"/></svg>
            </label>
            <input type="text" name="firstname" id="firstname-input" placeholder="Firstname" value="<%= session.getAttribute("firstname") != null ? session.getAttribute("firstname") : "" %>">
            <label for="lastname-input">
              <svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 -960 960 960" width="24"><path d="M480-480q-66 0-113-47t-47-113q0-66 47-113t113-47q66 0 113 47t47 113q0 66-47 113t-113 47ZM160-160v-112q0-34 17.5-62.5T224-378q62-31 126-46.5T480-440q66 0 130 15.5T736-378q29 15 46.5 43.5T800-272v112H160Z"/></svg>
            </label>
            <input type="text" name="lastname" id="lastname-input" placeholder="Lastname" value="<%= session.getAttribute("lastname") != null ? session.getAttribute("lastname") : "" %>">
        </div>
        
        <div>
            <label for="phone-input">
              <svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24"><path d="M0 0h24v24H0V0z" fill="none"/><path d="M6.62 10.79a15.466 15.466 0 006.59 6.59l2.2-2.2a1 1 0 011.11-.27c1.21.49 2.53.76 3.88.76a1 1 0 011 1v3.5a1 1 0 01-1 1C10.34 22 2 13.66 2 3.5A1 1 0 013 2.5h3.5a1 1 0 011 1c0 1.35.26 2.67.76 3.88a1 1 0 01-.27 1.11l-2.2 2.2z"/></svg>
            </label>
            <input type="tel" name="phone" id="phone-input" placeholder="011-12345678" value="<%= phone %>">
        </div>
        
        <div>
            <label for="address-input">
                <svg xmlns="http://www.w3.org/2000/svg" height="34" viewBox="0 0 24 24" width="54"><path d="M0 0h24v24H0V0z" fill="none"/><path d="M10 20v-6h4v6h5v-8h3L12 3 2 12h3v8z"/></svg>
            </label>
            <input type="text" name="address" id="address-input" placeholder="Home Address" value="<%= address %>">
        </div>

        <button type="submit">Sign up</button>
        <p><a href="login.jsp">Skip For Now</a> </p>
    </form>
  </div>
</body>
</html>
