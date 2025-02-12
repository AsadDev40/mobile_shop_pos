import 'package:flutter/material.dart';
import 'package:mobile_shop_pos/models/product_model.dart';
import 'package:mobile_shop_pos/utils/constants.dart';
import 'package:mobile_shop_pos/widgets/product_detail_popup.dart';

class ProductListViewContent extends StatefulWidget {
  final List<ProductModel> products;

  const ProductListViewContent({
    super.key,
    required this.products,
  });

  @override
  State<ProductListViewContent> createState() => _ProductListViewContentState();
}

class _ProductListViewContentState extends State<ProductListViewContent> {
  late ValueNotifier<ProductModel> selectedProductNotifier;

  @override
  void initState() {
    super.initState();
    // Initialize the ValueNotifier with the first product
    selectedProductNotifier =
        ValueNotifier<ProductModel>(widget.products.first);
  }

  @override
  void dispose() {
    // Dispose of the ValueNotifier when the widget is removed
    selectedProductNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: widget.products.map((product) {
            return ValueListenableBuilder<ProductModel>(
              valueListenable: selectedProductNotifier,
              builder: (context, selectedProduct, child) {
                return ProductListViewWidget(
                  product: product,
                  isSelected: selectedProduct == product,
                  onTap: () {
                    // Update the ValueNotifier when a product is tapped
                    selectedProductNotifier.value = product;
                  },
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}

class ProductListViewWidget extends StatelessWidget {
  final ProductModel product;
  final bool isSelected;
  final VoidCallback onTap;

  const ProductListViewWidget({
    super.key,
    required this.product,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.2 - 50,
        height: MediaQuery.of(context).size.height * 0.2,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: isSelected ? AppColors.SecondaryColor : Colors.transparent,
              width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2 - 86,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Vendor: ${product.vendorName}",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Company: ${product.company}",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "RAM: ${product.ram} | ROM: ${product.rom}",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Serial Number: ${product.serialNumbers.first}",
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Invoice: RS ${product.productInvoice}",
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.TertiaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (product.salePrice != null &&
                          product.salePrice!.isNotEmpty)
                        Text(
                          "Price: RS ${product.salePrice}",
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.PrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                ProductPopupWidget(product: product),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.SecondaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "View Details",
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
          ],
        ),
      ),
    );
  }
}
