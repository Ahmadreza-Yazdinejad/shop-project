class Comment {
  String userId;
  String id;
  String text;
  String productId;
  String thumnailUrl;
  String avatar;
  String username;
  Comment({
    required this.id,
    required this.productId,
    required this.text,
    required this.userId,
    required this.thumnailUrl,
    required this.avatar,
    required this.username,
  });

  factory Comment.formMapJsone(Map<String, dynamic> jsoneMapObject) {
    return Comment(
      id: jsoneMapObject['id'],
      productId: jsoneMapObject['product_id'],
      text: jsoneMapObject['text'],
      userId: jsoneMapObject['user_id'],
      thumnailUrl:
          'http://startflutter.ir/api/files/${jsoneMapObject['expand']['user_id']['collectionName']}/${jsoneMapObject['expand']['user_id']['id']}/${jsoneMapObject['expand']['user_id']['avatar']}',
      avatar: jsoneMapObject['expand']['user_id']['avatar'],
      username: jsoneMapObject['expand']['user_id']['name'],
    );
  }
}
