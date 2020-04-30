<?php
require 'Database.php';
class Register
{
    public static function getUser($username)
    {
        return Database::getInstance()->getUserByUsername($username);
    }

    public static function addUser($username,$fname, $lname,$password, $email)
    {
        return Database::getInstance()->registerUser($username,$fname, $lname,$password, $email);
    }
}


