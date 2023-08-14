import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/authentication_repository.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthenticationRespository _respository;
  AuthBloc(this._respository) : super(AuthInitial()) {
    on<AuthRegisterRequiest>(
      (event, emit) async {
        emit(AuthLoading());
        var resposnee = await _respository.register(
            event.username, event.password, event.passwordConfirm);
        emit(
          AuthRegisterGetData(resposnee),
        );
      },
    );
    on<AuthLoginRequiest>(
      (event, emit) async {
        emit(AuthLoading());
        var _response =
            await _respository.login(event.username, event.password);
        emit(
          AuthLoginGetData(_response),
        );
      },
    );
  }
}
