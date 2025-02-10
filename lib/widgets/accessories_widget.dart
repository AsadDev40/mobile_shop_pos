import 'package:flutter/material.dart';
import 'package:mobile_shop_pos/models/accessories_model.dart';
import 'package:mobile_shop_pos/provider/product_provider.dart';
import 'package:mobile_shop_pos/utils/constants.dart';
import 'package:mobile_shop_pos/widgets/add_accessories_quantity.dart';
import 'package:mobile_shop_pos/widgets/edit_acccesory_popup.dart';
import 'package:mobile_shop_pos/widgets/sell_accessory_popup.dart';
import 'package:provider/provider.dart';

class AccessoriesListViewContent extends StatefulWidget {
  final List<AccessoriesModel> accessories;
  final bool isSell;

  const AccessoriesListViewContent({
    super.key,
    required this.accessories,
    this.isSell = false,
  });

  @override
  State<AccessoriesListViewContent> createState() =>
      _AccessoriesListViewContentState();
}

class _AccessoriesListViewContentState
    extends State<AccessoriesListViewContent> {
  late AccessoriesModel selectedAccessory;

  @override
  void initState() {
    super.initState();
    selectedAccessory = widget.accessories.first;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: widget.accessories.map((accessory) {
            return AccessoriesListViewWidget(
              isSell: widget.isSell,
              accessory: accessory,
              isSelected: selectedAccessory == accessory,
              onTap: () {
                setState(() {
                  selectedAccessory = accessory;
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}

class AccessoriesListViewWidget extends StatelessWidget {
  final AccessoriesModel accessory;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isSell;

  AccessoriesListViewWidget({
    required this.accessory,
    required this.isSelected,
    required this.onTap,
    this.isSell = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.2 - 50,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.SecondaryColor : Colors.transparent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title with 3-dot menu
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    accessory.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                PopupMenuButton<String>(
                  color: Colors.white,
                  onSelected: (value) {
                    if (value == 'edit') {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              EditAccessoryPopup(accessory: accessory));
                    } else if (value == 'delete') {
                      productProvider.deleteAccessory(accessory.id.toString());
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Text('Edit'),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 6),

            /// Quantity
            Text(
              "Quantity: ${accessory.quantity}",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 6),

            /// Customer Name (Only shown when `isSell` is true)
            if (isSell)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Customer Name:",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    accessory.customerName ?? "N/A",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 6),
                ],
              ),

            /// Invoice
            Text(
              "Invoice: RS ${accessory.invoice}",
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.TertiaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),

            /// Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Price: RS ${accessory.price}",
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.PrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                isSell
                    ? ElevatedButton(
                        onPressed: () {
                          // Handle Return action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Return",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) =>
                                    AddAccessoriesQuantityPopup(
                                  id: accessory.id.toString(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.SecondaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              "Add",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => SellAccessoriesPopup(
                                  accessorymodel: accessory,
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.SecondaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              "Sell",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
            const SizedBox(height: 6),

            const SizedBox(
              height: 5,
            ),

            /// Action Buttons (Return if `isSell` is true, otherwise Add & Sell)
          ],
        ),
      ),
    );
  }
}
