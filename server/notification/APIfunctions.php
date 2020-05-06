<?php
/**
 * FUNCTIONS
 */
/**
 * @param int $type : 1=send email, 2=send network notification, 3 or any other value = send both
 * @param $user : user's email address. May be array: user[0]=email, user[1]=deviceID
 * @param string $msg : message to send
 * @param $subject : heading for notification
 * @param string $deviceID : client's device ID. if empty, function defaults to email only
 */

function sendNotification($type="", $user="", $msg="", $subject="", $deviceID="")
{
    if ($deviceID = "" || $type == 1) {
        sendEmail($user, $msg, $subject);
    } elseif ($type == 2) {
        sendNetworkNotification($deviceID,$msg,$subject);
    } else {
        sendEmail($user, $msg, $subject);
        sendNetworkNotification($deviceID,$msg,$subject);
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
        echo json_encode(array("Message"=> "Please enter email as 1st param"));
        die("Please enter email as 1st param");
    } else if ($msg == "") {
        echo json_encode(array("Message"=> "Please enter message as 2nd param"));
        die("Please enter email as 2nd param");
    } else {
        
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

function sendNetworkNotification($deviceID = "", $message = "",$subject)
{
  //  echo "<b><i>Sending Network notification</i></b>";
    if ($message == "") {
        echo json_encode(array("Message"=> "Please enter email as 2nd param"));
        die("Please enter email as 2nd param");
    }
    $url = 'https://fcm.googleapis.com/fcm/send';

    $fields = array(
        //'registration_ids' => array($deviceID),
        'to' => json_encode($deviceID),
        'priority' => "high",
        'data' => array(
            "message" => $message
        )
    );
    //Integration's Firebase key
    $api_key = "AAAAPDuMMk8:APA91bEGTm5df7sn0shq88tGMWcUOkWidRlNE13m7YI1McSZfBJTcT2whSwH3WbUec9vdsWBgBQVnFn44N7I6snccPOOi4eymJZuDyjk4pEV_P1wGxyY1E7b4azBbnUrCFCbLCxTs_U7";
    //$api_key = "AAAAPDuMMk8:APA91bH-Cu39_4NCIeENsvHdo6ANeyVKLNapcXOjRec_-X8GIZ0rpST736yWTaEhtLSdjAbGB5qRziseBWyzFYDW1sZ1KRP3EYHk7VgEhYQQFc29KEysTUyp46NLb74N8l0c62bSTmuG";
    //Notification Team firebase key
    //$api_key = "AAAALQ1KC18:APA91bGg7iuimXlkzx90JtVrLHLyIbbMuWGRaBcYoG8IpiK-hqQKVhvoj3KafCQfvNDnQ7sK9blEBWz3GPXkX86Fe-tjXf2fsNHHjw3gaY9Z59iViVuZcSPmB_AP1KsuQv11cP6p0JFA";
    // "BETr3AbYVksWTs_JIoHuuNnp9lfp3q9f1E9fBebkV6MQNMYuLWWWyOepQ9rEFUYWIYnb02XKcddQp7_9D2XCrr0";

    $headers = array(
        'Content-Type:application/json',
        'Authorization: key=' . $api_key
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
        return false;
        //echo json_encode(array("Message"=>('FCM Send Error: ' . curl_error($ch))));
    }
    curl_close($ch);
    echo json_encode(array("Message"=>($result)));
    return $result;

    /*
curl -X POST --header "Authorization: key=BETr3AbYVksWTs_JIoHuuNnp9lfp3q9f1E9fBebkV6MQNMYuLWWWyOepQ9rEFUYWIYnb02XKcddQp7_9D2XCrr0" \
--Header "Content-Type: application/json" \
https://fcm.googleapis.com/fcm/send \
-d "{\"to\":\"1:193496484703:android:dff32eba757777540184ea\",\"notification\":{\"body\":\"Yellow\"},\"priority\":10}"
*/
}