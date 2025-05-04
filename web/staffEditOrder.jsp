<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*, Entity.DBConnection, Entity.Staff, Entity.*, java.util.ArrayList,java.util.List"%>
<html>
        <%
            String header = (String) session.getAttribute("header");
            if (header != null) {%>
                <jsp:include page="<%= header %>"/>
         <% }%>
         <head>
<style>
             form{
                width:80%;
                 margin-left: auto;
                margin-right: auto;
                margin-top: 20px;
            }
            
            table{
                width:80%;
                border: collapse;
                margin-left: auto;
                margin-right: auto;
                margin-top: 20px;
                
            }
            
            th{
                
                background-color: green;
                padding-left: 8px;
                text-align: left;
                color: black;
            }
            .data{
                
                border: 1px solid black;
                padding: 8px;
                text-align: left;
                
            }
            
     
        </style>
         </head>
         
    <body>
        <% 
            HttpSession sessions = request.getSession(false);
         Staff staff = new Staff();
         staff = (Staff) session.getAttribute("staff");
         request.setAttribute("staffID", staff.getStaffid());
        %>

        <!-- Single Page Header start -->
        <div class="container-fluid page-header py-5">
            <h1 class="text-center text-white display-6">Welcome, <%= staff.getStaffname() %></h1>
            <ol class="breadcrumb justify-content-center mb-0">
                <li class="breadcrumb-item">Edit Order Status</li>
               
               
            </ol>
        </div>
        <!-- Single Page Header End -->
<%
    DBConnection db = new DBConnection();
    db.initializeJdbc();
    Connection conn = db.getConnection();

    String displayAllOrderSql = "SELECT * FROM ORDERS";
    ResultSet rs = null;
    boolean hasRecord = false;

    try {
        PreparedStatement stmt = conn.prepareStatement(displayAllOrderSql);
%>

<form action="EditOrderSearch" method="GET">
    <label>Search By ID: </label>
    <input type="text" name="searchByID" placeholder="ORD000000000">
    <input type="submit" name="Search" value="Search">
</form>

<div class="allOrder">
    <form id="statusForm" action="StaffEditOrder" method="post">
        <table>
            <tr>
                <th>ORDER ID</th>
                <th>CART ID</th>
                <th>CUSTOMER ID</th>
                <th>TAX</th>
                <th>DISCOUNT</th>
                <th>SHIPPING ID</th>
                <th>TOTAL</th>
                <th>ADDRESS</th>
                <th>PAYMENT METHOD</th>
                <th>STATUS</th>
                <th>CREATED AT</th>
            </tr>

            <%
                Boolean searched = (Boolean) request.getAttribute("searched");
                if (searched == null) searched = false;

                rs = stmt.executeQuery();
                Order order = (Order) request.getAttribute("order");

                if (order != null) {
            %>
                    <tr>
                        <td class="data"><%= order.getOrderId() %></td>
                        <td class="data"><%= order.getCart().getCartID() %></td>
                        <td class="data"><%= order.getCustomerId() %></td>
                        <td class="data"><%= order.getTax() %></td>
                        <td class="data"><%= order.getDiscountAmt() %></td>
                        <td class="data"><%= order.getShipping().getShippingId() %></td>
                        <td class="data"><%= order.getTotal() %></td>
                        <td class="data"><%= order.getShippingAddress().getAddressId()%></td>
                        <td class="data"><%= order.getPaymentMethodId() %></td>
                        <td class="data"> 
                            <select name="status" id="status" onchange="document.getElementById('statusForm').submit();">
                            <option value="PACKAGING" <%= "PACKAGING".equals(order.getStatus())? "selected": "" %>>PACKAGING</option>
                            <option value="SHIPPED" <%= "SHIPPED".equals(order.getStatus())? "selected": "" %> >SHIPPED</option>
                            <option value="DELIVERING" <%= "DELIVERING".equals(order.getStatus())? "selected": ""  %> >DELIVERING</option>
                            <option value="DELIVERED" <%= "DELIVERED".equals(order.getStatus())? "selected": ""  %> >DELIVERED</option>
                     
                          </select>
                            <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                        </td>
                        <td class="data"><%= order.getTimestamp()%></td>
                    </tr>
            <%
                } else if (searched && order == null) {
            %>
                    <tr>
                        <td colspan="11" style="text-align: center;">No record found</td>
                    </tr>
            <%
                } else {
                   while (rs.next()) {
                        hasRecord = true;
            %>
                        <tr>
                            <form action="StaffEditOrder" method="post">
        <td class="data"><%= rs.getString("ORDERID") %></td>
        <td class="data"><%= rs.getString("CARTID") %></td>
        <td class="data"><%= rs.getString("CUSTOMERID") %></td>
        <td class="data"><%= rs.getDouble("TAX") %></td>
        <td class="data"><%= rs.getDouble("DISCOUNTAMT") %></td>
        <td class="data"><%= rs.getString("SHIPPINGID") %></td>
        <td class="data"><%= rs.getDouble("TOTAL") %></td>
        <td class="data"><%= rs.getString("ADDRESSID") %></td>
        <td class="data"><%= rs.getString("METHODID") %></td>
        <td class="data">
            <select name="status" onchange="this.form.submit();">
                <option value="PACKAGING" <%= "PACKAGING".equals(rs.getString("STATUS")) ? "selected" : "" %>>PACKAGING</option>
                <option value="SHIPPED" <%= "SHIPPED".equals(rs.getString("STATUS")) ? "selected" : "" %>>SHIPPED</option>
                <option value="DELIVERING" <%= "DELIVERING".equals(rs.getString("STATUS")) ? "selected" : "" %>>DELIVERING</option>
                <option value="DELIVERED" <%= "DELIVERED".equals(rs.getString("STATUS")) ? "selected" : "" %>>DELIVERED</option>
            </select>
            <input type="hidden" name="orderId" value="<%= rs.getString("ORDERID") %>">
        </td>
        <td class="data"><%= rs.getTimestamp("CREATED_AT") %></td>
    </form>
                        </tr>
            <%
                    }

                    if (!hasRecord) {
            %>
                        <tr>
                            <td colspan="11" style="text-align: center;">No record exists <a href="admCreateStaff.jsp">Go to Create Account?</a></td>
                        </tr>
            <%
                    }
                }
            %>
        </table>
    </form>
</div>

<%
    } catch (SQLException ex) {
        ex.printStackTrace();
    } finally {
        try { if (rs != null) rs.close(); } catch (SQLException e) {}
        try { if (conn != null) conn.close(); } catch (SQLException e) {}
    }
%>

            
<jsp:include page="staffFooter.jsp" />
    </body>
</html>
