<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="dbConnection" scope="session" class="Entity.DBConnection"></jsp:useBean>
<%@ page import="Entity.*;"%>
<% dbConnection.initializeJdbc(); %>
<!DOCTYPE html>
<html>
    <head>
        <style>
            #replied{
                display: none;
            }
        </style>
    </head>
    
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
                <div class="row g-4">
                    <h4 class="fw-bold" style="padding-bottom:30px;margin-bottom: -30px;margin-top: -80px">Customer Reviews</h4>
                    
                    <div class="col-lg-12 tab-class" style="margin-top: -30px;">
                        <div class="row g-4" style="margin-bottom: -40px;">
                            <div class="col-lg-8">
                                <ul class="nav nav-pills d-inline-flex text-center mb-5">
                                    <li class="nav-item">
                                        <a class="d-flex m-2 py-2 bg-light rounded-pill active" data-bs-toggle="pill" onclick="displayHavent();">
                                            <span class="text-dark" style="width: 130px;">Haven't Reply</span>
                                        </a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="d-flex py-2 m-2 bg-light rounded-pill" data-bs-toggle="pill" onclick="displayReplied()">
                                            <span class="text-dark" style="width: 130px;">Replied</span>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="tab-content" style="border-top: gray 1px solid;">
                            <div id="havent">
                        <%@page import="java.util.*;"%>
                        <%
                            String tableName = "RATING";
                            String tableName2 = "CUSTOMER";
                            String joinVariable = "CUSTOMERID";
                            ArrayList<Object[]> joinRows = dbConnection.joinTable(tableName, tableName2,joinVariable);
                            
                            tableName2 = "RATING";
                            tableName = "CUSTOMER";
                            String tableName3 = "REPLY";
                            joinVariable = "CUSTOMERID";
                            String secondJoinVariable = "RATINGID";
                            ArrayList<Object[]> existData = dbConnection.joinThreeTable(tableName,tableName2,tableName3,joinVariable,secondJoinVariable);
                            
                            String productTaleName = "PRODUCT";
                            ArrayList<Object[]> productTableData = dbConnection.getRows(productTaleName);

                            Object[] ratingProductData = null;
                            ArrayList<Object[]> sameData = null;
                            
                            int totalReview = 0;
                            
                            for(int a = 0 ; a < joinRows.size(); a++){
                            Object[] ratingData = null;
                                for(int b = 0; b < existData.size(); b++){
                                    if(joinRows.get(a)[0].equals(existData.get(b)[8])){
                                        ratingData = joinRows.get(a);
                                    }
                                }
                                
                                if(ratingData == null){
                                    totalReview++;
                                    ratingData = joinRows.get(a);
                                        for(int c = 0; c < productTableData.size(); c++){
                                            if(ratingData[4].equals(productTableData.get(c)[0])){
                                                ratingProductData = productTableData.get(c);
                                                break;
                                            }
                                        }
                         %>
                         
                        <div class="d-flex" style="padding: 20px 5px;border-bottom: gray 1px solid;width: 100%;">
                            <div style="border: 1px solid gray;width: 20%;border-radius: 10px;">
                                <h6 style="margin: 10px;">Rating On: </h6>
                                <p style="padding-left: 10px;border-bottom: 1px solid gray"><%= String.valueOf(ratingProductData[1])%></p>
                                <img src="<%= String.valueOf(ratingProductData[4])%>" alt="" style="width:90%;margin-left: 10px; ">
                            </div>
                            <div style="width: 80%;padding: 0 30px;">
                            
                            <div style="width:100%;">
                                <div class="d-flex justify-content-between">
                                    <img src="<% if(ratingData[13] == null){out.print("img/avatar.jpg");}else{out.print(ratingData[13]);}%>" class="img-fluid rounded-circle p-3" style="width: 100px; height: 100px;" alt="">
                                    <div style="width: 70%;margin-left: -60px;margin-top: 10px;">
                                        <h4 style="width: 90%;"><%= String.valueOf(ratingData[7])%></h4>
                                        <%
                                            int ratingNum = Integer.parseInt(ratingData[1].toString());
                                            for(int i = 0; i < ratingNum; i++){
                                                out.print("<i class='bi bi-star-fill text-secondary'></i>");
                                            }
                                            for(int i = 0; i < (5 - ratingNum) ; i++){
                                                out.print("<i class='bi bi-star text-secondary'></i>");
                                            }
                                            Staff staff = (Staff)session.getAttribute("staff");
                                        %>
                                    </div>
                                    <div class="d-flex mb-3">
                                        <h6 class="mb-2" style="font-size: 18px; right: 0"><%= String.valueOf(ratingData[3])%></h6>
                                    </div>
                                    
                                </div>
                                <p style="margin-top: 10px;padding: 5px;"><%= String.valueOf(ratingData[2])%></p>
                                    
                                    <div style="display:flex;width: 100%;">
                                        <i class="bi bi-arrow-return-right" style="font-size: 30px;width:3%;margin: 5px;"></i>
                                        <div style="width: 97%;">
                                            <form action="replyReview" method="POST">
                                                <% Staff staffSession = (Staff)session.getAttribute("staff"); %>
                                                <input type="hidden" name="staffID" value="<%= staffSession.getStaffid() %>">
                                                <input type="hidden" name="ratingID" value="<%= String.valueOf(ratingData[0])%>">
                                                <input type="hidden" name="replyURL" value="replyReview.jsp?roomID=<%=request.getParameter("roomID")%>&productID=<%=request.getParameter("productID")%>">
                                                <textarea name="replyReview" id="" class="form-control" cols="20" rows="3" placeholder="Your Reply Review *" spellcheck="false"></textarea>
                                                <input type="submit" class="btn border border-secondary text-primary rounded-pill" style="margin-left: 870px; margin-top: 10px" value="Reply">
                                            </form>
                                        </div>
                                    </div>                
                                </div>
                                </div>
                            
                            </div>
                            <% } }
                                if(totalReview == 0){
                            %>
                            <h5 style="margin-top:50px;">Don't have any review yet!</h5>
                            <%}%>
                            </div>
                            
                        <div id="replied">
                            <% 
                                String customerTaleName = "CUSTOMER";
                                ArrayList<Object[]> customerTableData = dbConnection.getRows(customerTaleName);
                                
                                    String getReplyDataTableName = "RATING";
                                    String getReplyDataTableName2 = "REPLY";
                                    String getReplyDataTableName3 = "STAFF";
                                    String replyJoinVariable = "RATINGID";
                                    String replyJoinVariable2 = "STAFFID";
                                    ArrayList<Object[]> replyData = dbConnection.joinThreeTable(getReplyDataTableName, getReplyDataTableName2,getReplyDataTableName3,replyJoinVariable,replyJoinVariable2);
                                    
                                    Object[] customerRatingData = null;
                                    for(int i = 0 ; i < replyData.size() ; i++){
                                        Object[] replyingData = replyData.get(i);
                                        for(int c = 0; c < customerTableData.size(); c++){
                                            if(replyingData[5].equals(customerTableData.get(c)[0])){
                                                customerRatingData = customerTableData.get(c);
                                                break;
                                            }
                                        }
                                    %>
                                
                            <div class="d-flex" style="padding: 20px 5px;border-bottom: gray 1px solid;">
                                <img src="<% if(customerRatingData[7] == null){out.print("img/avatar.jpg");}else{out.print(customerRatingData[7]);}%>" class="img-fluid rounded-circle p-3" style="width: 100px; height: 100px;" alt="">
                                <div style="width:100%;">
                                    <div class="justify-content-between">
                                    <div class="d-flex" style="width: 100%;">
                                        <h4 style="width: 90%;"><%= String.valueOf(customerRatingData[1])%></h4>
                                        <h6 class="mb-2" style="font-size: 18px; right: 0"><%= String.valueOf(replyingData[3])%></h6>
                                    </div>
                                    <div class="d-flex mb-3">
                                        <%
                                            int ratingNum = Integer.parseInt(replyingData[1].toString());
                                            for(int d = 0; d < ratingNum; d++){
                                                out.print("<i class='bi bi-star-fill text-secondary'></i>");
                                            }
                                            for(int d = 0; d < (5 - ratingNum) ; d++){
                                                out.print("<i class='bi bi-star text-secondary'></i>");
                                            }
                                        %>
                                        
                                    </div>
                                    <p><%= String.valueOf(replyingData[2])%></p>
                                </div>
                                    
                                <div style="display:flex;width: 100%;">
                                    <i class="bi bi-arrow-return-right" style="font-size: 30px;width:3%;"></i>
                                    <div style="width: 100%;margin-left: 10px;" class="form-control">
                                        <p class="form-control" style="border:none;margin-top: 5px;font-size: 18px;"><%= String.valueOf(replyingData[7])%></p>
                                        <div class="d-flex" style="margin-left: 5px; margin-bottom: -2px;width: 100%;">
                                            <p style="width: 90%;">Reply By: <%= String.valueOf(replyingData[12])%></p>
                                            <p style="width: 10%;"><%= String.valueOf(replyingData[8])%></p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                            <% } %>
                            <% if(replyData.size() == 0){ %>
                            <h5 style="margin-top:50px;">Don't have any reply yet!</h5>
                            <%}%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
        <!-- Single Product End -->
<jsp:include page="staffFooter.jsp" />

<script>
    const havent = document.getElementById("havent");
    const replied = document.getElementById("replied");
    
    function displayHavent(){
        havent.style.display = "block";
        replied.style.display = "none";
    }
    
    function displayReplied(){
        havent.style.display = "none";
        replied.style.display = "block";
    }
</script>
</html>