import 'package:flutter/material.dart';
import 'register-page.dart';
import 'package:flutter_auth_firebase/helper/form-validators.dart';
import 'package:flutter_auth_firebase/ui/custom-text-field.dart';
import 'package:flutter_auth_firebase/ui/custom-button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  static const String routeName = "/LoginPage";

  final String title;

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final formValidators = new FormValidators();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool _autoValidate = false;
  String _email;
  String _password;
  String _userId;

  void _validateInputs() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      try {
        AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(
            email: _email, password: _password);
        FirebaseUser user = result.user;
        _userId = user.uid;
      } catch(e) {
        print('Error: $e');
      }



    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  void _goToRegisterPage() {
    Navigator.pushNamed(context, RegisterPage.routeName);
  }

  @override
  Widget build(BuildContext context) {

    final emailField = CustomTextField(
        keyboardType: TextInputType.emailAddress,
        hintText: 'Email',
        validators: formValidators.validateEmail,
        onSaved: (String val) => _email = val,
    );

    final passwordField = CustomTextField(
      keyboardType: TextInputType.text,
      hintText: 'Password',
      validators: formValidators.validatePassword,
      onSaved: (String val) => _password = val,
      isPassword: true,
    );

    final registerLinkBtn = CustomButton(
      context: context,
      buttonText: "I dont have an Account",
      onPressed: _goToRegisterPage,
      withoutBg: true,
    );

    final loginButton = CustomButton(
      context: context,
      buttonText: "Login",
      onPressed: _validateInputs,
    );

    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
              padding: EdgeInsets.all(32.0),
              child: new Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 155.0,
                      child: Image.asset(
                        "images/flutter_logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 45.0),
                    emailField,
                    SizedBox(height: 25.0),
                    passwordField,
                    SizedBox(height: 35.0),
                    loginButton,
                    SizedBox(height: 15.0),
                    registerLinkBtn,
                    SizedBox(height: 15.0),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}