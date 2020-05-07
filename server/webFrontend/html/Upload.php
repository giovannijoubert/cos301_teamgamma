<!DOCTYPE html>
<html lang="en-za">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload Mouth Pack</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <link rel="stylesheet" href="../vendor/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" integrity="sha256-h20CPZ0QyXlBuAw7A+KluUYx/3pK+c7lYEpqLTlxjYQ=" crossorigin="anonymous" />
    <link rel="stylesheet" href="../css/Light-Theme.css">
    <!-- toastify -->
    <link rel="stylesheet" href="../css/lib/toastify.css">
    <script src="../js/lib/toastify.js"></script>
    <script src="../vendor/jquery/jquery.min.js" defer></script>
    <script src="../vendor/bootstrap/js/bootstrap.min.js" defer></script>
    <script src="../js/ui.js" defer></script>
    <script src="../js/Upload.js" defer></script>
    <script type="text/javascript" src="../js/Profile.js"></script>
    <script type="text/javascript" src="../js/DarkTheme.js"></script>

    <?php 
        //dark theme
       if(isset($_COOKIE["theme"]))
           if($_COOKIE["theme"] == "Dark")
                echo '<link rel="stylesheet" href="../css/Dark-Theme.css">';
    ?>
</head>

<body>
    <div class="header"></div>
    <!-- NAVBAR CODE BEGIN HERE -->
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
                    <a class="active" href="Upload" class="nav-item nav-link text-dark">Upload</a>
                    <a class="not" href="Collections" class="nav-item nav-link text-dark">Collections</a>
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
    <!-- NAVBAR CODE ENDS HERE -->
    <div class="container-fluid">
        <section class="row bg-dark text-center text-white" id="breadcrumb">
            <div class="col-12 p-2">
                <h4>Upload Mouth Pack</h4>
            </div>
        </section>
        <section class="row p-3 mb-4">
            <div class="col-sm-12 col-md-10 mx-auto">
                <div class="mt-3">
                    <form id="upload-form">
                        <div id="instructions" style="border-radius: 4px;" class=" bg-light p-3 m-0 mb-2">
                            <p class="mb-1 text-primary small"><strong>Upload mouthpack in 3 easy steps:</strong></p>
                            <ol class="text-primary small">
                                <li>Add 12 images to the corresponding sounds</li>
                                <li>Fill in the title and select the category for the mouthpack</li>
                                <li>Click upload</li>
                            </ol>
                        </div>
                        <div class="card">
                            <div class="card-body">
                                <div id="upload-form-container">
                                    <div class="mouth-drop-target" id="div-oei">
                                        <input type="file" name="oei" id="inp-oei" style="opacity: 0; position:absolute;" required>
                                        <h4>o e i</h4>
                                    </div>
                                    <div class="mouth-drop-target" id="div-l">
                                        <input type="file" name="l" id="inp-l" style="opacity: 0; position:absolute;" required>
                                        <h4>l</h4>
                                    </div>
                                    <div class="mouth-drop-target" id="div-o">
                                        <input type="file" name="o" id="inp-o" style="opacity: 0; position:absolute;" required>
                                        <h4>o</h4>
                                    </div>
                                    <div class="mouth-drop-target" id="div-r">
                                        <input type="file" name="r" id="inp-r" style="opacity: 0; position:absolute;" required>
                                        <h4>r</h4>
                                    </div>
                                    <div class="mouth-drop-target" id="div-cdgknstxyz">
                                        <input type="file" name="cdgknstxyz" id="inp-cdgknstxyz" style="opacity: 0; position:absolute;" required>
                                        <h4>c d g k n s t x y z</h4>
                                    </div>
                                    <div class="mouth-drop-target" id="div-fv">
                                        <input type="file" name="fv" id="inp-fv" style="opacity: 0; position:absolute;" required>
                                        <h4>f v</h4>
                                    </div>
                                    <div class="mouth-drop-target" id="div-qw">
                                        <input type="file" name="qw" id="inp-qw" style="opacity: 0; position:absolute;" required>
                                        <h4>q w</h4>
                                    </div>
                                    <div class="mouth-drop-target" id="div-th">
                                        <input type="file" name="th" id="inp-th" style="opacity: 0; position:absolute;" required>
                                        <h4>th</h4>
                                    </div>
                                    <div class="mouth-drop-target" id="div-bmp">
                                        <input type="file" name="bmp" id="inp-bmp" style="opacity: 0; position:absolute;" required>
                                        <h4>b m p</h4>
                                    </div>
                                    <div class="mouth-drop-target" id="div-u">
                                        <input type="file" name="u" id="inp-u" style="opacity: 0; position:absolute;" required>
                                        <h4>u</h4>
                                    </div>
                                    <div class="mouth-drop-target" id="div-ee">
                                        <input type="file" name="ee" id="inp-ee" style="opacity: 0; position:absolute;" required>
                                        <h4>ee</h4>
                                    </div>
                                    <div class="mouth-drop-target" id="div-chjsh">
                                        <input type="file" name="chjsh" id="inp-chjsh" style="opacity: 0; position:absolute;" required>
                                        <h4>ch j sh</h4>
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="col-12 col-md-6">
                                        <div class="form-group">
                                            <label for="mouth-pack-title"><strong>Title:</strong></label>
                                            <input type="text" id="mouth-pack-title" class="form-control" required>
                                        </div>
                                    </div>
                                    <div class="col-12 col-md-6">
                                        <div class="form-group">
                                            <label for="mouth-pack-title"><strong>Category:</strong></label>
                                            <select id="mouth-pack-category" class="form-control" required>
                                                <option value="" selected disabled>Select the category</option>
                                                <option value="Monster">Monster</option>
                                                <option value="Funny">Funny</option>
                                                <option value="Random">Random</option>
                                                <option value="Robot">Robot</option>
                                                <option value="Animal">Animal</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="mt-4 text-center">
                    <div class="col-sm-12 col-md-10 mx-auto">
                        <div class="row" id="upload-mouths-btns">
                            <div class="col-12 col-md-6 my-2">
                                <button onclick="resetUpload()" class="btn btn-outline-secondary btn-default btn-block bg-white text-dark">Clear Form</button>
                            </div>
                            <div class="col-12 col-md-6 my-2">
                                <button type="submit" form="upload-form" class="btn btn-default btn-block bg-dark text-white">Upload Mouth Pack</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
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
        <span id="theme_toggler" class="theme-circle-div"><i class="fas fa-moon"></i></span>
    </div>


</body>

</html>