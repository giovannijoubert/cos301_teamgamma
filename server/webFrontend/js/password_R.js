
$(document).ready(function ()
{
    ErrorHandler3 = new Vue({el:"#Error3", data:{output: "Please enter the email you registered with to recover your password"}});

$('#bottomnextup4').click(function () {
    let email = document.getElementById('username').value;

    if(email === "")
    {
        ErrorHandler3.output = "Please enter your email to recover password or press the close button to login";
        document.getElementById('username').style.borderColor = 'red';
        document.getElementById('Error3').style.color = 'red';
    }
    else
    {

        //-*****************REGEX IS 99.99 PERFECT****************************-//
        let regExp = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
        if(regExp.test(email))
        {

            ////////////////////////////////////////////////////////////////////////////////////
            ///////////////////////////////////////////////////////////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////API NEEDED ,UNDERCONSTUCTION//////////////////////////////////
            //////////////////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////////////////////////
            ErrorHandler3.output = "An email has been send to " + email + " with a temporaly pasword";
            document.getElementById('username').style.borderColor = 'black';
            document.getElementById('Error3').style.color = 'black';
        }
        else
        {
            ErrorHandler3.output = "Please a valid email address";
            document.getElementById("username").style.borderColor = 'red';
            document.getElementById('Error3').style.color = 'red';
        }


    }

})

});

