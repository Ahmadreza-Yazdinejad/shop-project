import 'package:dartz/dartz.dart';

import '../../data/model/main_product.dart';

abstract class ProductCategoryState {}

class ProductCategoryLoading extends ProductCategoryState {}

class ProudctCategoryGetData extends ProductCategoryState {
  Either<String, List<Product>> getProductMachList;
  ProudctCategoryGetData(this.getProductMachList);
}
