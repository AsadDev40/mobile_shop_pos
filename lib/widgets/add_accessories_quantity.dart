import 'package:flutter/material.dart';
import 'package:mobile_shop_pos/provider/product_provider.dart';
import 'package:mobile_shop_pos/utils/constants.dart';
import 'package:mobile_shop_pos/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class AddAccessoriesQuantityPopup extends StatefulWidget {
  final String id;
  const AddAccessoriesQuantityPopup({super.key, required this.id});

  @override
  State<AddAccessoriesQuantityPopup> createState() =>
      _AddAccessoriesQuantityPopupState();
}

class _AddAccessoriesQuantityPopupState
    extends State<AddAccessoriesQuantityPopup> {
  final TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Add Quantity",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  productProvider.updateStock(
                      widget.id, int.parse(quantityController.text));
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
                  child: Text("Add Quantity",
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
