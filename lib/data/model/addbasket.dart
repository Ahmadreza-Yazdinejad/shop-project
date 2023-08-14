import 'package:hive/hive.dart';

part 'addbasket.g.dart';

@HiveType(typeId: 0)
class BasketItem {
  @HiveField(0)
  String id;
  @HiveField(1)
  String collectionId;
  @HiveField(2)
  String thumbnail;
  @HiveField(3)
  int discountPrice;
  @HiveField(4)
  int price;
  @HiveField(5)
  String popularity;
  @HiveField(6)
  String name;
  @HiveField(7)
  String categoryId;
  @HiveField(8)
  int? realPrice;
  @HiveField(9)
  num? percent;

  BasketItem(
    this.id,
    this.categoryId,
    this.thumbnail,
    this.discountPrice,
    this.price,
    this.popularity,
    this.name,
    this.collectionId,
  ) {
    realPrice = price + discountPrice;
    percent = ((price - realPrice!) / price) * 100;
  }
  // http://127.0.0.1:8090/api/files/COLLECTION_ID_OR_NAME/RECORD_ID/FILENAME
}
