<?php

require_once 'Database.php';

class AddMouthpack
{

    public static function getUserViaAuth($authkey)
    {
        return Database::getInstance()->getUserByAuthKey($authkey);
    }

    public static function exists($mp_id, $authkey)
    {
        //get user id
        $obj = self::getUserViaAuth($authkey);
        $username = json_decode($obj)->user->username;

        //check if mouthpack already exists
        $obj = Database::getInstance()->checkOwnership($username, $mp_id);
        if(json_decode($obj)->status == "success")
        {
           Database::getInstance()->removeMouthpack($username, $mp_id);
           return true;
        }
        return false;
    }

    public static function addMouth($mp_id, $u_type, $bg_colour, $authkey)
    {

        //get user id
        $obj = self::getUserViaAuth($authkey);
        $user_id = json_decode($obj)->user->user_id;

        return Database::getInstance()->createMouthpack($user_id,$mp_id,$u_type,$bg_colour);
    }
}