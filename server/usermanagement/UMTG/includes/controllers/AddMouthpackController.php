<?php
require_once 'Controller.php';
require_once 'includes/models/AddMouthpack.php';
require_once 'includes/models/Encryption.php';
require_once 'includes/models/ResponseObject.php';

class AddMouthpackController extends Controller {
    public static function commitUpdate()
    {
       //authenticate via authkey
        if(json_decode(AddMouthpack::getUserViaAuth(self::getAuthkey()))->status != "success") {
            ResponseObject::error401a();
        } else if(self::getAuthkey()&&self::getUserType()&&self::getBGColour()) {
                AddMouthpack::exists(self::getMouthpackId(), self::getAuthKey());
                ResponseObject::success200b(AddMouthpack::addMouth(self::getMouthpackId(),self::getUserType(),self::getBGColour(),self::getAuthkey())); 
            } 
            else
                ResponseObject::error400a();
        }
    }
AddMouthpackController::commitUpdate();