<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*, java.text.DecimalFormat, Entity.DBConnection, Entity.Staff, java.util.Map, java.util.HashMap"%>
<!DOCTYPE html>
<!--
Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Html.html to edit this template
-->
<html>
     <%
            String header = (String) session.getAttribute("header");
            if (header != null) {%>
                <jsp:include page="<%= header %>"/>
         <% }%>
         <style>
             body{
                 width: 100%;
             }
             .uForm{
                  width:1200px;
                  margin: auto;
             }
             .field > label{
                 width: 20%;
             }
         </style>
        
        <!-- Single Page Header start -->
        <div class="container-fluid page-header py-5">
            <h1 class="text-center text-white display-6">Edit Staff Account</h1>
        </div>
        <!-- Single Page Header End -->
        
            <%
                Staff staff = (Staff) session.getAttribute("staff");
            %>
        
            <div class="uForm">
            <p style=" font-size: 30px; margin-left: 5%; margin-right: 5%;">Please Edit Your Account</p>
            
            <form action="EditStaff" method="get">
                <div class="field"><label> Staff ID: </label>
                   <br> <input  type="text" name="staffID" maxlength="7" value="<%= staff.getStaffid() %>" readonly>
               
                </div>
                    
                    <div class="field"><label>Staff Username: </label>
                    <br><input  type="text" name="staffName" maxlength="50" value="<%=staff.getStaffname() == null ? "" : staff.getStaffname() %>" >
               
                    <% Map<String,String> errors = (Map<String,String>) request.getAttribute("errors");
                    
                    if(errors != null && errors.get("staffNameError") != null && !errors.get("staffNameError").isEmpty()){
               %>
               <p class="errorMessage"><%= errors.get("staffNameError") %><p>
               <%}%>
                    
                </div>
                    
                    <div class="field"><label>Staff IC: </label>
                    <br><input  type="text" name="staffIc" maxlength="12" value="<%= staff.getIc() == null ? "" : staff.getIc() %>" >
                    <% 
                    if(errors != null && errors.get("icFormatError") != null && !errors.get("icFormatError").isEmpty()){
               %>
               <p class="errorMessage"><%= errors.get("icFormatError") %><p>
               <%}%>
                </div>
                    
                    <div class="field"><label>Staff Phone No: </label>
                    <br><input  type="text" name="phoneNo" maxlength="13" value="<%=staff.getPhoneno() == null ? "" : staff.getPhoneno() %>" >
             
                    <% 
                    
                    if(errors != null && errors.get("phoneError") != null && !errors.get("phoneError").isEmpty()){
               %>
               <p class="errorMessage"><%= errors.get("phoneError") %><p>
               <%}%>
                    
                </div>
                    
                    <div class="field"><label>Staff Home Address: </label>
                   <br> <input  type="text" name="homeAddress" maxlength="100" value="<%=staff.getHomeaddress() == null ? "" : staff.getHomeaddress() %>" >
               
                    <% 
                    
                    if(errors != null && errors.get("homeAddressError") != null && !errors.get("homeAddressError").isEmpty()){
               %>
               <p class="errorMessage"><%= errors.get("homeAddressError") %><p>
               <%}%>
                   
                </div>
                    
                    <div class="field"><label>Staff Email: </label>
                    <br><input  type="text" name="email" maxlength="50" value="<%=staff.getEmail() == null ? "" : staff.getEmail() %>" >
                <% 
                    
                    if(errors != null && errors.get("emailFormatError") != null && !errors.get("emailFormatError").isEmpty()){
               %>
               <p class="errorMessage"><%= errors.get("emailFormatError") %><p>
               <%}%>
                </div>
                   
                    <div class="field"><label>Staff Password: </label>
                    <br><input  type="text" name="password" maxlength="20"  >
                <% 
                    if(errors != null && errors.get("pwdFormatError") != null && !errors.get("pwdFormatError").isEmpty()){
                %>
               <p class="errorMessage"><%= errors.get("pwdFormatError") %><p>
               <%}%>
                </div>
                <div>
                     <input type="submit" name="submit" value="Submit">
                </div>
               <%
               Boolean editSuccessful = (Boolean) request.getAttribute("editSuccessful");
               if(editSuccessful != null && editSuccessful){
               

               %>
               
               <p class="updateStatus">Account edited Successful. Return to <a href="staffMainPage.jsp?param1=true">Main Page</a>?</p>
               
               <%}else if(editSuccessful != null && editSuccessful == false){%>
               <p class="updateStatus">Account not updated</p>
               <%}else if(editSuccessful == null){%>
               <p></p>
               <%}%>
            </form>
        </div>
<jsp:include page="staffFooter.jsp" />
    </body>

</html>
