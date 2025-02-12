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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    await productProvider.loadProducts();
    await productProvider.loadAccessories();
    productProvider.updateSalesAndLossData();
    _filterItems('');
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

    if (productProvider.products.isEmpty &&
        productProvider.accessories.isEmpty) {
      // Show a loading indicator while data is being fetched
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    List<double> salesData = selectedValue == 'This Week'
        ? productProvider.salesDataThisWeek
        : productProvider.salesDataThisYear;
    List<double> lossData = selectedValue == 'This Week'
        ? productProvider.lossDataThisWeek
        : productProvider.lossDataThisYear;

    // Extract percentages for each brand
    double infinixPercentage = double.parse((productProvider
            .getSalesPercentage()
            .firstWhere((e) => e['company'] == 'Infinix',
                orElse: () =>
                    <String, Object>{'percentage': 0.0})['percentage'] as num)
        .toDouble()
        .toStringAsFixed(2));

    double tecnoPercentage = double.parse((productProvider
            .getSalesPercentage()
            .firstWhere((e) => e['company'] == 'Techno',
                orElse: () =>
                    <String, Object>{'percentage': 0.0})['percentage'] as num)
        .toDouble()
        .toStringAsFixed(2));

    double realmePercentage = double.parse((productProvider
            .getSalesPercentage()
            .firstWhere((e) => e['company'] == 'Realme',
                orElse: () =>
                    <String, Object>{'percentage': 0.0})['percentage'] as num)
        .toDouble()
        .toStringAsFixed(2));

    double redmiPercentage = double.parse((productProvider
            .getSalesPercentage()
            .firstWhere((e) => e['company'] == 'Redmi',
                orElse: () =>
                    <String, Object>{'percentage': 0.0})['percentage'] as num)
        .toDouble()
        .toStringAsFixed(2));

    double othersPercentage = double.parse((productProvider
            .getSalesPercentage()
            .firstWhere((e) => e['company'] == 'Others',
                orElse: () =>
                    <String, Object>{'percentage': 0.0})['percentage'] as num)
        .toDouble()
        .toStringAsFixed(2));

    final combinedItems = [...filteredProducts, ...filteredAccessories];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Overview',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await productProvider.exportData();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Data exported successfully!')),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to export data: $e')),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.PrimaryColor),
                    child: Text(
                      'Export Data',
                      style: AppTextStyles.body1.copyWith(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        await productProvider.importData();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Data imported successfully!')),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Failed to import data: $e')),
                        );
                      }
                    },
                    child: Text(
                      'Import Data',
                      style: AppTextStyles.body1.copyWith(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.PrimaryColor),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              StatCard(
                  title: 'Total Sales',
                  value:
                      'RS ${(productProvider.getTotalProductSales()).toStringAsFixed(0)}',
                  color: AppColors.PrimaryColor),
              const SizedBox(width: 16),
              StatCard(
                  title: 'Total Mobiles',
                  value: '${productProvider.products.length}',
                  color: AppColors.SecondaryColor),
              StatCard(
                  title: 'Profit',
                  value:
                      'RS ${(productProvider.getTotalAccessoriesProfit() + productProvider.getTotalProductProfit()).toStringAsFixed(0)} ',
                  color: AppColors.TertiaryColor),
              StatCard(
                  title: 'Losses',
                  value:
                      'RS ${(productProvider.getTotalAccessoriesLoss() + productProvider.getTotalProductLoss()).toStringAsFixed(0)} ',
                  color: AppColors.PrimaryColor),
              const SizedBox(width: 16),
              StatCard(
                  title: 'Accesories',
                  value: productProvider.accessories.length.toString(),
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
                  filterValues: ['This Week', 'This Year'],
                  salesData: salesData,
                  lossData: lossData,
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: MobileSalesChart(
                  unitsSold: productProvider.getSoldProducts().length,
                  infinixPercentage: infinixPercentage,
                  tecnoPercentage: tecnoPercentage,
                  realmePercentage: realmePercentage,
                  redmiPercentage: redmiPercentage,
                  othersPercentage: othersPercentage,
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
