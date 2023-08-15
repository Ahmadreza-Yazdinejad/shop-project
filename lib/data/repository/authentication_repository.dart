import 'package:dartz/dartz.dart';
import '../datasource/authentication_datasource.dart';
import '../../utility/Errors/api_exception.dart';

abstract class IAuthenticationRespository {
  Future<Either<String, String>> register(username, password, passwordConfirm);
  Future<Either<String, String>> login(username, password);
}

class AuthenticatonRespository extends IAuthenticationRespository {
  final IAuthenticaitonDataSource _datasource;
  AuthenticatonRespository(this._datasource);
  @override
  Future<Either<String, String>> register(
      username, password, passwordConfirm) async {
    try {
      await _datasource.register(username, password, passwordConfirm);
      return right('شما ثبت نام شدید');
    } on ApiException {
      return left('شما یک مرتبه ثبت نام شدید');
    } catch (ex) {
      return left('ارور نا مشخص');
    }
  }

  @override
  Future<Either<String, String>> login(username, password) async {
    try {
      await _datasource.login(username, password);
      return right('شما وارد شدید');
    } on ApiException {
      return left('نام کاربری یا کلمه عبور اشتباه است');
    } catch (ex) {
      return left('ارور نا مشخص');
    }
  }
}
