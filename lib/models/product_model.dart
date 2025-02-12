class ProductModel {
  final String productId;
  final String productName;
  final String productInvoice;
  String? salePrice;
  final String ram;
  final String rom;
  String stock;
  final List<String> imeiNumbers;
  final List<String> serialNumbers;
  final String? vendorName;
  String? customerName;
  final String company;
  String? customerAddress;
  int? customerCnic;
  DateTime? dateTime;

  ProductModel({
    required this.productId,
    required this.productName,
    required this.productInvoice,
    this.salePrice,
    required this.ram,
    required this.rom,
    required this.stock,
    required this.imeiNumbers,
    required this.serialNumbers,
    this.vendorName,
    this.customerName,
    required this.company,
    this.customerAddress,
    this.customerCnic,
    this.dateTime,
  });

  // Convert a ProductModel instance into a Map.
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'productInvoice': productInvoice,
      'salePrice': salePrice,
      'ram': ram,
      'rom': rom,
      'stock': stock,
      'imeiNumbers': imeiNumbers,
      'serialNumbers': serialNumbers,
      'vendorName': vendorName,
      'company': company,
      'customerAddress': customerAddress,
      'customerName': customerName,
      'customerCnic': customerCnic,
      'dateTime': dateTime?.toIso8601String(),
    };
  }

  // Create a ProductModel instance from a Map.
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        productId: json['productId'],
        productName: json['productName'],
        productInvoice: json['productInvoice'],
        salePrice: json['salePrice'],
        ram: json['ram'],
        rom: json['rom'],
        stock: json['stock'],
        imeiNumbers: List<String>.from(json['imeiNumbers']),
        serialNumbers: List<String>.from(json['serialNumbers']),
        vendorName: json['vendorName'],
        company: json['company'],
        customerAddress: json['customerAddress'],
        customerName: json['customerName'],
        dateTime:
            json['dateTime'] != null ? DateTime.parse(json['dateTime']) : null,
        customerCnic: json['customerCnic']);
  }
}
