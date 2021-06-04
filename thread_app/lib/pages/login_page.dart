import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thread_app/bloc/user_bloc/user_bloc.dart';
import 'package:thread_app/bloc/user_bloc/user_state.dart';
import 'package:thread_app/pages/register_page.dart';
import 'package:thread_app/widgets/auth/auth_widgets.dart';
import 'package:thread_app/widgets/forms/login_form.dart';

class LoginPage extends StatelessWidget {  

  @override
  Widget build(BuildContext context) {
    return Scaffold(     
      backgroundColor: Colors.white,  
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {            
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text('Failure'),
              ),
            );
          }
        },
        child: Container(
          height: double.infinity,
          child: SafeArea(
            minimum: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [        
                  Logo(), 
                  PageGreeting(
                    pageGreeting: 'Login to your Account',
                  ),    
                  LoginForm(),
                  OtherAuthPage(
                    prevText: 'New to us?',
                    toPageName: 'Sign Up',
                    nextPage: RegisterPage(),
                  ),   
                  ForgotPassword()                 
                ],
              )
            ),
          ),
        ),
      ),
    );
  }
}


