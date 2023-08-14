class Product {
  String id;
  String collectionId;
  String thumbnail;
  String description;
  int discountPrice;
  int price;
  String popularity;
  String name;
  int quantity;
  String categoryId;
  int? realPrice;
  num? percent;

  Product(
    this.id,
    this.categoryId,
    this.thumbnail,
    this.description,
    this.discountPrice,
    this.price,
    this.popularity,
    this.name,
    this.quantity,
    this.collectionId,
  ) {
    realPrice = price + discountPrice;
    percent = ((price - realPrice!) / price) * 100;
  }
  // http://127.0.0.1:8090/api/files/COLLECTION_ID_OR_NAME/RECORD_ID/FILENAME

  factory Product.formJsone(Map<String, dynamic> jsoneObject) {
    return Product(
      jsoneObject['id'],
      jsoneObject['category'],
      'http://startflutter.ir/api/files/${jsoneObject['collectionId']}/${jsoneObject['id']}/${jsoneObject['thumbnail']}',
      jsoneObject['description'],
      jsoneObject['discount_price'],
      jsoneObject['price'],
      jsoneObject['popularity'],
      jsoneObject['name'],
      jsoneObject['quantity'],
      jsoneObject['collectionId'],
    );
  }
}
