import 'package:dartz/dartz.dart';
import '../datasource/product_category_datasource.dart';
import '../model/main_product.dart';
import '../../utility/Errors/api_exception.dart';

abstract class IProductCategoryRepository {
  Future<Either<String, List<Product>>> getProductCategoryList(
      String categoryId);
}

class ProductCategoryRespository extends IProductCategoryRepository {
  final IProductCategoryDataSource _datasource;
  ProductCategoryRespository(this._datasource);
  @override
  Future<Either<String, List<Product>>> getProductCategoryList(
      String categoryId) async {
    try {
      var produuctCategoryList =
          await _datasource.getProductCategoryList(categoryId);
      return right(produuctCategoryList);
    } on ApiException {
      return left('ارور نا مشخص');
    }
  }
}
