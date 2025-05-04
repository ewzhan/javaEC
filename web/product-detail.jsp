<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="dbConnection" scope="session" class="Entity.DBConnection"></jsp:useBean>
<jsp:useBean id="customer" scope="session" class="Entity.Customer"/>
<% dbConnection.initializeJdbc(); %>
<!DOCTYPE html>
<html>
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
                <li class="breadcrumb-item"><a href="shop.jsp">Shop</a></li>
                <li class="breadcrumb-item"><a href="shop-detail.jsp">Shop Detail</a></li>
                <li class="breadcrumb-item active text-white">Product Detail</li>
            </ol>
        </div>
        <!-- Single Page Header End -->
        
        <!-- Single Product Start -->
        <div class="container-fluid py-5 mt-5">
            <div class="container py-5">
                <div class="row g-4 mb-5">
                    <%@page import="java.util.*;"%>
                    <% 
                        String productID = request.getParameter("productID");
                        String tableName = "PRODUCT";
                        ArrayList<Object[]> tableRows = dbConnection.getRows(tableName);
                        Object[] data = null;
                        for(int i = 0 ; i < tableRows.size(); i++){
                            if(tableRows.get(i)[0].equals(productID)){
                                data = tableRows.get(i);
                                break;
                            }
                        }
                        
                        tableName = "RATING";
                        ArrayList<Object[]> ratingRows = dbConnection.getRows(tableName);
                        double totalRating = 0;
                        int ratingNumber = 0;
                        for(int j = 0; j < ratingRows.size(); j++){
                            if(ratingRows.get(j)[4].equals(productID)){
                                totalRating += Integer.parseInt(ratingRows.get(j)[1].toString());
                                ratingNumber++;
                            }
                        }
                        double averageRating = 0;
                        if(ratingNumber != 0){
                            averageRating = totalRating / ratingNumber;
                        }
                        double averageDecPoint = averageRating % 1;
                    %>
                    
                    <div>
                        <div class="row g-4">
                            <div class="col-lg-5">
                                <div class="border rounded">
                                    <img src="<%= String.valueOf(data[4]) %>" class="img-fluid rounded" id="mainImage" alt="Image">
                                </div>
                            </div>
                            <div class="col-lg-7">
                                <h2 class="fw-bold"><%= String.valueOf(data[1]) %></h2>
                                <p class="mb-3"><%= String.valueOf(data[3]) %></p>
                                <h5 class="fw-bold mb-4">RM<%= String.valueOf(data[2]) %></h5>
                                <h2><%= String.format("%.2f",averageRating)%></h2>
                                <div class="d-flex">
                                    <%
                                        if(ratingNumber == 0){
                                            out.println("<p class='mb-4'>There is no rating yet!</p>");
                                        }else{
                                        
                                            //int ratingNum = Integer.parseInt(rating[1].toString());
                                            double badRating = 5 - averageRating - averageDecPoint;
                                            
                                            for(int i = 0; i < (averageRating-averageDecPoint) ; i++){
                                                out.print("<i class='bi bi-star-fill text-secondary'></i>");
                                            }
                                            if(averageDecPoint != 0){
                                                out.print("<i class='bi bi-star-half text-secondary'></i>");
                                            }
                                            for(int i = 0; i < badRating ; i++){
                                                out.print("<i class='bi bi-star text-secondary'></i>");
                                            }
                                        }
                                    %>
                                    <p class="mb-4">&nbsp;&nbsp;(<%= ratingNumber%>)</p>
                                </div>
                                <h6 class="mb-5" style="margin-top: -10px;">Average Rating</h6>
                                <p class="mb-4"><%= String.valueOf(data[5]) %></p>
                                <div class="input-group quantity mb-5" style="width: 100px;">
                                    <div class="input-group-btn">
                                        <button class="btn btn-sm btn-minus rounded-circle bg-light border" >
                                            <i class="fa fa-minus"></i>
                                        </button>
                                    </div>
                                    <input type="number" class="form-control form-control-sm text-center border-0" id="quantity" value="1">
                                    <div class="input-group-btn">
                                        <button class="btn btn-sm btn-plus rounded-circle bg-light border">
                                            <i class="fa fa-plus"></i>
                                        </button>
                                    </div>
                                </div>
                                <form action="AddToCart" method="post">
                                <input type="hidden" name="productID" value="<%= request.getParameter("productID")%>">
                                <input type="hidden" name="roomID" value="<%= request.getParameter("roomID")%>">
                                <input type="hidden" name="quantity" value="1">
                                <button type="submit" class="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-primary"><i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
               
                <div class="col-lg-12" style="margin-top: 100px;">
                    <h4 class="fw-bold" style="padding-bottom:30px;margin-bottom: -30px;border-bottom: gray 1px solid;">Customer Reviews</h4>
                    <div style="margin-top: 30px;">
                        <%
                            tableName = "RATING";
                            String tableName2 = "CUSTOMER";
                            String joinVariable = "CUSTOMERID";
                            ArrayList<Object[]> joinRows = dbConnection.joinTable(tableName, tableName2,joinVariable);
                            
                            Object[] ratingData = null;
                            int totalReview = 0;
                            for(int j = 0; j < joinRows.size(); j++){
                            if(joinRows.get(j)[4].equals(productID)){
                                totalReview++;
                                ratingData = joinRows.get(j);
                         %>
                         
                        <div class="d-flex" style="padding: 20px 5px;border-bottom: gray 1px solid;">
                            <img src="<% if(ratingData[13] == null){out.print("img/avatar.jpg");}else{out.print(ratingData[13]);}%>" class="img-fluid rounded-circle p-3" style="width: 100px; height: 100px;" alt="">
                            <div style="width:100%;">
                                
                                <div class="justify-content-between">
                                    <div class="d-flex" style="width: 100%;">
                                        <h4 style="width: 90%;"><%= String.valueOf(ratingData[7])%></h4>
                                        <h6 class="mb-2" style="font-size: 18px; right: 0"><%= String.valueOf(ratingData[3])%></h6>
                                    </div>
                                    <div class="d-flex mb-3">
                                        <%
                                            int ratingNum = Integer.parseInt(ratingData[1].toString());
                                            for(int i = 0; i < ratingNum; i++){
                                                out.print("<i class='bi bi-star-fill text-secondary'></i>");
                                            }
                                            for(int i = 0; i < (5 - ratingNum) ; i++){
                                                out.print("<i class='bi bi-star text-secondary'></i>");
                                            }
                                        %>
                                        
                                    </div>
                                    <p><%= String.valueOf(ratingData[2])%></p>
                                </div>
                                <% 
                                    String getReplyDataTableName = "RATING";
                                    String getReplyDataTableName2 = "REPLY";
                                    String getReplyDataTableName3 = "STAFF";
                                    String replyJoinVariable = "RATINGID";
                                    String replyJoinVariable2 = "STAFFID";
                                    ArrayList<Object[]> replyData = dbConnection.joinThreeTable(getReplyDataTableName, getReplyDataTableName2,getReplyDataTableName3,replyJoinVariable,replyJoinVariable2);
                                    
                                    for(int i = 0 ; i < replyData.size() ; i++){
                                        if(replyData.get(i)[0].equals(ratingData[0])){
                                        
                                %>
                                <div style="display:flex;width: 100%;">
                                    <i class="bi bi-arrow-return-right" style="font-size: 30px;width:3%;"></i>
                                    <div style="width: 100%;margin-left: 10px;" class="form-control">
                                        <p class="form-control" style="border:none;margin-top: 5px;font-size: 18px;"><%= String.valueOf(replyData.get(i)[7])%></p>
                                        <div class="d-flex" style="margin-left: 5px; margin-bottom: -2px;width: 100%;">
                                            <p style="width: 90%;">Reply By: <%= String.valueOf(replyData.get(i)[12])%></p>
                                            <p style="width: 10%;"><%= String.valueOf(replyData.get(i)[8])%></p>
                                        </div>
                                    </div>
                                </div>
                                <% }} %>
                            </div>
                        </div>
                    <% }}
                        if(totalReview == 0){
                    %>
                    <h5 style="margin-top:50px;">Don't have any review yet!</h5>
                    <%}%>
                </div>
                </div>
            <h4 class="fw-bold mb-0" style="margin-top: 100px;">Related products</h4>
            
            <%
                String id = request.getParameter("roomID");
                tableName = "ROOMCATEGORY";
                tableName2 = "PRODUCT";
                joinVariable = "ROOMID";
                ArrayList<Object[]> joinRowsProduct = dbConnection.joinTable(tableName, tableName2,joinVariable);
                Object[] productData = null;
            %>  
           
            
            <div class="vesitable">
                <div class="owl-carousel vegetable-carousel justify-content-center">
                <%
                    for (int i = 0; i < joinRowsProduct.size(); ++i) {
                    if(joinRowsProduct.get(i)[0].equals(id) && !joinRowsProduct.get(i)[4].equals(productID)){
                        productData = joinRowsProduct.get(i);
                %>
                    <div class="border border-primary rounded position-relative vesitable-item" >
                        <div class="vesitable-img">
                            <img src="<%= String.valueOf(productData[8])%>" class="img-fluid w-100 rounded-top" alt="">
                        </div>
                        <div class="p-4 pb-0 rounded-bottom" style="height: 150px;">
                            <h5 style="height: 55%;"><%= String.valueOf(productData[5])%></h5>
                            <div class="d-flex justify-content-between flex-lg-wrap">
                                <p class="text-dark fs-5 fw-bold">RM<small><%= String.valueOf(productData[6])%></small></p>
                                <a href="product-detail.jsp?roomID=<%= String.valueOf(productData[0])%>&productID=<%= String.valueOf(productData[4])%>" class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i class="bi bi-zoom-in me-2 text-primary"></i> View Details</a>
                            </div>
                        </div>
                    </div>
                <% }} %> 
                </div>
            </div>
                
            <form action="Rating" method="Post" id="ratingForm">
                <h4 class="mb-5 fw-bold">Leave a Reply</h4>
                <div style="color: red;font-size: 20px;">
                    
                <%
                    Object errorMessage = request.getAttribute("ratingError");
                    if(errorMessage != null)
                        out.print(errorMessage);
                %>     
                </div>
                <input type="hidden" value="product-detail.jsp?roomID=<%= id%>&productID=<%=productID%>" name="productURL">
                <input type="hidden" value="<%=productID%>" name="productID">
                <div class="row g-4">
                    <div class="col-lg-12">
                        <div class="border-bottom rounded my-4">
                            <textarea name="getReview" id="" class="form-control border-0" cols="30" rows="8" placeholder="Your Review *" spellcheck="false"></textarea>
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <div class="d-flex justify-content-between py-3 mb-5">
                            <div class="d-flex align-items-center">
                                <p class="mb-0 me-3">Please rate:</p>
                                <div class="rate">
                                    <input type="radio" id="star5" name="rate" value="5" />
                                    <label for="star5" title="text">5 stars</label>
                                    <input type="radio" id="star4" name="rate" value="4" />
                                    <label for="star4" title="text">4 stars</label>
                                    <input type="radio" id="star3" name="rate" value="3" />
                                    <label for="star3" title="text">3 stars</label>
                                    <input type="radio" id="star2" name="rate" value="2" />
                                    <label for="star2" title="text">2 stars</label>
                                    <input type="radio" id="star1" name="rate" value="1" />
                                    <label for="star1" title="text">1 star</label>
                                </div>
                            </div>
                            <input type="hidden" value="${customer.customerid}" name="customerID">
                            <input type="submit" class="btn border border-secondary text-primary rounded-pill px-4 py-3" value="Post Comment">
                        </div>
                    </div>
                </div>
            </form>
            
            </div>
        </div>
        <!-- Single Product End -->
        <script>
            const mainImage = document.getElementById('mainImage');
            const thumbnails = document.querySelectorAll('.thumbnails img');

            thumbnails.forEach(thumb => {
                thumb.addEventListener('mouseenter', () => {
                    mainImage.src = thumb.dataset.img;
                });
            });
            
            const quantity = document.getElementById("quantity");
            quantity.addEventListener('input', () => {
                if (quantity.value === '') {
                  quantity.value = quantity.min || 0;
                }
            });

            quantity.addEventListener('input', () => {
              if (quantity.value.length > 1) {
                quantity.value = quantity.value.replace(/^0+/, '');
              }
            });   
            
       </script>
<%
            String footer = (String) session.getAttribute("footer");
            if (footer != null) {%>
                <jsp:include page="<%= footer %>" />
         <% }%>
</html>