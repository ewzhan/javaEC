
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*, java.text.DecimalFormat, Entity.DBConnection,java.util.HashMap,java.util.Map"%>
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
        <!-- Single Page Header start -->
        <div class="container-fluid page-header py-5">
            <h1 class="text-center text-white display-6">Create Staff Account</h1>
            <ol class="breadcrumb justify-content-center mb-0">
                <li class="breadcrumb-item"><a href="#">Home</a></li>
                
                <li class="breadcrumb-item active text-white">Create Staff Account</li>
            </ol>
        </div>
        <!-- Single Page Header End -->

        <%
            DBConnection db = new DBConnection();
            db.initializeJdbc();
            Connection conn = db.getConnection();
        String newStaffID = "SF0001";
String lastRecord = "SELECT STAFFID FROM STAFF ORDER BY STAFFID DESC FETCH FIRST ROW ONLY";
try{
        PreparedStatement stmt = conn.prepareStatement(lastRecord);
        ResultSet rs = stmt.executeQuery();

        if(rs.next()){
            
            String result = rs.getString("STAFFID");
            int num = Integer.parseInt(result.substring(2));
            num++;
            DecimalFormat df = new DecimalFormat("0000");
            newStaffID = "SF" + df.format(num);
            }
            }catch(SQLException ex){
            ex.printStackTrace();
            }
        %>
        
        <div class="cForm">
            <p style=" font-size: 30px; margin-left: 5%">Create Login Information</p>
            
            <form action="CreateStaffAccount" method="post">
                <div class="field"><label>New Staff ID: </label><br>
                    <input style="background-color: lightsteelblue" type="text" name="staffID" maxlength="7" value="<%=newStaffID %>" readonly>
               
                </div>
                
                 <div class="field"><label>New Staff UserName: </label><br>
                     <input type="text" name="staffUserName" maxlength="50">
                 </div>

                    <div class="field"> <Label>Staff Email:</label><br>
                        <input type="text" name="email" maxlength="50">
                        <% Map<String,String> errors = (Map<String,String>) request.getAttribute("errors");
                        if(errors != null){%>
                            
                        <p class="errorMessage"> <%= errors.get("emailFormatError") %></p>
                        
                       <% }%>
                        
                    </div>

                <div class="field"> <label>Create Password: </label><br>
                    <input type="text" name="pwd" id="pwd" maxlength="20">
                    
                    
                    <%                         
                        if(errors != null){%>
                            
                        <p class="errorMessage"> <%= errors.get("pwdFormatError") %></p>
                        
                       <% }%>
                </div>
                 
                <div class="field"><label>Confirm Password: </label><br>
                    <input type="text" name="pwdConfirm" id="pwdConfirm" maxlength="20">
               
                </div>
                
              
                
                
                <div>
                <input type="submit" name="submit" value="Submit">
               <%
               Boolean addSuccessful = (Boolean) request.getAttribute("addSuccessful");
               if(addSuccessful != null && addSuccessful){
               %>
               
               <p class="updateStatus">Account added Sucessful <a href="staffList.jsp">View Your List here</a></p>
               
               <%}else if(addSuccessful != null && addSuccessful == false){%>
               <p class="updateStatus">Account not added Sucessful</p>
               <%}else if(addSuccessful == null){%>
               <p></p>
               <%}%>
               
                </div>
            </form>
            
            
        </div>
<jsp:include page="staffFooter.jsp" />
</html>
