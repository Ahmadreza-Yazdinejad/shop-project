import 'package:apple_shop/bloc/product_category/product_category_event.dart';
import 'package:apple_shop/bloc/product_category/product_category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/product_category_respository.dart';

class ProductCategoryBloc
    extends Bloc<ProductCategoryEvent, ProductCategoryState> {
  final IProductCategoryRepository _productCategoryRepository;
  ProductCategoryBloc(this._productCategoryRepository)
      : super(ProductCategoryLoading()) {
    on<ProductCategoryGetData>(
      (event, emit) async {
        var response = await _productCategoryRepository
            .getProductCategoryList(event.categoryId);
        emit(
          ProudctCategoryGetData(response),
        );
      },
    );
  }
}
