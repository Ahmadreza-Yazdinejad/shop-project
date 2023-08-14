abstract class AuthEvent {}

class AuthRegisterRequiest extends AuthEvent {
  String username;
  String password;
  String passwordConfirm;
  AuthRegisterRequiest(this.password, this.passwordConfirm, this.username);
}

class AuthLoginRequiest extends AuthEvent {
  String username;
  String password;
  AuthLoginRequiest(this.username, this.password);
}
