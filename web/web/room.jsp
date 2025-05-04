<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="dbConnection" scope="session" class="Entity.DBConnection"></jsp:useBean>
<%@page import="java.util.*,Entity.*"%>
<% dbConnection.initializeJdbc(); %>
<!DOCTYPE>
    <html>
       <%
            String header = (String) session.getAttribute("header");
            if (header != null) {%>
                <jsp:include page="<%= header %>"/>
         <% }%>
        
        <body>

        <div class="container-fluid page-header py-5">
            <h1 class="text-center text-white display-6">Shop</h1>
            <ol class="breadcrumb justify-content-center mb-0">
                <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                <li class="breadcrumb-item active text-white">Shop</li>
            </ol>
        </div>
        <div class="container-fluid fruite py-5">
            <div class="container py-5">
                <div class="row g-4">
                    <div class="col-lg-12 tab-class">
                    <div class="row g-4">
                        <div class="col-lg-8">
                            <ul class="nav nav-pills d-inline-flex text-center mb-5">
                                <li class="nav-item">
                                    <a class="d-flex m-2 py-2 bg-light rounded-pill active" data-bs-toggle="pill" href="#product">
                                        <span class="text-dark" style="width: 130px;">Products</span>
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="d-flex py-2 m-2 bg-light rounded-pill" data-bs-toggle="pill" href="#room">
                                        <span class="text-dark" style="width: 130px;">Rooms</span>
                                    </a>
                                </li>
                            </ul>
                        </div>
                    </div>
                        
                    <div class="tab-content">
                        <div id="product" class="tab-pane fade show p-0 active">
                            <div class="row g-4" style="width:100%;">
                                <div style="width: 10%;">
                                    <div class="bg-light ps-3 py-3 rounded d-flex justify-content-between mb-4">
                                        <a href="room.jsp">Clear <i class="bi bi-x"></i></a>
                                    </div>
                                </div>
                            </div>
                            
                            <!--Product Start Here-->
                    <div class="row g-4">    
                    <%  
                        String tableName = "PRODUCT";
                        ArrayList<Object[]> tableRows = dbConnection.getRows(tableName);
                        
                        ArrayList<Product> searchData = (ArrayList<Product>)request.getAttribute("data");
                        if(searchData != null){
                            for (int i = 0; i < tableRows.size(); ++i){
                                for(int j = 0 ; j < searchData.size() ; j++){
                                    if(tableRows.get(i)[0].equals(searchData.get(j).getProductid())){
                                        Object[] search = tableRows.get(i);
                    %>
                    
                        <div class="col-md-6 col-lg-4 col-xl-3" style="max-height: 510px;">
                            <div class="rounded position-relative fruite-item" >
                                <div>
                                    <img src="<%= String.valueOf(search[4])%>" class="img-fluid w-100 rounded-top product-img" style="border: 1px solid #ffc107;">
                                </div>
                                <div class="p-4 border border-secondary border-top-0 rounded-bottom" style="height:200px; max-height: 200px">
                                    <div style="height: 85%;">
                                        <h4><%= String.valueOf(search[1])%></h4>
                                        <p><%= String.valueOf(search[3])%></p>
                                    </div>
                                    <div class="d-flex justify-content-between flex-lg-wrap">
                                        <p class="text-dark fs-5 fw-bold mb-0">RM<%= String.valueOf(search[2])%></p>
                                        <a href="product-detail.jsp?roomID=<%= String.valueOf(search[6])%>&productID=<%= String.valueOf(search[0])%>" class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i class="bi bi-zoom-in me-2 text-primary"></i> View Details</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    
                    <%  }}}}else{
                        for (int i = 0; i < tableRows.size(); ++i) {
                        Object[] row = tableRows.get(i);
                    %>
                        <div class="col-md-6 col-lg-4 col-xl-3" style="max-height: 510px;">
                            <div class="rounded position-relative fruite-item" >
                                <div>
                                    <img src="<%= String.valueOf(row[4])%>" class="img-fluid w-100 rounded-top product-img" style="border: 1px solid #ffc107;">
                                </div>
                                <div class="p-4 border border-secondary border-top-0 rounded-bottom" style="height:200px; max-height: 200px">
                                    <div style="height: 85%;">
                                        <h4><%= String.valueOf(row[1])%></h4>
                                        <p><%= String.valueOf(row[3])%></p>
                                    </div>
                                    <div class="d-flex justify-content-between flex-lg-wrap">
                                        <p class="text-dark fs-5 fw-bold mb-0">RM<%= String.valueOf(row[2])%></p>
                                        <a href="product-detail.jsp?roomID=<%= String.valueOf(row[6])%>&productID=<%= String.valueOf(row[0])%>" class="btn border border-secondary rounded-pill px-3 py-1 mb-4 text-primary"><i class="bi bi-zoom-in me-2 text-primary"></i> View Details</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    <% }} %>          
                            </div>
                        </div>
                        
                        <div id="room" class="tab-pane fade show p-0">
                    <div class="row g-4">
                            <div class="col-lg-12">
                                <div class="row g-4 justify-content-center">
            <%@page import="java.util.*" %>
            <%               
                String secondTableName = "PRODUCT";
                ArrayList<Object[]> product = dbConnection.getRows(secondTableName);
                
                tableName = "ROOMCATEGORY";
                tableRows = dbConnection.getRows(tableName);
                for (int i = 0; i < tableRows.size(); ++i) {
                    for(int j = 0; j < product.size(); j++){
                        if(tableRows.get(i)[0].equals(product.get(j)[6])){
                            Object[] row = tableRows.get(i);
                    %>
                    <div class='col-md-6 col-lg-6 col-xl-4'>
                        <div class='rounded position-relative fruite-item'>
                            <div class='fruite-img'>
                                <img src="<%= String.valueOf(row[3])%>" class='img-fluid w-100 rounded-top categoryImg'>
                            </div>
                            <div class='text-white bg-secondary px-3 py-1 rounded position-absolute' style='top: 10px; left: 10px;'><%= String.valueOf(row[2])%></div>
                            <div class='p-4 border border-secondary border-top-0 rounded-bottom roomDetails' style="height: 180px;">
                                <h4 style="height: 65%;"><%= String.valueOf(row[1]) %></h4>
                                <div class='d-flex justify-content-between flex-lg-wrap' style='margin:20px 0px; height: 20%;'>
                                    <a href='roomDetails.jsp?id=<%=String.valueOf(row[0])%>' class='btn border border-secondary rounded-pill px-3 text-primary'><i class='bi bi-zoom-in me-2 text-primary'></i> View Details</a>
                                </div>
                            </div>
                        </div>
                    </div>
                <% break;}}}%>
                
                
                                        <div class="col-12">
                                        <div class="pagination d-flex justify-content-center mt-5">
                                            <a href="#" class="rounded">&laquo;</a>
                                            <a href="#" class="active rounded">1</a>
                                            <a href="#" class="rounded">2</a>
                                            <a href="#" class="rounded">3</a>
                                            <a href="#" class="rounded">4</a>
                                            <a href="#" class="rounded">5</a>
                                            <a href="#" class="rounded">6</a>
                                            <a href="#" class="rounded">&raquo;</a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                       </div>  
                    </div>
                        
                    </div>
                </div>
            </div>
        </div>
        
        <%
            String footer = (String) session.getAttribute("footer");
            if (footer != null) {%>
                <jsp:include page="<%= footer %>" />
         <% }%>
    <script>
        //Default Form
        const sortBtn = document.getElementById("sortingDefaultBtn");
        const sortForm = document.getElementById("sortingForm");
        
        sortBtn.addEventListener("click",(e) => {
            if(sortForm.style.display === "none" || sortForm.style.display === ""){
                sortForm.style.display = "block";
            }else{
                sortForm.style.display = "none"
            }
            
            if(priceForm.style.display === "block"){
                priceForm.style.display = "none";
            }
            e.stopPropagation();
        });
        
        sortForm.addEventListener("click",(e) => {
            e.stopPropagation();
        });
        
        document.body.addEventListener("click",(e) =>{
           sortForm.style.display = "none"; 
        });
        
        //Price
        const priceBtn = document.getElementById("sortingPriceBtn");
        const priceForm = document.getElementById("sortingPrice");
        
        priceBtn.addEventListener("click",(e) => {
            if(priceForm.style.display === "none" || priceForm.style.display === ""){
                priceForm.style.display = "block";
            }else{
                priceForm.style.display = "none"
            }
            
            if(sortForm.style.display === "block"){
                sortForm.style.display = "none";
            }
            
            e.stopPropagation();
        });
        
        priceForm.addEventListener("click",(e) => {
            e.stopPropagation();
        });
        
        document.body.addEventListener("click",(e) =>{
           priceForm.style.display = "none"; 
        });
        
        
        const rangeInput = document.querySelectorAll(".range-input input"),
        priceInput = document.querySelectorAll(".price-input input"),
        range = document.querySelector(".slider .progress");
        let priceGap = 1000;

        priceInput.forEach((input) => {
          input.addEventListener("input", (e) => {
            let minPrice = parseInt(priceInput[0].value),
              maxPrice = parseInt(priceInput[1].value);

            if (maxPrice - minPrice >= priceGap && maxPrice <= rangeInput[1].max) {
              if (e.target.className === "input-min") {
                rangeInput[0].value = minPrice;
                range.style.left = (minPrice / rangeInput[0].max) * 100 + "%";
              } else {
                rangeInput[1].value = maxPrice;
                range.style.right = 100 - (maxPrice / rangeInput[1].max) * 100 + "%";
              }
            }
          });
        });

        rangeInput.forEach((input) => {
          input.addEventListener("input", (e) => {
            let minVal = parseInt(rangeInput[0].value),
              maxVal = parseInt(rangeInput[1].value);

            if (maxVal - minVal < priceGap) {
              if (e.target.className === "range-min") {
                rangeInput[0].value = maxVal - priceGap;
              } else {
                rangeInput[1].value = minVal + priceGap;
              }
            } else {
              priceInput[0].value = minVal;
              priceInput[1].value = maxVal;
              range.style.left = (minVal / rangeInput[0].max) * 100 + "%";
              range.style.right = 100 - (maxVal / rangeInput[1].max) * 100 + "%";
            }
          });
        });
    </script>
    </body>
</html>
