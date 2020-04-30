<?php

require_once 'Database.php';

class DeleteMouthpack
{
    public static function getUserViaAuth($authkey)
    {
        return Database::getUserByAuthKey($authkey);
    }

    public static function exists($mp_id, $authkey)
    {
        //get user id
        $obj = getUserByAuthKey($authkey);
        $user = $obj->user;

        //check if mouthpack already exists
        $obj = Database::checkOwnership($user, $mp_id);
        if(json_decode($obj)->status === "failure")
        {
            return false;
        }
        return true;
    }

    public static function deleteMouth($authkey, $mp_id)
    {
        //get user id
        $obj = getUserByAuthKey($authkey);
        $user = $obj->user;

        return Database::deleteMouthpack($user,$mp_id);
    }
}