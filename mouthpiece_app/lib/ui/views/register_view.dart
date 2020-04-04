import 'package:flutter/material.dart';
import 'package:mouthpiece_app/ui/views/login_view.dart';
import 'package:mouthpiece_app/ui/views/voice_training_view.dart';
import '../../core/enums/viewstate.dart';
import '../../core/viewmodels/register_model.dart';
import '../../ui/shared/app_colors.dart';
// import '../../ui/widgets/login_header.dart';
import '../../ui/shared/text_styles.dart';

import 'base_view.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}
 
class _RegisterViewState extends State<RegisterView> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
 
  @override
   Widget build(BuildContext context) {
    return BaseView<RegisterModel>(
        builder: (context, model, child) => Scaffold(
          body: Padding(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  RegisterHeader(),
                  LoginInputFields(
                    usernameController: usernameController, 
                    emailController: emailController, 
                    passwordController: passwordController, 
                    usernameValidationMsg: model.errorMessage, 
                    emailValidationMsg: model.errorMessage, 
                    passwordValidationMsg: model.errorMessage,
                  ),
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
                        'Register',
                        style: TextStyle(fontSize: 15,
                        fontFamily: 'Arciform'),
                      ),
                      onPressed: () async {
                        var loginSuccess = await model.register(usernameController.text, emailController.text, passwordController.text);
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

class RegisterHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Title(),
        CreateAccount(),
        LogoImage(),
      ]
    );
  }
}

class Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
      padding: EdgeInsets.all(10),
      child: Text(
        'MouthPiece',
        style: TextStyle(fontSize: 45,
        color: Color(0xff303030),
        fontFamily: 'Arciform'),
      )
    );
  }
}

class CreateAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(0,0,0,30),
      child: Text(
        'Create your account',
        style: TextStyle(fontSize: 15,
        color: Color(0xff303030),
        fontFamily: 'Arciform'),
      )
    );
  }
}

class LogoImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(alignment: Alignment.center,
      child: Image.asset( 
      "assets/images/wave.png",
      fit:BoxFit.fill),
    );
  }
}

class LoginInputFields extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String usernameValidationMsg;
  final String emailValidationMsg;
  final String passwordValidationMsg;

  LoginInputFields({@required this.usernameController, @required this.emailController, @required this.passwordController, this.usernameValidationMsg, this.emailValidationMsg, this.passwordValidationMsg});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextInputField(usernameController, 'Username', '', false),
        this.emailValidationMsg != null
          ? Text(usernameValidationMsg, style: TextStyle(color: Colors.red))
          : Container(),
        TextInputField(emailController, 'Email', '', false),
        this.passwordValidationMsg != null
          ? Text(passwordValidationMsg, style: TextStyle(color: Colors.red))
          : Container(),
        TextInputField(passwordController, 'Password', '', true),
        this.passwordValidationMsg != null
          ? Text(passwordValidationMsg, style: TextStyle(color: Colors.red))
          : Container(),
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
            pageBuilder: (context, animation1, animation2) => LoginView(),
        ),);
      },textColor: Color(0xffB1B4E5),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          'Login in your account',
          style: TextStyle(fontSize: 15,
          color: Color(0xffB1B4E5),
          fontFamily: 'Helvetica'),
        )
      )
    );
  }
}



