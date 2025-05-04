<%@page contentType="text/html" pageEncoding="UTF-8" import="java.sql.*, Entity.*, java.util.ArrayList,java.util.List"%>

<!DOCTYPE html>
    <body>
<%
            String header = (String) session.getAttribute("header");
            if (header != null) {%>
                <jsp:include page="<%= header %>" />
         <% }%>

<div class="container-fluid page-header py-5">
        </div>

        <!-- Single Page Header start -->
        <form action="SalesRecordSearch" method="post">
            <legend>Search By:</legend>
            <label>Year:</label>
            
            <select id="year" name="year" onchange="document.getElementById('monthSection').style.display = this.value ? 'block' : 'none';">
    <option value="">--Select Year--</option>
    <option value="2023">2023</option>
    <option value="2024">2024</option>
    <option value="2025">2025</option>
</select>
            <div id="monthSection" style="display:none;" >
                
                 <label>Month:</label>
                 <select id="month" name="month" onchange="document.getElementById('daySection').style.display = this.value ? 'block' : 'none';">
                      <option value="" >--Select Month--</option>
                <option value="01">January</option>
                <option value="02">February</option>
                <option value="03">March</option>
                <option value="04">April</option>
                <option value="05">May</option>
                <option value="06">June</option>
                <option value="07">July</option>
                <option value="08">August</option>
                <option value="09">September</option>
                <option value="10">October</option>
                <option value="11">November</option>
                <option value="12">December</option>
                 </select>
               
            </div>
            
            <div id="daySection" style="display:none;" >
                
                <label>Day:</label>
                <select id="day" name="day">
                    <option value="" onchange="document.getElementById('daySection').style.display = this.value ? 'block' : 'none';">--Select Day--</option>
                <option value="01">1</option>
                <option value="02">2</option>
                <option value="03">3</option>
                <option value="04">4</option>
                <option value="05">5</option>
                <option value="06">6</option>
                <option value="07">7</option>
                <option value="08">8</option>
                <option value="09">9</option>
                <option value="10">10</option>
                <option value="11">11</option>
                <option value="12">12</option>
                <option value="13">13</option>
                <option value="14">14</option>
                <option value="15">15</option>
                <option value="16">16</option>
                <option value="17">17</option>
                <option value="18">18</option>
                <option value="19">19</option>
                <option value="20">20</option>
                <option value="21">21</option>
                <option value="22">22</option>
                <option value="23">23</option>
                <option value="24">24</option>
                <option value="25">25</option>
                <option value="26">26</option>
                <option value="27">27</option>
                <option value="28">28</option>
                <option value="29">29</option>
                <option value="30">30</option>
                <option value="31">31</option>

                </select>
                
            </div>
            <br>
            <input type="submit" value="Search"> 
        </form>
        
        <div>
            <table>
                <tr> 
                <th>Index</th>
                <th>Product ID</th>
                <th>Product Name</th>
                <th>Sold unit(s)</th>
                <th>Unit price</th>
                <th>D/T Created</th>
                
                <th>subtotal</th>
                </tr>
               <%
    SalesRecord[] salesRecord = (SalesRecord[]) request.getAttribute("salesRecord");
    double total = 0;
    if (salesRecord != null && salesRecord.length > 0) {
    int index =1;
        for (SalesRecord r : salesRecord) {
            double subtotal = r.getUnitPrice() * r.getSoldUnits();
            
            total += subtotal;
%>
<tr>
    <td><%= index %></td>
    <td><%= r.getProductId() %></td>
    <td><%= r.getProductName() %></td>
    <td><%= r.getSoldUnits() %></td>
    <td><%= r.getUnitPrice() %></td>
    <td><%= r.getDate().substring(0,19) %></td>
    <td><%= subtotal %></td>
</tr>
<%
    index++;
        }
%>
<tr>
    <td colspan="6" style="text-align:right;"><strong>Total:</strong></td>
    <td><strong><%= total %></strong></td>
</tr>
<%
    } else {
%>
<tr>
    <td colspan="7">No Record Found</td>
</tr>
<%
    }
%>
                
            </table>
            
        </div>


<div>
    <h1>Top 10 Sales Product</h1>
    <table>
        <tr>
            <th>Rank</th><th>Product ID</th><th>Product Name</th><th>Sold Units</th>
        </tr>
        <%
        SalesRecord[] topTen = (SalesRecord[]) request.getAttribute("topTen");
        if(topTen != null && topTen.length>0){ 
        int rank = 1;
        for(SalesRecord r: topTen){
        
        %>
            <tr> 
            <td><%= rank %></td>
            <td><%= r.getProductId() %></td>
            <td><%= r.getProductName() %></td>
            <td> <%= r.getSoldUnits() %> </td>
            </tr>     
        <%  rank++; } }else{ %>

        <tr><td colspan="4">start by picking a date<td>></tr>\
 <% } %>
         
        
    </table>
    
</div>
<jsp:include page="staffFooter.jsp" />
    </body>

</html>
