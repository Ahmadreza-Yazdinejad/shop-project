class ProductDetailImage {
  String? productId;
  String? image;
  String? id;
  String? collectionId;
  ProductDetailImage(
    this.image,
    this.productId,
    this.collectionId,
    this.id,
  );

  factory ProductDetailImage.fromMapJsone(Map<String, dynamic> jsoenMapObject) {
    return ProductDetailImage(
      'http://startflutter.ir/api/files/${jsoenMapObject['collectionId']}/${jsoenMapObject['id']}/${jsoenMapObject['image']}',
      jsoenMapObject['product_id'],
      jsoenMapObject['collectionId'],
      jsoenMapObject['id'],
    );
  }
}
