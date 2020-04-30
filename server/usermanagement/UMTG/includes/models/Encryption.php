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

    public static function decryptpass($password, $hash){
        if (password_verify($password, $hash)) {
            return true;
          } else {
            return false; // login failed
        }
    }


}
?>
