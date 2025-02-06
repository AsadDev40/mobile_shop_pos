class VendorModel {
  final String vendorImage;
  final String vendorName;
  final String vendorAddress;

  VendorModel({
    required this.vendorImage,
    required this.vendorName,
    required this.vendorAddress,
  });

  // Convert VendorModel instance to a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'vendorImage': vendorImage,
      'vendorName': vendorName,
      'vendorAddress': vendorAddress,
    };
  }

  // Create VendorModel instance from a JSON Map
  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      vendorImage: json['vendorImage'],
      vendorName: json['vendorName'],
      vendorAddress: json['vendorAddress'],
    );
  }

  List<VendorModel> dummyVendors = [
    VendorModel(
      vendorImage: 'https://example.com/vendor1.png',
      vendorName: 'Multan Mobile Hub',
      vendorAddress: 'Gulgasht Colony, Multan, Pakistan',
    ),
    VendorModel(
      vendorImage: 'https://example.com/vendor2.png',
      vendorName: 'Saif Mobile Center',
      vendorAddress: 'Hussain Agahi, Multan, Pakistan',
    ),
    VendorModel(
      vendorImage: 'https://example.com/vendor3.png',
      vendorName: 'Techno World Mobiles',
      vendorAddress: 'Cantt Market, Multan, Pakistan',
    ),
    VendorModel(
      vendorImage: 'https://example.com/vendor4.png',
      vendorName: 'Fast Mobile Solutions',
      vendorAddress: 'Chowk Bazaar, Multan, Pakistan',
    ),
    VendorModel(
      vendorImage: 'https://example.com/vendor5.png',
      vendorName: 'Smart Mobile Point',
      vendorAddress: 'Bosan Road, Multan, Pakistan',
    ),
    VendorModel(
      vendorImage: 'https://example.com/vendor6.png',
      vendorName: 'Makkah Mobile House',
      vendorAddress: 'Shah Rukn-e-Alam, Multan, Pakistan',
    ),
    VendorModel(
      vendorImage: 'https://example.com/vendor7.png',
      vendorName: 'City Mobile Zone',
      vendorAddress: 'Vehari Chowk, Multan, Pakistan',
    ),
    VendorModel(
      vendorImage: 'https://example.com/vendor8.png',
      vendorName: 'Mobile Mart Multan',
      vendorAddress: 'Dera Adda, Multan, Pakistan',
    ),
    VendorModel(
      vendorImage: 'https://example.com/vendor9.png',
      vendorName: 'Future Tech Mobiles',
      vendorAddress: 'Nawan Shehar, Multan, Pakistan',
    ),
    VendorModel(
      vendorImage: 'https://example.com/vendor10.png',
      vendorName: 'Al-Madina Mobile Gallery',
      vendorAddress: 'Qasim Bela, Multan, Pakistan',
    ),
  ];
}
