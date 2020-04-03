let userTocken;
let userId;
let AuthenticateHeader="";
$(document).ready(function () {

    // ErrorHandler  = new Vue({el:"#Error1", data:{message:""}});
    ErrorHandler2 = new Vue({el:"#Error2", data:{object:""}});


$('#bottomnextup3').click(function () {
    let password=document.getElementById("password").value;
    let username=document.getElementById("username").value;



    if(password === "" || username === "")
    {
        ErrorHandler2.object = "Please fill in all fields.";
        document.getElementById('password').style.borderColor="red";
        document.getElementById('username').style.borderColor="red";
        document.getElementById('Error2').style.color='red';
    }
    /* This code will  be edited after the document of the api has been recieved */
    else
    {
        // $.ajax(
        //     {
        //         url: '/api/users/authenticate',
        //         method:'Get',
        //         contentType:'application/JSON',
        //         header: {
        //             'Authorization': 'Bearer' + AuthenticateHeader,
        //         },
        //         data:{'username':username,
        //             'password':password,
        //         },
        //         success:function (response) {
        //             localStorage.setItem('userTocken',response.token);
        //             localStorage.setItem('userId',response.token);
                    window.location.href = "../html/Explore.html";
        //         },
        //         error:function(response){
        //             document.getElementById("Error1").innerHTML = response;
        //         }
        //     }
        // )
    }

});
$('#R_bottomnextup3').click(function (){


        let username = document.getElementById('R_username').value;
        let email    = document.getElementById('R_email').value;
        let password = document.getElementById('R_password').value;
        let check    = true;

        if(username === "" || email === "" || password === "")
        {
            ErrorHandler2.object = "Please fill in all fields.";
            if(username === "")
                document.getElementById('R_username').style.borderColor = 'red';
            if(email === "")
                document.getElementById('R_email').style.borderColor = 'red';
            if (password === "")
                document.getElementById('R_password').style.borderColor = 'red';

            document.getElementById('Error2').style.color = 'red';
            check = false;
        }

        if(check)
        {
            let count = 0;
            let correctEmail_F    = false;
            let correctPassword_F = false;

            for (let i = 0;i < email.length;i++)
            {
                if(email[i] === '@')
                    count++;
            }

            //-*****************REGEX IS 99.99 PERFECT****************************-//
            let regExp = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
            if(regExp.test(email)){
                correctEmail_F = true;
            }
            let passReg = /((?=.*\d)(?=.*[A-Z])(?=.*\W).{8,200})/;
            if (passReg.test(password)){
                correctPassword_F = true;
            }

            if(count  > 0 && correctPassword_F && correctEmail_F)
            {

                alert('Hello ' + username + ' You are succesfuly logged in ');
                //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                /////////////////////////////////////////////////Post method using the API///////////////////////////////////////////////
                ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            }
            else if (correctEmail_F === false)
            {
                document.getElementById("R_email").style.borderColor = "red";
                ErrorHandler2.object = "Please enter a valid email address";
                document.getElementById('Error2').style.color = 'red';
            }
            else if(correctPassword_F === false)
            {
                document.getElementById("R_password").style.borderColor = "red";
                ErrorHandler2.object = "Password must consist of at least 1 uppercase letter, 1 lowercase letter, 1 digit and 1 special character.";
                document.getElementById('Error2').style.color = 'red';
            }
            else
            {
                ErrorHandler2.object = "Email or password is invalid";
                document.getElementById('Error2').style.color = 'red';
            }
        }


    });

});



