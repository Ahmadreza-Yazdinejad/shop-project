import 'package:dio/dio.dart';
import '../model/category.dart';
import '../model/product_detail_image.dart';
import '../model/product_properties.dart';
import '../model/product_varient.dart';
import '../model/varients.dart';
import '../model/varients_type.dart';
import '../../utility/Errors/api_exception.dart';

abstract class IProductDetailDataSource {
  Future<List<ProductDetailImage>> productDetailImageList(String productId);
  Future<List<VarientType>> getvarientTypeList();
  Future<List<Varients>> getVarientList(String productId);
  Future<List<ProductVarients>> getProductVarientList(String productId);
  Future<Categoryy> getCategoryProductDetail(String categoryId);
  Future<List<ProductProperties>> getProperties(String productId);
}

class ProductDetailRemoteDataSource implements IProductDetailDataSource {
  final Dio _dio;
  ProductDetailRemoteDataSource(this._dio);
  @override
  Future<List<ProductDetailImage>> productDetailImageList(
      String productId) async {
    try {
      Map<String, String> qParames = {'filter': ' product_id="$productId"'};
      var response = await _dio.get('collections/gallery/records',
          queryParameters: qParames);
      return response.data['items']
          .map<ProductDetailImage>((jsoneMapObjcet) =>
              ProductDetailImage.fromMapJsone(jsoneMapObjcet))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException('Erro', 300);
    }
  }

  @override
  Future<List<Varients>> getVarientList(String productId) async {
    try {
      Map<String, String> qParames = {'filter': ' product_id="$productId"'};
      var response = await _dio.get('collections/variants/records',
          queryParameters: qParames);
      return response.data['items']
          .map<Varients>(
              (jsoneMapObject) => Varients.formMapJsone(jsoneMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException('Erorr', 500);
    }
  }

  @override
  Future<List<VarientType>> getvarientTypeList() async {
    try {
      var response = await _dio.get('collections/variants_type/records');
      return response.data['items']
          .map<VarientType>(
              (jsoneMapObject) => VarientType.fromjson(jsoneMapObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException('Erorr', 500);
    }
  }

  @override
  Future<List<ProductVarients>> getProductVarientList(String productId) async {
    var varientList = await getVarientList(productId);
    var varientTypeList = await getvarientTypeList();
    List<ProductVarients> productVarientList = [];
    try {
      for (var varientType in varientTypeList) {
        var varientsListt = varientList
            .where((element) => element.typeId == varientType.id)
            .toList();
        productVarientList.add(
          ProductVarients(
              varientMachedList: varientsListt, varientType: varientType),
        );
      }
      return productVarientList;
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException('Erorr', 500);
    }
  }

  @override
  Future<Categoryy> getCategoryProductDetail(String categoryId) async {
    try {
      Map<String, String> qParames = {'filter': 'id="$categoryId"'};

      var response = await _dio.get('collections/category/records',
          queryParameters: qParames);
      return Categoryy.fromMapJsone(
        response.data['items'][0],
      );
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException('Erorr', 500);
    }
  }

  @override
  Future<List<ProductProperties>> getProperties(String productId) async {
    try {
      Map<String, String> qParames = {'filter': 'product_id="$productId"'};
      var resposne = await _dio.get('collections/properties/records',
          queryParameters: qParames);
      return resposne.data['items']
          .map<ProductProperties>(
              (jsoneMap) => ProductProperties.fromMapJsone(jsoneMap))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException('Erorr', 500);
    }
  }
}
