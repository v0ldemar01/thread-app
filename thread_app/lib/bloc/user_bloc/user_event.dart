import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:thread_app/models/user.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationInit extends UserEvent {}
class LoginInit extends UserEvent {}
class RegisterInit extends UserEvent {}

class LoginTry extends UserEvent {
  final String phone;
  final String password;

  LoginTry({@required this.phone, @required this.password});

  @override
  List<Object> get props => [phone, password];
}
class RegisterTry extends UserEvent {
  final String phone;
  final String username;
  final String password;

  RegisterTry({@required this.phone, @required this.username, @required this.password});

  @override
  List<Object> get props => [phone, username, password];
}

class UserInSystem extends UserEvent {
  final User user;

  UserInSystem({@required this.user});

  @override
  List<Object> get props => [user];
}

class AuthAbort extends UserEvent {
  final Exception message;

  AuthAbort({@required this.message});

  @override
  List<Object> get props => [message];
}

class UserLoggedOut extends UserEvent {}