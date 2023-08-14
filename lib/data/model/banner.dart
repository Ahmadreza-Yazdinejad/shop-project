class BannerCampain {
  String categoryId;
  String collectionId;
  String id;
  String thumbnail;

  BannerCampain(
    this.categoryId,
    this.collectionId,
    this.id,
    this.thumbnail,
  );
  //http://127.0.0.1:8090/api/files/COLLECTION_ID_OR_NAME/RECORD_ID/FILENAME
  factory BannerCampain.fromJsone(Map<String, dynamic> jsoneObject) {
    return BannerCampain(
        jsoneObject['categoryId'],
        jsoneObject['collectionId'],
        jsoneObject['id'],
        'http://startflutter.ir/api/files/${jsoneObject['collectionId']}/${jsoneObject['id']}/${jsoneObject['thumbnail']}');
  }
}
