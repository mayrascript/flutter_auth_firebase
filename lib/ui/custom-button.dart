import 'package:flutter/material.dart';

class CustomButton extends Material {
  static TextStyle _style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  static Color _customBlue = Color(0xff01A0C7);

  CustomButton({
    context,
    String buttonText,
    Function onPressed,
    TextAlign textAlign = TextAlign.center,
    bool withoutBg = false
  }) : super(
    elevation: 5.0,
    borderRadius: BorderRadius.circular(30.0),
    color: withoutBg ? null : _customBlue,
    child: MaterialButton(
        minWidth: MediaQuery
            .of(context)
            .size
            .width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: onPressed,
        child: Text(
            buttonText,
            textAlign: textAlign,
            style: _style.copyWith(
                color: withoutBg ? _customBlue : Colors.white, fontWeight: FontWeight.bold)))
  );
}