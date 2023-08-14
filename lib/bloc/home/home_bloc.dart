import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repository/banner_category.dart';
import '../../data/repository/category_respository.dart';
import '../../data/repository/product_detail_repository.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final IBannerRepository _bannerRepository;
  final ICategoryRepository _categoryRepositry;
  final IProductRepository _productRepository;
  HomeBloc(
      this._bannerRepository, this._categoryRepositry, this._productRepository)
      : super(HomeInitial()) {
    on<HomeGetDataEvent>(
      (event, emit) async {
        emit(HomeLoading());
        var respponse = await _bannerRepository.bannerListt();
        var reposne2 = await _categoryRepositry.categoryList();
        var response3 = await _productRepository.listProduct();
        var response4 = await _productRepository.productHottestList();
        var response5 = await _productRepository.productBestSellerList();

        emit(
          HomeGetData(respponse, reposne2, response3, response4, response5),
        );
      },
    );
  }
}
