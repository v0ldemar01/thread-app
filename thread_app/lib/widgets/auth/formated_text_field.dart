  
import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  final Widget textFormFieldChild;
  
  const RoundedTextField({
    Key key,
    this.textFormFieldChild  
  }) : super(key: key);  
  
  @override
  Widget build(BuildContext context) {    
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),      
      child: textFormFieldChild,
    );
  }
}