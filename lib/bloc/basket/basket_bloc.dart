import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/basket_repository.dart';
import '../../utility/zarinpal_payment.dart';
import 'basket_event.dart';
import 'basket_state.dart';

class BasketBloc extends Bloc<BasketSEvent, BasketState> {
  final PaymentHandler _paymentHander;
  final IBasketRepository _basketRepository;
  BasketBloc(this._basketRepository, this._paymentHander)
      : super(BasketInitial()) {
    on<BasketFetchDataFromHive>(
      (event, emit) async {
        var response = await _basketRepository.getBasketItemList();
        var response2 = await _basketRepository.getFinalPriceBasketList();
        emit(
          BasketDataFetched(response, response2),
        );
      },
    );
    on<BasketInitPayment>((event, emit) {
      _paymentHander.initPaymentRequiest();
    });
    on<BasketPaymentRequiest>(
      (event, emit) {
        _paymentHander.sendRequiestPayment();
      },
    );
  }
}
