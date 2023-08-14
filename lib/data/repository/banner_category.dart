import 'package:dartz/dartz.dart';

import '../datasource/banner_datasource.dart';
import '../model/banner.dart';
import '../../utility/Errors/api_exception.dart';

abstract class IBannerRepository {
  Future<Either<String, List<BannerCampain>>> bannerListt();
}

class BannerRepository extends IBannerRepository {
  final IBannerDataSource _datasource;
  BannerRepository(this._datasource);
  @override
  Future<Either<String, List<BannerCampain>>> bannerListt() async {
    try {
      List<BannerCampain> bannerListItem = await _datasource.bannerListt();
      return right(bannerListItem);
    } on ApiException {
      return left('Error 2');
    }
  }
}
