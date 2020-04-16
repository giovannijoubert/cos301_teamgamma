<?php
require_once 'Controller.php';
require_once 'includes/models/Login.php';
require_once 'includes/models/Encryption.php';
require_once 'includes/models/ResponseObject.php';
/**
 * Extends Controller Class
 */
class LoginController extends Controller{
    public static function commitLogin()
    {
        $user = json_decode(Login::getUser(self::getUsername()));

        if($user->status == "failure")
            ResponseObject::error404a();
        else if(!($user->user->password == Encrypt::encryptpass(self::getPassword())))
            ResponseObject::error401a();
        else
        {
            $mouthpacks = json_decode(Login::getMouthpacks(self::getUsername()))->mouthpack;
            ResponseObject::success200a($user->user->f_name,$user->user->l_name,$user->user->theme,$user->user->listening_mode,$user->user->authkey,$mouthpacks);
        }
    }
}
LoginController::commitLogin();