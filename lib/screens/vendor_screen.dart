import 'package:flutter/material.dart';
import 'package:mobile_shop_pos/models/vendor_model.dart';
import 'package:mobile_shop_pos/utils/constants.dart';
import 'package:mobile_shop_pos/widgets/add_vendor_popup.dart';
import 'package:mobile_shop_pos/widgets/vendor_widget.dart';

class VendorScreen extends StatefulWidget {
  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  final TextEditingController searchController = TextEditingController();
  List<VendorModel> filteredVendors = [];

  @override
  void initState() {
    super.initState();
    filteredVendors = List.from(dummyVendors);
  }

  void _filterVendors(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredVendors = List.from(dummyVendors);
      } else {
        String lowerQuery = query.toLowerCase();
        filteredVendors = dummyVendors.where((vendor) {
          return vendor.vendorName.toLowerCase().contains(lowerQuery) ||
              vendor.vendorAddress.toLowerCase().contains(lowerQuery) ||
              vendor.vendorContact.toLowerCase().contains(lowerQuery);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Text(
                  "Vendors",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  width: 200,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) => _filterVendors(value),
                    decoration: const InputDecoration(
                      hintText: "Search Vendor...",
                      border: InputBorder.none,
                      icon: Icon(Icons.search, color: AppColors.PrimaryColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: filteredVendors.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                mainAxisSpacing: 20,
                crossAxisSpacing: 5,
                childAspectRatio: 1.6,
              ),
              itemBuilder: (context, index) {
                final vendor = filteredVendors[index];
                return VendorWidget(vendor: vendor);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, right: 30),
            child: FloatingActionButton(
              backgroundColor: AppColors.PrimaryColor,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => const AddVendorPopup());
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
