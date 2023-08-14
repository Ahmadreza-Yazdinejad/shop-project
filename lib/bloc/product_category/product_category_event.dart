abstract class ProductCategoryEvent {}

class ProductCategoryGetData extends ProductCategoryEvent {
  String categoryId;
  ProductCategoryGetData(this.categoryId);
}
