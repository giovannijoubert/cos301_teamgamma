<?php

class Request
{

    public static function post($data)
    {
        $POST = json_decode(file_get_contents("php://input"));
        if(isset($POST->$data))
            return $POST->$data;
        else
         //   ResponseObject::error400a();

         return null;
    }
}

