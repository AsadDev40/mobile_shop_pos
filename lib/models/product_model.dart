class ProductModel {
  final String productId;
  final String productName;
  final String productInvoice;
  final String salePrice;
  final String ram;
  final String rom;
  int quantity;
  final List<String> imeiNumbers;
  final List<String> serialNumbers;
  final String vendorName;
  final String company;

  ProductModel({
    required this.productId,
    required this.productName,
    required this.productInvoice,
    required this.salePrice,
    required this.ram,
    required this.rom,
    required this.quantity,
    required this.imeiNumbers,
    required this.serialNumbers,
    required this.vendorName,
    required this.company,
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
      'quantity': quantity,
      'imeiNumbers': imeiNumbers,
      'serialNumbers': serialNumbers,
      'vendorName': vendorName,
      'company': company,
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
      quantity: json['quantity'],
      imeiNumbers: List<String>.from(json['imeiNumbers']),
      serialNumbers: List<String>.from(json['serialNumbers']),
      vendorName: json['vendorName'],
      company: json['company'],
    );
  }

  // Method to add quantity and IMEI/Serial Numbers
  void addStock(
      {required List<String> newImei, required List<String> newSerial}) {
    imeiNumbers.addAll(newImei);
    serialNumbers.addAll(newSerial);
    quantity += newImei.length; // Assuming one IMEI per product unit
  }

  List<ProductModel> dummyProducts = [
    ProductModel(
      productId: '001',
      productName: 'Infinix Hot 50',
      productInvoice: 'INV001',
      salePrice: '29999',
      ram: '6GB',
      rom: '128GB',
      quantity: 10,
      imeiNumbers: ['123456789012345', '123456789012346'],
      serialNumbers: ['SN001', 'SN002'],
      vendorName: 'Vendor A',
      company: 'Infinix',
    ),
    ProductModel(
      productId: '002',
      productName: 'Tecno Spark 10',
      productInvoice: 'INV002',
      salePrice: '34999',
      ram: '4GB',
      rom: '128GB',
      quantity: 5,
      imeiNumbers: ['234567890123456', '234567890123457'],
      serialNumbers: ['SN003', 'SN004'],
      vendorName: 'Vendor B',
      company: 'Tecno',
    ),
    ProductModel(
      productId: '003',
      productName: 'QMobile Noir Z12',
      productInvoice: 'INV003',
      salePrice: '17999',
      ram: '3GB',
      rom: '32GB',
      quantity: 8,
      imeiNumbers: ['345678901234567'],
      serialNumbers: ['SN005'],
      vendorName: 'Vendor C',
      company: 'QMobile',
    ),
    ProductModel(
      productId: '004',
      productName: 'VGO Tel Smart 7',
      productInvoice: 'INV004',
      salePrice: '9999',
      ram: '2GB',
      rom: '16GB',
      quantity: 12,
      imeiNumbers: ['456789012345678'],
      serialNumbers: ['SN006'],
      vendorName: 'Vendor D',
      company: 'VGO Tel',
    ),
    ProductModel(
      productId: '005',
      productName: 'GFive Smart 5',
      productInvoice: 'INV005',
      salePrice: '7999',
      ram: '1GB',
      rom: '8GB',
      quantity: 6,
      imeiNumbers: ['567890123456789'],
      serialNumbers: ['SN007'],
      vendorName: 'Vendor E',
      company: 'GFive',
    ),
    ProductModel(
      productId: '006',
      productName: 'Sparx Neo 7',
      productInvoice: 'INV006',
      salePrice: '20999',
      ram: '4GB',
      rom: '64GB',
      quantity: 10,
      imeiNumbers: ['678901234567890'],
      serialNumbers: ['SN008'],
      vendorName: 'Vendor F',
      company: 'Sparx',
    ),
    ProductModel(
      productId: '007',
      productName: 'Oppo A17',
      productInvoice: 'INV007',
      salePrice: '35999',
      ram: '6GB',
      rom: '128GB',
      quantity: 9,
      imeiNumbers: ['789012345678901'],
      serialNumbers: ['SN009'],
      vendorName: 'Vendor G',
      company: 'Oppo',
    ),
    ProductModel(
      productId: '008',
      productName: 'Realme C35',
      productInvoice: 'INV008',
      salePrice: '31999',
      ram: '6GB',
      rom: '128GB',
      quantity: 7,
      imeiNumbers: ['890123456789012'],
      serialNumbers: ['SN010'],
      vendorName: 'Vendor H',
      company: 'Realme',
    ),
    ProductModel(
      productId: '009',
      productName: 'Samsung Galaxy A14',
      productInvoice: 'INV009',
      salePrice: '54999',
      ram: '6GB',
      rom: '128GB',
      quantity: 4,
      imeiNumbers: ['901234567890123'],
      serialNumbers: ['SN011'],
      vendorName: 'Vendor I',
      company: 'Samsung',
    ),
    ProductModel(
      productId: '010',
      productName: 'iPhone 14 Pro',
      productInvoice: 'INV010',
      salePrice: '279999',
      ram: '6GB',
      rom: '256GB',
      quantity: 3,
      imeiNumbers: ['012345678901234'],
      serialNumbers: ['SN012'],
      vendorName: 'Vendor J',
      company: 'Apple',
    ),
  ];
}
