<?php
//require_once 'Database.php';

class Recover
{
    public static function getUserViaEmail($email)
    {
        return Database::query("SELECT * FROM Users WHERE username=:username", array(':username'=>$username));
    }

    public static function getUserViaAuth($authkey)
    {
        return Database::getInstance()->getUserByAuthKey($authkey);
    }
}
