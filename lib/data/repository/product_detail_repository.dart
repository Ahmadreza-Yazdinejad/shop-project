import 'package:dartz/dartz.dart';

import '../datasource/product_detail_datasource.dart';
import '../model/main_product.dart';
import '../../utility/Errors/api_exception.dart';

abstract class IProductRepository {
  Future<Either<String, List<Product>>> listProduct();
  Future<Either<String, List<Product>>> productHottestList();
  Future<Either<String, List<Product>>> productBestSellerList();
  Future<Either<String, List<Product>>> getProductMachCategoryList(String id);
}

class ProductRepository extends IProductRepository {
  final IProductDataSource _datasource;
  ProductRepository(this._datasource);
  @override
  Future<Either<String, List<Product>>> listProduct() async {
    try {
      var response = await _datasource.productList();
      return right(response);
    } on ApiException {
      return left('ارور نا مشخص');
    }
  }

  @override
  Future<Either<String, List<Product>>> productHottestList() async {
    try {
      var resposne = await _datasource.prosuctHottstList();
      return right(resposne);
    } on ApiException {
      return left('You have an Error');
    }
  }

  @override
  Future<Either<String, List<Product>>> productBestSellerList() async {
    try {
      var resposne = await _datasource.prosuctBestSellerList();
      return right(resposne);
    } on ApiException {
      return left('You have an Error');
    }
  }

  @override
  Future<Either<String, List<Product>>> getProductMachCategoryList(
      String id) async {
    try {
      var productMachList = await _datasource.getProductMachCategory(id);
      return right(productMachList);
    } on ApiException {
      return left('You have an Error');
    }
  }
}
