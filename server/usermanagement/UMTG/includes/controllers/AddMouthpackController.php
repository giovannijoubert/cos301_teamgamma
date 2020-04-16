<?php
require_once 'Controller.php';
require_once 'includes/models/AddMouthpack.php.php';
require_once 'includes/models/Encryption.php';
require_once 'includes/models/ResponseObject.php';

class AddMouthpackController extends Controller {
    public static function commitUpdate()
    {
        if(!AddMouthpack::getUserViaAuth(self::getAuthkey()))
            ResponseObject::error401();
        else if(self::getMouthpackId()&&self::getAuthkey()&&!AddMouthpack::exists())
            ResponseObject::success200b(AddMouthpack::addMouth(self::getMouthpackId(),self::getUserType(),self::getBGColour(),self::getAuthkey()));
        else
            ResponseObject::error400a();
    }
}
AddMouthpackController::commitUpdate();