<?php

require_once 'includes/models/Request.php';
/**
 * Extendable Controller Class
 */
class Controller
{
    public static function getName() {
        return Request::post("f_name");
    }

    public static function getLName() {
        return Request::post("l_name");
    }

    public static function getEmail() {
        return Request::post("email");
    }

    public static function getPassword() {
        return Request::post("password");
    }

    public static function getUsername() {
        return Request::post("username");
    }

    public static function getAuthkey() {
        return Request::post("authkey");
    }

    public static function getLM() {
        return Request::post("listening_mode");
    }

    public static function getTheme() {
        return Request::post("theme");
    }

    public static function getProfilePic() {
        return Request::post("image");
    }

    public static function getMouthpackId() {
        return Request::post("mouthpack_id");
    }

    public static function getBGColour() {
        return Request::post("bgcolour");
    }

    public static function getUserType() {
        return Request::post("user_type");
    }

    public static function getCurrentMouthpack() {
        return Request::post("current_mouthpack");
    }

}