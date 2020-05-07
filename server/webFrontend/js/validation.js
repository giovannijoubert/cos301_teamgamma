let userTocken;
let userId;
let AuthenticateHeader = "";
$(document).ready(function() {

    // ErrorHandler  = new Vue({el:"#Error1", data:{message:""}});
    ErrorHandler2 = new Vue({ el: "#Error2", data: { object: "" } });


    $('#bottomnextup3').click(function() {
        let password = document.getElementById("password").value;
        let email = document.getElementById("email").value;



        if (password === "" || email === "") {
            ErrorHandler2.object = "Please fill in all fields.";
            document.getElementById('password').style.borderColor = "red";
            document.getElementById('email').style.borderColor = "red";
            document.getElementById('Error2').style.color = 'red';
        } else {

            var profile = {
                    email: $("#email").val(), //last minute change to use email
                    password: $("#password").val()
                }
                //API Call to Login
            login(profile);
        }

    });
    $('#R_bottomnextup3').click(function() {


        let username = document.getElementById('R_username').value;
        let email = document.getElementById('R_email').value;
        let password = document.getElementById('R_password').value;
        let check = true;

        if (username === "" || email === "" || password === "") {
            ErrorHandler2.object = "Please fill in all fields.";
            if (username === "")
                document.getElementById('R_username').style.borderColor = 'red';
            if (email === "")
                document.getElementById('R_email').style.borderColor = 'red';
            if (password === "")
                document.getElementById('R_password').style.borderColor = 'red';

            document.getElementById('Error2').style.color = 'red';
            check = false;
        }

        if (check) {
            let count = 0;
            let correctEmail_F = false;
            let correctPassword_F = false;

            for (let i = 0; i < email.length; i++) {
                if (email[i] === '@')
                    count++;
            }

            //-*****************REGEX IS 99.99 PERFECT****************************-//
            let regExp = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            if (regExp.test(email)) {
                correctEmail_F = true;
            }
            let passReg = /((?=.*\d)(?=.*[A-Z])(?=.*\W).{8,200})/;
            if (passReg.test(password)) {
                correctPassword_F = true;
            }

            if (count > 0 && correctPassword_F && correctEmail_F) {

                var profile = {
                    username: username,
                    password: password,
                    f_name: "na",
                    l_name: "na",
                    email: email
                }

                //API Call to Register
                register(profile);

            } else if (correctEmail_F === false) {
                document.getElementById("R_email").style.borderColor = "red";
                ErrorHandler2.object = "Please enter a valid email address";
                document.getElementById('Error2').style.color = 'red';
            } else if (correctPassword_F === false) {
                document.getElementById("R_password").style.borderColor = "red";
                ErrorHandler2.object = "Password must consist of at least 1 uppercase letter, 1 lowercase letter, 1 digit and 1 special character.";
                document.getElementById('Error2').style.color = 'red';
            } else {
                ErrorHandler2.object = "Email or password is invalid";
                document.getElementById('Error2').style.color = 'red';
            }
        }

    });

    function makeid(length) {
        var result           = '';
        var characters       = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        var charactersLength = characters.length;
        for ( var i = 0; i < length; i++ ) {
           result += characters.charAt(Math.floor(Math.random() * charactersLength));
        }
        return result;
     }

    //reset password
    $("#bottomnextup4").click(function(){
        var npass = makeid(10);
        var email = $("#email").val();

        var postData = {
            "email" : email,
            "password" :  npass,
            "secretkey" : "E#*NqknMYTcy1BYu4ffufjL3BWO23#"
        }
        $.ajax({
            url: 'https://teamgamma.ga/api/umtg/reset',
            type: 'post',
            dataType: 'json',
            contentType: 'application/json',
            success: function(data) {
                //password reset 
              
                passwordResetEmail(email, npass);
                var passwordResetSuccess = Toastify({
                    text: "A new password has been sent to your email.",
                    gravity: "bottom",
                    backgroundColor: "linear-gradient(135deg, #56ab2f, #56ab2f)",
                    duration: 4000
                });
                passwordResetSuccess.showToast();
            },
            error: function(data) {
                console.log(data);
                //Toast message: Register Failed
                var failedRegister = Toastify({
                    close: true,
                    gravity: "bottom",
                    text: "Password Reset Failed: " + data.responseJSON.message,
                    backgroundColor: "linear-gradient(135deg, #9E1A1A, #9E1A1A)",
                    duration: 5000
                });

                failedRegister.showToast();
            },
            data: JSON.stringify(postData)
        });
        email

    });


    function register(profile) {

        $.ajax({
            url: 'https://teamgamma.ga/api/umtg/register',
            type: 'post',
            dataType: 'json',
            contentType: 'application/json',
            success: function(data) {
                var loginDetail = {
                    username: profile.username,
                    password: profile.password
                };
                //login after successful registration
                regSuccessEmail(profile.email, profile.username);
                login(loginDetail);
            },
            error: function(data) {
                console.log(data);
                //Toast message: Register Failed
                var failedRegister = Toastify({
                    close: true,
                    gravity: "bottom",
                    text: "Registration Failed: " + data.responseJSON.message,
                    backgroundColor: "linear-gradient(135deg, #9E1A1A, #9E1A1A)",
                    duration: 5000
                });

                failedRegister.showToast();
            },
            data: JSON.stringify(profile)
        });
    }
    //API call to manage login
    function login(profile) {
        console.log(profile);
        $.ajax({
            url: 'https://teamgamma.ga/api/umtg/login',
            type: 'post',
            dataType: 'json',
            contentType: 'application/json',
            success: function(data) {
                if (data.message === "Successful Login") {
                    localStorage.setItem("userProfile", JSON.stringify(data));
                    console.log(data.JWT)
                    localStorage.setItem("image", data.JWT);
                    localStorage.setItem("theme",data.theme)
                    window.location.href = "../html/Explore.html";
                }
            },
            error: function(data) {
                //Toast message: Login Failed
                var failedLogin = Toastify({
                    close: true,
                    gravity: "bottom",
                    text: "Login Failed: " + data.responseJSON.message,
                    backgroundColor: "linear-gradient(135deg, #9E1A1A, #9E1A1A)",
                    duration: 5000
                });

                failedLogin.showToast();
            },
            data: JSON.stringify(profile)
        });
    }

    //Api call to retreive latest profile
    function getProfile(username, JWT) {
        var profile = {
            username: username,
            jwt: JWT
        }

        $.ajax({
            url: 'https://teamgamma.ga/api/umtg/getprofile',
            type: 'post',
            dataType: 'json',
            contentType: 'application/json',
            success: function(data) {
                localStorage.setItem("userProfile", JSON.stringify(data));
                successfullLogin.showToast();
            },
            error: function(data) {
                alert("API FAIL: getProfile");
            },
            data: JSON.stringify(profile)
        });
    }


    function passwordResetEmail(email, npass){
        var fd = new FormData();    
        fd.append( 'email', email);
        fd.append( 'key',  "3e30630d-239b-488d-8938-b9305dff3e54");
        fd.append( 'type',  "email");
        fd.append( 'msg',  'Hey here is your new password for Mouthpiece: ' + npass);
        fd.append( 'heading',  "Mouthpiece Password Reset");

        $.ajax({
        url: 'https://teamgamma.ga/notification/notificationAPI.php',
        data: fd,
        processData: false,
        contentType: false,
        type: 'POST',
        success: function(data){
            console.log(data);
        }
        });
    }

    function regSuccessEmail(email, username){
        var fd = new FormData();    
        fd.append( 'key',  "3e30630d-239b-488d-8938-b9305dff3e54");
        fd.append( 'type',  "email");
        fd.append( 'email', email);
        fd.append( 'msg',  'Hey ' + username + ' Congratulations for signing up on MouthPiece.');
        fd.append( 'heading',  "Mouthpiece Profile Registration: " + username);

        $.ajax({
        url: 'https://teamgamma.ga/notification/notificationAPI.php',
        data: fd,
        processData: false,
        contentType: false,
        type: 'POST',
        success: function(data){
         console.log(alert(data));
        }
        });
    }


});
