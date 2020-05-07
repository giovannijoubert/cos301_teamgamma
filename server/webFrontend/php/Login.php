<!DOCTYPE html>
<html lang="en">

<head>

<link rel="shortcut icon" href="https://teamgamma.ga/webfrontend/images/favicon.png" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="EBIT life Cycle.">
    <link rel="icon" href="favicon.png" type="image/gif" sizes="10x10">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <!-- toastify -->
    <link rel="stylesheet" href="../css/lib/toastify.css">
    <script src="../js/lib/toastify.js"></script>
    <!-- font awesome link ------------ -->

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css" integrity="sha256-h20CPZ0QyXlBuAw7A+KluUYx/3pK+c7lYEpqLTlxjYQ=" crossorigin="anonymous" />
    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <!-- Latest compiled JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    <!-- script for validation -->
    <script src="../js/validation.js"></script>
    <script src="../js/password_R.js"></script>
    <link rel="stylesheet" type="text/css" href="../css/Login.css" />
    <script src="https://cdn.jsdelivr.net/npm/vue"></script>

    <title>Mouthpiece</title>
</head>

<body>

    <div class="mp_logo">MouthPiece</div>
    <div class="loginContainer">
        <div class="logReg">
            <ul>
                <li><a class="active" href="Login">Login</a></li>
                <li><a href="Register">Register</a></a>
                </li>
            </ul>
        </div>
        <div id="Error2">
            <p>{{object}}</p>
        </div>
        <div>
            <label>Email:</label> <br><input id="email" type="text" name="email"><br> <label>Password:</label> <br><input id="password" type="password" name="password"><br>
            <div id="input">
                <!-- <button id="back" href="Explore"> <i class="fa fa-share-square-o"></i>  Back</button> -->
                <button id="bottomnextup3"> <i class="fa fa-sign-in"></i>  Login</button>
                <a data-target="#password_R" class="pull-right" style='margin-top:115px' href="PasswordRecovery">Forgot Password </a>
            </div>
        </div>
    </div>



</body>

</html>