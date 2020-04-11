import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import '../../core/enums/viewstate.dart';
import '../../core/viewmodels/login_model.dart';
import '../../ui/shared/app_colors.dart';
import '../../ui/shared/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base_view.dart';
 
class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}
 
class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _email;
  String _password;

Widget _buildEmail() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Email'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is Required';
        }

        /* if(EmailValidator.Validate(value, true))
        {
          return 'Please enter a valid email Address';
        } */

        if (!RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?").hasMatch(value)) {
          return 'Please enter a valid email Address';
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
          return 'Password is Required';
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


  Future _loginCommand(model) async{
      var loginSuccess = await model.login(_email, _password);
      if(loginSuccess){
           SharedPreferences prefs = await SharedPreferences.getInstance();
           prefs.setBool('loggedIn', true);
           Navigator.pushNamed(context, '/');
       }else{
            Navigator.pushNamed(context, 'login'); 
            throw Exception('Invalid email or Invalid password provided'); 
           
        }
  }
  @override
   Widget build(BuildContext context) {
    return BaseView<LoginModel>(
      builder: (context, model, child) => Scaffold(
        body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              LoginHeader(),
              Container(
                  child: Form(
                      key: formKey,
                      child: Column(
                        children: <Widget> [ 
                            _buildEmail(),
                            _buildPassword()
                        ],
                      ),
                  ),
              ),
              ForgotPassword(),
              model.state == ViewState.Busy ? Center (child: CircularProgressIndicator()) : 
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
                  onPressed: (){
                      final form = formKey.currentState;

                      if(form.validate()){
                        form.save();
                        _loginCommand(model);
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

  final formKey;
  String email;
  String password;
  LoginInputFields({@required this.formKey,@required this.email, @required this.password});

  @override
  Widget build(BuildContext context) {
      return Container(
          child: Form(
              key: formKey,
              child: Column(
                children: [ 
                    TextFormField(
                        decoration: InputDecoration(labelText: 'Email'),
                        validator: (val) => EmailValidator.Validate(val,true)
                        ? 'Please provide a valid email.'
                        : null,
                        onSaved: (val) => email = val,
                    ),
                    TextFormField(
                        decoration: InputDecoration(labelText: 'Password'),
                        validator: (val) => val.length < 4 
                        ? 'Your password is too short.'
                        : null,
                        onSaved: (val) => password = val,
                        obscureText: true,
                    ),
                ],
              ),
          ),
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
                Navigator.pushNamed(context, 'voice-training');
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
        Navigator.pushNamed(context, 'register');
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


