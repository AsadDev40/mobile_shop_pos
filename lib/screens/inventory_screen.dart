import 'package:flutter/material.dart';
import 'package:mobile_shop_pos/provider/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:mobile_shop_pos/models/accessories_model.dart';
import 'package:mobile_shop_pos/models/product_model.dart';
import 'package:mobile_shop_pos/utils/constants.dart';
import 'package:mobile_shop_pos/widgets/accessories_widget.dart';
import 'package:mobile_shop_pos/widgets/popup_options.dart';
import 'package:mobile_shop_pos/widgets/product_listview_widget.dart';

class InventoryScreen extends StatefulWidget {
  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final TextEditingController searchController = TextEditingController();
  List<ProductModel> filteredProducts = [];
  List<AccessoriesModel> filteredAccessories = [];
  List<dynamic> combinedItems = [];

  @override
  void initState() {
    super.initState();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _filterProducts(searchController.text);
    });
  }

  void _filterProducts(String query) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final products = productProvider.products;
    final accessories = productProvider.accessories;

    if (query.isEmpty) {
      filteredProducts = List.from(products);
      filteredAccessories = List.from(accessories);
    } else {
      String lowerQuery = query.toLowerCase();

      filteredProducts = products.where((product) {
        bool nameMatch = product.productName.toLowerCase().contains(lowerQuery);
        bool imeiMatch = product.imeiNumbers
            .any((imei) => imei.toLowerCase().contains(lowerQuery));
        return nameMatch || imeiMatch;
      }).toList();

      filteredAccessories = accessories.where((accessory) {
        return accessory.name.toLowerCase().contains(lowerQuery);
      }).toList();
    }

    combinedItems = [...filteredProducts, ...filteredAccessories];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, productProvider, child) {
        // Update filtered lists whenever provider changes
        filteredProducts = List.from(productProvider.products);
        filteredAccessories = List.from(productProvider.accessories);
        combinedItems = [...filteredProducts, ...filteredAccessories];

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
                      "Inventory",
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
                      return ProductListViewContent(products: [item]);
                    } else if (item is AccessoriesModel) {
                      return AccessoriesListViewContent(accessories: [item]);
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10, right: 30),
                child: FloatingActionButton(
                  backgroundColor: AppColors.PrimaryColor,
                  onPressed: () async {
                    bool? productAdded = await showDialog(
                      context: context,
                      builder: (context) => AddOptionsPopup(),
                    );

                    if (productAdded == true) {
                      setState(() {}); // Refresh UI after adding a new product
                    }
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
      },
    );
  }
}
