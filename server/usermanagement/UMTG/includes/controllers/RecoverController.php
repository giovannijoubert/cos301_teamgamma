<?php
require_once 'Controller.php';
require_once 'includes/models/Recover.php';
require_once 'includes/models/Encryption.php';
require_once 'includes/models/ResponseObject.php';
/**
 * Extends Controller Class
 */
class RecoverController extends Controller {
    public static function commitRecovery()
    {
        
        $obj = Recover::getUserViaAuth(self::getAuthkey());
        if(!user)
        {
            ResponseObject::error401();
        }
        else
        {
            $response = json_decode($obj);
            if($response->status= "failure")
            {
                ResponseObject::error401();
            }
            else
            {
                $user = $response->user;

                //Mailing
                $to = $user['email_address'];
                $subject = 'TEAM GAMA USER MANAGEMENT: RECOVERY';
                $message = 'Here are your details:\n\n';
                $message .= 'Username: ' .$user['username '].'\n';
                $message .= 'Theme: ' .$user['theme'] .'\n';
                $message .= 'Listening mode: ' .$user['listening_mode'] .'\n';
                $message .'Mouth packs: \n';
                $message .= Database::getInstance()->getMouthPackByUsername($user['username']);

                $headers = 'From: umtg@teamgamma.ga';
                mail($to,$subject,$message,$headers);
                ResponseObject::success200e();

            }
        }

    }
}
RecoverController::commitRecovery();
