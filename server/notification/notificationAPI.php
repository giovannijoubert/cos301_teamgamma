<?php
    require ('APIfunctions.php');
    /** PARAMETERS:
     * 1. key: required = API key
     * 2. getMessages (**optional** type must be sent if getMessages not sent) = for retrieving template data
     * 2. type (**optional** getMessages must be sent if type not sent ) = Message type: email, push, both
     * 3. email (optional) = User's email
     * 4. deviceID (optional) = User's device ID
     * 5. msg (required if type is sent) = Message body of notification
     * 6. heading (required if type is sent)
     */
    if (isset($_POST["key"]))//=="3e30630d-239b-488d-8938-b9305dff3e54"))//&& trim($_GET["q"]) == 'link1');
    {
       // session_start();
        $key =  "3e30630d-239b-488d-8938-b9305dff3e54";
        $api = $_POST["key"];
        if($api===$key) {

            if (isset($_POST['getMessages'])) {
                $filename = "template notifications.json";
                $jsonTmplateFile = fopen($filename, "r") or die("An error occurred with the file");
                $fileData = fread($jsonTmplateFile, filesize($filename));
               // $jsonData = json_decode($fileData, true);

                header("HTTP/1.1 200 Success",true,200);
                header('Content-Type: text/json');
                echo $fileData;

                /**
                 * End of JSON Initialization
                 */
            } else if (isset($_POST["type"])) {

                $notificationType = $_POST["type"];
               // $email = $_POST['email'];
                if ($notificationType === 1 && !isset($_POST['email']))
                {
                    header("HTTP/1.1 400 Bad Request",true,400);
                    header('Content-Type: text/json');
                    echo json_encode(array("message"=>"Error! Please Enter an email address"));
                }
                else if ($notificationType === 2 && !isset($_POST['deviceID']))
                {
                    header("HTTP/1.1 400 Bad Request",true,400);
                    header('Content-Type: text/json');
                    echo json_encode(array( "Error! Please Enter a device ID"));
                }
                else if ($notificationType > 2) //Both
                {
                    if (!isset($_POST['email']))
                    {
                        header("HTTP/1.1 400 Bad Request",true,400);
                        header('Content-Type: text/json');
                        echo json_encode(array("message"=> "Error! Please Enter an email address"));
                    }else
                    if (!isset($_POST['deviceID'])) {
                        header("HTTP/1.1 400 Bad Request",true,400);
                        header('Content-Type: text/json');
                        echo json_encode(array("message"=> "Error! Please Enter a device ID"));
                    }
                    else{
                        $email = $_POST['email'];
                        $message = $_POST['msg'];
                        $deviceID = $_POST['deviceID'];
                        $heading = $_POST['heading'];

                        sendNotification($notificationType, $email, $message, $heading, $deviceID);
                        header("HTTP/1.1 200 Success",true,200);
                        header('Content-Type: text/json');
                        echo json_encode(array("message"=> "Success! Notification sent successfully"));
                    }
                } else {
                    $email = $_POST['email'];
                    $message = $_POST['msg'];
                    $deviceID = $_POST['deviceID'];
                    $heading = $_POST['heading'];

                    sendNotification($notificationType, $email, $message, $heading, $deviceID);
                    header("HTTP/1.1 200 Success",true,200);
                    header('Content-Type: text/json');
                    echo json_encode(array("message"=> "Success! Notification sent successfully"));
                }
            }
            else{
                header("HTTP/1.1 400 Bad Request",true,400);
                header('Content-Type: text/json');
                echo json_encode(array("message"=> "What's happening?"));
            }

            /**
             * Testing. REMOVE/ CHANGE
             * echo "<br>";
             *        //sendNotification(3, "jgopal@willowmoore.co.za","this is a test message", "TEST","1:193496484703:android:dff32eba757777540184ea");
             * echo "<br>";
             */

        }
        else{
            header("HTTP/1.1 401 Unauthorized",true,401);
            //header('Content-Type: text/json');
            echo json_encode(array("message"=> "Incorrect API key"));
        }

    }
    else{
        header("HTTP/1.1 403 Forbidden",true,403);
        //header('Content-Type: text/json');
        echo json_encode(array("message"=> "Error Incorrect parameters"));
    }