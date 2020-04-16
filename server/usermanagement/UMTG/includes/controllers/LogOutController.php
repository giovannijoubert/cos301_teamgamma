<?php
require_once 'Controller.php';
require_once 'includes/models/Logout.php';
require_once 'includes/models/Encryption.php';
require_once 'includes/models/ResponseObject.php';
/**
 * Extends Controller Class
 */
class LogOutController extends Controller{
    public static function commitLogOut()
    {
        $user = json_decode(Logout::getUser(self::getUsername()));

        if($user->status == "failure")
            ResponseObject::error404a(); //user does not exist  
        else if(Controller::getAuthkey() != $user->user->authkey) //user doesn't have valid authkey to make change
           {
                ResponseObject::error401a();  
           }
        else
        {
            //logout success
            $authkey = "";
            echo "successfully logged out";
            ResponseObject::success200a(Logout::setAuthkey($user->user->username, $authkey));
        }
    }
}
LogOutController::commitLogOut();