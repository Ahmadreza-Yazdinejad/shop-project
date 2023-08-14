import 'package:dartz/dartz.dart';
import '../../../data/model/category.dart';
import '../../data/model/product_detail_image.dart';
import '../../data/model/product_properties.dart';
import '../../data/model/product_varient.dart';

abstract class ProductDetailState {}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailLaoding extends ProductDetailState {}

class ProductDetailGetData extends ProductDetailState {
  Either<String, List<ProductDetailImage>> productDetailImage;
  Either<String, List<ProductVarients>> productVarientsList;
  Either<String, Categoryy> categoryProductDetail;
  Either<String, List<ProductProperties>> productProperties;
  ProductDetailGetData(
    this.categoryProductDetail,
    this.productDetailImage,
    this.productVarientsList,
    this.productProperties,
  );
}
