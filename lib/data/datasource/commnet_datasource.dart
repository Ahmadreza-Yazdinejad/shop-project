import 'package:apple_shop/data/model/commet.dart';
import 'package:dio/dio.dart';

import '../../utility/Errors/api_exception.dart';

abstract class ICommnetDataSource {
  Future<List<Comment>> getCommentList(String productId);
}

class CommnetRemoteDataSource extends ICommnetDataSource {
  final Dio _dio;
  CommnetRemoteDataSource(this._dio);
  @override
  Future<List<Comment>> getCommentList(String productId) async {
    try {
      Map<String, String> qParames = {'filter': 'product_id="$productId"'};
      var response = await _dio.get('collections/comment/records',
          queryParameters: qParames);
      return response.data['items']
          .map<Comment>(
            (jsoneMapObject) => Comment.formMapJsone(jsoneMapObject),
          )
          .toList();
    } on DioException catch (ex) {
      throw ApiException(
          ex.response!.data['errorMessage'], ex.response!.statusCode);
    } catch (ex) {
      throw ApiException('Error', 400);
    }
  }
}
