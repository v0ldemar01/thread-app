import 'package:flutter/material.dart';
import 'package:thread_app/utils/fieldFocus.dart';
import 'package:thread_app/utils/validate/phone.dart';

import 'formated_text_field.dart';

class EmailField extends StatelessWidget {
  final TextEditingController phoneController; 
  final FocusNode currentFocus;
  final FocusNode nextFocus;
  final Function onSaved;

  EmailField({this.phoneController, this.currentFocus, this.nextFocus, this.onSaved});

  @override
  Widget build(BuildContext context) {
    return RoundedTextField(
      textFormFieldChild: TextFormField(
        focusNode: currentFocus,
        autofocus: true,
        onFieldSubmitted: (_) {
          fieldFocusChange(context, currentFocus, nextFocus);
        },
        controller: phoneController,
        decoration: InputDecoration(
          labelText: 'Phone *',
          labelStyle: TextStyle(
            color: Colors.blue,
            height: 1.0,   
            fontSize: 18.0,
            fontWeight: FontWeight.w500,        
          ),
          hintText: 'Enter your email',
          prefixIcon: Icon(Icons.alternate_email),
          suffixIcon: GestureDetector(
            onTap: () {
              phoneController.clear();
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
        validator: validateEmail,
        onSaved: onSaved,
      ),
    );
  }
}