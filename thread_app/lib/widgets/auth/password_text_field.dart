import 'package:flutter/material.dart';
import 'package:thread_app/utils/validate/password.dart';

import 'formated_text_field.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController passwordController; 
  final FocusNode currentFocus;  
  final Function onSaved;  

  PasswordField({this.passwordController, this.currentFocus, this.onSaved});

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return RoundedTextField(
      textFormFieldChild: TextFormField(
        focusNode: widget.currentFocus,
        controller: widget.passwordController,
        obscureText: !_passwordVisible,
        maxLength: 10,
        decoration: InputDecoration(
          labelText: 'Password *',
          labelStyle: TextStyle(
            color: Colors.blue,
            height: 1.0,   
            fontSize: 18.0,
            fontWeight: FontWeight.w500,        
          ),
          hintText: 'Enter the password',
          suffixIcon: GestureDetector(
            onLongPress: () {
              setState(() {
                _passwordVisible = true;
              });
            },
            onLongPressUp: () {
              setState(() {
                _passwordVisible = false;
              });
            },
            child: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Colors.black,
            ),
          ),
          prefixIcon: Icon(Icons.lock),          
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(29.0)),
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(29.0)),
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),
        ), 
        validator: validatePassword,
      )
    );
  }
}