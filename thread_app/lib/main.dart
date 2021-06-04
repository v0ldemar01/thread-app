import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thread_app/pages/home_page.dart';
import 'package:thread_app/pages/login_page.dart';
import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;
import 'package:thread_app/pages/register_page.dart';
import 'package:thread_app/services/user_service.dart';

import 'bloc/user_bloc/user_bloc.dart';
import 'bloc/user_bloc/user_event.dart';
import 'bloc/user_bloc/user_state.dart';

void main() {
  debugPaintSizeEnabled = false;
  runApp(BlocProvider<UserBloc>(
    create: (context) {
      final authService = AuthService();      
      return UserBloc(authenticationService: authService)
        ..add(AuthenticationInit());
    },
    child: MyApp()
  ));
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Thread',      
      home: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is AuthSuccess) {            
            return HomePage();
          }
          if (state is LoginInitial || state is AuthBreak) {
            return LoginPage();
          }   
          if (state is RegisterInitial) {
            return RegisterPage();
          }            
          return Scaffold(            
            body: Container(
              child: Center(
                child: CircularProgressIndicator()
              ),
            ),
          );
        },
      ),
    );
  }
}
