<?php
require 'Database.php';
class Logout
{
    public static function getUser($username)
    {
        return Database::getInstance()->getUserByUsername($username);
    }
    public static function setAuthkey($username, $authkey)
    {
        return Database::getInstance()->setAuthkey($username, $authkey);
    }
}