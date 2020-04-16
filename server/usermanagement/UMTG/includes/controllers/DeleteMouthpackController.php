<?php
require_once 'Controller.php';
require_once 'includes/models/RemoveMouthpack.php';
require_once 'includes/models/Encryption.php';
require_once 'includes/models/ResponseObject.php';

class RemoveMouthPackController extends Controller {
    public static function commitUpdate()
    {
       //authenticate via authkey
        if(json_decode(AddMouthpack::getUserViaAuth(self::getAuthkey()))->status != "success") {
            ResponseObject::error401a();
        } else {
            if(!AddMouthpack::exists(self::getMouthpackId(), self::getAuthkey())){
                ResponseObject::success200b(AddMouthpack::addMouth(self::getMouthpackId(),self::getUserType(),self::getBGColour(),self::getAuthkey()));
            }
            else
                ResponseObject::error400a();
        }
    }
}
RemoveMouthPackController::commitUpdate();