import 'package:flutter/material.dart';
import 'package:mobile_shop_pos/models/accessories_model.dart';
import 'package:mobile_shop_pos/utils/constants.dart';
import 'package:mobile_shop_pos/widgets/add_accessories_quantity.dart';
import 'package:mobile_shop_pos/widgets/sell_accessory_popup.dart';

class AccessoriesListViewContent extends StatefulWidget {
  final List<AccessoriesModel> accessories;

  const AccessoriesListViewContent({
    super.key,
    required this.accessories,
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

  const AccessoriesListViewWidget({
    super.key,
    required this.accessory,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
            Text(
              accessory.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "Quantity: ${accessory.quantity}",
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Invoice: RS ${accessory.invoice}",
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.TertiaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AddAccessoriesQuantityPopup());
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
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
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
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) =>
                            SellAccessoriesPopup(accessorymodel: accessory));
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
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
