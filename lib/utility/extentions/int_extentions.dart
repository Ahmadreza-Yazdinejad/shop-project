import 'package:intl/intl.dart';

extension IntExtentions on int? {
  String formatIntAsPriceWithCommas() {
    NumberFormat numberFormat = NumberFormat('#,##0', 'en_US');
    return numberFormat.format(this);
  }
}
