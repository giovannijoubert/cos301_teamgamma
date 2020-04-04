import 'package:flutter/material.dart';
import 'package:mouthpiece_app/ui/views/register_view.dart';
import 'package:mouthpiece_app/ui/views/voice_training_view.dart';
import '../../core/enums/viewstate.dart';
import '../../core/viewmodels/login_model.dart';
import '../../ui/shared/app_colors.dart';
import '../../ui/shared/text_styles.dart';

import 'base_view.dart';
 
class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}
 
class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
 
  @override
   Widget build(BuildContext context) {
    precacheImage(AssetImage("assets/images/wave.png"), context);
    return BaseView<LoginModel>(
      builder: (context, model, child) => Scaffold(
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              LoginHeader(),
              LoginInputFields(
                emailController: emailController, 
                passwordController: passwordController, 
                emailValidationMsg: model.errorMessage, 
                passwordValidationMsg: model.errorMessage,
              ),
              ForgotPassword(),
              model.state == ViewState.Busy ? 
              Center (child: CircularProgressIndicator()) :  
              Container(
                height: 50,
                width: 325,
                margin: const EdgeInsets.only(top: 20.0),
                  padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                  child: RaisedButton(
                    textColor: Colors.white,
                    color: mainTextColor,
                    child: Text(
                    'Login',
                    style: TextStyle(fontSize: 15,
                    fontFamily: 'Arciform'),
                  ),
                  onPressed: () async {
                    var loginSuccess = await model.login(emailController.text, passwordController.text);
                    if(loginSuccess){
                      Navigator.push(context, PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) => VoiceTrainingView(),
                      ),);
                    }
                  },
                    shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  )
                )
              ),
              SkipLink(),  
              SignUpAccountLink(),
            ],
          ),
        ),
      ),
    );
  }
}

class LoginHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
      padding: EdgeInsets.all(10),
      child: Text(
        'Login',
        style: TextStyle(fontSize: 35,
        color: Color(0xff303030),
        fontFamily: 'Arciform'),
      )
    );
  }
}

class LoginInputFields extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String passwordValidationMsg;
  final String emailValidationMsg;

  LoginInputFields({@required this.emailController, @required this.passwordController, this.emailValidationMsg, this.passwordValidationMsg});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextInputField(emailController, 'Email', 'john@gmail.com', false),
        this.emailValidationMsg != null
          ? Text(emailValidationMsg, style: TextStyle(color: Colors.red))
          : Container(),
        TextInputField(passwordController, 'Password', '*******', true),
        this.passwordValidationMsg != null
          ? Text(passwordValidationMsg, style: TextStyle(color: Colors.red))
          : Container()
      ]
    );
  }
}

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String label;
  final bool obscureText;

  TextInputField(this.controller, this.label, this.hintText, this.obscureText);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: TextField(
          style: new TextStyle(color: Color(0xff303030)),
          obscureText: obscureText,
          decoration: new InputDecoration(
            hintText: hintText,
            hintStyle: hintStyle,
            labelText: label,
            labelStyle: inputFieldStyle,
            /* enabledBorder: UnderlineInputBorder(      
              borderSide: BorderSide(color: Colors.cyan),   
            ), */  
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xff303030)),
            ),  
          ),
          controller: controller,
      ),
    );
  }
}

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          children: <Widget>[
            FlatButton(
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xffB1B4E5),
                  fontFamily: 'Helvetica',
                  decoration: TextDecoration.underline,
                ),
              ),
              onPressed: () {
                //forgot password
              },
            )
          ],
          mainAxisAlignment: MainAxisAlignment.end,
        )
      )
    );
  }
}

class SkipLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          children: <Widget>[
            FlatButton(
              child: Text(
                'Skip',
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xffB1B4E5),
                  fontFamily: 'Helvetica',
                  decoration: TextDecoration.underline,
                ),
              ),
              onPressed: () {
                Navigator.push(context, PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) => VoiceTrainingView(),
                ),);
              },
            )
          ],
          mainAxisAlignment: MainAxisAlignment.end,
        )
      )
    );
  }
}

class SignUpAccountLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: (){
        Navigator.push(context, PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => RegisterView(),
        ),);
      },textColor: Color(0xffB1B4E5),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          'Sign up an account',
          style: TextStyle(fontSize: 15,
          color: Color(0xffB1B4E5),
          fontFamily: 'Helvetica'),
        )
      )
    );
  }
}


