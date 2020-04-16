<?php

class ResponseObject
{
    public static function success200()
    {
        $json['status']=200;
        $json['message']='Success';
        echo json_encode($json);
    }
    
    public static function success200e()
    {
        $json['status']=200;
        $json['message']='Successful recovery. Your data has been sent to your email';
        echo json_encode($json);
    }


    public static function success200c($x)
    {
        $json['status']=200;
        $json['message']='Successful registration';
        echo json_encode($json);
    }

    public static function success200b($x)
    {
        $json['status']=200;
        $json['message']='Successful mouthpack upload';
        echo json_encode($json);
    }

    public static function success200d($x)
    {
        $json['status']=200;
        $json['message']='Successful mouthpack removal';
        echo json_encode($json);
    }


    public static function success200a($name, $lname, $theme, $lm, $ak, $mp)
    {
        $json['status']=200;
        $json['message']='Successful Login';
        $json['f_name']=$name;
        $json['l_name']=$lname;
        $json['theme']=$theme;
        $json['listening_mode']=$lm;
        $json['authkey']=$ak;
        $json['mouthpacks']=$mp;
        echo json_encode($json);
    }

    public static function error400()
    {
        $json['status']=400;
        $json['message']='Bad Request';
        echo json_encode($json);
    }

    public static function error400a()
    {
        $json['status']=400;
        $json['message']='Missing Fields Required';
        echo json_encode($json);
    }

    public static function error401()
    {
        $json['status']=401;
        $json['message']='Unauthorized';
        echo json_encode($json);
    }

    public static function error404()
    {
        $json['status']=404;
        $json['message']='Not Found';
        echo json_encode($json);
    }

    public static function error409()
    {
        $json['status']=409;
        $json['message']='User already exists';
        echo json_encode($json);
    }

    public static function error409a()
    {
        $json['status']=409;
        $json['message']='Email already exists';
        echo json_encode($json);
    }

    public static function error404a()
    {
        $json['status'] = 404;
        $json['message'] = 'User Does Not Exist';
        echo json_encode($json);
    }

    public static function error401a()
    {
        $json['status']=401;
        $json['message']='Incorrect Password';
        echo json_encode($json);
    }
}
