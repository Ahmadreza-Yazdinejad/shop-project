import 'package:hive_flutter/adapters.dart';
import '../model/addbasket.dart';

abstract class IBasketDataSource {
  Future<void> addproductToBox(BasketItem basketItem);
  Future<List<BasketItem>> getBasketItemList();

  Future<int> getFinalPriceProduct();
}

class IBasketLocalDataSource extends IBasketDataSource {
  var box = Hive.box<BasketItem>('BasketBox');

  @override
  Future<void> addproductToBox(BasketItem basketItem) async {
    box.add(basketItem);
  }

  @override
  Future<List<BasketItem>> getBasketItemList() async {
    return box.values.toList();
  }

  @override
  Future<int> getFinalPriceProduct() async {
    var finalPrice = box.values.toList();
    var finalPricee = finalPrice.fold(
        0, (previousValue, product) => previousValue + product.realPrice!);
    return finalPricee;
  }
}
