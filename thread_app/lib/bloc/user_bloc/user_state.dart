import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:thread_app/models/user.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class AuthenticateInitial extends UserState {}
class LoginInitial extends UserState {}
class RegisterInitial extends UserState {}

class AuthLoading extends UserState {}

class AuthSuccess extends UserState {
  final User user;

  AuthSuccess({@required this.user});

  @override
  List<Object> get props => [user];
}

class AuthBreak extends UserState {}

class AuthFailure extends UserState {
  final Exception message;

  AuthFailure({@required this.message});

  @override
  List<Object> get props => [message];
}

