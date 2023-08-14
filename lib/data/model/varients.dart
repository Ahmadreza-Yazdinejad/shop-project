class Varients {
  String? id;
  String? name;
  int? priceChange;
  String? typeId;
  String? value;
  Varients(
    this.id,
    this.name,
    this.priceChange,
    this.typeId,
    this.value,
  );
  factory Varients.formMapJsone(Map<String, dynamic> jsone) {
    return Varients(
      jsone['id'],
      jsone['name'],
      jsone['price_change'],
      jsone['type_id'],
      jsone['value'],
    );
  }
}
