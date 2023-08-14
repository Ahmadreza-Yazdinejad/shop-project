import 'package:dartz/dartz.dart';

import '../../data/model/addbasket.dart';

abstract class BasketState {}

class BasketInitial extends BasketState {}

class BasketDataFetched extends BasketState {
  Either<String, List<BasketItem>> getBasketItemList;
  int getFinalPrice;

  BasketDataFetched(this.getBasketItemList, this.getFinalPrice);
}
