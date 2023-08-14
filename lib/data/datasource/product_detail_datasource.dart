import 'package:dio/dio.dart';
import '../model/main_product.dart';
import '../../utility/Errors/api_exception.dart';

abstract class IProductDataSource {
  Future<List<Product>> productList();
  Future<List<Product>> prosuctHottstList();
  Future<List<Product>> prosuctBestSellerList();
  Future<List<Product>> getProductMachCategory(String id);
}

class ProductRemoteDataSource implements IProductDataSource {
  final Dio _dio;
  ProductRemoteDataSource(this._dio);
  @override
  Future<List<Product>> productList() async {
    try {
      var response = await _dio.get('collections/products/records');
      return response.data['items']
          .map<Product>((jsoneObjectMap) => Product.formJsone(jsoneObjectMap))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException('Error ', 747);
    }
  }

  @override
  Future<List<Product>> prosuctHottstList() async {
    try {
      Map<String, String> qParames = {'filter': 'popularity="Hotest"'};

      var response = await _dio.get('collections/products/records',
          queryParameters: qParames);
      return response.data['items']
          .map<Product>(
            (jsoneObjectMap) => Product.formJsone(jsoneObjectMap),
          )
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException('Error', 324);
    }
  }

  @override
  Future<List<Product>> prosuctBestSellerList() async {
    try {
      Map<String, String> qParames = {'filter': 'popularity="Best Seller"'};

      var response = await _dio.get('collections/products/records',
          queryParameters: qParames);
      return response.data['items']
          .map<Product>(
            (jsoneObjectMap) => Product.formJsone(jsoneObjectMap),
          )
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException('Error', 324);
    }
  }

  @override
  Future<List<Product>> getProductMachCategory(String id) async {
    try {
      Map<String, String> qParams = {'filter': 'category="categoryId"'};
      var response = await _dio.get('collections/products/records',
          queryParameters: qParams);
      return response.data['items']
          .map<Product>((jsoneObjectMap) => Product.formJsone(jsoneObjectMap))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException('Error ', 747);
    }
  }
}
