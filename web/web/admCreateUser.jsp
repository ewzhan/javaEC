<%@page import="java.util.*,Entity.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
    <body>
        <%
            String header = (String) session.getAttribute("header");
            if (header != null) {%>
                <jsp:include page="<%= header %>" />
         <% }%>
         
         
         <div style="display:flex;">
            <div style="border: 1px solid; border-radius: 20px; margin: 25vh auto; height: 90vh; min-width: 1000px; padding: 2em; overflow: hidden;">
    <h2>Customer Information</h2>
        <form action="admCreateUser" method="post" >       
            <div style="max-height: 70vh; overflow-y: auto; overflow-x: auto;">
            <table style="width: 100%; border-collapse: collapse; border: 1px solid #ddd;">
                <thead>
                    <tr>
                        <th style="padding: 8px; border: 1px solid #ddd;">Select</th>
                        <th style="padding: 8px; border: 1px solid #ddd;">Customer ID</th>
                        <th style="padding: 8px; border: 1px solid #ddd;">Name</th>
                        <th style="padding: 8px; border: 1px solid #ddd;">Email</th>
                        <th style="padding: 8px; border: 1px solid #ddd;">Phone Number</th>
                        <th style="padding: 8px; border: 1px solid #ddd;">IC Number</th>
                        <th style="padding: 8px; border: 1px solid #ddd;">Home Address</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Customer> customers = (List<Customer>) session.getAttribute("customers");
                        for (Customer customer : customers) {
                    %>
                    <tr>
                        <td style="padding: 8px; border: 1px solid #ddd; text-align: center;">
                            <input type="radio" name="selectedCustomer" value="<%= customer.getCustomerid() %>">
                        </td>
                        <td style="padding: 8px; border: 1px solid #ddd;"><%= customer.getCustomerid() %></td>
                        <td style="padding: 8px; border: 1px solid #ddd;"><%= customer.getCustomername()!=null?customer.getCustomername():"" %></td>
                        <td style="padding: 8px; border: 1px solid #ddd;"><%= customer.getEmail() %></td>
                        <td style="padding: 8px; border: 1px solid #ddd;"><%= customer.getPhoneno()!=null?customer.getPhoneno():"" %></td>
                        <td style="padding: 8px; border: 1px solid #ddd;"><%= customer.getIc()!=null?customer.getIc():"" %></td>
                        <td style="padding: 8px; border: 1px solid #ddd;"><%= customer.getHomeaddress()!=null?customer.getHomeaddress():"" %></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
</div>

         <div style="border:1px solid;border-radius: 20px;margin: 25vh auto;height: 100vh;max-width: 400px;padding:2em;">
            
                               <p class="errorMessage" style="color:red;"><%= request.getAttribute("errorMessage") != null ? request.getAttribute("errorMessage") : "" %><p>

                <div class="field"><label> Customer ID: </label>
                   <br> <input  type="text" name="customerID" maxlength="7" value="" readonly>
               
                </div>
                    
                    <div class="field"><label>Customer Username: </label>
                    <br><input  type="text" name="customerName" maxlength="50" value="" >
               
                 
               <p class="errorMessage"><p>
              
                    
                </div>
                    
                    <div class="field"><label>Customer IC: </label>
                    <br><input  type="text" name="customerIc" maxlength="12" value="">
                  
               
                </div>
                    
                    <div class="field"><label>Customer Phone No: </label>
                    <br><input  type="text" name="phoneNo" maxlength="13" value="" >
             
                   
               <p class="errorMessage"><p>
                    
                </div>
                    
                    <div class="field"><label>Customer Home Address: </label>
                   <br> <input  type="text" name="homeAddress" maxlength="100" value="" >
               
                  
               <p class="errorMessage"><p>
               
                   
                </div>
                    
                    <div class="field"><label>Customer Email: </label>
                    <br><input  type="text" name="email" maxlength="50" value="" >
               
               <p class="errorMessage"><p>
               
                </div>
                   
                    <div class="field"><label>Customer Password: </label>
                    <br><input  type="text" name="password" maxlength="20" value="" >
                
               <p class="errorMessage"><p>
              
                </div>
                    
                      <div>
                <button type="submit" name="action" value="create">Create</button>
                <button type="submit" name="action" value="update">Update</button>
                <button type="submit" name="action" value="delete">Delete</button>
               
                </div>
              
               
               <p class="updateStatus" ><%= request.getAttribute("message")!=null?request.getAttribute("message"):""%></p>
               
              
              
            </form>
             </div>
               
    </div>
<jsp:include page="staffFooter.jsp" />
</body>
</html>