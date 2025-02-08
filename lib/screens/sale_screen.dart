import 'package:flutter/material.dart';
import 'package:mobile_shop_pos/models/accessories_model.dart';
import 'package:mobile_shop_pos/models/product_model.dart';
import 'package:mobile_shop_pos/utils/constants.dart';
import 'package:mobile_shop_pos/widgets/accessories_widget.dart';
import 'package:mobile_shop_pos/widgets/product_listview_widget.dart';

class SalesScreen extends StatefulWidget {
  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final TextEditingController searchController = TextEditingController();
  List<ProductModel> filteredProducts = [];
  List<AccessoriesModel> filteredAccessories = [];
  List<dynamic> combinedItems = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = List.from(dummyProducts);
    filteredAccessories = List.from(dummyAccessories);
    combinedItems = [...filteredProducts, ...filteredAccessories];
  }

  void _filterProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredProducts = List.from(dummyProducts);
        filteredAccessories = List.from(dummyAccessories);
      } else {
        String lowerQuery = query.toLowerCase();

        filteredProducts = dummyProducts.where((product) {
          bool nameMatch =
              product.productName.toLowerCase().contains(lowerQuery);
          bool imeiMatch = product.imeiNumbers
              .any((imei) => imei.toLowerCase().contains(lowerQuery));
          return nameMatch || imeiMatch;
        }).toList();

        filteredAccessories = dummyAccessories.where((accessory) {
          return accessory.name.toLowerCase().contains(lowerQuery);
        }).toList();
      }

      // Merge products and accessories into a single list
      combinedItems = [...filteredProducts, ...filteredAccessories];
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Text(
                  "Sales List",
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
                    onChanged: (value) => _filterProducts(value),
                    decoration: const InputDecoration(
                      hintText: "Search by Name or IMEI...",
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
              itemCount: combinedItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 2,
                crossAxisSpacing: 5,
                childAspectRatio: 1.4,
              ),
              itemBuilder: (context, index) {
                final item = combinedItems[index];

                if (item is ProductModel) {
                  return ProductListViewContent(products: [item]);
                } else if (item is AccessoriesModel) {
                  return AccessoriesListViewContent(accessories: [item]);
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
