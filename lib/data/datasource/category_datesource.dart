import 'package:dio/dio.dart';
import '../model/category.dart';
import '../../utility/Errors/api_exception.dart';

abstract class ICategoryDataSource {
  Future<List<Categoryy>> getCategoryList();
}

class CategoryRemoteDataSource extends ICategoryDataSource {
  final Dio _dio;
  CategoryRemoteDataSource(this._dio);
  @override
  Future<List<Categoryy>> getCategoryList() async {
    try {
      var response = await _dio.get('collections/category/records');
      return response.data['items']
          .map<Categoryy>((jsoneMap) => Categoryy.fromMapJsone(jsoneMap))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException('un known Error', 408);
    }
  }
}
