import 'package:flutter/material.dart';
//import 'package:email_validator/email_validator.dart';
import 'package:mouthpiece/ui/views/login_view.dart';
import 'package:mouthpiece/ui/views/voice_training_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/enums/viewstate.dart';
import '../../core/viewmodels/register_model.dart';
import '../../ui/shared/app_colors.dart';
import '../../ui/shared/text_styles.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'base_view.dart';
import 'choose_mode_view.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}
 
class _RegisterViewState extends State<RegisterView> {
 
  final GlobalKey<FormState> form_Key = GlobalKey<FormState>();
  String _email; 
  String _password;
  String _userName;

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Username'),
      // maxLength: 10,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Username is Required';
        }
        if(value.length < 4){
            return 'Username must exceed 4 characters.';
        }

        return null;
      },
      onSaved: (String value) {
        _userName = value;
      },
    );
  }

  Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is required';
        }
        if (!RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?").hasMatch(value)) {
          return 'Please enter a valid email address';
        }

        return null;
      },
      onSaved: (String value) {
        _email = value;
      },
    );
  }

  Widget _buildPassword() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Password'),
      keyboardType: TextInputType.visiblePassword,
      obscureText: true,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password is required';
        }

        if (value.length < 4 ) {
          return 'Password is too short';
        }

        return null;
      },
      onSaved: (String value) {
        _password = value;
      },
    );
  }

  Future _registerCommand(model) async{
        bool loginSuccess = await model.register(_userName,_email,_password);
        if(loginSuccess){
          SharedPreferences prefs = await SharedPreferences.getInstance(); 
          if (prefs.getBool('loggedIn'))
            Navigator.push(context, PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => VoiceTrainingView(),
            ),);
          else
             Navigator.push(context, PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => ChooseModeView(),
            ),);
        }else{
            Navigator.push(context, PageRouteBuilder(
                pageBuilder: (context, animation1, animation2) => RegisterView(),
            ),);  
            Fluttertoast.showToast(
              msg: "Registration Failed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white,
              textColor: Colors.black,
              fontSize: 16.0
          );
        }
  }
  @override
   Widget build(BuildContext context) {
    return BaseView<RegisterModel>(
        builder: (context, model, child) => Scaffold(
          body: Padding(
              padding: EdgeInsets.all(10),
              child: ListView(
                children: <Widget>[
                  RegisterHeader(),
                  Container(
                      child: Form(
                          key: form_Key,
                          child: Column(
                            children: <Widget> [         
                                _buildName(),
                                _buildEmail(),
                                _buildPassword(),
                            ],
                          ),
                      ),
                  ),
                  model.state == ViewState.Busy ? 
                  Center(child: CircularProgressIndicator()) :  
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
                              final form = form_Key.currentState;
                              if(form.validate())
                              {
                                form.save();
                                _registerCommand(model);
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
                      pageBuilder: (context, animation1, animation2) => ChooseModeView(),
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