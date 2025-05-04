
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
                <jsp:include page="<%= header %>" />
         <% }%>

    <body>
        <!-- Single Page Header start -->
        <div class="container-fluid page-header py-5">
            <h1 class="text-center text-white display-6">Edit Staff Account</h1>
            <ol class="breadcrumb justify-content-center mb-0">
                <li class="breadcrumb-item"><a href="#">Home</a></li>
                
                <li class="breadcrumb-item active text-white">Edit Staff Account</li>
            </ol>
        </div>
        <!-- Single Page Header End -->

        <%
            DBConnection db = new DBConnection();
            db.initializeJdbc();
            Connection conn = db.getConnection();
        String selectedStaffID = (String) request.getAttribute("staffID");
String findRecord = "SELECT * FROM STAFF WHERE STAFFID = ?";
Staff staff = new Staff();
try{

            
        PreparedStatement stmt = conn.prepareStatement(findRecord);
        stmt.setString(1, selectedStaffID);
        ResultSet rs = stmt.executeQuery();
        
        if(rs.next()){
        
         staff.setStaffid(rs.getString("STAFFID"));
           staff.setStaffname(rs.getString("STAFFNAME"));
           staff.setIc(rs.getString("IC"));
           staff.setPhoneno(rs.getString("PHONENO"));
           staff.setHomeaddress(rs.getString("HOMEADDRESS"));
           staff.setEmail(rs.getString("EMAIL"));
           staff.setPassword(rs.getString("PASSWORD"));
           staff.setIsfirstlogin(rs.getBoolean("ISFIRSTLOGIN"));
        
            }
            
            
            }catch(SQLException ex){
            ex.printStackTrace();
            }
        
            
        %>
        
        <div class="uForm">
            <p style=" font-size: 30px; margin-left: 5%; margin-right: 5%;">Update Staff Account</p>
            
            <form action="EditStaff" method="post">
                <div class="field"><label> Staff ID: </label>
                   <br> <input  type="text" name="staffID" maxlength="7" value="<%= staff.getStaffid() %>" readonly>
               
                </div>
                    
                    <div class="field"><label>Staff Username: </label>
                    <br><input  type="text" name="staffName" maxlength="50" value="<%=staff.getStaffname() == null ? "" : staff.getStaffname() %>" >
               
                </div>
                    
                    <div class="field"><label>Staff IC: </label>
                    <br><input  type="text" name="staffIc" maxlength="12" value="<%= staff.getIc() == null ? "" : staff.getIc() %>" >
                    <% Map<String,String> errors = (Map<String,String>) request.getAttribute("errors");
                    
                    if(errors != null && errors.get("icFormatError") != null && !errors.get("icFormatError").isEmpty()){
               %>
               <p class="errorMessage"><%= errors.get("icFormatError") %><p>
               <%}%>
                </div>
                    
                    <div class="field"><label>Staff PhoneNo: </label>
                    <br><input  type="text" name="phoneNo" maxlength="13" value="<%=staff.getPhoneno() == null ? "" : staff.getPhoneno() %>" >
             
                </div>
                    
                    <div class="field"><label>Staff Home Address: </label>
                   <br> <input  type="text" name="homeAddress" maxlength="100" value="<%=staff.getHomeaddress() == null ? "" : staff.getHomeaddress() %>" >
               
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
                <%
               Boolean editSuccessful = (Boolean) request.getAttribute("editSuccessful");
               if(editSuccessful != null && editSuccessful){
               %>
               
               <p class="updateStatus">Account edited Sucessful. Return to <a href="staffList.jsp">Staff List</a>?</p>
               
               <%}else if(editSuccessful != null && editSuccessful == false){%>
               <p class="updateStatus">Account not updated</p>
               <%}else if(editSuccessful == null){%>
               <p></p>
               <%}%>
                </div>
            </form>   
        </div>
<jsp:include page="staffFooter.jsp" />
    </body>

</html>
