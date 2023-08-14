import 'package:apple_shop/bloc/product/product_event.dart';
import 'package:apple_shop/bloc/product/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/addbasket.dart';
import '../../data/repository/basket_repository.dart';
import '../../data/repository/varients_image_repository.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final IProductDetailRepository _productDeatilRepository;
  final IBasketRepository _basketRepository;
  ProductDetailBloc(this._productDeatilRepository, this._basketRepository)
      : super(ProductDetailInitial()) {
    on<ProductDetailRequiestList>(
      (event, emit) async {
        emit(ProductDetailLaoding());
        var response =
            await _productDeatilRepository.getDetailImageList(event.productId);
        var response2 = await _productDeatilRepository
            .getProductVarientList(event.productId);
        var response3 = await _productDeatilRepository
            .getCategoryProductdetail(event.categoryId);
        var response4 = await _productDeatilRepository.getProp(event.productId);

        emit(
          ProductDetailGetData(
            response3,
            response,
            response2,
            response4,
          ),
        );
      },
    );
    on<ProductAddedBasket>(
      (event, emit) async {
        var value = BasketItem(
          event.product.id,
          event.product.categoryId,
          event.product.thumbnail,
          event.product.discountPrice,
          event.product.price,
          event.product.popularity,
          event.product.name,
          event.product.collectionId,
        );
        await _basketRepository.getBasketRepository(value);
      },
    );
  }
}
