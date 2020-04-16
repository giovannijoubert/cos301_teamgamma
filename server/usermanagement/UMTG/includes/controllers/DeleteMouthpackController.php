<?php
require_once 'Controller.php';
require_once 'includes/models/DeleteMouthpack.php';
require_once 'includes/models/Encryption.php';
require_once 'includes/models/ResponseObject.php';

class DeleteMouthpackController extends Controller {
    public static function commitUpdate()
    {
        if(!DeleteMouthpack::getUserViaAuth(self::getAuthkey()))
            ResponseObject::error401();
        else if(self::getMouthpackId()&&self::getAuthkey()&&DeleteMouthpack::exists())
            ResponseObject::success200b(DeleteMouthpack::deleteMouth(self::getAuthkey(),self::getMouthpackId()));
        else
            ResponseObject::error400a();
    }
}
DeleteMouthpackController::commitUpdate();
