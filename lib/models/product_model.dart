class ProductModel {
  final String productId;
  final String productName;
  final String productInvoice;
  final String salePrice;
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
    required this.salePrice,
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
      'dateTime': dateTime,
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
        dateTime: json['dateTime'],
        customerCnic: json['customerCnic']);
  }
}

List<ProductModel> dummyProducts = [
  ProductModel(
      productId: '001',
      productName: 'Infinix Hot 50',
      productInvoice: 'INV001',
      salePrice: '29999',
      ram: '6GB',
      rom: '128GB',
      stock: 'availiable',
      imeiNumbers: ['123456789012345', '123456789012346'],
      serialNumbers: ['SN001', 'SN002'],
      vendorName: 'Vendor A',
      company: 'Infinix',
      customerAddress: 'https://images.app.goo.gl/6ezMTG45bjK7kytX7'),
  ProductModel(
      productId: '002',
      productName: 'Tecno Spark 10',
      productInvoice: 'INV002',
      salePrice: '34999',
      ram: '4GB',
      rom: '128GB',
      stock: 'availiable',
      imeiNumbers: ['234567890123456', '234567890123457'],
      serialNumbers: ['SN003', 'SN004'],
      vendorName: 'Vendor B',
      company: 'Tecno',
      customerAddress: 'https://picsum.photos/250?image=9'),
  ProductModel(
      productId: '003',
      productName: 'QMobile Noir Z12',
      productInvoice: 'INV003',
      salePrice: '17999',
      ram: '3GB',
      rom: '32GB',
      stock: 'availiable',
      imeiNumbers: ['345678901234567'],
      serialNumbers: ['SN005'],
      vendorName: 'Vendor C',
      company: 'QMobile',
      customerAddress: 'https://picsum.photos/250?image=9'),
  ProductModel(
      productId: '004',
      productName: 'VGO Tel Smart 7',
      productInvoice: 'INV004',
      salePrice: '9999',
      ram: '2GB',
      rom: '16GB',
      stock: 'sold',
      imeiNumbers: ['456789012345678'],
      serialNumbers: ['SN006'],
      vendorName: 'Vendor D',
      company: 'VGO Tel',
      customerAddress: 'https://picsum.photos/250?image=9'),
  ProductModel(
      productId: '005',
      productName: 'GFive Smart 5',
      productInvoice: 'INV005',
      salePrice: '7999',
      ram: '1GB',
      rom: '8GB',
      stock: 'sold',
      imeiNumbers: ['567890123456789'],
      serialNumbers: ['SN007'],
      vendorName: 'Vendor E',
      company: 'GFive',
      customerAddress: 'https://picsum.photos/250?image=9'),
  ProductModel(
      productId: '006',
      productName: 'Sparx Neo 7',
      productInvoice: 'INV006',
      salePrice: '20999',
      ram: '4GB',
      rom: '64GB',
      stock: 'availiable',
      imeiNumbers: ['678901234567890'],
      serialNumbers: ['SN008'],
      vendorName: 'Vendor F',
      company: 'Sparx',
      customerAddress: 'https://picsum.photos/250?image=9'),
  ProductModel(
      productId: '007',
      productName: 'Oppo A17',
      productInvoice: 'INV007',
      salePrice: '35999',
      ram: '6GB',
      rom: '128GB',
      stock: 'availiable',
      imeiNumbers: ['789012345678901'],
      serialNumbers: ['SN009'],
      vendorName: 'Vendor G',
      company: 'Oppo',
      customerAddress: 'https://picsum.photos/250?image=9'),
  ProductModel(
      productId: '008',
      productName: 'Realme C35',
      productInvoice: 'INV008',
      salePrice: '31999',
      ram: '6GB',
      rom: '128GB',
      stock: 'availiable',
      imeiNumbers: ['890123456789012'],
      serialNumbers: ['SN010'],
      vendorName: 'Vendor H',
      company: 'Realme',
      customerAddress: 'https://picsum.photos/250?image=9'),
  ProductModel(
      productId: '009',
      productName: 'Samsung Galaxy A14',
      productInvoice: 'INV009',
      salePrice: '54999',
      ram: '6GB',
      rom: '128GB',
      stock: 'availiable',
      imeiNumbers: ['901234567890123'],
      serialNumbers: ['SN011'],
      vendorName: 'Vendor I',
      company: 'Samsung',
      customerAddress: 'https://picsum.photos/250?image=9'),
  ProductModel(
      productId: '010',
      productName: 'iPhone 14 Pro',
      productInvoice: 'INV010',
      salePrice: '279999',
      ram: '6GB',
      rom: '256GB',
      stock: 'availiable',
      imeiNumbers: ['012345678901234'],
      serialNumbers: ['SN012'],
      vendorName: 'Vendor J',
      company: 'Apple',
      customerAddress: 'https://picsum.photos/250?image=9'),
];
