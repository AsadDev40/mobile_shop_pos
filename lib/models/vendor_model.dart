class VendorModel {
  final String id;
  final String vendorName;
  final String vendorAddress;
  final String vendorContact;

  VendorModel({
    required this.id,
    required this.vendorName,
    required this.vendorAddress,
    required this.vendorContact,
  });

  // Convert VendorModel instance to a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'vendorName': vendorName,
      'vendorAddress': vendorAddress,
      'vendorContact': vendorContact,
    };
  }

  // Create VendorModel instance from a JSON Map
  factory VendorModel.fromJson(Map<String, dynamic> json) {
    return VendorModel(
      id: json['id'],
      vendorName: json['vendorName'],
      vendorAddress: json['vendorAddress'],
      vendorContact: json['vendorContact'],
    );
  }
}

// Dummy Vendors List
List<VendorModel> dummyVendors = [
  VendorModel(
    id: '1',
    vendorName: 'Multan Mobile Hub',
    vendorAddress: 'Gulgasht Colony, Multan, Pakistan',
    vendorContact: '+92 300 1234567',
  ),
  VendorModel(
    id: '2',
    vendorName: 'Saif Mobile Center',
    vendorAddress: 'Hussain Agahi, Multan, Pakistan',
    vendorContact: '+92 301 7654321',
  ),
  VendorModel(
    id: '3',
    vendorName: 'Techno World Mobiles',
    vendorAddress: 'Cantt Market, Multan, Pakistan',
    vendorContact: '+92 302 9876543',
  ),
  VendorModel(
    id: '4',
    vendorName: 'Fast Mobile Solutions',
    vendorAddress: 'Chowk Bazaar, Multan, Pakistan',
    vendorContact: '+92 303 5678901',
  ),
  VendorModel(
    id: '5',
    vendorName: 'Smart Mobile Point',
    vendorAddress: 'Bosan Road, Multan, Pakistan',
    vendorContact: '+92 304 1122334',
  ),
  VendorModel(
    id: '6',
    vendorName: 'Makkah Mobile House',
    vendorAddress: 'Shah Rukn-e-Alam, Multan, Pakistan',
    vendorContact: '+92 305 4455667',
  ),
  VendorModel(
    id: '7',
    vendorName: 'City Mobile Zone',
    vendorAddress: 'Vehari Chowk, Multan, Pakistan',
    vendorContact: '+92 306 7788990',
  ),
  VendorModel(
    id: '8',
    vendorName: 'Mobile Mart Multan',
    vendorAddress: 'Dera Adda, Multan, Pakistan',
    vendorContact: '+92 307 9911223',
  ),
  VendorModel(
    id: '9',
    vendorName: 'Future Tech Mobiles',
    vendorAddress: 'Nawan Shehar, Multan, Pakistan',
    vendorContact: '+92 308 3344556',
  ),
  VendorModel(
    id: '10',
    vendorName: 'Al-Madina Mobile Gallery',
    vendorAddress: 'Qasim Bela, Multan, Pakistan',
    vendorContact: '+92 309 5566778',
  ),
];
