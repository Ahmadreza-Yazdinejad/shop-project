class Comment {
  String userId;
  String id;
  String text;
  String productId;
  Comment({
    required this.id,
    required this.productId,
    required this.text,
    required this.userId,
  });

  factory Comment.formMapJsone(Map<String, dynamic> jsoneMapObject) {
    return Comment(
      id: jsoneMapObject['id'],
      productId: jsoneMapObject['product_id'],
      text: jsoneMapObject['text'],
      userId: jsoneMapObject['user_id'],
    );
  }
}
