<%@page import="java.util.*,Entity.*"%>
<jsp:useBean id="dbConnection" scope="session" class="Entity.DBConnection"></jsp:useBean>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id="customer" scope="session" class="Entity.Customer"/>
<!DOCTYPE html>
<html>
    <head>
        <link href="css/profile.css" rel="stylesheet" type="text/css"/>
    </head>
    
    <body>
        <%  
            String header = (String) session.getAttribute("header");
            if (header != null) {%>
                <jsp:include page="<%= header %>" />
         <% }%>
        

    <div class="container mt-4" style="padding-top: 150px;">
        <div class="row">
            <div class="col-lg-3 my-lg-0 my-md-1">
                <div id="sidebar" class="bg-green">
                    <div class="h4 text-white">Account</div>
                    <ul>
                        <li class="active">
                            <a href="customerProfile.jsp" class="text-decoration-none d-flex align-items-start">
                                <div class="fas fa-box pt-2 me-3"></div>
                                <div class="d-flex flex-column">
                                    <div class="link">My Orders</div>
                                    <div class="link-desc">View & Manage orders and returns</div>
                                </div>
                            </a>
                        </li>
                        <li>
                            <a href="customerAccount.jsp" class="text-decoration-none d-flex align-items-start">
                                <div class="far fa-user pt-2 me-3"></div>
                                <div class="d-flex flex-column">
                                    <div class="link">My Profile</div>
                                    <div class="link-desc">Change your profile details & password</div>
                                </div>
                            </a>
                        </li>
                       <li>
                            <a href="customerLogout.jsp" class="text-decoration-none d-flex align-items-start">
                                <div class="far fa-user pt-2 me-3"></div>
                                <div class="d-flex flex-column">
                                    <div class="link">Log Out</div>
                                    <div class="link-desc">Decide to Log out</div>
                                </div>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="col-lg-9 my-lg-0 my-1">
                <div id="main-content" class="bg-white border">
                    <div class="d-flex flex-column">
                        <div class="h5">Hello ${empty customer.customername ? 'User' : customer.customername},</div>
                        <div>Logged in as: ${empty customer.email ? 'unknown@example.com' : customer.email}</div>
                    </div>
                    <div class="d-flex my-4 flex-wrap">
                        <div class="box me-4 my-1 bg-light">
                            <div class="fa fa-archive fa-2x"></div>    
                            <div class="d-flex align-items-center mt-2">
                                <div class="tag">Orders placed</div>
                                <div class="ms-auto number">
                                    <%
                                        dbConnection.initializeJdbc();
                                        int total=0;
                                    ArrayList<Object[]> orderQty = dbConnection.getRows("orders");
                                    Customer cust = (Customer) session.getAttribute("customer");
                                    String custID = cust.getCustomerid();
                                    for(int i=0;i<orderQty.size();i++){
                                        Object[] order = orderQty.get(i);
                                        String customerOrderID = String.valueOf(order[2]);
                                        if(customerOrderID.equals(custID)){
                                            total= i + 1;
                                        }
                                    }
                                    out.print(total);
                                    %></div>
                            </div>
                        </div>
                        <div class="box me-4 my-1 bg-light">
                            <div class="fa fa-shopping-cart fa-2x"></div>
                            <div class="d-flex align-items-center mt-2">
                                <div class="tag">Items in Cart</div>
                                <div class="ms-auto number"><%
                                        int totalCart=0;
                                    ArrayList<Object[]> itemQty = dbConnection.getRows("cartitems");
                                    ArrayList<Object[]> cartsSelect = dbConnection.getRows("carts");

                                    for (int i = 0; i < cartsSelect.size(); i++) {
                                        Object[] cart = cartsSelect.get(i);
                                        String cartID = String.valueOf(cart[0]);
                                        String customerOrderID = String.valueOf(cart[1]);

                                        if (customerOrderID.equals(custID)) {
                                            for (int j = 0; j < itemQty.size(); j++) {
                                                Object[] item = itemQty.get(j);
                                                String itemCartID = String.valueOf(item[1]);
                                                if (itemCartID.equals(cartID)) {
                                                    totalCart++;
                                                }
                                            }
                                        }
                                    }

                                    out.print(totalCart);
                                    %></div>
                            </div>
                        </div>
                    </div>
                    <div class="text-uppercase">My recent orders</div>
                    
                <%
                try {
                System.out.print("Error 2");
                    Customer customers = (Customer) session.getAttribute("customer");
                    System.out.print("Error 3");
                    if (customers != null) {
                    System.out.print("Error 4");
                        String customerId = customers.getCustomerid();
                        ArrayList<Object[]> orders = dbConnection.getRows("orders");                       
                        System.out.print("Error 5");
                        if (orders != null) {
                        System.out.print("Error 6");
                        System.out.print(orders);
                            for(int i = 0; i < orders.size() ; i++){
                            System.out.print("Error 7");
                            System.out.print(String.valueOf(orders.get(i)[2]));
                            if(String.valueOf(orders.get(i)[2]).equals(customerId)){
                                System.out.print("Error 8");
                                    String[] stepClasses = {"text-muted", "text-muted", "text-muted", "text-muted", "text-muted"};
                                    String status = String.valueOf(orders.get(i)[9]);
                                    
                                    // Fix the strings in switch by using if-else logic instead
                                    if ("PACKAGING".equals(status)) {
                                        stepClasses[0] = "text-muted green";
                                        stepClasses[1] = "text-muted green";
                                    } else if ("SHIPPING".equals(status)) {
                                        stepClasses[0] = "text-muted green";
                                        stepClasses[1] = "text-muted green";
                                        stepClasses[2] = "text-muted green"; // step-3
                                    } else if ("DELIVERING".equals(status)) {
                                        stepClasses[0] = "text-muted green";
                                        stepClasses[1] = "text-muted green";
                                        stepClasses[2] = "text-muted green";
                                        stepClasses[3] = "text-muted green";
                                    } else if ("DELIVERED".equals(status)) {
                                        Arrays.fill(stepClasses, "text-muted green");
                                    }
                                    System.out.print("Error 9");
                %>

                <div class="order my-3 bg-light">
                    <div class="row">
                        <div class="col-lg-4">
                            <div class="d-flex flex-column justify-content-between order-summary">
                                <div class="d-flex align-items-center">
                                    <div class="text-uppercase">Order #<%= String.valueOf(orders.get(i)[0]) %></div>
                                    <input type="hidden" name="order" value="<%=String.valueOf(orders.get(i)[0])%>">
                                    <div class="blue-label ms-auto text-uppercase">Paid</div>
                                </div>
                                <div class="fs-8"><%= String.valueOf(orders.get(i)[10]) %></div>
                            </div>
                        </div>
                        <div class="col-lg-8">
                            <div class="d-sm-flex align-items-sm-start justify-content-sm-between">
                                <div class="status">Status: <%= String.valueOf(orders.get(i)[9]) %></div>
                                <form action="customerProfileOrder" method="post">
                                    <input type="hidden" name="order" value="<%=String.valueOf(orders.get(i)[0])%>">
                                    <button type="submit"class="btn btn-primary text-uppercase">Order Info</button>
                                </form>
                            </div>
                            <div class="progressbar-track">
                                <ul class="progressbar">
                                    <li id="step-1" class="<%= stepClasses[0] %>"><span class="fas fa-gift"></span></li>
                                    <li id="step-2" class="<%= stepClasses[1] %>"><span class="fas fa-check"></span></li>
                                    <li id="step-3" class="<%= stepClasses[2] %>"><span class="fas fa-box"></span></li>
                                    <li id="step-4" class="<%= stepClasses[3] %>"><span class="fas fa-truck"></span></li>
                                    <li id="step-5" class="<%= stepClasses[4] %>"><span class="fas fa-box-open"></span></li>
                                </ul>
                                <div id="tracker"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <%
                                }
                            }
                        }else{
                            System.out.print(orders);
                        }
                    }
                } catch (Exception e) {
                    out.println("Error processing orders: " + e.getMessage());
                }
                %>

                   
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
          <!-- Back to Top -->
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
    </body>
</html>