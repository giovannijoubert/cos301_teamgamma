<!doctype html>
<html>

    <body>
        <form method="post">
            Send Test email<br>
            <input type="submit" name="testEmail" class="testEmail" value="testEmail"/>
           <!-- <input type="submit" name="testJson" class="testJson" value="testJson"/>
            <input type="submit" name="testBoth" class="testBoth" value="testBoth"/>
-->
        </form>



</html>

<?php
//sendEmail();
/*
    if(array_key_exists('testEmail', $_POST)) { 
        sendEmail();
    } 
    else if(array_key_exists('testJSON', $_POST)) { 
        loadJson(); 
    } 
    else if(array_key_exists('testBOTH', $_POST)) { 
        sendEmail();
        loadJson(); 
    } 

    function sendEmail()*/
   //if (isset("testEmail",$_POST))
    {
        $msg = "Congratulations! You have successfully signed up for MouthPiece\n 
            Have fun with our range of exciting mouthpieces to play with.\n 
            With love from the MouthPiece Team :)";
        
        $msg = wordwrap($msg,70);

        $headers = "MIME-Version: 1.0" . "\r\n";
        $headers .= "Content-type:text/html;charset=UTF-8" . "\r\n";

        // More headers
        $headers .= 'From: <mail.teamgamma.ga>' . "\r\n";
        $headers .= 'Cc: mail.teamgamma.ga' . "\r\n";
        mail("u15175295@tuks.co.za","MouthPiece signup successful",$msg,$headers);
    }

    function loadJson(){

        $myfile = fopen("notifications.json", "r") or die("Unable to open file!");
        $jsonData = "";
        while(!feof($myfile)) {
            $jsonData = fgets($myfile);
        }
        echo "1\n".$jsonData."\n";
        $jsonData = json_decode($jsonData);

        echo $jsonData[0];
        fclose($myfile);
    }



?>