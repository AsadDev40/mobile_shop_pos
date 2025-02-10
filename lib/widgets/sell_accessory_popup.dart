import 'package:flutter/material.dart';
import 'package:mobile_shop_pos/models/accessories_model.dart';
import 'package:mobile_shop_pos/provider/product_provider.dart';
import 'package:mobile_shop_pos/utils/constants.dart';
import 'package:mobile_shop_pos/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class SellAccessoriesPopup extends StatefulWidget {
  final AccessoriesModel accessorymodel;
  const SellAccessoriesPopup({super.key, required this.accessorymodel});

  @override
  State<SellAccessoriesPopup> createState() => _SellAccessoriesPopupState();
}

class _SellAccessoriesPopupState extends State<SellAccessoriesPopup> {
  final TextEditingController customerController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Sell Accessory",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: customerController,
                hintText: "Customer Name",
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: quantityController,
                hintText: "Quantity",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  productProvider.sellAccessory(
                      widget.accessorymodel.id.toString(),
                      int.parse(quantityController.text),
                      customerController.text,
                      DateTime.now());
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.PrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                  child: Text("Sell",
                      style: AppTextStyles.body1.copyWith(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
