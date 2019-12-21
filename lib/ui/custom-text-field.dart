import 'package:flutter/material.dart';

class CustomTextField extends TextFormField {
  static TextStyle _style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);

  CustomTextField({
    TextInputType keyboardType,
    String hintText,
    Function validators,
    Function onSaved,
    bool isPassword = false,
    TextEditingController controller
  }): super(
      obscureText: isPassword,
      style: _style,
      keyboardType: TextInputType.emailAddress,
      onSaved: onSaved,
      validator: validators,
      controller: controller,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: hintText,
          border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))));

}