<?php
require_once 'Controller.php';
require_once 'includes/models/Register.php';
require_once 'includes/models/Encryption.php';
require_once 'includes/models/ResponseObject.php';

/**
 * Extends Controller Class
 */
class RegisterController extends Controller{
    public static function commitRegister()
    {
        if(json_decode(Register::getUser(self::getUsername()))->status == "success")
            ResponseObject::error409();
        else if(self::getName()&&self::getLName()&&self::getUsername()&&self::getPassword()&&self::getEmail())
            ResponseObject::success200c(Register::addUser(self::getName(),self::getLName(),self::getUsername(),Encrypt::encryptpass(self::getPassword()),self::getEmail(),null));
        else
            ResponseObject::error400a();
    }
}
RegisterController::commitRegister();