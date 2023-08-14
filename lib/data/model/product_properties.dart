class ProductProperties {
  String? title;
  String? value;

  ProductProperties(
    this.title,
    this.value,
  );
  factory ProductProperties.fromMapJsone(Map<String, dynamic> jsone) {
    return ProductProperties(
      jsone['title'],
      jsone['value'],
    );
  }
}
