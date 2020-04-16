<?php
require_once 'Controller.php';
require_once 'includes/models/RemoveMouthpack.php';
require_once 'includes/models/Encryption.php';
require_once 'includes/models/ResponseObject.php';

class RemoveMouthPackController extends Controller {
    public static function commitUpdate()
    {
       //authenticate via authkey
        if(json_decode(RemoveMouthpack::getUserViaAuth(self::getAuthkey()))->status != "success") {
            ResponseObject::error401a();
        } else {
            if(self::getMouthpackId() != NULL){

               echo RemoveMouthpack::removeMouth(self::getMouthpackId(),self::getAuthkey());

               // ResponseObject::success200d("A");
            }
            else
                ResponseObject::error400a();
        }
    }
}
RemoveMouthPackController::commitUpdate();