class AccessoriesModel {
  final String? id;
  final String name;
  int quantity;
  int invoice;
  int price;

  AccessoriesModel({
    this.id,
    required this.name,
    required this.quantity,
    required this.invoice,
    required this.price,
  });

  // Convert object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'invoice': invoice,
      'price': price,
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
    );
  }
}

// Dummy Accessories List
List<AccessoriesModel> dummyAccessories = [
  AccessoriesModel(
      id: "1",
      name: "Wireless Earbuds",
      quantity: 50,
      invoice: 101,
      price: 1500),
  AccessoriesModel(
      id: "2",
      name: "Bluetooth Speaker",
      quantity: 30,
      invoice: 102,
      price: 3500),
  AccessoriesModel(
      id: "3",
      name: "Power Bank 10000mAh",
      quantity: 20,
      invoice: 103,
      price: 2500),
  AccessoriesModel(
      id: "4", name: "Smartwatch", quantity: 15, invoice: 104, price: 5000),
  AccessoriesModel(
      id: "5",
      name: "USB Type-C Cable",
      quantity: 100,
      invoice: 105,
      price: 300),
  AccessoriesModel(
      id: "6",
      name: "Fast Charger 25W",
      quantity: 40,
      invoice: 106,
      price: 2000),
  AccessoriesModel(
      id: "7", name: "Phone Stand", quantity: 60, invoice: 107, price: 800),
  AccessoriesModel(
      id: "8", name: "VR Headset", quantity: 10, invoice: 108, price: 6000),
  AccessoriesModel(
      id: "9",
      name: "Memory Card 128GB",
      quantity: 25,
      invoice: 109,
      price: 3200),
  AccessoriesModel(
      id: "10",
      name: "Gaming Headset",
      quantity: 18,
      invoice: 110,
      price: 4500),
];
