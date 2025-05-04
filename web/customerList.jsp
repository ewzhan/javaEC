<%@page import="java.util.*,Entity.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="dbConnection" scope="session" class="Entity.DBConnection"></jsp:useBean>
<% dbConnection.initializeJdbc(); %>
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
            
            <div style="max-height: 70vh; overflow-y: auto; overflow-x: auto;">
            <table style="width: 100%; border-collapse: collapse; border: 1px solid #ddd;">
                <thead>
                    <tr>
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
                        String tableName = "CUSTOMER";
                        ArrayList<Object[]> customerData = dbConnection.getRows(tableName);
                        
                        for(int i = 0 ; i < customerData.size(); i++){
                            Object[] customer = customerData.get(i);
                    %>
                    <tr>
                        <td style="padding: 8px; border: 1px solid #ddd;"><%= String.valueOf(customer[0])%></td>
                        <td style="padding: 8px; border: 1px solid #ddd;"><%= String.valueOf(customer[1]) %></td>
                        <td style="padding: 8px; border: 1px solid #ddd;"><%= String.valueOf(customer[5]) %></td>
                        <td style="padding: 8px; border: 1px solid #ddd;"><%= String.valueOf(customer[3]) %></td>
                        <td style="padding: 8px; border: 1px solid #ddd;"><%= String.valueOf(customer[2])%></td>
                        <td style="padding: 8px; border: 1px solid #ddd;"><%= String.valueOf(customer[4])%></td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
</div>
    </div>
<jsp:include page="staffFooter.jsp" />
</body>
</html>