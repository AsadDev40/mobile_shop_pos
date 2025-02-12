import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_shop_pos/models/product_model.dart';
import 'package:mobile_shop_pos/provider/product_provider.dart';
import 'package:mobile_shop_pos/service/utils.dart';
import 'package:mobile_shop_pos/utils/constants.dart';
import 'package:mobile_shop_pos/widgets/add_product_quantity.dart';
import 'package:mobile_shop_pos/widgets/edit_product_popup.dart';
import 'package:mobile_shop_pos/widgets/product_sell_popup.dart';
import 'package:provider/provider.dart';

class ProductPopupWidget extends StatelessWidget {
  final ProductModel product;

  const ProductPopupWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    bool hasCustomer = product.customerName != null &&
        product.customerName!.isNotEmpty &&
        product.customerCnic != null &&
        product.customerAddress != null &&
        product.customerAddress!.isNotEmpty;

    return AlertDialog(
      shadowColor: AppColors.SecondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      contentPadding: const EdgeInsets.all(16),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.2 + 20,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.productName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                if (!hasCustomer)
                  PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'update') {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                EditProductPopup(product: product));
                      } else if (value == 'delete') {
                        productProvider.deleteProduct(product.productId);
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'update',
                        child: Text('Update'),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ],
                    child: const Icon(Icons.more_vert),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            if (hasCustomer) ...[
              Text("Customer: ${product.customerName}",
                  style: const TextStyle(fontSize: 14, color: Colors.black54)),
              Text("CNIC: ${product.customerCnic}",
                  style: const TextStyle(fontSize: 14, color: Colors.black54)),
              Text("Address: ${product.customerAddress}",
                  style: const TextStyle(fontSize: 14, color: Colors.black54)),
              Text(
                "Date Time: ${product.dateTime != null ? DateFormat('yyyy-MM-dd hh:mm a').format(product.dateTime!) : 'N/A'}",
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ] else ...[
              Text("Vendor: ${product.vendorName}",
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600)),
              Text("Company: ${product.company}",
                  style: const TextStyle(fontSize: 14, color: Colors.black54)),
            ],
            const SizedBox(height: 8),
            Text("RAM: ${product.ram} | ROM: ${product.rom}",
                style: const TextStyle(fontSize: 14, color: Colors.black54)),
            const SizedBox(height: 8),
            Text("Serial Number: ${product.serialNumbers.first}",
                style: const TextStyle(fontSize: 14, color: Colors.black54)),
            const SizedBox(height: 8),
            Text("IMEI: ${product.imeiNumbers.first}",
                style: const TextStyle(fontSize: 14, color: Colors.black54)),
            const SizedBox(height: 8),
            Text("IMEI2: ${product.imeiNumbers.last}",
                style: const TextStyle(fontSize: 14, color: Colors.black54)),
            const SizedBox(height: 8),
            if (product.salePrice != null && product.salePrice!.isNotEmpty)
              Text("Price: RS ${product.salePrice}",
                  style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.TertiaryColor,
                      fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("Invoice: RS ${product.productInvoice}",
                style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.TertiaryColor,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (hasCustomer)
                  ElevatedButton(
                    onPressed: () async {
                      await productProvider.updateProductFields(
                          customerAddress: null,
                          customerCnic: null,
                          customerName: null,
                          salePrice: '',
                          productId: product.productId,
                          stock: 'available');
                      Utils.showToast('Product Returned Successfully');
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.PrimaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text("Return",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  )
                else
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          String productId = product.productId;
                          showDialog(
                              context: context,
                              builder: (context) => SellProductPopUp(
                                    productId: productId,
                                  ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.PrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text("Sale",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AddProductQuantityPopup(
                                  productModel: product));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.PrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text("Add Quantity",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ],
                  ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.PrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Close",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
