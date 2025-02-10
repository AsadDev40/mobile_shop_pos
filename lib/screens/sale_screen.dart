import 'package:flutter/material.dart';
import 'package:mobile_shop_pos/models/accessories_model.dart';
import 'package:mobile_shop_pos/models/product_model.dart';
import 'package:mobile_shop_pos/provider/product_provider.dart';
import 'package:mobile_shop_pos/utils/constants.dart';
import 'package:mobile_shop_pos/widgets/accessories_widget.dart';
import 'package:mobile_shop_pos/widgets/product_listview_widget.dart';
import 'package:provider/provider.dart';

class SalesScreen extends StatefulWidget {
  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  final TextEditingController searchController = TextEditingController();
  String searchQuery = "";

  void _filterProducts(String query) {
    setState(() {
      searchQuery = query.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        List<ProductModel> filteredProducts =
            productProvider.getProductsByStock("sold");
        List<AccessoriesModel> filteredAccessories = productProvider.sales;

        if (searchQuery.isNotEmpty) {
          filteredProducts = filteredProducts.where((product) {
            bool nameMatch =
                product.productName.toLowerCase().contains(searchQuery);
            bool imeiMatch = product.imeiNumbers
                .any((imei) => imei.toLowerCase().contains(searchQuery));
            return nameMatch || imeiMatch;
          }).toList();

          filteredAccessories = filteredAccessories.where((accessory) {
            return accessory.name.toLowerCase().contains(searchQuery);
          }).toList();
        }

        List<dynamic> combinedItems = [
          ...filteredProducts,
          ...filteredAccessories
        ];

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
                        onChanged: _filterProducts,
                        decoration: const InputDecoration(
                          hintText: "Search by Name or IMEI...",
                          border: InputBorder.none,
                          icon:
                              Icon(Icons.search, color: AppColors.PrimaryColor),
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
                      return ProductListViewContent(
                        products: [item],
                      );
                    } else if (item is AccessoriesModel) {
                      return AccessoriesListViewContent(
                        accessories: [item],
                        isSell: true,
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
