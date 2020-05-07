<!DOCTYPE html>
<html lang="en">

<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="EBIT life Cycle.">
    <link rel="icon" href="favicon.JPG" type="image/gif" sizes="10x10">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <!-- font awesome link ------------ -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
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
    <div class="loginPage">
        <span id="images">
                <div class ="logo">
                    <img src="../images/logo.png" alt="Logo"  width="400" height="90">
                </div>
                <div class="mouthImage">
                    <div class="desc">
                        <p>Mouthpiece is an application based software that anyone can use to synchronise an animated mouth to their mouth in real-time. The possibilities are endless.</p>
                    </div>
                    <img src="../images/num4.png" alt="Mouth" class="mouth">
                    <img src="../images/num1.png" alt="Mouth" class="mouth">
                    <img src="../images/num3.png" alt="Mouth" class="mouth">
                    <img src="../images/mouth8.jpg" alt="Mouth" class="mouth">
                </div>
            </span>

        <span class="loginContainer">
                <div class = "logReg">
                    <ul>
                        <li><a  href="Register">Password Recovery</a></a></li>
                    </ul>
                </div>
                <div id="Error3">
                    <p>{{output}}</p>
                  </div>
                <div>
                Email:<input id="username" type="text" name="Email"><br>

                <div id="input">
                    <!-- <button id="back" href="Explore"> <i class="fa fa-share-square-o"></i>  Back</button> -->
                    <button id="bottomnextup4"> <i class="fa fa-sign-in"></i>  Submit</button>
                    <div class="modal-footer">
                     <div id="bottomnextup2">
                       <a  data-dismiss="modal" class="detailedView pull-right" href="Login">Close</a>
                     </div>
                     </div>
                </div>
            </div>
            </span>
    </div>


</body>

</html>