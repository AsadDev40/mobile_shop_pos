import 'package:flutter/material.dart';
import 'package:mobile_shop_pos/models/accessories_model.dart';
import 'package:mobile_shop_pos/provider/product_provider.dart';
import 'package:mobile_shop_pos/utils/constants.dart';
import 'package:mobile_shop_pos/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddAccessoriesPopup extends StatefulWidget {
  const AddAccessoriesPopup({super.key});

  @override
  State<AddAccessoriesPopup> createState() => _AddAccessoriesPopupState();
}

class _AddAccessoriesPopupState extends State<AddAccessoriesPopup> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController invoiceController = TextEditingController();
  final TextEditingController vendorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Add Accessory",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: nameController,
                hintText: "Accessory Name",
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: vendorController,
                hintText: "Vendor Name",
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: quantityController,
                hintText: "Quantity",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: invoiceController,
                hintText: "Invoice Price",
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  final String id = const Uuid().v4();
                  final AccessoriesModel accessory = AccessoriesModel(
                    id: id,
                    name: nameController.text,
                    vendorName: vendorController.text,
                    quantity: int.parse(quantityController.text),
                    invoice: int.parse(invoiceController.text),
                    dateTime: DateTime.now(),
                  );
                  productProvider.addAccessory(accessory);
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
                  child: Text("Add Accessory",
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
