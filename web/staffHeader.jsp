<jsp:useBean id="staff" scope="session" class="Entity.Staff"/>
    <head>
        <meta charset="utf-8">
        <title>SnugNest</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap" rel="stylesheet"> 

        <!-- Icon Font Stylesheet -->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="lib/lightbox/css/lightbox.min.css" rel="stylesheet">
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js" rel="stylesheet">
        <link href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" rel="stylesheet">

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <link href="css/profile.css" rel="stylesheet">
        
        <style>
            body{
                width: 100%;
                
            }
.menu {
  display: grid;
  grid-template-columns: 1fr;
  width: 500px;
  margin: 30px auto 0 auto;
}

.dropdown {
  position: relative;
  border: 1px solid gray;
  margin: 15px;
  font-size: 30px;
  padding: 0 15px;
  border-radius: 40px;
}

.dropdown-btn:hover{
    cursor: pointer;
}

.dropdown-content {
  display: none;
  flex-direction: column;
  position: absolute;
  background-color: #f9f9f9;
  width: 100%;
  box-shadow: 0px 8px 16px rgba(0,0,0,0.2);
  z-index: 1;
  border: 1px solid gray;
  font-size: 30px;
}

.dropdown:hover .dropdown-content {
  display: flex;
}

.dropdownLitem a {
  padding: 8px 12px;
  display: block;
  text-decoration: none;
  color: black;
}

.dropdownLitem a:hover {
  background-color: #ddd;
  cursor: pointer;
}

a {
  padding: 10px;
  display: block;
  text-decoration: none;
  color: black;
}
        </style>
    </head>
    <body>
<header>
            <!-- Navbar start -->
        <div class="container-fluid fixed-top">
            <div class="container topbar bg-primary d-none d-lg-block">
                <div class="d-flex justify-content-between">
                    <div class="top-info ps-2">
                        <small class="me-3"><i class="fas fa-map-marker-alt me-2 text-secondary"></i> <a href="https://maps.app.goo.gl/VwKu9aTcBpbwu64A6" class="text-white">TARUMT</a></small>
                        <small class="me-3"><i class="fas fa-envelope me-2 text-secondary"></i><a href="#" class="text-white">SnugNest@Example.com</a></small>
                    </div>
                    <div class="top-link pe-2">
                        <a href="#" class="text-white"><small class="text-white mx-2">Privacy Policy</small>/</a>
                        <a href="#" class="text-white"><small class="text-white mx-2">Terms of Use</small>/</a>
                        <a href="#" class="text-white"><small class="text-white ms-2">Sales and Refunds</small></a>
                    </div>
                </div>
            </div>
            <div class="container px-0">
                <nav class="navbar navbar-light bg-white navbar-expand-xl">
                    <a href="index.html" class="navbar-brand"><img src="img/icon.png"alt="Snug Nest" style="width: 100px; height: 100px;"/></a>
                    <button class="navbar-toggler py-2 px-3" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                        <span class="fa fa-bars text-primary"></span>
                    </button>
                    <div class="collapse navbar-collapse bg-white" id="navbarCollapse">
                        <div class="navbar-nav mx-auto">
                            <a href="staffMainPage.jsp" class="nav-item nav-link active">Home</a>
                            <a href="editProduct.jsp" class="nav-item nav-link">Room</a>
                        </div>
                        <div class="d-flex m-3 me-0">
                            <button class="btn-search btn border border-secondary btn-md-square rounded-circle bg-white me-4" data-bs-toggle="modal" data-bs-target="#searchModal"><i class="fas fa-search text-primary"></i></button>
                            
                            <a href="staffProfile.jsp" class="my-auto">
                                <img src="img/avatar.jpg" alt="Profile Image" style="width: 40px; height: 40px; border-radius: 50%; object-fit: cover;" />
                                                          
                            </a>                          
                        </div>
                    </div>
                </nav>
            </div>
        </div>
        <!-- Navbar End -->
        
        <!-- Modal Search Start -->
        <form action="AdmSearch" method="POST">
        <div class="modal fade" id="searchModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-fullscreen">
                <div class="modal-content rounded-0">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Search by keyword</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body d-flex align-items-center">
                        <div class="input-group w-75 mx-auto d-flex">
                            <input type="text" class="form-control p-3" placeholder="keywords" aria-describedby="search-icon-1" name="keywords">
                            <button id="search-icon-1" class="input-group-text p-3" type="submit"><i class="fa fa-search"></i></button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </form>
        <!-- Modal Search End -->
</header>
