import 'package:dio/dio.dart';
import '../model/banner.dart';
import '../../utility/Errors/api_exception.dart';

abstract class IBannerDataSource {
  Future<List<BannerCampain>> bannerListt();
}

class BannerRemoteDataSource implements IBannerDataSource {
  final Dio _dio;
  BannerRemoteDataSource(this._dio);
  @override
  Future<List<BannerCampain>> bannerListt() async {
    try {
      var resposne = await _dio.get('collections/banner/records');
      return resposne.data['items']
          .map<BannerCampain>(
              (jsoneObject) => BannerCampain.fromJsone(jsoneObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.data['message'], ex.response?.statusCode);
    } catch (ex) {
      throw ApiException('an Error', 503);
    }
  }
}
