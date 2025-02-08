import 'package:flutter/material.dart';
import 'package:mobile_shop_pos/screens/inventory_screen.dart';
import 'package:mobile_shop_pos/screens/overview_screen.dart';
import 'package:mobile_shop_pos/screens/purchase_screen.dart';
import 'package:mobile_shop_pos/screens/sale_screen.dart';
import 'package:mobile_shop_pos/screens/vendor_screen.dart';

import 'package:mobile_shop_pos/utils/constants.dart';
import 'package:mobile_shop_pos/widgets/menu_item_widget.dart';

class POSDashboard extends StatefulWidget {
  const POSDashboard({super.key});

  @override
  POSDashboardState createState() => POSDashboardState();
}

class POSDashboardState extends State<POSDashboard> {
  int selectedIndex = 0;

  final List<Widget> _tabs = [
    OverviewScreen(),
    SalesScreen(),
    PurchaseScreen(),
    InventoryScreen(),
    VendorScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.TertiaryColor.withOpacity(0.1),
                  AppColors.PrimaryColor.withOpacity(0.3),
                  Colors.white.withOpacity(0.1),
                  AppColors.TertiaryColor.withOpacity(0.0),
                  AppColors.SecondaryColor.withOpacity(0.3),
                  Colors.white.withOpacity(0.1),
                ],
              ),
            ),
            child: Row(
              children: [
                // Left Sidebar
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white.withOpacity(0.8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.only(
                      top: 60,
                      left: 16,
                      right: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mobile POS',
                          style: AppTextStyles.title2.copyWith(
                            color: AppColors.SecondaryColor,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Menu Items
                        MenuItemWidget(
                          icon: Icons.dashboard_outlined,
                          title: 'Dashboard',
                          isSelected: selectedIndex == 0,
                          onTap: () {
                            setState(() {
                              selectedIndex = 0;
                            });
                          },
                        ),
                        MenuItemWidget(
                          icon: Icons.sell,
                          title: 'Sales',
                          isSelected: selectedIndex == 1,
                          onTap: () {
                            setState(() {
                              selectedIndex = 1;
                            });
                          },
                        ),
                        MenuItemWidget(
                          icon: Icons.shopping_cart,
                          title: 'Purchase',
                          isSelected: selectedIndex == 2,
                          onTap: () {
                            setState(() {
                              selectedIndex = 2;
                            });
                          },
                        ),

                        MenuItemWidget(
                          icon: Icons.inventory,
                          title: 'Inventory',
                          isSelected: selectedIndex == 3,
                          onTap: () {
                            setState(() {
                              selectedIndex = 3;
                            });
                          },
                        ),

                        MenuItemWidget(
                          icon: Icons.store,
                          title: 'Vendors',
                          isSelected: selectedIndex == 4,
                          onTap: () {
                            setState(() {
                              selectedIndex = 4;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _tabs[selectedIndex],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
