import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:mouthpiece/ui/shared/theme.dart';
import 'package:mouthpiece/ui/views/choose_mode_view.dart';
import 'package:mouthpiece/ui/views/home_view.dart';
import 'package:mouthpiece/ui/views/register_view.dart';
import 'package:mouthpiece/ui/views/voice_training_view.dart';
import 'package:provider/provider.dart';
import '../../core/enums/viewstate.dart';
import '../../core/viewmodels/login_model.dart';
import '../../ui/shared/app_colors.dart';
import '../../ui/shared/text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'base_view.dart';
 
class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}
 
class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _userName;
  String _password;
  bool circularDisplay = false;

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Username'),
      // maxLength: 10,
      validator: (String value) {
        if (value.isEmpty) {
          setState(() {
            circularDisplay = false;
          });
          return 'Username is Required';
        }
        setState(() {
            circularDisplay = false;
          });
        return null;
      }, 
      onSaved: (String value) {
        _userName = value;
      },
    );
  }

  Widget _buildPassword() {
      return TextFormField(
        decoration: InputDecoration(labelText: 'Password'),
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        validator: (String value) {
          // String message = "";
          if (value.isEmpty) {
            setState(() {
              circularDisplay = false;
            });
            return 'Password is required';
          }
          if (value.length < 4 ) {
            setState(() {
              circularDisplay = false;
            });
            return 'Password is too short';
          }

          setState(() {
            circularDisplay = false;
          });
          
          return null;
        }, 
        onSaved: (String value) {
          _password = value;
        },
      );
    }

  Future _loginCommand(model, theme) async{
    final prefs = await SharedPreferences.getInstance();
    var loginSuccess = await model.login(_userName, _password);
    if(loginSuccess){
      ThemeData themeVal = prefs.getString("theme") == "Light" ? lightTheme : darkTheme;
      if (themeVal == null)
        themeVal = lightTheme;
      await theme.setTheme(themeVal);
      Navigator.of(context).pushAndRemoveUntil(PageRouteBuilder(pageBuilder: (context, animation1, animation2) => HomeView()), (Route<dynamic> route) => false);
    } else {
      /* Navigator.push(context, PageRouteBuilder(
        pageBuilder: (context, animation1, animation2) => LoginView(),
      ),); */
      setState(() {
        circularDisplay = false;
      });

      Fluttertoast.showToast(
        msg: "Incorrect username or password.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color(0xff303030),
        textColor: Colors.white,
        fontSize: 16.0
      );
    }
  }

  @override
   Widget build(BuildContext context) {
    // precacheImage(AssetImage("assets/images/wave.png"), context);
    final theme = Provider.of<ThemeChanger>(context);  
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
                      _buildName(),
                      _buildPassword()
                    ],
                  ),
                ),
              ),
              ForgotPassword(),
              Visibility(
                child: Center(child: CircularProgressIndicator()),
                visible: circularDisplay, 
              ),
              Visibility(
                visible: !circularDisplay,
                child: Container(
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
                      setState(() {
                        // final prefs = await SharedPreferences.getInstance();
                        // ThemeData themeVal = prefs.getString("theme") == "Light" ? lightTheme : darkTheme;
                        // theme.setTheme(themeVal);
                        circularDisplay = true;
                      });
                        FocusScopeNode currentFocus = FocusScope.of(context);

                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }

                        final form = formKey.currentState;

                        if (form.validate()) {
                          form.save();
                          await _loginCommand(model, theme);
                        }
                    },
                      shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    )
                  )
                ),
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


