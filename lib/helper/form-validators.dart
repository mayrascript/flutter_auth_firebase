class FormValidators {
  static FormValidators _formValidators;
  factory FormValidators() => _formValidators ??= new FormValidators._();

  FormValidators._();

  String validateEmail(String arg) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(arg))
      return 'Enter valid Email';
    else
      return null;
  }

  String validatePassword(String arg) {
    if (arg.length < 6)
      return 'Password must be more than 6 charaters';
    else if (arg.length > 15)
      return 'Password must be less than 16 charaters';
    else if (arg.isEmpty)
      return 'This field can not be empty';
    else
      return null;
  }

  String validateConfirmPassword(String arg, String password) {
    print(arg);
    print(password);
    if (arg != password)
      return 'Password do not match';
    else
      return null;
  }
}