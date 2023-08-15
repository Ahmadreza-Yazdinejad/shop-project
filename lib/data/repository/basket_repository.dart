import 'package:dartz/dartz.dart';
import '../datasource/basket_datasouce.dart';
import '../model/addbasket.dart';

abstract class IBasketRepository {
  Future<Either<String, String>> getBasketRepository(BasketItem basketItem);
  Future<Either<String, List<BasketItem>>> getBasketItemList();
  Future<int> getFinalPriceBasketList();
}

class BasketRepository extends IBasketRepository {
  final IBasketDataSource _datasource;
  BasketRepository(this._datasource);

  @override
  Future<Either<String, String>> getBasketRepository(
      BasketItem basketItem) async {
    try {
      await _datasource.addproductToBox(basketItem);
      return right('محصول به سبد خرید اضافه شد');
    } catch (ex) {
      return left('خطا, محصول مورد نظر به سبد خرید اضافه نشد');
    }
  }

  @override
  Future<Either<String, List<BasketItem>>> getBasketItemList() async {
    try {
      var basketItemList = await _datasource.getBasketItemList();
      return right(basketItemList);
    } catch (ex) {
      return left('خطا در نمایش محصولات');
    }
  }

  @override
  Future<int> getFinalPriceBasketList() async {
    var finalPrice = await _datasource.getFinalPriceProduct();
    return finalPrice;
  }
}
