<?php
require 'Database.php';
class Update
{
    public static function getUser($authkey)
    {
        return Database::getInstance()->getUserByAuthKey($authkey);
    }

    public static function setFName($authkey, $f_name)
    {
        return Database::getInstance()->setFName($authkey, $f_name);
    }

    public static function setLName($authkey, $l_name)
    {
        return Database::getInstance()->setLName($authkey, $l_name);
    }

    public static function setEmail($authkey, $email)
    {
        return Database::getInstance()->setEmail($authkey, $email);
    }

    public static function setUsername($authkey, $username)
    {
        return Database::getInstance()->setUsername($authkey, $username);
    }

    public static function setListeningMode($authkey, $listeningMode)
    {
        return Database::getInstance()->setListeningMode($authkey, $listeningMode);
    }

    public static function setTheme($authkey, $theme)
    {
        return Database::getInstance()->setTheme($authkey, $theme);
    }

    public static function setProfilePic($authkey, $pp)
    {
        return Database::getInstance()->setProfilePic($authkey, $pp);
    }
}