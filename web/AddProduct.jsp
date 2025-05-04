<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="dbConnection" scope="session" class="Entity.DBConnection"></jsp:useBean>
<% dbConnection.initializeJdbc(); %>
<!DOCTYPE html>
<html>
    
    <body>
        <%
            String header = (String) session.getAttribute("header");
            if (header != null) {%>
                <jsp:include page="<%= header %>" />
         <% }%>
         
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
        
        <div class="container-fluid py-5 mt-5">
            <div class="container py-5">
                <div class="row g-4 mb-5">
                    
                    <h1>Add Product</h1>
                    <% if(request.getAttribute("errorMessage") != null){
                    %>
                    <p style="color: red;"><%= request.getAttribute("errorMessage") %></p>
                     <% }%>
                    
                    <form action="AddProduct" method="POST" enctype="multipart/form-data">
                        <div class="row g-4" style="display: flex">
                                <div class="col-lg-3" style="border: 1px solid black">
                                    <div>
                                        <h5 class="fw-bold">Product Image :</h5>
                                        <input type="file" id="file" name="imageFile">
                                    </div>
                                    <div class="border rounded" style="margin-top: 20px;">
                                        <img src="<%= request.getAttribute("file") %>" class="img-fluid rounded" style="width: 100%;max-width: 100%" id="mainImage" alt="Image">
                                    </div>
                                </div>
                            
                                <div class="col-lg-7">
                                    <div class="editClass" style="display: flex;">
                                        <h5 class="fw-bold">Product Name :</h5>
                                        <input type="text" class="form-control" name="productName">
                                    </div>

                                    <div class="editClass" style="display: flex;">
                                        <h5 class="fw-bold">Product Description :</h5>
                                        <input type="text" class="form-control" name="productDecs">
                                    </div>

                                    <div class="editClass" style="display: flex;">
                                        <h5 class="fw-bold">Product Price (RM)  :</h5>
                                        <input type="text" class="form-control" name="productPrice">
                                    </div>
                                    
                                    <div class="editClass" style="display: flex;">
                                        <h5 class="fw-bold">Room Category :</h5>
                                        <select name="roomName" class="form-control" style="margin-left:50px;">
                                            <%@ page import="java.util.*;"%>
                                            <% 
                                                String tableName = "ROOMCATEGORY";
                                                ArrayList<Object[]> roomRows = dbConnection.getRows(tableName);
                                                for(int i = 0; i < roomRows.size();i++){
                                            %>
                                            <option name="roomName"><%= String.valueOf(roomRows.get(i)[1])%></option>
                                            <% } %>
                                        </select>
                                    </div>                                    

                                    <div class="editClass">
                                        <h5 class="fw-bold">Product Long Description : </h5>
                                        <textarea type="text" class="form-control" cols="30" rows="8" name="productLongDesc"></textarea>
                                    </div>
                                    <input type="hidden" value="" name="roomID">
                                    <input type="hidden" value="" name="productID">
                                    <button type="submit" class="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-primary editFormBtn">Add</button>
                                </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
                                            
<%
            String footer = (String) session.getAttribute("footer");
            if (footer != null) {%>
                <jsp:include page="<%= footer %>" />
         <% }%>
    </body>
    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i class="fa fa-arrow-up"></i></a>   

        
    <!-- JavaScript Libraries -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>
    <script src="lib/waypoints/waypoints.min.js"></script>
    <script src="lib/lightbox/js/lightbox.min.js"></script>
    <script src="lib/owlcarousel/owl.carousel.min.js"></script>

    <!-- Template Javascript -->
    <script src="js/main.js"></script>
</html>
