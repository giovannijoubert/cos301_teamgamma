<?php
require_once 'Database.php';

class UpdateProfileImage
{
    public static function getUserViaAuth($authkey)
    {
        return Database::getUserByAuthKey($authkey);
    }

    public static function updateProfileImage($profImage, $authkey)
    {
        $obj = getUserByAuthKey($authkey);
        $user = $obj->user;
        return Database::setProfileImage($user,$profImage);
    }
}