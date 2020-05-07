<!DOCTYPE html>
<html lang="en">

<head>
    <title>Collections</title>
    <link rel="shortcut icon" href="https://teamgamma.ga/webfrontend/images/favicon.png" />
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script type="text/javascript" src="../js/ui.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <!-- toastify -->
    <link rel="stylesheet" href="../css/lib/toastify.css">
    <script src="../js/lib/toastify.js"></script>
    <script type="text/javascript" src="../js/Profile.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" integrity="sha256-h20CPZ0QyXlBuAw7A+KluUYx/3pK+c7lYEpqLTlxjYQ=" crossorigin="anonymous" />
    <link rel="stylesheet" href="../vendor/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/Light-Theme.css">
    <script type="text/javascript" src="../js/Collections.js"></script>
    <script type="text/javascript" src="../js/DarkTheme.js"></script>
    

    <?php 
        //dark theme
       if(isset($_COOKIE["theme"]))
           if($_COOKIE["theme"] == "Dark")
                echo '<link rel="stylesheet" href="../css/Dark-Theme.css">';
    ?>

</head>

<body>


    <nav class="navbar navbar-expand-sm navbar-light bg-light" id="navbar">
        <div class="container-fluid">
            <a class="navbar-brand">
                <span class="mp_logo">MouthPiece</span>
            </a>
            <div class="nav navbar-nav ml-auto mr-2 user-prefs" id="user-prefs-1">
                <a href="javascript: void(0)" data-toggle="collapse" data-target="#user-preferences-section" class="nav-item nav-link"><i class="fa fa-user"></i></a>
            </div>

            <div class="navbar-collapse collapse flex-row" id="mp-nav">
                <div class="nav navbar-nav">
                    <a class="not" href="Explore" class="nav-item nav-link text-dark">Explore</a>
                    <a class="not" href="Upload" class="nav-item nav-link text-dark">Upload</a>
                    <a class="active" href="Collections" class="nav-item nav-link text-dark">Collections</a>
                </div>
            </div>
            <a class="nav_login_btn" href="Login" class="nav-item nav-link text-dark"><i class="fa fa-user"></i> Login</a>

            <div class="nav navbar-nav ml-auto user-prefs" id="user-prefs-2">
                <a href="javascript: void(0)" data-toggle="collapse" data-target="#user-preferences-section" class="nav-item nav-link"><i class="fa fa-user"></i></a>
            </div>
            <button class="navbar-toggler" data-toggle="collapse" data-target="#mp-nav">
                <span class="navbar-toggler-icon"></span>
           </button>
        </div>
    </nav>
    <section class="row collapse" id="user-preferences-section">
        <div class="container py-3 mt-4">
            <div class="col-12 flex-row mb-3">
                <h4>
                    Account Settings
                    <a href="javascript: void(0)" data-toggle="collapse" data-target="#user-preferences-section" class="text-dark float-right"><i class="fa fa-user"></i></a>
                </h4>
            </div>
            <div class="col-12 flex-row">
                <div class="text-muted user-prefs-header pb-1">Account Preferences</div>
                <div class="preference-option m-2">
                    <div class="profilepictureholder img">
                       
                    </div>
                     <div>
                        <button data-toggle="modal" data-target="#update-user-prefs" id="updateProfilePicBtn" class="btn btn-outline-secondary bg-white text-dark">Change</button>
                      </div>
                 </div>
                <div class="preference-option m-2">
                    <div>
                        <h5 class="mb-0">Username</h5>
                        <p class="small text-muted username_display">Username</p>
                    </div>
                    <div>
                        <button data-toggle="modal" data-target="#update-user-prefs" id="updateUsernameBtn" class="btn btn-outline-secondary bg-white text-dark">Change</button>
                    </div>
                </div>
                <div class="preference-option m-2">
                    <div>
                        <h5 class="mb-0">Email Address</h5>
                        <p class="small text-muted email_display">Email</p>
                    </div>
                    <div>
                        <button data-toggle="modal" data-target="#update-user-prefs" id="updateEmailBtn" class="btn btn-outline-secondary bg-white text-dark">Change</button>
                    </div>
                </div>
                <div class="preference-option m-2">
                    <div>
                        <h5 class="mb-0">Password</h5>
                        <p class="small text-muted">Change your password</p>
                    </div>
                    <div>
                        <button data-toggle="modal" data-target="#update-user-prefs" id="updatePasswordBtn" class="btn btn-outline-secondary bg-white text-dark">Change</button>
                    </div>
                </div>

                <!-- <div class="text-muted user-prefs-header pb-1">Theme Preferences</div>
        <div class="preference-option m-2">
            <div>
                <h5 class="mb-0">Dark Mode</h5>
            </div>
            <div>
                <div class="custom-control custom-switch float-right">
                    <input type="checkbox" class="custom-control-input" id="switch-theme">
                    <label class="custom-control-label" for="switch-theme"></label>
                </div>
            </div>
        </div> -->

                <div class="mt-3 mb-1 text-center">
                    <button class="mx-auto btn btn-outline-secondary bg-white text-dark" id="logoutBtn" style="border-radius: 40px"><i class="fa fa-sign-out"></i> Logout</button><br>

                    <button class="btn btn-link text-secondary mt-2" data-toggle="collapse" data-target="#user-preferences-section">&times; close</button>
                </div>
            </div>
        </div>
    </section>
    <section class="row bg-dark text-center text-white" id="breadcrumb">
        <div class="col-12 p-2">
            <h4>My Collection</h4>
        </div>
    </section>
    <div class="container" id="main-content">

        <div class="no-results">No results</div>
        <div class="box_container row text-center text-lg-left">

            <div id="box0" class="box">

                <div class="card cardSize">
                    <h2 class="mpName">Title</h2>
                    <a href="SpecificMouth" class="d-block mb-4 h-100">
                        <img class="img-fluid img-thumbnail" src="../images/mouth3.jpg" alt="">
                    </a>
                    <div class="ratingStars">
                        <span rating="1" class="fa fa-star checked"></span>
                        <span rating="2" class="fa fa-star checked"></span>
                        <span rating="3" class="fa fa-star checked"></span>
                        <span rating="4" class="fa fa-star"></span>
                        <span rating="5" class="fa fa-star"></span>
                    </div>
                    <button type="button" class="btns" style="width: 80%" id="download-btn"> <i class="fa fa-download"></i> Download</button>
                    <button type="button" class="btns" style="width: 80%" id="collection-btn"> <i class="fa fa-trash"></i> Remove</button>
                    <div class="card-body">
                        <h5 class="card-title">By John Doe</h5>
                    </div>
                </div>
            </div>

        </div>

        <div class="modal fade" v-if="updateForm !== null" id="update-user-prefs">
            <div class="modal-dialog modal-md">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4>Update field</h4>
                        <button class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <!-- html elements injected via javascript-->
                    </div>
                </div>
            </div>
        </div>
    </div>

    <span id="theme_toggler" class="theme-circle-div"><i class="fas fa-moon"></i></span>
    </div>


</body>

</html>