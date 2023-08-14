import 'package:apple_shop/data/model/varients.dart';
import 'package:apple_shop/data/model/varients_type.dart';

class ProductVarients {
  VarientType varientType;
  List<Varients> varientMachedList;

  ProductVarients({
    required this.varientMachedList,
    required this.varientType,
  });
}
