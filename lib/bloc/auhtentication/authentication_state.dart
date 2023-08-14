import 'package:dartz/dartz.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoginGetData extends AuthState {
  Either<String, String> AuthLogin;
  AuthLoginGetData(this.AuthLogin);
}

class AuthRegisterGetData extends AuthState {
  Either<String, String> AuthRegister;
  AuthRegisterGetData(this.AuthRegister);
}
