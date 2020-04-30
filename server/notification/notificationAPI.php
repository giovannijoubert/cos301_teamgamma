<?php
    if (array_key_exists("api", $_POST))//&& trim($_GET["q"]) == 'link1');
    {
        $key =  "kd*&TG>LO(*hfksvbs.,sybKUHNUI^*87y*&6T.l(8yhngbt7u,7ubtgfr7r666ol.0p9n";
        $api = $_POST['api'];
        if($api===$key) {
            $email = $_POST['email'];

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

                if ($notificationType === 1 && !isset($_POST['email'])) {

                    echo "Error! Please Enter an email address";
                } else if ($notificationType === 2 && !isset($_POST['deviceID'])) {
                    echo "Error! Please Enter a device ID";
                } else if ($notificationType > 2) {
                    if (!isset($_POST['email'])) {
                        header("HTTP/1.1 200 Success",true,200);
                        header('Content-Type: text/json');
                        echo "Error! Please Enter an email address";
                    }
                    if (!isset($_POST['deviceID'])) {
                        header("HTTP/1.1 200 Success",true,200);
                        header('Content-Type: text/json');
                        echo "Error! Please Enter a device ID";
                    }
                } else {
                    $email = $_POST['email'];
                    $message = $_POST['msg'];
                    $deviceID = $_POST['deviceID'];
                    $heading = $_POST['heading'];

                    sendNotification($notificationType, $email, $message, $heading, $deviceID);
                }
            }

            /**
             * Testing. REMOVE/ CHANGE
             * echo "<br>";
             *        //sendNotification(3, "jgopal@willowmoore.co.za","this is a test message", "TEST","1:193496484703:android:dff32eba757777540184ea");
             * echo "<br>";
             */

            /**
             * FUNCTIONS
             */
            /**
             * @param int $type : 0=send email, 1=send network notification, 2 or any other value = send both
             * @param $user : user's email address. May be array: user[0]=email, user[1]=deviceID
             * @param string $msg : message to send
             * @param $subject : heading for notification
             * @param string $deviceID : client's device ID. if empty, function defaults to email only
             */

            function sendNotification($type = 3, $user, $msg = "Generic Template message that goes here", $subject = "Generic Message", $deviceID = "")
            {
                if ($deviceID = "" || $type == 0) {
                    sendEmail($user, $msg, $subject);
                } elseif ($type == 1) {
                    sendNetworkNotification();
                } else {
                    sendEmail($user, $msg, $subject);
                    sendNetworkNotification();
                }
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
                }*/
            }

            /**
             * @param string $email client's email address
             * @param string $msg : message that is entered or can manually be retieved from the template messages, edit if necessary
             * @param string $subject : Email subject to send
             * @param bool $network : N/A changed to seperate function
             */
            function sendEmail($email = "", $msg = "", $subject = "", $network = false)
                //if (isset("testEmail",$_POST))
            {
                if ($email == "") {
                    echo "Please enter email as 1st param";
                    die("Please enter email as 1st param");
                } else if ($msg == "") {
                    echo "Please enter message as 2nd param";
                    die("Please enter email as 2nd param");
                } else {
                    $emailaddr = 'u15175295@tuks.co.za';
                    /*$msg = "Congratulations! You have successfully signed up for MouthPiece\n
                        Have fun with our range of exciting mouthpieces to play with.\n
                        With love from the MouthPiece Team :)";*/

                    $msg = wordwrap($msg, 70);

                    $headers = "MIME-Version: 1.0" . "\r\n";
                    $headers .= "Content-type:text/html;charset=UTF-8" . "\r\n";

                    // More headers
                    $headers .= 'From: <mail.teamgamma.ga>' . "\r\n";
                    $headers .= 'Cc: mail.teamgamma.ga' . "\r\n";
                    mail($email, $subject, $msg, $headers);

                }

            }

            /**
             * @param string $deviceID : get from user profile, Cant test it out properly
             * @param string $message : message to send in notification
             * @return bool|string: dw about it
             */

            function sendNetworkNotification($deviceID = "", $message = "")
            {
                echo "<b><i>Sending Network notification</i></b>";
                if ($message == "") {
                    echo "Please enter email as 2nd param";
                    die("Please enter email as 2nd param");
                }
                $url = 'https://fcm.googleapis.com/fcm/send';

                $fields = array(
                    'registration_ids' => array($deviceID),
                    'priority' => "high",
                    'data' => array(
                        "message" => $message
                    )
                );
                $api_key = "AAAALQ1KC18:APA91bGg7iuimXlkzx90JtVrLHLyIbbMuWGRaBcYoG8IpiK-hqQKVhvoj3KafCQfvNDnQ7sK9blEBWz3GPXkX86Fe-tjXf2fsNHHjw3gaY9Z59iViVuZcSPmB_AP1KsuQv11cP6p0JFA";
                // "BETr3AbYVksWTs_JIoHuuNnp9lfp3q9f1E9fBebkV6MQNMYuLWWWyOepQ9rEFUYWIYnb02XKcddQp7_9D2XCrr0";

                $headers = array(
                    'Content-Type:application/json',
                    'Authorization:key=' . $api_key
                );

                $ch = curl_init();
                curl_setopt($ch, CURLOPT_URL, $url);
                curl_setopt($ch, CURLOPT_POST, true);
                curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
                curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
                curl_setopt($ch, CURLOPT_SSL_VERIFYHOST, 0);
                curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);
                curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($fields));
                $result = curl_exec($ch);
                if ($result === FALSE) {
                    die('FCM Send Error: ' . curl_error($ch));
                    echo('FCM Send Error: ' . curl_error($ch));
                }
                curl_close($ch);
                echo $result;
                return $result;

                /*
            curl -X POST --header "Authorization: key=BETr3AbYVksWTs_JIoHuuNnp9lfp3q9f1E9fBebkV6MQNMYuLWWWyOepQ9rEFUYWIYnb02XKcddQp7_9D2XCrr0" \
            --Header "Content-Type: application/json" \
            https://fcm.googleapis.com/fcm/send \
        -d "{\"to\":\"1:193496484703:android:dff32eba757777540184ea\",\"notification\":{\"body\":\"Yellow\"},\"priority\":10}"
            */
            }
        }
        else{
            header("HTTP/1.1 401 Unauthorized",true,401);
            //header('Content-Type: text/json');
            echo "Incorrect API key";
        }

    }
    else{
        header("HTTP/1.1 403 Forbidden",true,403);
        //header('Content-Type: text/json');
        echo "Error Incorrect parameters";
    }