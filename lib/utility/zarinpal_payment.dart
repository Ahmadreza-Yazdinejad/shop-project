import 'package:apple_shop/utility/extentions/string_extentions.dart';
import 'package:apple_shop/utility/launch_url.dart';
import 'package:uni_links/uni_links.dart';
import 'package:zarinpal/zarinpal.dart';

abstract class PaymentHandler {
  Future<void> initPaymentRequiest();
  Future<void> sendRequiestPayment();
  Future<void> verifyPaymentRequiest(String status, String authority);
}

class ZarinpalPaymentHandler extends PaymentHandler {
  final UrlLauncher _url;
  final PaymentRequest _paymentRequest;
  ZarinpalPaymentHandler(this._paymentRequest, this._url);
  @override
  Future<void> initPaymentRequiest() async {
    _paymentRequest.setAmount(1000);
    _paymentRequest.setIsSandBox(true);
    _paymentRequest.setDescription('this is test from apple shop');
    _paymentRequest.setCallbackURL('expertflutter//:shop');
    _paymentRequest.setMerchantID('3434kj_kdjf_kdf_kdjfdj3r_dfkjf');

    linkStream.listen(
      (deepLink) {
        if (deepLink!.toLowerCase().contains('authority')) {
          String? status = deepLink.extractValueFromQuery('Status');
          String? authority = deepLink.extractValueFromQuery('Authority');
          verifyPaymentRequiest(status!, authority!);
        }
      },
    );
  }

  @override
  Future<void> sendRequiestPayment() async {
    ZarinPal().startPayment(
      _paymentRequest,
      (status, paymentGatewayUri) {
        _url.lauchUrl(paymentGatewayUri!);
      },
    );
  }

  @override
  Future<void> verifyPaymentRequiest(String status, String authority) async {
    ZarinPal().verificationPayment(
      status,
      authority,
      _paymentRequest,
      (isPaymentSuccess, refID, paymentRequest) {
        if (isPaymentSuccess) {
          print('thank you ');
        } else {
          print('Errror');
        }
      },
    );
  }
}
