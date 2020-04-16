<?php

require_once 'Database.php';

class RemoveMouthpack
{

    public static function getUserViaAuth($authkey)
    {
        return Database::getInstance()->getUserByAuthKey($authkey);
    }

    public static function exists($mp_id, $authkey)
    {
        //get user id
        $obj = self::getUserViaAuth($authkey);
        $user = json_decode($obj)->user->username;

        //check if mouthpack already exists
        $obj = Database::getInstance()->checkOwnership($user, $mp_id);
        if(json_decode($obj)->status === "failure")
        {
            return false;
        }
        return true;
    }

    public static function RemoveMouth($mp_id, $authkey)
    {

        //get user id
        $obj = self::getUserViaAuth($authkey);
        $username = json_decode($obj)->user->username;
        return Database::getInstance()->removeMouthpack($username, $mp_id);
    }
}