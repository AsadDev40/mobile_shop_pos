class CustomerModel {
  final String customerName;
  final String customerCnic;
  final String customerAddress;

  CustomerModel({
    required this.customerName,
    required this.customerCnic,
    required this.customerAddress,
  });

  // Convert a CustomerModel instance into a Map.
  Map<String, dynamic> toJson() {
    return {
      'customerName': customerName,
      'customerCnic': customerCnic,
      'customerAddress': customerAddress,
    };
  }

  // Create a CustomerModel instance from a Map.
  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      customerName: json['customerName'],
      customerCnic: json['customerCnic'],
      customerAddress: json['customerAddress'],
    );
  }

  List<CustomerModel> dummyCustomers = [
    CustomerModel(
      customerName: 'Ali Khan',
      customerCnic: '35201-1234567-8',
      customerAddress: 'Multan, Punjab, Pakistan',
    ),
    CustomerModel(
      customerName: 'Hassan Raza',
      customerCnic: '35202-2345678-9',
      customerAddress: 'Gulgasht Colony, Multan, Punjab, Pakistan',
    ),
    CustomerModel(
      customerName: 'Fatima Sheikh',
      customerCnic: '35203-3456789-0',
      customerAddress: 'Shah Rukn-e-Alam, Multan, Punjab, Pakistan',
    ),
    CustomerModel(
      customerName: 'Usman Farooq',
      customerCnic: '35204-4567890-1',
      customerAddress: 'New Multan, Multan, Punjab, Pakistan',
    ),
    CustomerModel(
      customerName: 'Ayesha Malik',
      customerCnic: '35205-5678901-2',
      customerAddress: 'Cantt Area, Multan, Punjab, Pakistan',
    ),
  ];
}
