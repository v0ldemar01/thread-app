import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thread_app/bloc/user_bloc/user_bloc.dart';
import 'package:thread_app/bloc/user_bloc/user_event.dart';
import 'package:thread_app/widgets/auth/phone_text_field.dart';
import 'package:thread_app/widgets/auth/password_text_field.dart';

import '../auth/auth_widgets.dart';
import '../auth/username_text_field.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController(); 
  final _usernameController = TextEditingController(); 
  final _passwordController = TextEditingController();

  final _phoneFocus = FocusNode();
  final _usernameFocus = FocusNode();
  final _passwordFocus = FocusNode();
  UserBloc _userBloc;

  @override
  void initState() {
    super.initState();
    _userBloc = BlocProvider.of<UserBloc>(context);    
  }

  @override
  void dispose() {    
    _phoneController.dispose();   
    _usernameController.dispose(); 
    _passwordController.dispose();    
    _phoneFocus.dispose();
    _usernameFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }
  
  void _submitForm() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();      
      _userBloc.add(RegisterTry(
        phone: _phoneController.text, username: _usernameController.text, password: _passwordController.text
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Form is not valid'),
        ),
      );
    }     
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0, bottom: 10.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            EmailField(
              phoneController: _phoneController,
              currentFocus: _phoneFocus,
              nextFocus: _usernameFocus,
            ),
            SizedBox(height: 10.0),
            UsernameField(
              usernameController: _usernameController,
              currentFocus: _usernameFocus,
              nextFocus: _passwordFocus,
            ),
            SizedBox(height: 10.0),
            PasswordField(
              passwordController: _passwordController,
              currentFocus: _passwordFocus,
            ),
            SizedBox(height: 10.0),
            ActionButton(
              buttonName: 'Register',
              action: () => _submitForm(),
            ),
          ],
        ),
      ),
    );  
  }
}

