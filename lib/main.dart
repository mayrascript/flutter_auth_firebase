import 'package:flutter/material.dart';
import 'package:flutter_auth_firebase/auth/login-page.dart';
import 'package:flutter_auth_firebase/auth/register-page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _routes = <String, WidgetBuilder> {
      RegisterPage.routeName: (BuildContext context) => new RegisterPage(title: "RegisterPage"),
    };

    return MaterialApp(
      title: 'Flutter login UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(title: 'Flutter Simple Login'),
      routes: _routes,
    );
  }
}