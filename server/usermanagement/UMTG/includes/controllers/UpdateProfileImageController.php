<?php
require_once 'Controller.php';
require_once 'includes/models/UpdateProfileImage.php';
require_once 'includes/models/Encryption.php';
require_once 'includes/models/ResponseObject.php';

class UpdateProfileImageController extends Controller {
    public static function commitUpdate()
    {
        if(!UpdateProfileImage::getUserViaAuth(self::getAuthkey()))
            ResponseObject::error401();
        else if(self::getProfileImage()&&self::getAuthkey())
            ResponseObject::success200b(UpdateProfileImage::updateProfileImage(self::getProfilePic(),self::getAuthkey()));
        else
            ResponseObject::error400a();
    }
}
UpdateProfileImageController::commitUpdate();