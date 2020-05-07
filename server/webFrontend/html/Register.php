<!DOCTYPE html>
<html lamg="en">

<head>
    <script src="https://cdn.jsdelivr.net/npm/vue"></script>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0, user-scalable=no">
    <meta name="description" content="EBIT life Cycle.">
    <link rel="icon" href="favicon.JPG" type="image/gif" sizes="10x10">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <!-- toastify -->
    <link rel="stylesheet" href="../css/lib/toastify.css">
    <script src="../js/lib/toastify.js"></script>
    <!-- font awesome link ------------ -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <!-- script for validation -->
    <script src="../js/validation.js"></script>
    <link rel="stylesheet" type="text/css" href="../css/Register.css" />
</head>

<body>
    <div class="loginPage">
        <div class="mp_logo">MouthPiece</div>

        <span class="loginContainer">
                <div class = "logReg">
                    <ul>
                        <li><a  href="Login">Login</a></li>
                        <li><a  class="active" href="Register">Register</a></a></li>
                    </ul>
                    
                </div>
                <div id="Error2">
                    <p>{{object}}</p>
                  </div>
                <div>
                <label>Username:</label> <br><input id="R_username" type="text" name="R_username"><br>
                <label> Email Address:</label> <br><input id="R_email" type="text" name="R_email"><br>
                <label> Password:</label> <br><input id="R_password" type="password" name="R_password"><br>

                <div id="input">
                    <button id="R_bottomnextup3"> <i class="fa fa-sign-in"></i>  Register</button>
                </div>
            </div>
            </span>
    </div>

</body>

</html>