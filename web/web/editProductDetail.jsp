<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="dbConnection" scope="session" class="Entity.DBConnection"></jsp:useBean>
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
                        
                        System.out.print("Here 1");
                        
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
                        System.out.print("Here 2");
                        double averageDecPoint = averageRating % 1;
                    %>
                    <form action="DeleteProduct" method="POST" style="margin: -100px 0 0 0;">
                        <div class="btn border border-secondary rounded-pill text-primary" onclick="document.getElementById('deleteDiv').style.display='block'">Delete Product</div>
                        <div style="margin-top: 20px; display: none;" id="deleteDiv">
                            <input type="hidden" value="<%= request.getParameter("productID")%>" name="productID">
                            <h6 style="color: red;">Are you sure want to delete this product?</h6>
                            <button type="submit" class="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-primary">Yes</button>
                            <div class="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-primary" style="margin-left: 30px;" onclick="document.getElementById('deleteDiv').style.display='none'">No</div>
                        </div>
                    </form>
                    
                    <div style="margin-top: -10px;">
                        <form action="updateProduct" method="POST">
                        <div class="row g-4">
                                <div class="col-lg-3">
                                    <div class="border rounded">
                                        <img src="<%= String.valueOf(data[4]) %>" class="img-fluid rounded" id="mainImage" alt="Image">
                                    </div>
                                </div>
                                <div class="col-lg-7">
                                    <div class="editClass" style="display: flex;">
                                        <h5 class="fw-bold">Product Name :</h5>
                                        <input type="text" class="form-control" value="<%= String.valueOf(data[1]) %>" name="productName">
                                    </div>

                                    <div class="editClass" style="display: flex;">
                                        <h5 class="fw-bold">Product Description :</h5>
                                        <input type="text" class="form-control" value="<%= String.valueOf(data[3]) %>" name="productDecs">
                                    </div>

                                    <div class="editClass" style="display: flex;">
                                        <h5 class="fw-bold">Product Price (RM)  :</h5>
                                        <input type="text" class="form-control" value="<%= String.valueOf(data[2]) %>" name="productPrice">
                                    </div>
                                    
                                    <div class="editClass" style="display: flex;">
                                        <h5 class="fw-bold">Room Category :</h5>
                                        <select name="roomName" class="form-control" style="margin-left:50px;">
                                            <% 
                                                tableName = "ROOMCATEGORY";
                                                ArrayList<Object[]> roomRows = dbConnection.getRows(tableName);
                                                for(int i = 0; i < roomRows.size();i++){
                                            %>
                                            <option name="roomName"><%= String.valueOf(roomRows.get(i)[1])%></option>
                                            <% } %>
                                        </select>
                                    </div>

                                    <div class="editClass">
                                        <h5 class="fw-bold">Product Long Description : </h5>
                                        <textarea type="text"  class="form-control" cols="30" rows="8" name="productLongDesc"><%= String.valueOf(data[5]) %></textarea>
                                    </div>
                                    <input type="hidden" value="<%= String.valueOf(data[4]) %>" name="productImg">
                                    <input type="hidden" value="<%= request.getParameter("productID")%>" name="productID">
                                    <button type="submit" class="btn border border-secondary rounded-pill px-4 py-2 mb-4 text-primary editFormBtn">Edit</button>
                                </div>
                            
                        </div>
                        </form>
                    </div>
                </div>

            </div>
        </div>
<jsp:include page="staffFooter.jsp" />
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
       
</html>