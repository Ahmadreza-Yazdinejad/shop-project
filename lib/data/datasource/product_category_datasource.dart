import 'package:dio/dio.dart';
import '../model/main_product.dart';
import '../../utility/Errors/api_exception.dart';

abstract class IProductCategoryDataSource {
  Future<List<Product>> getProductCategoryList(String categoryId);
}

class ProductCategoryRemoteDataSource extends IProductCategoryDataSource {
  final Dio _dio;
  ProductCategoryRemoteDataSource(this._dio);
  @override
  Future<List<Product>> getProductCategoryList(String categoryId) async {
    try {
      Map<String, String> qParsms = {'filter': 'category="$categoryId"'};
      Response<dynamic> response;
      if (categoryId == '78q8w901e6iipuk') {
        response = await _dio.get('collections/products/records');
      } else {
        response = await _dio.get('collections/products/records',
            queryParameters: qParsms);
      }
      return response.data['items']
          .map<Product>((jsoneMap) => Product.formJsone(jsoneMap))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data['message'], ex.response?.statusCode);
    }
  }
}
