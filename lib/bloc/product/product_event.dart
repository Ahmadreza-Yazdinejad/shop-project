import '../../../data/model/main_product.dart';

abstract class ProductDetailEvent {}

class ProductDetailRequiestList extends ProductDetailEvent {
  String categoryId;
  String productId;
  String id;
  ProductDetailRequiestList(this.productId, this.categoryId, this.id);
}

class ProductAddedBasket extends ProductDetailEvent {
  Product product;
  ProductAddedBasket(this.product);
}
