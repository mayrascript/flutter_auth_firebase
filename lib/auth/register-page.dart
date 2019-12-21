import 'package:flutter/material.dart';
import 'package:flutter_auth_firebase/helper/form-validators.dart';
import 'package:flutter_auth_firebase/ui/custom-text-field.dart';
import 'package:flutter_auth_firebase/ui/custom-button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.title}) : super(key: key);

  static const String routeName = "/RegisterPage";

  final String title;

  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final formValidators = new FormValidators();
  final confirmPasswordCtrl = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool _autoValidate = false;
  String _email;
  String _password;
  String _confirmPassword;
  String _userId;

  void _validateInputs() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

     try {
       AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
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

  void _goToLoginPage() {
    Navigator.pushNamed(context, RegisterPage.routeName);
  }


  @override
  void dispose() {
    confirmPasswordCtrl.dispose();
    super.dispose();
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
      controller: confirmPasswordCtrl,
      isPassword: true,
    );

    final confirmPasswordField = CustomTextField(
      keyboardType: TextInputType.text,
      hintText: 'Confirm Password',
      validators: (String arg) => formValidators.validateConfirmPassword(arg, confirmPasswordCtrl.text),
      onSaved: (String val) => _confirmPassword = val,
      isPassword: true,
    );

    final loginLinkBtn = CustomButton(
      context: context,
      buttonText: "I already have an Account",
      onPressed: _goToLoginPage,
      withoutBg: true,
    );

    final registerButton = CustomButton(
      context: context,
      buttonText: "Register",
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
                      height: 80.0,
                      child: Image.asset(
                        "images/flutter_logo.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 45.0),
                    emailField,
                    SizedBox(height: 25.0),
                    passwordField,
                    SizedBox(height: 25.0),
                    confirmPasswordField,
                    SizedBox(height: 35.0),
                    registerButton,
                    SizedBox(height: 15.0),
                    loginLinkBtn,
                    SizedBox(height: 15.0),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

