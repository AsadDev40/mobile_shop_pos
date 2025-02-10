import 'package:flutter/material.dart';
import 'package:mobile_shop_pos/provider/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:mobile_shop_pos/models/accessories_model.dart';
import 'package:mobile_shop_pos/models/product_model.dart';
import 'package:mobile_shop_pos/utils/constants.dart';
import 'package:mobile_shop_pos/widgets/accessories_widget.dart';
import 'package:mobile_shop_pos/widgets/enrolled_chart.dart';
import 'package:mobile_shop_pos/widgets/pie_chart.dart';
import 'package:mobile_shop_pos/widgets/product_listview_widget.dart';
import 'package:mobile_shop_pos/widgets/statcard_widget.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  String selectedValue = 'This Week';
  final TextEditingController searchController = TextEditingController();

  List<ProductModel> filteredProducts = [];
  List<AccessoriesModel> filteredAccessories = [];

  List<double> salesDataThisWeek = [1000, 1200, 1500, 1800, 1300, 1600, 2000];
  List<double> lossDataThisWeek = [200, 300, 250, 150, 100, 180, 220];

  List<double> salesDataThisYear =
      List.generate(12, (index) => 3000 + (index % 3) * 500);
  List<double> lossDataThisYear =
      List.generate(12, (index) => 500 + (index % 2) * 200);

  List<String> dropdownlist = ['This Week', 'This Year'];

  @override
  void initState() {
    super.initState();
    _loadData();
    _filterItems('');
  }

  Future<void> _loadData() async {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    await productProvider.loadProducts();
    await productProvider.loadAccessories();
  }

  void onFilterChanged(String? value) {
    setState(() {
      selectedValue = value!;
    });
  }

  void _filterItems(String query) {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);

    setState(() {
      if (query.isEmpty) {
        filteredProducts = List.from(productProvider.products);
        filteredAccessories = List.from(productProvider.accessories);
      } else {
        filteredProducts = productProvider.products.where((product) {
          final nameMatch =
              product.productName.toLowerCase().contains(query.toLowerCase());
          final imeiMatch = product.imeiNumbers
              .any((imei) => imei.toLowerCase().contains(query.toLowerCase()));

          return nameMatch || imeiMatch;
        }).toList();

        filteredAccessories = productProvider.accessories.where((accessory) {
          return accessory.name.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    List<double> salesData =
        selectedValue == 'This Week' ? salesDataThisWeek : salesDataThisYear;
    List<double> lossData =
        selectedValue == 'This Week' ? lossDataThisWeek : lossDataThisYear;

    final combinedItems = [...filteredProducts, ...filteredAccessories];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Overview',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              StatCard(
                  title: 'Total Sales',
                  value: 'RS 12,345',
                  color: AppColors.PrimaryColor),
              const SizedBox(width: 16),
              StatCard(
                  title: 'Total Products',
                  value: '${productProvider.products.length}',
                  color: AppColors.SecondaryColor),
              StatCard(
                  title: 'Profit',
                  value: 'RS 1,234',
                  color: AppColors.TertiaryColor),
              StatCard(
                  title: 'Losses',
                  value: 'RS 1,234',
                  color: AppColors.PrimaryColor),
              const SizedBox(width: 16),
              StatCard(
                  title: 'Customers',
                  value: '567',
                  color: AppColors.SecondaryColor),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: SalesChart(
                  selectedFilter: selectedValue,
                  onFilterChanged: onFilterChanged,
                  filterValues: dropdownlist,
                  salesData: salesData,
                  lossData: lossData,
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: const MobileSalesChart(
                  infinixPercentage: 35,
                  tecnoPercentage: 25,
                  realmePercentage: 20,
                  redmiPercentage: 15,
                  othersPercentage: 5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            height: MediaQuery.of(context).size.height * 0.4 - 9,
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
                        "Product & Accessories List",
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
                          onChanged: (value) => _filterItems(value),
                          decoration: const InputDecoration(
                            hintText: "Search...",
                            border: InputBorder.none,
                            icon: Icon(Icons.search,
                                color: AppColors.PrimaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: combinedItems.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
          ),
        ],
      ),
    );
  }
}
