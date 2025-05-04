<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*, Entity.DBConnection, Entity.Staff, java.util.ArrayList,java.util.List"%>
<!DOCTYPE html>
<html lang="en">
        <%
            String header = (String) session.getAttribute("header");
            if (header != null) {%>
                <jsp:include page="<%= header %>" />
         <% }%>

        <!-- Single Page Header start -->
       <div class="container-fluid page-header py-5">
            <h1 class="text-center text-white display-6">Staff List</h1>
            <ol class="breadcrumb justify-content-center mb-0">
                <li class="breadcrumb-item"><a href="#">Home</a></li>
                
                <li class="breadcrumb-item active text-white">Staff List</li>
            </ol>
        </div>
        <!-- Single Page Header End -->
        <%
            
            DBConnection db = new DBConnection();
            db.initializeJdbc();
            Connection conn = db.getConnection();
            String selectAll = "SELECT * FROM STAFF";
            ResultSet rs = null;
            try{
                PreparedStatement stmt = conn.prepareStatement(selectAll);
                rs = stmt.executeQuery();
                
            }catch(SQLException ex){
            ex.printStackTrace();
            }
        
        
        %>

        
        <form action="StaffSearchUpdate" method="post">
            <label>Search By ID: </label><input type="text" name="searchByID" placeholder="SF0000">
             <input type="submit" name="Search" value="Search">
        </form>
     
        
        <table>
    <tr>
        <th>Staff ID</th><th>Staff UserName</th><th>Staff Email</th><th>IC</th><th>Phone No</th>
        <th>Home Address</th><th>First Time Login</th><th>Edit</th><th>Delete</th>
    </tr>

    <%
        
     Staff staffList = (Staff) request.getAttribute("staffList");
    Boolean searched = (Boolean) request.getAttribute("searched");
    if (searched == null) searched = false;    
    
    if (staffList != null) {
        
    %>
        <tr>
            <td class="data"><%= staffList.getStaffid() %></td>
            <td class="data"><%= staffList.getStaffname() == null ? "" : staffList.getStaffname() %></td>
            <td class="data"><%= staffList.getEmail() == null ? "" : staffList.getEmail() %></td>
            <td class="data"><%= staffList.getIc() == null ? "" : staffList.getIc() %></td>
            <td class="data"><%= staffList.getPhoneno() == null ? "" : staffList.getPhoneno() %></td>
            <td class="data"><%= staffList.getHomeaddress() == null ? "" : staffList.getHomeaddress() %></td>
            <td class="data"><%= staffList.getIsfirstlogin() ? "Yes" : "No" %></td>
            <td class="data"><a href="StaffSearchUpdate?action=edit&param1=<%= staffList.getStaffid() %>">Edit</a></td>
            <td class="data"><a href="StaffSearchUpdate?action=delete&param1=<%= staffList.getStaffid() %>">Delete</a></td>
        </tr>
    <%
        
    }else if(searched && staffList== null ){ %>

 
                 <tr>
            <td colspan="10" style="text-align: center;">No record found</td>
        </tr>




<%}else{%>

 <%
boolean hasRecord = false;
while(rs.next()){
    hasRecord = true;

    String staffID = rs.getString("STAFFID");
    String staffUserName = rs.getString("STAFFNAME");
    String staffEmail = rs.getString("EMAIL");
    String staffIC = rs.getString("IC");
    String staffPhoneNo = rs.getString("PHONENO");
    String staffHomeAddress = rs.getString("HOMEADDRESS");
    String staffPassword = rs.getString("PASSWORD");
    boolean isFirstLogin = rs.getBoolean("ISFIRSTLOGIN");
    if(!staffID.equals("SF0000")){
%>
    <tr> 
        <td class="data"><%= staffID %></td>
        <td class="data"><%= staffUserName == null ? "" : staffUserName %></td>
        <td class="data"><%= staffEmail == null ? "" : staffEmail %></td>
        <td class="data"><%= staffIC == null ? "" : staffIC %></td>
        <td class="data"><%= staffPhoneNo == null ? "" : staffPhoneNo %></td>
        <td class="data"><%= staffHomeAddress == null ? "" : staffHomeAddress %></td>
        <td class="data"><%= isFirstLogin ? "Yes" : "No" %></td>
         <td class="data"><a href="StaffSearchUpdate?action=edit&param1=<%= staffID %>">Edit</a></td>
        <td class="data"><a href="StaffSearchUpdate?action=delete&param1=<%= staffID %>">Delete</a></td>
    </tr>
<%
}}
if (!hasRecord) {
%>
    <tr>
        <td colspan="10" style="text-align: center;">No record exists <a href="admCreateStaff.jsp">Go to Create Account?</a></td>
    </tr>
<%
}}
%>
</table>
            

<jsp:include page="staffFooter.jsp" />
</html>