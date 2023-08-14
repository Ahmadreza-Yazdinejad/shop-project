import 'package:dartz/dartz.dart';

import '../datasource/category_datesource.dart';
import '../model/category.dart';
import '../../utility/Errors/api_exception.dart';

abstract class ICategoryRepository {
  Future<Either<String, List<Categoryy>>> categoryList();
}

class CategoryRepository extends ICategoryRepository {
  final ICategoryDataSource _datasource;
  CategoryRepository(this._datasource);
  @override
  Future<Either<String, List<Categoryy>>> categoryList() async {
    try {
      List<Categoryy> response = await _datasource.getCategoryList();

      return right(response);
    } on ApiException {
      return left('مشکلی پیش آمده');
    }
  }
}
