<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="dbConnection" scope="session" class="Entity.DBConnection"></jsp:useBean>
<% dbConnection.initializeJdbc(); %>
<!DOCTYPE html>
<html lang="en">
<%
            String header = (String) session.getAttribute("header");
            if (header != null) {%>
                <jsp:include page="<%= header %>" />
         <% }%>

    <body>
        <!-- Single Page Header start -->
        <div class="container-fluid page-header py-5">
            <h1 class="text-center text-white display-6">Shop Detail</h1>
            <ol class="breadcrumb justify-content-center mb-0">
                <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                <li class="breadcrumb-item"><a href="shop.html">Shop</a></li>
                <li class="breadcrumb-item active text-white">Shop Detail</li>
            </ol>
        </div>
        <!-- Single Page Header End -->
        
        <!-- Single Product Start -->
        <div class="container-fluid py-5 mt-5">
            <div class="container py-5">
                <div class="row g-4 mb-5">       
                    <%@page import="java.util.*;" %>
            <%
                String id = request.getParameter("id");
                String tableName = "ROOMCATEGORY";
                String tableName2 = "PRODUCT";
                String joinVariable = "ROOMID";
                ArrayList<Object[]> joinRows = dbConnection.joinTable(tableName, tableName2,joinVariable);
                Object[] data = null;
                for (int i = 0; i < joinRows.size(); ++i) {
                    if(joinRows.get(i)[0].equals(id)){
                            data = joinRows.get(i);
                            break;
                    }
                }
                
            %>                   
                        <div class="row g-4">
                            <div class="col-lg-12">
                                <div class="border rounded">
                                    <img src="<%= String.valueOf(data[3])%>" class="img-fluid rounded  shop-detail-img" alt="Image">
                                </div>
                                <div style="margin-top: 20px;">
                                    <h2><%= String.valueOf(data[1])%></h2>
                                </div>
                                <div style="margin-top: 20px;">
                                    <h5>Category : <%= String.valueOf(data[2])%></h5>
                                </div>
                            </div>
                            
                            <h3 class="fw-bold mb-0" style="margin-top: 80px;">Related products</h3>
                            <div class="vesitable">
                                    <div class="owl-carousel vegetable-carousel justify-content-center">
                                    <%
                                    for (int i = 0; i < joinRows.size(); ++i) {
                                        if(joinRows.get(i)[0].equals(id)){
                                                Object[] joinData = joinRows.get(i);
                                    %>
                                        <div class="border border-primary rounded position-relative vesitable-item" >
                                            <div class="vesitable-img">
                                                <img src="<%= String.valueOf(joinData[8])%>" class="img-fluid w-100 rounded-top" alt="">
                                            </div>
                                            <div class="p-4 pb-0 rounded-bottom" style="height: 150px;">
                                                <h5 style="height: 55%;"><%= String.valueOf(joinData[5])%></h5>
                                                <div class="d-flex justify-content-between flex-lg-wrap">
                                                    <p class="text-dark fs-5 fw-bold">RM<small><%= String.valueOf(joinData[6])%></small></p>
                                                    <a href="product-detail.jsp?roomID=<%= String.valueOf(joinData[0])%>&productID=<%= String.valueOf(joinData[4])%>" class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i class="bi bi-zoom-in me-2 text-primary"></i> View Details</a>
                                                </div>
                                            </div>
                                        </div>
                                    <% }} %>
                                    </div>
                            </div>
                        </div>                   
                </div>

            </div>
        </div>
        <!-- Single Product End -->
<%
            String footer = (String) session.getAttribute("footer");
            if (footer != null) {%>
                <jsp:include page="<%= footer %>" />
         <% }%>
    </body>

</html>