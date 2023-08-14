import 'package:dartz/dartz.dart';
import '../datasource/varients_image_datasource.dart';
import '../model/category.dart';
import '../model/product_detail_image.dart';
import '../model/product_properties.dart';
import '../model/product_varient.dart';
import '../../utility/Errors/api_exception.dart';

abstract class IProductDetailRepository {
  Future<Either<String, List<ProductDetailImage>>> getDetailImageList(
      String productId);
  Future<Either<String, List<ProductVarients>>> getProductVarientList(
      String productId);
  Future<Either<String, Categoryy>> getCategoryProductdetail(String categoryId);
  Future<Either<String, List<ProductProperties>>> getProp(String productId);
}

class ProductDetailRepository extends IProductDetailRepository {
  final IProductDetailDataSource _dataSource;
  ProductDetailRepository(this._dataSource);
  @override
  Future<Either<String, List<ProductDetailImage>>> getDetailImageList(
      String productId) async {
    try {
      var response = await _dataSource.productDetailImageList(productId);
      return right(response);
    } on ApiException {
      return left('Error');
    }
  }

  @override
  Future<Either<String, List<ProductVarients>>> getProductVarientList(
      String productId) async {
    try {
      var vareintsProductList =
          await _dataSource.getProductVarientList(productId);
      return right(vareintsProductList);
    } on ApiException {
      return left('Erorr Boy!!');
    }
  }

  @override
  Future<Either<String, Categoryy>> getCategoryProductdetail(
      String categoryId) async {
    try {
      var categoryDetail =
          await _dataSource.getCategoryProductDetail(categoryId);
      return right(categoryDetail);
    } on ApiException {
      return left('Erorr Boy!!');
    }
  }

  @override
  Future<Either<String, List<ProductProperties>>> getProp(
      String productId) async {
    try {
      var productProperties = await _dataSource.getProperties(productId);
      return right(productProperties);
    } on ApiException {
      return left('Erorr Boy!!');
    }
  }
}
