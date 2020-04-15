<?php
require 'Database.php';
class Login
{
    public static function getUser($username)
    {
        return Database::getInstance()->getUserByUsername($username);
    }
    public static function getMouthpacks($username)
    {
        return Database::getInstance()->getMouthPackByUsername($username);
    }
}