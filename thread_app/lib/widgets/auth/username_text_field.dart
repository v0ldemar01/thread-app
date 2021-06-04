import 'package:flutter/material.dart';
import 'package:thread_app/utils/fieldFocus.dart';
import 'package:thread_app/utils/validate/username.dart';

import 'formated_text_field.dart';

class UsernameField extends StatelessWidget {
  final TextEditingController usernameController; 
  final FocusNode currentFocus;
  final FocusNode nextFocus;
  final Function onSaved;

  UsernameField({this.usernameController, this.currentFocus, this.nextFocus, this.onSaved});

  @override
  Widget build(BuildContext context) {
    return RoundedTextField(
      textFormFieldChild: TextFormField(
        focusNode: currentFocus,
        autofocus: true,
        onFieldSubmitted: (_) {
          fieldFocusChange(context, currentFocus, nextFocus);
        },
        controller: usernameController,
        decoration: InputDecoration(
          labelText: 'Username *',
          labelStyle: TextStyle(
            color: Colors.blue,
            height: 1.0,   
            fontSize: 18.0,
            fontWeight: FontWeight.w500,        
          ),
          hintText: 'Enter your username',
          prefixIcon: Icon(Icons.person),
          suffixIcon: GestureDetector(
            onTap: () {
              usernameController.clear();
            },
            child: Icon(
              Icons.delete_outline,
              color: Colors.black,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(29.0)),
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(29.0)),
            borderSide: BorderSide(color: Colors.blue, width: 2.0),
          ),          
        ),
        keyboardType: TextInputType.emailAddress,
        validator: validateUsername,
        onSaved: onSaved,
      ),
    );
  }
}