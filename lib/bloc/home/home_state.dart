import 'package:dartz/dartz.dart';
import '../../../data/model/category.dart';
import '../../data/model/banner.dart';
import '../../data/model/main_product.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeGetData extends HomeState {
  Either<String, List<BannerCampain>> bannerList;
  Either<String, List<Categoryy>> categoryList;
  Either<String, List<Product>> getProdurctList;
  Either<String, List<Product>> productHottestList;
  Either<String, List<Product>> productBestSellerList;
  HomeGetData(
    this.bannerList,
    this.categoryList,
    this.getProdurctList,
    this.productBestSellerList,
    this.productHottestList,
  );
}
