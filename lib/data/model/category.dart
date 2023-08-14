class Categoryy {
  String collectionId;
  String color;
  String icon;
  String id;
  String thumbnail;
  String title;
  String? categoryId;

  Categoryy(this.collectionId, this.color, this.icon, this.id, this.thumbnail,
      this.title);
// http://127.0.0.1:8090/api/files/COLLECTION_ID_OR_NAME/RECORD_ID/FILENAME
  factory Categoryy.fromMapJsone(Map<String, dynamic> jsoneObject) {
    return Categoryy(
      jsoneObject['collectionId'],
      jsoneObject['color'],
      'http://startflutter.ir/api/files/${jsoneObject['collectionId']}/${jsoneObject['id']}/${jsoneObject['icon']}',
      jsoneObject['id'],
      'http://startflutter.ir/api/files/${jsoneObject['collectionId']}/${jsoneObject['id']}/${jsoneObject['thumbnail']}',
      jsoneObject['title'],
    );
  }
}
