class AccessoriesModel {
  final String? id;
  final String name;
  int quantity;
  int invoice;
  int? price;
  String? customerName;
  DateTime? dateTime;
  String vendorName;

  AccessoriesModel({
    this.id,
    required this.name,
    required this.quantity,
    required this.invoice,
    this.price,
    this.customerName,
    this.dateTime,
    required this.vendorName,
  });

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'invoice': invoice,
      'price': price,
      'customerName': customerName,
      'dateTime': dateTime?.toIso8601String(),
      'vendorName': vendorName,
    };
  }

  // Convert JSON to object
  factory AccessoriesModel.fromJson(Map<String, dynamic> json) {
    return AccessoriesModel(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      invoice: json['invoice'],
      price: json['price'],
      vendorName: json['vendorName'],
      customerName: json['customerName'],
      dateTime:
          json['dateTime'] != null ? DateTime.parse(json['dateTime']) : null,
    );
  }
}
