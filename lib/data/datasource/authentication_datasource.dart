import 'package:dio/dio.dart';
import '../../utility/Errors/api_exception.dart';

abstract class IAuthenticaitonDataSource {
  Future<String> login(String username, String password);
  Future<void> register(
      String username, String password, String passwordConfirm);
}

class AuthenticationRemoteDataSource implements IAuthenticaitonDataSource {
  final Dio _dio;
  AuthenticationRemoteDataSource(this._dio);
  @override
  Future<void> register(
      String username, String password, String passwordConfirm) async {
    try {
      await _dio.post(
        'collections/users/records',
        data: {
          'username': username,
          'password': password,
          'passwordConfirm': passwordConfirm,
        },
      );
    } on DioException {
      throw ApiException('Error', 400);
    } catch (ex) {
      throw ApiException('Error', 300);
    }
  }

  @override
  Future<String> login(String username, String password) async {
    try {
      var response = await _dio.post(
        'collections/users/auth-with-password',
        data: {
          'identity': username,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        return response.data['token'];
      }
    } on DioException {
      throw ApiException('Error', 402);
    } catch (ex) {
      throw ApiException('Error', 402);
    }
    return '';
  }
}
