<?php

class Encrypt
{
    public static function encryptpass($password){
        /*
            security algorithm
        */
        $encrypted_password = password_hash($password, PASSWORD_BCRYPT);

        return $encrypted_password;
    }

}
?>
